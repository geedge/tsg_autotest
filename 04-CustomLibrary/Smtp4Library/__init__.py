#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This file is part of robotframework-Smtp3Library.
# https://github.io/lucamaro/robotframework-Smtp3Library

# Licensed under the Apache License 2.0 license:
# http://www.opensource.org/licenses/Apache-2.0
# Copyright (c) 2016, Luca Maragnani <luca.maragnani@gmail.com>

"""
Library implementation
"""
import ast
import smtplib
import email
import random
import string
import mimetypes
import quopri
from email.message import Message
from email.mime.audio import MIMEAudio
from email.mime.base import MIMEBase
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email import encoders
import os.path
import socket
from robot.api.deco import keyword
from robot.api import logger

from Smtp3Library.version import __version__  # NOQA

COMMASPACE = ', '

class Smtp3Library(object):
    """
    SMTP Client class
    """

    def __init__(self):
        """
        Constructor
        """
        self.message = self._MailMessage()
        self.host = None
        self.port = None
        self.user = None
        self.password = None
        self.smtp = None

    def _prepare_connection(self, host, port, user=None, password=None):
        """
        Private method to collect connection informations
        """
        self.host = host
        self.port = int(port)
        self.user = user
        self.password = password
        self.client_hostname = socket.gethostname()


    def prepare_ssl_connection(self, host, port=465, user=None, password=None):
        """
        Collect connection informations for SSL channel
        """
        self._prepare_connection(host, port, user, password)
        self.smtp = smtplib.SMTP_SSL()

    def prepare_connection(self, host, port=25, user=None, password=None):
        """
        Collect connection informations for unencrypted channel
        """
        self._prepare_connection(host, port, user, password)
        self.smtp = smtplib.SMTP()

    def add_to_recipient(self, recipient):
        """
        Add a recipient to "To:" list
        """
        self.message.mail_to.append(recipient)

    def add_cc_recipient(self, recipient):
        """
        Add a recipient to "Cc:" list
        """
        self.message.mail_cc.append(recipient)

    def add_bcc_recipient(self, recipient):
        """
        Add a recipient to "Bcc:" list
        """
        self.message.mail_bcc.append(recipient)

    def set_subject(self, subj):
        """
        Set email subject
        """
        self.message.subject = subj

    def set_from(self, from_recipient):
        """
        Set from address of message and envelope
        """
        self.message.mail_from = from_recipient

    def set_body(self, body):
        """
        Set email body
        """
        self.message.body = body

    def set_random_body(self, size):
        """
        Set a random body of <size> length
        """
        body = ''
        for i in range(0, size):
            body += ''.join(random.choice(string.uppercase + string.digits))
            if i % 80 == 0:
                body += "\n"
        self.message.body = body

    def add_attachment(self, attach):
        """
        Add attachment to a list of filenames
        """
        self.message.attachments.append(attach)

    def add_header(self, name, value):
        """
        Add a custom header to headers list
        """
        self.message.headers[name] = value

    def connect(self):
        '''
        Open connection to server
        Returns tuple (smtp status code, message)
        '''
        return self.smtp.connect(self.host, self.port)

    def present_client_as(self, client_hostname):
        '''
        Set helo/ehlo client identity
        '''
        self.client_hostname = client_hostname

    def helo(self):
        '''
        Send HELO command
        Returns tuple (smtp status code, message)
        '''
        result = self.smtp.helo(self.client_hostname)
        logger.info(result)
        return result

    def ehlo(self):
        '''
        Send EHLO command
        Returns tuple (smtp status code, message)
        '''
        result = self.smtp.ehlo(self.client_hostname)
        logger.info(result)
        return result

    def get_esmtp_features(self):
        '''
        Returns hashmap with ESMTP feature received with EHLO
        '''
        logger.info(self.smtp.esmtp_features)
        return self.smtp.esmtp_features

    def logins(self):
        try:
            '''
            Login user
            Returns tuple (smtp status code, message)
            '''  
            logger.info("Login with user " + self.user + " and password " + self.password)
            '''try:
                subuser=bytes.decode(self.user)
                subpassword=bytes.decode(self.password)
                result = self.smtp.login(subuser.encode('ascii'), subpassword.encode('ascii'))
                logger.info(result)
                return result
            except:
                logger.info("本身就是str类型不需要bytes to str！")
                subuser=str(self.user).encode('ascii')
                subpassword=str(self.password).encode('ascii')
                result = self.smtp.login(subuser, subpassword)
                logger.info(result)
                return result'''
            result = self.smtp.login(self.user, self.password)
            logger.info(result)
            return "success"
        except:
            return "fail"
        

    def starttls(self, keyfile=None, certfile=None):
        '''
        sends STARTTLS
        optional: keyfile certfile
        Returns tuple (smtp status code, message)
        '''
        logger.info("STARTTLS")
        if keyfile is None and certfile is None:
            result = self.smtp.starttls()
        else:
            result = self.smtp.starttls(keyfile, certfile)
        logger.info(result)
        return result

    def data(self):
        '''
        Data command send email body with "MAIL FROM:", "RCPT TO:" and "DATA" commands
        Returns tuple (smtp status code, message)
        '''        
        result = self.smtp.mail(self.message.mail_from)
        result += self.smtp.rcpt(self.message.get_message_recipients())
        
        result += self.smtp.data(self.message.get_message_as_string())
        logger.info(result)
        return result

    def sendmail(self):
        '''
        Send email with "MAIL FROM:", "RCPT TO:" and "DATA" commands
        Returns tuple (smtp status code, message)
        '''
        result = self.smtp.sendmail(self.message.mail_from, self.message.get_message_recipients(), self.message.get_message_as_string())
        logger.info(result)
        return result

    def quit(self):
        '''
        Send QUIT command
        Returns tuple (smtp status code, message)
        '''
        result = self.smtp.quit()
        logger.info(result)
        return result

    def close_connection(self):
        '''
        Close connection to server
        '''
        return self.smtp.close()

    def send_message(self):
        """
        Send the message, from connection establishment to quit and close connection.
        All the connection and email parameters must be already set before invocation.
        Returns sendmail response (code, message)
        """

        # Send the message
        try:
            self.connect()

            if self.user is not None:
                self.ehlo()
                self.logins()

            send_result = self.sendmail()

            self.quit()
            self.close_connection()
            # return send_result
            return "success"
        except:
            return "fail"

    @keyword('Send Message With All Parameters')
    def send_message_full(self, host, user, password, subj,
                          from_recipient, to_recipient, cc_recipient=None, bcc_recipient=None,
                          body=None, attach=None):
        """
        Send a message specifing all parameters on the same linecc
        cc, bcc and attach parameters may be strings or array of strings
        host, user, password, subj, fromadd, toadd - are mandatory parameters
        to use the optional paramaters pleas specify the name fo the parameter in the call
        user and password even if mandatory could be set to None so no authentication will be made
            Example:
            sendMail("smtp.mail.com", None, None, "The subject", "me@mail.com", "friend@mai.com", body="Hello World body")

            sendMail("smtp.mail.com", "scott", "tiger", "The subject", "me@mail.com", "friend@mai.com", body="Hello World body", attach=attaches
        where could be:
        attaches = ["c:\\desktop\\file1.zip", "c:\\desktop\\file2.zip"] or
        attaches = "c:\\desktop\\file1.zip"
        Returns sendmail response (code, message)
        """

        self.host = host
        self.user = user
        self.password = password

        self.set_subject(subj)
        self.set_from(from_recipient)
        self.message.mail_to = to_recipient
        if cc_recipient != None:
            self.message.mail_cc = cc_recipient
        if bcc_recipient != None:
            self.message.mail_bcc = bcc_recipient
        #Fill the message
        if body != None:
            self.set_body(body)
        # Part two is attachment
        if attach != None:
            attachlist = ast.literal_eval(attach)
            self.message.attachments = attachlist
            #logger.info("self.message.attachments:"+str(type(self.message.attachments)))
            #logger.info("attachtype:"+str(type(attachlist)))
            #logger.info("attachlist:"+str(attachlist))

        return self.send_message()


    class _MailMessage:
        """
        Simplified email message
        This class represent email headers and payload content, not envelope data
        """

        def __init__(self):
            """
            init object variables
            """
            self.mail_from = None
            self.mail_to = []
            self.mail_cc = []
            self.mail_bcc = []
            self.subject = ''
            self.body = ''
            self.attachments = []
            self.headers = {}

        def get_message_recipients(self):
            '''
            Get all message recipients (to, cc, bcc)
            '''
            recipients = []
            tolist = ast.literal_eval(self.mail_to)
            cclist = ast.literal_eval(self.mail_cc)
            bcclist = ast.literal_eval(self.mail_bcc)
            recipients.extend(tolist)
            recipients.extend(cclist)
            recipients.extend(bcclist)
            #logger.info("recipientslist:"+str(recipients))
            return recipients

        def get_message_as_string(self):
            '''
            Get message as string to be sent with smtplib.sendmail api
            '''
            if len(self.attachments) > 0:
                #logger.info("attachments:"+str(self.attachments))
                #logger.info("attachmentstype:"+str(type(self.attachments)))
                #logger.info("attachmentsnum:"+str(len(self.attachments)))
                
                envelope = MIMEMultipart()
                envelope.attach(MIMEText(self.body))
            else:
                envelope = MIMEText(self.body)

            recipients = self.get_message_recipients()
            
            
            tolist = ast.literal_eval(self.mail_to)
            cclist = ast.literal_eval(self.mail_cc)
            envelope['From'] = self.mail_from
            envelope['To'] = COMMASPACE.join(tolist)
            envelope['Cc'] = COMMASPACE.join(cclist)
            envelope['Subject'] = self.subject
            #logger.info("envelope111:"+str(self.attachments))
            for attachment in list(self.attachments):
                ctype, encoding = mimetypes.guess_type(attachment)
                #logger.info("attachment:"+attachment+" ctype:"+str(ctype)+" encoding:"+str(encoding))
                if ctype is None or encoding is not None:
                    # No guess could be made, or the file is encoded (compressed), so
                    # use a generic bag-of-bits type.
                    ctype = 'application/octet-stream'
                maintype, subtype = ctype.split('/', 1)
                #logger.info("maintype:"+str(maintype)+" subtype:"+str(subtype))

                msg = None
                if maintype == 'text':
                    attach_file = open(attachment,'rb')
                    # TODO: we should handle calculating the charset
                    msg = MIMEText(attach_file.read(), _subtype=subtype, _charset='utf-8')
                    attach_file.close()
                elif maintype == 'image':
                    attach_file = open(attachment, 'rb')
                    msg = MIMEImage(attach_file.read(), _subtype=subtype)
                    attach_file.close()
                elif maintype == 'audio':
                    attach_file = open(attachment, 'rb')
                    msg = MIMEAudio(attach_file.read(), _subtype=subtype)
                    attach_file.close()
                else:
                    attach_file = open(attachment, 'rb')
                    msg = MIMEBase(maintype, subtype)
                    msg.set_payload(attach_file.read())
                    attach_file.close()
                    # Encode the payload using Base64
                    encoders.encode_base64(msg)

                # Set the filename parameter
                msg.add_header('Content-Disposition', 'attachment',
                               filename=os.path.basename(attachment))
                envelope.attach(msg)
                
                
            #logger.info("envelope.as_string:"+envelope.as_string())
            return envelope.as_string()
