// Shared top menu: every page includes <div id="nav"></div> and this script.
(function () {
  var items = [
    ["index.html", "Architecture"],
    ["concepts.html", "Concepts"],
    ["sop.html", "SOP: step by step"],
    ["alternatives.html", "Alternatives"],
    ["responsible.html", "Responsible use"]
  ];
  var here = location.pathname.split("/").pop() || "index.html";
  var html = '<nav class="topnav" aria-label="Main"><div class="in">' +
    '<a class="brand" href="index.html">Lo<b>RA</b> Lab</a><ul>' +
    items.map(function (i) {
      return '<li><a href="' + i[0] + '"' + (i[0] === here ? ' aria-current="page"' : "") + ">" + i[1] + "</a></li>";
    }).join("") + "</ul></div></nav>";
  var el = document.getElementById("nav");
  if (el) el.outerHTML = html;
})();
