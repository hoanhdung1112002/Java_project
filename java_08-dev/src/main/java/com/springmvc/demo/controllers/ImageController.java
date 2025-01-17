package com.springmvc.demo.controllers;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ImageController {
    @RequestMapping(value = "getImage/{photo}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<ByteArrayResource> getImage(@PathVariable("photo") String photo) {
        Path fileName = Paths.get("uploads/", "no-avatar.jpg");
        if (!photo.equals("") || photo != null) {
            fileName = Paths.get("uploads/", photo);
        }
        try {
            byte[] buffer = Files.readAllBytes(fileName);
            ByteArrayResource byteArrayResource = new ByteArrayResource(buffer);

            return ResponseEntity.ok()
                .contentLength(buffer.length)
                .contentType(MediaType
                .parseMediaType("image/jpeg"))
                .body(byteArrayResource);
        } catch (Exception e) {
            // TODO: handle exception
        }
        return ResponseEntity.badRequest().build();
    }
}
