package com.kangmin.todolist.service.tutorial;

import com.kangmin.todolist.model.dto.StudentDto;
import org.springframework.stereotype.Service;

@Service
public class StudentService implements BasicService {
    @Override
    public final String sayHello(final StudentDto s) {
        return "Hi, Student: " + s.getFirstName();
    }

    @Override
    public final String sayBye() {
        return "Bye";
    }
}
