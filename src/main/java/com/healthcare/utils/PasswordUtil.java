package com.healthcare.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Hash a plain text password
    public static String hash(String plain) {
        // gensalt() default is 10 rounds; you can increase to 12 for stronger hashing
        return BCrypt.hashpw(plain, BCrypt.gensalt(12));
    }

    // Verify a plain text password against a hashed password
    public static boolean verify(String plain, String hashed) {
        if (hashed == null || hashed.isEmpty()) {
            return false;
        }
        return BCrypt.checkpw(plain, hashed);
    }
}
