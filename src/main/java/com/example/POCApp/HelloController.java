package com.example.POCApp;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
@Slf4j
@RestController
public class HelloController {
    @RequestMapping(method = RequestMethod.GET, value = "/api/pocgic")
    public String sayHello() {
            log.info("generating welcome message");
        return " Welcome priyanshu -- I am here to give you a short POC of EKS for GIC ";

    }


}
