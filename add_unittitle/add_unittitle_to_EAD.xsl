<?xml version='1.0'?>
<!--
//*****************************************************************************
// The unitid algorithm for EHRI
// authors: 
// 
// Distributed under the GNU General Public Licence
//*****************************************************************************
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="urn:isbn:1-931666-22-9"
  xmlns:ead="urn:isbn:1-931666-22-9"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  version="2.0">
  <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>
  <xsl:output encoding="UTF-8"/>


  <xsl:template match="/ead:ead">
      <!-- Output one file:
            - updated EAD with new <unittitle>s -->
    
    <!-- New EAD file -->  
      <ead>
        <xsl:copy-of select="ead:eadheader" />
        <xsl:copy-of select="ead:frontmatter" />
        <xsl:apply-templates select="ead:archdesc" />
      </ead>
    
  </xsl:template>

  <!-- On every level in the EAD... -->
  <xsl:template match="ead:archdesc|ead:c|ead:c01|ead:c02|ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12">

    <xsl:element name="{name(.)}">
        <xsl:apply-templates select="@*" />
        <xsl:apply-templates select="ead:did[not(ead:unittitle)]" />
        <xsl:apply-templates select="node()[not(self::ead:did[not(ead:unittitle)])]" />
    </xsl:element>
  </xsl:template>

  <!-- ... add a unittitle if there is none -->
  <xsl:template match="ead:did[not(ead:unittitle)]">
    <xsl:element name="did">
        <xsl:apply-templates select="@*" />
        
        <!-- $currenttitle will hold the existing title, or a generated title based on
        the parent title -->
        <xsl:variable name="currenttitle">
            <xsl:choose>
                <xsl:when test="not(exists(ead:unittitle)) and ead:unitid[1] != ''">
                    <xsl:value-of select="concat(../../ead:did/ead:unittitle[1], ' / ', ead:unitid[1])" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="ead:unittitle" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <unittitle><xsl:value-of select="$currenttitle"/></unittitle>
        
        <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

    <xsl:template match="@*|node()">
      <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
