// create a fortune
// http://api.jquery.com/jquery.post/
//
fortune = { text: "Walk through life like a badass." };
$.post("/fortunes.json", fortune, function() {
  alert("New fortune accepted");
});

// read a fortune
// https://api.jquery.com/jquery.get/
//
$.get("/fortunes/random.json", function(data) {
  alert("Read some data: " + data);
});

// update a fortune
// http://api.jquery.com/jquery.ajax/
//
requestData = {
  method: "PUT",
  url: "/fortunes/8.json",
  data: { text: "You are confused; but clarity will come soon." }
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
  url: "/fortunes/8.json"
};

var request = $.ajax(requestData);
request.done(function(msg) {
  alert("Deleted that terrible fortune: " + msg);
});
