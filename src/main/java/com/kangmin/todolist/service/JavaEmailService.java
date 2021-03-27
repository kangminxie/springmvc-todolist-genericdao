package com.kangmin.todolist.service;

import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public final class JavaEmailService {

    private final JavaMailSender javaMailSender;

    public JavaEmailService(final JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    public void sendPlainEmail(final String target, final String subject, final String text) {
        final SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(target);
        msg.setSubject(subject);
        msg.setText(text);
        // right now, gmail.smtp.auth only work locally
        // javaMailSender.send(msg);
    }

    public void sendPlainEmails(final String[] targets, final String subject, final String text) {
        final SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(targets);
        msg.setSubject(subject);
        msg.setText(text);
        // javaMailSender.send(msg);
    }

    void sendEmailWithAttachment() throws MessagingException {
        final MimeMessage msg = javaMailSender.createMimeMessage();
        // true = multipart message
        final MimeMessageHelper helper = new MimeMessageHelper(msg, true);
        helper.setTo("1@gmail.com");
        helper.setSubject("Testing from Spring MVC ToDoList");
        // default = text/plain
        //helper.setText("Check attachment for image!");
        // true = text/html
        helper.setText("<h1>Check attachment for image!</h1>", true);
        helper.addAttachment("test_photo.png", new ClassPathResource("test.png"));
        // javaMailSender.send(msg);
    }
}
