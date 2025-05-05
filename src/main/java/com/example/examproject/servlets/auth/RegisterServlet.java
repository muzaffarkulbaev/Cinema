package com.example.examproject.servlets.auth;

import com.example.examproject.dto.RegisterDto;
import com.example.examproject.dto.ValidationError;
import com.example.examproject.entity.Attachment;
import com.example.examproject.service.MailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.example.examproject.entity.User;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Set;

import static com.example.examproject.config.MyListener.attachmentService;
import static com.example.examproject.config.MyListener.userService;

@MultipartConfig
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        User checkUser = new User(req);
        req.setAttribute("oldData", checkUser);
        ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
        Validator validator = validatorFactory.getValidator();
        Set<ConstraintViolation<User>> violations = validator.validate(checkUser);
        if (!violations.isEmpty()) {
            List<ValidationError> errors = new ArrayList<>();
            for (ConstraintViolation<User> violation : violations) {
                errors.add(new ValidationError(
                        violation.getPropertyPath().toString(),
                        violation.getMessage(),
                        violation.getInvalidValue().toString()
                ));
                System.out.println(violation.getPropertyPath().toString());
            }
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
        }else {

            User user = userService.findByEmail(checkUser.getEmail());
            System.out.println(checkUser.getEmail());
            if (user != null) {
                req.setAttribute("sameEmail", "This email is already in use");
                System.out.println("This email is already in use");
                req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
                return;
            }
            System.out.println("This email is not already in use");


            Part part = req.getPart("photo");
            Attachment attachment = new Attachment();
            attachment.setContent(part.getInputStream().readAllBytes());
            Attachment savedAttachment = attachmentService.save(attachment);

            RegisterDto registerDto = new RegisterDto(req);
            registerDto.setAttachmentId(savedAttachment.getId());
            if (!registerDto.getPassword().equals(registerDto.getPasswordRepeat())){
                System.out.println("Passwords do not match");
                req.setAttribute("errorPassword", "Passwords do not match");
                req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession();
            Random random = new Random();
            int randomCode = random.nextInt(1000, 9999);
            registerDto.setOtp(randomCode);
            session.setAttribute("registerDto", registerDto);

            Thread thread = new Thread(()->{
                MailService.sendCode(registerDto.getEmail(), registerDto.getOtp());
            });
            thread.start();

            resp.sendRedirect("/auth/verify.jsp");
        }
    }
}
