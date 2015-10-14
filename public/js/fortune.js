$("#new-fortune").on("click", function(event) {
  event.preventDefault();
  $.get("/fortunes/random.json", function(newFortune) {
    $("#fortune").text(newFortune.text);
  });
});

$("#submit-fortune").on("click", function(event) {
  event.preventDefault();
  var userFortune = $('#new-user-fortune').val()

  var request = $.ajax({
    method: "POST",
    data: { text: userFortune },
    url: "/fortunes.json"
  });

  request.success(function() {
    alert("Success!");
    $("ul.fortunes").append("<li>" + userFortune + "</li>");
    $('#new-user-fortune').val() = "";
  });
});
