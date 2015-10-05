package models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import play.db.ebean.Model;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "notes")
public class Note extends Model{

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id",unique = true,nullable = false)
    private Integer id;
    @Column(name = "text",nullable = false)
    private String text;
    @Column(name = "dateCreate",nullable = false)
    private Timestamp dateCreate;
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name = "username")
    @JsonIgnore
    private User user;

    //getters and setters ----------------------------
    public int getId() {
        return id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Timestamp getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Timestamp dateTimeCreate) {
        this.dateCreate = dateTimeCreate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    //------------------------------------------------

    //Constructors -----------------------------------
    public Note(int id, String text, User user, Timestamp dateCreate) {
        this.id = id;
        this.text = text;
        this.user = user;
        this.dateCreate = dateCreate;
    }

    public Note(String text, User user, Timestamp dateCreate) {
        this.user = user;
        this.text = text;
        this.dateCreate = dateCreate;
    }

    public Note() {
    }
    //------------------------------------------------

}