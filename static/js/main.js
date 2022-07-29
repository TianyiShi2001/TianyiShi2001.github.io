function toggleNav(x) {
  $(x).toggleClass("change");
  if ($(x).hasClass("change")) {
    $("#main-nav").height("100%");
    $("#nav-button").prop("title", "Close menu");
  } else {
    $("#main-nav").height("0%");
    $("#nav-button").prop("title", "Open menu");
  }
}

if (window.matchMedia("(max-width: 700px)").matches) {
  var prevScrollpos = window.pageYOffset;
  window.onscroll = function() {
    var currentScrollPos = window.pageYOffset;
    if (currentScrollPos > prevScrollpos + 50) {
      // hide
      document.getElementById("navbar").style.top = "-70px";
      $("#nav-button").addClass("bottom");
    } else if (currentScrollPos < prevScrollpos - 50) {
      // restore
      document.getElementById("navbar").style.top = "0";
      $("#nav-button").removeClass("bottom");
    }
    prevScrollpos = currentScrollPos;
  };
}

function rip(x) {
  $("html").css("filter", "grayscale(0)");
  $(x).css("opacity", "0");
}
