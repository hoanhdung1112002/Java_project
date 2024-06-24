package com.springmvc.demo.controllers.website;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.User;
import com.springmvc.demo.models.Messages;
import com.springmvc.demo.models.Room;
import com.springmvc.demo.repositories.MessagesRepository;
import com.springmvc.demo.repositories.RoomRepository;

@Controller
@RequestMapping(path = "messages")
public class MessagesController extends BaseController{
    /**
     * Initializes
     */
    @Autowired
    private MessagesRepository messagesRepository;
    @Autowired
    private RoomRepository roomRepository;

    /**
     * Get data room and first message of room
     * @param session
     * @return
     */
    private List<Object[]> getRoomAndFirstMessage(HttpSession session) {
        List<Object[]> dataList = new ArrayList<>();
        User userLogin = userLogin(session);
        if (userLogin != null) {
            Iterable<Room> rooms = roomRepository.getListRoomByUserID(userLogin);
            for (Room room : rooms) {
                List<Messages> messages = messagesRepository.getFirstMessagesByRoomID(room, PageRequest.of(0, 1));

                Messages firstMessage = new Messages();
                if (!messages.isEmpty()) {
                    firstMessage = messages.get(0);
                }

                Object[] data = new Object[]{room, firstMessage};
                dataList.add(data);
            }
        }
        return dataList;
    }

    /**
     * show list messages (list room and first message)
     * @param session
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String showListMessages(HttpSession session, ModelMap modelMap) {
        try {
            modelMap.addAttribute("rooms", getRoomAndFirstMessage(session));
        } catch (Exception e) {}
        return "website/messages/list";
    }

    /**
     * Show list messages of room by code of room
     * @param code
     * @param session
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/{code}", method = RequestMethod.GET)
    public String showListMessagesOfRoom(@PathVariable("code") String code, HttpSession session, ModelMap modelMap) {
        try {
            modelMap.addAttribute("rooms", getRoomAndFirstMessage(session));
            Optional<Room> roomOptional = roomRepository.findByCode(code);
            
            if (roomOptional.isPresent()) {
                Room room = roomOptional.get();
                List<Messages> messagesList = messagesRepository.getMessagesByRoomID(room, PageRequest.of(0, 100));
                User userLogin = userLogin(session);

                // Update viewDate
                for (Messages messages : messagesList) {
                    if (messages.getUserID().getID() != userLogin.getID()) {
                        messages.setViewDate(new Date());
                        messagesRepository.save(messages);
                    }
                }

                User user = userLogin.getID() == room.getUserCreate().getID() ? room.getUserRoom() : room.getUserCreate();

                modelMap.addAttribute("messagesList", messagesList);
                modelMap.addAttribute("user", user);
                modelMap.addAttribute("code", code);
            }
        } catch (Exception e) {}
        return "website/messages/list";
    }

    /**
     * Send messages (save to roomChat table in database)
     * @param code
     * @param content
     * @param session
     * @return
     */
    @RequestMapping(value = "/send/{code}", method = RequestMethod.POST)
    public String sendMessages(@PathVariable("code") String code, @RequestParam("content") String content, HttpSession session) {
        try {
            User userLogin = userLogin(session);
            Optional<Room> roomOptional = roomRepository.findByCode(code);
            if (roomOptional.isPresent()) {
                Room room = roomOptional.get();

                Messages messages = new Messages(room, userLogin, content.trim());
                messagesRepository.save(messages);

                room.setUpdatedAt(new Date());
                roomRepository.save(room);
            }
        } catch (Exception e) {}
        return "redirect:/messages/" + code;
    }
}
