package models;

import play.db.ebean.Model;

public class UserDAO {

    public static Model.Finder<String, User> find = new Model.Finder<String, User>(String.class, User.class);

    public static User create(String username, String password) {
        User user = new User(username, password);
        user.save();
        return user;
    }

    public static User update(String username, String password) {
        User user = new User(username, password);
        user.update();
        return user;
    }

    public static void delete(String username) {
        find.ref(username).delete();
    }

    public static User getUser(String username){
        return find.where().eq("username",username).findUnique();
    }

    public static User getUser(String username, String password) {
        return find.where().eq("username", username).eq("password", password).findUnique();
    }
}
