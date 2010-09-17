
// render table of contents
$(document).ready(function() {
   var contents = $('<div><ul></ul></div>');
   var tocDiv = $("#toc");
   tocDiv.append($("<a name=\"toc\"><h3>Table of Contents</h3></a>"));
   tocDiv.append(contents);
   var list = contents.children("ul");
   $("h2").each(function(i, elm) {
       var headerText = elm.innerHTML;
       var anchorText = escape(headerText);
       $(elm).wrap('<a name="' + anchorText + '" />');
       list.append($('<li><a href="#' + anchorText + '">' + headerText + '</a></li>'));
   });
});

// provide always on toc link
$(document).ready(function() {
   var element = $('<div style="position: fixed; top: 10px; left: 10px; display: none"><a href="#toc">Table of Contents</a></div>');
   $("body").append(element);
   $(document).scroll(function() {
     if($(document).scrollTop() != 0) {
       element.show();
     } else {
       element.hide();
     }
   });
});
