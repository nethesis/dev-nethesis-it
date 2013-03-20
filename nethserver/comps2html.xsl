<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dyn="http://exslt.org/dynamic"
                >

  <xsl:param name="date" />
  <xsl:param name="urlPrefix" />

  <xsl:template match="/comps">
    <html>
      <head>
	<title>NethServer package groups</title>
      </head>
      <body>
	<h1>NethServer package groups</h1>
	<p>Generated on: <xsl:value-of select="$date" /></p>
	  <xsl:apply-templates />
      </body>
    </html>   
  </xsl:template>

  <xsl:template match="//group">
    <h2><xsl:value-of select="name"/></h2>
    <p class="group-id"><xsl:value-of select="id" /></p>
    <p class="group-description"><xsl:value-of select="description" /></p>
    <xsl:choose>
      <xsl:when test="uservisible = 'true'">
	<xsl:apply-templates select="packagelist"/>
      </xsl:when>
      <xsl:otherwise>
	<p>hidden group</p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="packagelist">
    <ul>
      <xsl:apply-templates />
    </ul>
  </xsl:template>

  <xsl:template match="packagereq">
    <xsl:element name="li">
	<xsl:attribute name="class">package <xsl:value-of select="@type"/></xsl:attribute>
	<xsl:element name="a">
	  <xsl:attribute name="href"><xsl:value-of select="$urlPrefix" />/projects/nethserver/wiki/<xsl:value-of select="." /></xsl:attribute>
	  <xsl:value-of select="." />
	</xsl:element>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
