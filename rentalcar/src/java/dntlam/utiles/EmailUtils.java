/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.utiles;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author sasuk
 */
public class EmailUtils implements Serializable {

    public static final String HOST_NAME = "smtp.gmail.com";

    public static final int SSL_PORT = 465; // Port for SSL

    public static final int TSL_PORT = 25; // Port for TLS/STARTTLS

    public static final String APP_EMAIL = "h3nzyblog@gmail.com"; // your email

    public static final String APP_PASSWORD = "sasuke903"; // your password

    public static boolean sendMail(String receiverEmail, HttpServletRequest request) throws UnsupportedEncodingException {
        {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.host", HOST_NAME);
            props.put("mail.smtp.socketFactory.port", SSL_PORT);
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.port", SSL_PORT);

            // get Session
            Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
                }
            });

            // compose message
            try {

                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(APP_EMAIL, "Rental Car Company"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiverEmail));
                message.setSubject("Active Rental Car service account ");
                Integer code = generalCode();
                HttpSession sessionWeb = request.getSession(true);
                sessionWeb.setMaxInactiveInterval(60 * 30);
                sessionWeb.setAttribute("CODEACTIVE", code);
                String content = "Your Email Account in rental Car service is: " + receiverEmail + "\n"
                        + "OTP : " + code
                        + "\nUse OTP code to active Account";
                message.setText(content);

                // send message
                Thread thread = new Thread(new Runnable() {
                    @Override
                    public void run() {
                        try {
                            Transport.send(message);
                        } catch (MessagingException ex) {
                            Logger.getLogger(EmailUtils.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                });
                thread.start();
                return true;
            } catch (MessagingException e) {
                throw new RuntimeException(e);

            }

        }
    }

    public static int generalCode() {
        return 1000 + (int) (Math.random() * (10000 - 1000) + 1);
    }

}
