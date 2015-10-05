package models;

import play.db.ebean.Model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "users")
public class User extends Model {

    @Id
    @Column(name = "username", unique = true, nullable = false)
    private String username;

    @Column(name = "password", nullable = false)
    private String password;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "user",fetch=FetchType.LAZY)
    private List<Note> notes;

    //getters and setters ----------------------------
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Note> getNotes() {
        return notes;
    }

    public void setNotes(List<Note> notes) {
        this.notes = notes;
    }
    //------------------------------------------------

    //Constructors -----------------------------------
    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public User() {
    }
    //------------------------------------------------
}
