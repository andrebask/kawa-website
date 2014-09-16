#!/bin/bash

cd doc_

sed -i 's,</head>,<link rel="stylesheet" href="../kawa.css" type="text/css" media="all">\
</head>,' *.html

sed -i 's,<div class="navcol">,\
<div class="header">\
    <a href="index.html"><img class="logo" src="kawa-logo.png"/></a>\
    <h1><a href="index.html">The Kawa Scheme Language</a></h1>\
</div>\
<div class="navcol">,' *.html