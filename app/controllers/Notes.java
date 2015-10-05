package controllers;

import models.Note;
import models.NoteDAO;
import models.User;
import models.UserDAO;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import views.html.index;

import static play.data.Form.form;
import static play.libs.Json.toJson;

import views.html.*;
import play.mvc.Http.*;

import java.util.List;

@Security.Authenticated(Secured.class)
public class Notes extends Controller {

    public static Result index() {
        return ok(index.render(UserDAO.getUser(request().username())));
    }

    public static Result create(String noteText) {
        Note note = NoteDAO.create(noteText, request().username());
        return ok(toJson(note));
    }

    public static Result update(Integer idNote, String noteText) {
        if (isUserNote(idNote)) {
            return ok(toJson(NoteDAO.update(idNote, noteText)));
        } else {
            return forbidden();
        }
    }

    public static Result delete(Integer idNote) {
        if(isUserNote(idNote)) {
            NoteDAO.delete(idNote);
            return ok();
        } else {
            return forbidden();
        }
    }

    public static Result getNotes(String flag){
        if(flag.equals("last")){
            List<Note> notes = NoteDAO.getLastUserNotes(request().username());
            return ok(toJson(notes));
        }else{
            List<Note> notes = NoteDAO.getAllUserNotes(request().username());
            return ok(toJson(notes));
        }
    }

    public static Result getNote(Integer id){
        return ok(toJson(NoteDAO.getNote(id)));
    }

    public static boolean isUserNote(int idNote) {
        return NoteDAO.isUserNote(idNote, Context.current().request().username());
    }
}