<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
<!--<xsl:import href="html/chunktoc.xsl"/>-->
<xsl:import href="chunkfast.xsl"/>
<xsl:import href="docbook-to-html.xsl"/>

<!-- Change metatitle (window titlebar) to "Kawa: PAGE-TITLE" -->
<xsl:template match="*" mode="object.title.markup.textonly">
  <xsl:variable name="title">
    <xsl:apply-templates select="." mode="object.title.markup"/>
  </xsl:variable>Kawa: <xsl:value-of select="normalize-space($title)"/>
</xsl:template>

<xsl:template name="extra.header.navigation">
  <ul>
    <li><a href="toc.html">Table of Contents</a></li>
    <li><a href="tutorial/index.html">Tutorial</a></li>
    <li><a href="news.html">News: Recent changes</a></li>
  </ul>
</xsl:template>

<!-- Same as in common/common.xsl except for using $object/title. -->
<xsl:template name="object.id">
  <xsl:param name="object" select="."/>
  <xsl:choose>
    <xsl:when test="$object/@id">
      <xsl:value-of select="$object/@id"/>
    </xsl:when>
    <xsl:when test="$object/@xml:id">
      <xsl:value-of select="$object/@xml:id"/>
    </xsl:when>
    <!-- If $object has a title child, use that. -->
    <xsl:when test="$object/title">
      <xsl:value-of select="translate($object/title,' ','-')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="generate-id($object)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
