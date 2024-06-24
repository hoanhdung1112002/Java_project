package com.springmvc.demo.controllers.website;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springmvc.demo.Utilities.Functions;
import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Messages;
import com.springmvc.demo.models.Room;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.MessagesRepository;
import com.springmvc.demo.repositories.RoomRepository;
import com.springmvc.demo.repositories.UserRepository;

@Controller
@RequestMapping(path = "room")
public class RoomController extends BaseController {
    /**
     * Initializes
     */
    @Autowired
    private MessagesRepository messagesRepository;
    @Autowired
    private RoomRepository roomRepository;
    @Autowired
    private UserRepository userRepository;

    @RequestMapping(value = "/delete/{ID}", method = RequestMethod.GET)
    public ResponseEntity<String> deleteRoom(@PathVariable("ID") Long ID) {
        Optional<Room> room = roomRepository.findById(ID);
        if (room.isPresent()) {
            List<Messages> messagesList = messagesRepository.getMessagesByRoomID(room.get(), PageRequest.of(0, 100));

            // Delete messages of room
            for (Messages messages : messagesList) {
                messagesRepository.delete(messages);
            }

            roomRepository.deleteById(ID);
        }
        return new ResponseEntity<>("successfully", HttpStatus.OK);
    }

    /**
     * Create room chat
     * @param userID
     * @param session
     * @return
     */
    @RequestMapping(value = "/create/{userID}", method = RequestMethod.GET)
    public String createRoom(@PathVariable("userID") Long userID, HttpSession session) {
        
        User userLogin = userLogin(session);
        Optional<User> userOptional = userRepository.findById(userID);
        Optional<Room> room = roomRepository.checkRoomExists(userOptional.get(), userLogin);
        
        if (room.isPresent()) {
            return "redirect:/messages/" + room.get().getCode();
        } else {

            String codeRoom = Functions.generateCodeRoomChat();

            Room newRoom = new Room();
            newRoom.setUserCreate(userLogin);
            newRoom.setUserRoom(userOptional.get());
            newRoom.setCode(codeRoom);
            roomRepository.save(newRoom);

            return "redirect:/messages/" + codeRoom;
        }
    }
}
