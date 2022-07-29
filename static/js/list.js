var mq = window.matchMedia("(max-width: 1024px)");

var articles = document.getElementsByClassName("archive-item");

var showPreview = function () {
  this.lastElementChild.style.display = "block";
  document.getElementById("about").style.display = "none";
};

var hidePreview = function () {
  this.lastElementChild.style.display = "none";
  document.getElementById("about").style.display = "block";
};

for (var i = 0; i < articles.length; i++) {
  articles[i].addEventListener("mouseover", showPreview);
}

for (var i = 0; i < articles.length; i++) {
  articles[i].addEventListener("mouseout", hidePreview);
}

a = function () {
  if (mq.matches) {
    for (var i = 0; i < articles.length; i++) {
      articles[i].removeEventListener("mouseover", showPreview);
      articles[i].removeEventListener("mouseout", hidePreview);
      document.getElementById("about").style.display = "none";
    }
  } else {
    for (var i = 0; i < articles.length; i++) {
      articles[i].addEventListener("mouseover", showPreview);
      articles[i].addEventListener("mouseout", hidePreview);
      document.getElementById("about").style.display = "block";
    }
  }
};

a();

window.addEventListener("resize", a);

function fetchAndAppend(e) {
  if (!e.getAttribute("loaded") && !e.getAttribute("loading")) {
    e.setAttribute("loading", 1);
    let summaryDiv = e.parentElement.getElementsByClassName("article-summary")[0];

    let loading = document.createElement("div");
    loading.innerHTML = "<h2>loading preview...<h2>";
    summaryDiv.appendChild(loading);

    url = e.getAttribute("href");
    fetch(url)
      .then((res) => res.text())
      .then((data) => {
        let el = document.createElement("html");
        el.innerHTML = data;
        let res = document.createElement("div");
        res.appendChild(el.getElementsByTagName("article")[0]);
        summaryDiv.appendChild(res);
        console.log("loaded");
        e.setAttribute("loaded", 1);
        summaryDiv.removeChild(loading);
      })
      .catch(console.err);
  } else {
    console.log("already loaded");
  }
}
