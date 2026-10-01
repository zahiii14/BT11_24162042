package vn.edu.fit.mssv24162042.utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtils_24162042 {

    public static boolean sendOtpEmail(String toEmail, String otp) {
        System.out.println("=================================================");
        System.out.println("OTP CODE FOR [" + toEmail + "]: " + otp);
        System.out.println("=================================================");

        final String fromEmail = "zahiii1406@gmail.com"; 
        final String password = "qbpmbrvnzenlgfst"; // App Password 16 ký tự của Google

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "WebDB App"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã xác thực OTP đăng ký tài khoản - WebDB_24162042");
            message.setText("Mã OTP của bạn là: " + otp + "\nMã có hiệu lực cho việc kích hoạt tài khoản.");

            // Thực hiện gửi email thật qua SMTP
            Transport.send(message);
            System.out.println("-> Gửi email OTP thành công tới: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("Lỗi khi gửi email qua SMTP: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
