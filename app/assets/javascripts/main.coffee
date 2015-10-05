$(document).ready ->
  $("#switcherNote").on "click", ->
    $("#errorBox").remove()
    $("#messageBox").remove()
    if($("#switcher").val() == "last")
      $("#switcher").val("all");
      getNotes()
      $("#switcherNote").html('Show last notes')
    else
      $("#switcher").val("last")
      getNotes()
      $("#switcherNote").html('Show all notes')

$(document).ready ->
  $("#editNote").hide()
  getNotes()

$(document).ready getNotes = ->
  switcher = $('#switcher').val()
  r = jsRoutes.controllers.Notes.getNotes(switcher)
  $.ajax
    url: r.url
    type: r.type
    context: this
    error: (jqXHR, textStatus, errorThrown) ->
      $("<div id='errorBox' class='alert alert-danger fade in'>" +
          "<button type='button' class='close' data-dismiss='alert'>&times;</button>" + textStatus + "</div>")
      .insertBefore("#addNote");
    success: (data, textStatus, jqXHR) ->
      if(data.length == 0)
        $("<div id='messageBox' class='alert alert-success fade in'>" +
            "<button type='button' class='close' data-dismiss='alert'>&times;</button>You have no notes!</div>")
        .insertBefore("#addNote");
      else
        $("#noteTableBody").empty();
        $.each data, (index, elem) ->
          date = new Date(elem.dateCreate)
          $("#noteTable tbody").append("<tr><td style='display:none'>" + elem.id + "</td>" +
              "<td>" + date + "</td>" +
              "<td>" + elem.text + "</td>" +
              "<td><a onclick='selectNote(this)'><span class='glyphicon glyphicon-pencil' data-toggle='tooltip' title='Edit note'/></a>   " +
              "<a onclick='deleteNote(this)'><span class='glyphicon glyphicon-remove' data-toggle='tooltip' title='Delete note'/></td></tr>")

root = exports ? this
root.selectNote = (tmp) ->
  id = +($(tmp).parents('tr:first').find('td:first').text())
  $("#errorBox").remove()
  $("#messageBox").remove()
  r = jsRoutes.controllers.Notes.getNote(id)
  $.ajax
    url: r.url
    type: r.type
    context: this
    error: (jqXHR, textStatus, errorThrown) ->
      $("<div id='errorBox' class='alert alert-danger fade in'>" +
          "<button type='button' class='close' data-dismiss='alert'>&times;</button>" + textStatus + "</div>")
      .insertBefore("#addNote")
    success: (data, textStatus, jqXHR) ->
      $("#addNote").hide()
      $("#editNote").show()
      $("#selectedNote").attr("name", data.id)
      $("#noteText").val(data.note)

root = exports ? this
root.deleteNote = (tmp) ->
  id = +($(tmp).parents('tr:first').find('td:first').text())
  $("#errorBox").remove()
  $("#messageBox").remove()
  r = jsRoutes.controllers.Notes.delete(id)
  $.ajax
    url: r.url
    type: r.type
    context: this
    error: (jqXHR, textStatus, errorThrown) ->
      $("<div id='errorBox' class='alert alert-danger fade in'>" +
          "<button type='button' class='close' data-dismiss='alert'>&times;</button>" + textStatus + "</div>")
      .insertBefore("#addNote")
    success: (data, textStatus, jqXHR) ->
      $("<div id='messageBox' class='alert alert-success fade in'>" +
          "<button type='button' class='close' data-dismiss='alert'>&times;</button>Note successfully deleted</div>")
      .insertBefore("#addNote")
      $("#addNote").show()
      $("#editNote").hide()
      $("#selectedNote").removeAttr("name")
      getNotes()

$(document).ready ->
  $("#addNote").on "click", ->
    text = $('#noteText').val()
    $("#errorBox").remove()
    $("#messageBox").remove()
    r = jsRoutes.controllers.Notes.create(text)
    $.ajax
      url: r.url
      type: r.type
      context: this
      error: (jqXHR, textStatus, errorThrown) ->
        $("<div id='errorBox' class='alert alert-danger fade in'>" +
            "<button type='button' class='close' data-dismiss='alert'>&times;</button>" + textStatus + "</div>")
        .insertBefore("#addNote")
      success: (data, textStatus, jqXHR) ->
        $("<div id='messageBox' class='alert alert-success fade in'>" +
            "<button type='button' class='close' data-dismiss='alert'>&times;</button>Note added</div>")
        .insertBefore("#addNote")
        $("#noteText").val('')
        getNotes()

$(document).ready ->
  $("#editNote").on "click", ->
    id = $("#selectedNote").attr('name')
    note = $('#noteText').val()
    $("#errorBox").remove()
    $("#messageBox").remove()
    r = jsRoutes.controllers.Notes.update(id, note)
    $.ajax
      url: r.url
      type: r.type
      context: this
      error: (jqXHR, textStatus, errorThrown) ->
        $("<div id='errorBox' class='alert alert-danger fade in'>" +
            "<button type='button' class='close' data-dismiss='alert'>&times;</button>" + textStatus + "</div>")
        .insertBefore("#addNote")
      success: (data, textStatus, jqXHR) ->
        $("<div id='messageBox' class='alert alert-success fade in'>" +
            "<button type='button' class='close' data-dismiss='alert'>&times;</button>Note updated</div>")
        .insertBefore("#addNote")
        $("#noteText").val('')
        $("#addNote").show()
        $("#editNote").hide()
        $("#selectedNote").removeAttr("name")
        getNotes()


$(document).ready ->
  $("#registredUser").on "click", ->
    $("#errorBox").remove()
    username = $("#username").val()
    password = $("#password").val()
    confirmPassword = $("#confirmPassword").val()
    if(!username.trim() || !password.trim() || !confirmPassword.trim())
      $("<div id='errorBox' class='alert alert-danger fade in'>" +
          "<button type='button' class='close' data-dismiss='alert'>&times;</button>All fields are required!</div>")
      .insertBefore("#registrationForm")
    else
      if(password != confirmPassword)
        $("<div id='errorBox' class='alert alert-danger fade in'>" +
            "<button type='button' class='close' data-dismiss='alert'>&times;</button>Passwords aren't match!</div>")
        .insertBefore("#registrationForm")
      else
        r = jsRoutes.controllers.Application.registered(username, password)
        $.ajax
          url: r.url
          type: r.type
          context: this
          error: (jqXHR, textStatus, errorThrown) ->
            $("<div id='errorBox' class='alert alert-danger fade in'>" +
                "<button type='button' class='close' data-dismiss='alert'>&times;</button>" + textStatus + "</div>")
            .insertBefore("#registrationForm")
          success: (data, textStatus, jqXHR) ->
            if(data == "Success")
              window.location.replace("/")
            else
              $("<div id='messageBox' class='alert alert-danger fade in'>" +
                  "<button type='button' class='close' data-dismiss='alert'>&times;</button>" + data + "</div>")
              .insertBefore("#registrationForm")