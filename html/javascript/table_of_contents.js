$(document).ready(function() {
   var contents = $('<div><ul></ul></div>');
   var tocDiv = $("#toc");
   tocDiv.append($("<h3>Table of Contents</h3>"));
   tocDiv.append(contents);
   var list = contents.children("ul");
   $("h2").each(function(i, elm) {
       var headerText = elm.innerHTML;
       var anchorText = escape(headerText);
       $(elm).wrap('<a name="' + anchorText + '" />');
       list.append($('<li><a href="#' + anchorText + '">' + headerText + '</a></li>'));
   });
});
