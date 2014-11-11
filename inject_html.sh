#!/bin/bash

cd doc

# add new css
sed -i 's,</head>,<link rel="stylesheet" href="../kawa-layout.css" type="text/css" media="all">\
</head>,' *.html

# delete old javascript (utils.js)
sed -i 's,<script language="JavaScript" type="text/javascript" src="style/utils.js"></script><meta name="generator" content="DocBook XSL Stylesheets V1.78.1">,,' *.html

# delete old body
sed -i 's,<body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF" onload="javascript:onLoadHandler();" onunload="javascript:onUnloadHandler();">,,' *.html

# delete old logo
sed -i 's,<div class="logo"><a href="index.html"><img src="style/kawa-logo.png"></a></div>,,' *.html

# add new layout
sed -i 's,<div class="navcol">,\
<body>\
<div class="header">\
    <a href="../index.html"><img class="logo" src="kawa-logo.png"/></a>\
    <h1><a href="../index.html">The Kawa Scheme Language</a></h1>\
</div>\
<div class="content">\
<div class="navcol">,' *.html

# close layout
sed -i 's,</body>,</div>\
 </body>,' *.html

cd tutorial

# add new css
sed -i 's,</head>,<link rel="stylesheet" href="../../kawa-layout.css" type="text/css" media="all">\
</head>,' *.html

# delete old javascript (utils.js)
sed -i 's,<script language="JavaScript" type="text/javascript" src="style/utils.js"></script><meta name="generator" content="DocBook XSL Stylesheets V1.78.1">,,' *.html

# delete old body
sed -i 's,<body bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF" onload="javascript:onLoadHandler();" onunload="javascript:onUnloadHandler();">,,' *.html

# delete old logo
sed -i 's,<div class="logo"><a href="index.html"><img src="style/kawa-logo.png"></a></div>,,' *.html

# add new layout
sed -i 's,<div class="navcol">,\
<body>\
<div class="header">\
    <a href="../../index.html"><img class="logo" src="../kawa-logo.png"/></a>\
    <h1><a href="../../index.html">The Kawa Scheme Language</a></h1>\
</div>\
<div class="content">\
<div class="navcol">,' *.html

# close layout
sed -i 's,</body>,</div>\
 </body>,' *.html
