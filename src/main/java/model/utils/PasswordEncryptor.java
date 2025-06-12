package model.utils;

public class PasswordEncryptor {

    
    public static boolean checkPassword(String senhaDigitada, String senhaDoBanco) {
        if (senhaDigitada == null || senhaDoBanco == null) {
            return false;
        }
        return senhaDigitada.equals(senhaDoBanco);
    }
}