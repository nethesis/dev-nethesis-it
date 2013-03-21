<?xml version="1.0" encoding="utf-8"?>
<!--
    comps2html.xsl

    Author: Davide Principi <davide.principi@nethesis.it>

    Copyright (C) 2013 Nethesis S.r.l.
    http://www.nethesis.it - support@nethesis.it
    
    This script is part of NethServer.
    
    NethServer is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License,
    or any later version.
    
    NethServer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with NethServer.  If not, see <http://www.gnu.org/licenses/>.
     
-->
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
	<style type="text/css"><![CDATA[
	   body { background: #eee; margin: 0 }
	   .document { font-family: sans-serif; max-width: 64em; background: white; padding: 2em 2em 2em 3em; border-right: 1px solid #ccc }
	   h1, h2 { color: #1D247C; letter-spacing: 2px; font-weight: normal; position: relative; left: -1em }
	   h2 { margin: 2em 0 0.2em 0; border-bottom: 1px solid #1d247c }
	   .group-description { margin-top: .3em }
	   .toc .packagelist {padding: 0}
	   .toc a {text-decoration: none}
	   .toc li, .packagelist li { list-style: none; display: block }
	   .optional { font-style: italic }
	   .optional:after { content: " (optional)" }

	]]></style>	
      </head>
      <body>
	<div class="document">
	  <h1>NethServer package groups</h1>
	  <p><small>
	    Generated on <xsl:value-of select="$date" /> by 
	    <xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="$urlPrefix" />/nethserver/comps2html.xsl</xsl:attribute>comps2html.xsl</xsl:element></small>
	  </p>
	  <ul class="toc">
	    <xsl:apply-templates mode="toc" />
	  </ul>
	  <xsl:apply-templates />
	</div>
      </body>
    </html>   
  </xsl:template>

  <xsl:template match="//group" mode="toc">
    <li>
	<xsl:element name="a">
	  <xsl:attribute name="href">#<xsl:value-of select="id" /></xsl:attribute>
	  <xsl:value-of select="name" />
	</xsl:element>
    </li>
  </xsl:template>

  <xsl:template match="//group">
    <xsl:element name="h2">
      <xsl:attribute name="id"><xsl:value-of select="id"/></xsl:attribute>
      <xsl:value-of select="name"/>
    </xsl:element>

    <p class="group-description">    
      <xsl:value-of select="description" /><br/>
      <tt><xsl:value-of select="id" /></tt>
    </p>
    <xsl:choose>
      <xsl:when test="uservisible = 'true'">
	<xsl:apply-templates select="packagelist"/>
      </xsl:when>
      <xsl:otherwise>
	<p><em>hidden group</em></p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="packagelist">
    <ul class="packagelist">
      <xsl:apply-templates />
    </ul>
  </xsl:template>

  <xsl:template match="packagereq">
    <xsl:element name="li">
	<xsl:attribute name="class">package <xsl:value-of select="@type"/></xsl:attribute>
	<xsl:choose>
	  <xsl:when test="starts-with(., 'nethserver-')">
	<xsl:element name="a">
	  <xsl:attribute name="href"><xsl:value-of select="$urlPrefix" />/projects/nethserver/wiki/<xsl:value-of select="." /></xsl:attribute>
	  <xsl:value-of select="." />
	</xsl:element>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="." />
	  </xsl:otherwise>
	</xsl:choose>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
