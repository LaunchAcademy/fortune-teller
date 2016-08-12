// example code

// create a fortune
// http://api.jquery.com/jquery.post/
//
fortune = { content: "Walk through life like a badass." };
$.post("/api/v1/fortunes.json", fortune, function() {
  alert("New fortune accepted");
});

// read a fortune
// https://api.jquery.com/jquery.get/
//
$.get("/api/v1/fortunes/random.json", function(response) {
  alert("Read some data: " + response.content);
});

$.get("/api/v1/fortunes/8.json", function(response) {
  alert("Read some data: " + response.content);
});

// update a fortune
// http://api.jquery.com/jquery.ajax/
//
requestData = {
  method: "PUT",
  url: "/api/v1/fortunes/8.json",
  data: { content: "You are confused; but clarity will come soon." }
};

var request = $.ajax(requestData);
request.done(function(msg) {
  alert("Fixed that terrible fortune: " + msg);
});

// delete a fortune
// http://api.jquery.com/jquery.ajax/
//
requestData = {
  method: "DELETE",
  url: "/api/v1/fortunes/8.json"
};

var request = $.ajax(requestData);
request.done(function(msg) {
  alert("Deleted that terrible fortune: " + msg);
});
