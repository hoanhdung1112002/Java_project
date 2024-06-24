package com.springmvc.demo.Utilities;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.Date;
import java.util.Locale;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;

import org.springframework.util.StringUtils;

public class Functions {
    private static final Pattern LATIN = Pattern.compile("[^\\w-]");
    private static final Pattern WHITESPACE = Pattern.compile("[\\s]");

    /**
     * Hash to MD5
     * @param data
     * @return
     */
    public static String hashMD5(String data) {
        try {
            // Tạo đối tượng MessageDigest với thuật toán MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // Mã hóa dữ liệu và chuyển kết quả sang dạng hex
            byte[] hashedBytes = md.digest(data.getBytes());
            StringBuilder hexStringBuilder = new StringBuilder();

            for (byte b : hashedBytes) {
                hexStringBuilder.append(String.format("%02x", b));
            }

            return hexStringBuilder.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Make slug
     * @param input
     * @return
     */
    public static String makeSlug(String input) {
        if (!StringUtils.hasLength(input)) return "";

        String noWhitespace = WHITESPACE.matcher(input).replaceAll("-");
        String normalized = Normalizer.normalize(noWhitespace, Form.NFD);
        String slug = LATIN.matcher(normalized).replaceAll("");
        return slug.toLowerCase(Locale.ENGLISH);
    }

    /**
     * Convert time display
     * @param time
     * @return
     */
    public static String convertTime(Date time) {
        String timeResult =  "Vừa xong";

        if (time != null) {
            Date currentTime = new Date();

            long diffInMilliseconds = currentTime.getTime() - time.getTime();
            long diffInMinutes = TimeUnit.MILLISECONDS.toMinutes(diffInMilliseconds);
            long diffInHours = TimeUnit.MILLISECONDS.toHours(diffInMilliseconds);
            long diffInDays = TimeUnit.MILLISECONDS.toDays(diffInMilliseconds);

            if (diffInMinutes > 0 && diffInMinutes < 60) {
                timeResult = diffInMinutes + " phút trước";
            } else if (diffInHours > 0 && diffInHours < 24) {
                timeResult = diffInHours + " giờ trước";
            } else if (diffInDays > 0 && diffInDays < 7) {
                timeResult = diffInDays + " ngày trước";
            } else if (diffInDays >= 7 && diffInDays < 30) {
                timeResult = (diffInDays/7) + " tuần trước";
            } else if (diffInDays >= 30 && diffInDays < 365) {
                timeResult = (diffInDays/30) + " tháng trước";
            } else if (diffInDays >= 365) {
                timeResult = (diffInDays/365) + " năm trước";
            }
        }

        return timeResult;
    }

    /**
     * Generate random code room chat
     * @return String (16 characters)
     */
    public static String generateCodeRoomChat() {
        int codeLength = 16;
        String characters = "abcdefghijklmnopqrstuvwxyz0123456789-";

        StringBuilder code = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < codeLength; i++) {
            int randomIndex = random.nextInt(characters.length());
            code.append(characters.charAt(randomIndex));
        }

        return code.toString();
    }
}
