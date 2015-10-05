package models;

import play.db.ebean.Model;

import java.sql.Timestamp;
import java.util.List;

public class NoteDAO {

    public static Model.Finder<Integer, Note> find = new Model.Finder<Integer, Note>(Integer.class, Note.class);

    public static Note create(String noteText, String user) {
        Note note = new Note(noteText, UserDAO.find.ref(user), new Timestamp(new java.util.Date().getTime()));
        note.save();
        return note;
    }

    public static Note update(Integer idNote, String noteText) {
        Note note = find.ref(idNote);
        note.setDateCreate(new Timestamp(new java.util.Date().getTime()));
        note.setText(noteText);
        note.update();
        return note;
    }

    public static void delete(Integer idNote) {
        find.ref(idNote).delete();
    }

    public static Note getNote(Integer id) {
        return find.where().eq("id", id).findUnique();
    }

    public static List getAllNotes() {
        return find.all();
    }

    public static List<Note> getAllUserNotes(String username) {
        return find.where().eq("user.username", username).orderBy("dateCreate desc").findList();
    }

    public static List<Note> getLastUserNotes(String username) {
        List<Note> notes = find.where().eq("user.username", username).orderBy("dateCreate desc").setMaxRows(10).findList();
        return notes;
    }


    public static boolean isUserNote(Integer idNote, String user) {
        return find.where().eq("user.username", user).eq("id", idNote).findRowCount() > 0;
    }

}