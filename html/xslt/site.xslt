<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xsi="http://www.w3.org/2000/10/XMLSchema-instance"
xmlns:html="http://www.w3.org/1999/xhtml"
xsi:schemaLocation="
    http://www.w3.org/1999/XSL/Transform
    http://www.w3.org/2007/schema-for-xslt20.xsd"
>
    <xsl:template match="/">
        xsl:for-each>xsl:if
        <xsl:for-each select="/html/body/div[@class='document']" >
            <xsl:if test="name() = 'h2'">
                test
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="html:h2">
        <title>
            <xsl:value-of select="."/>
        </title>
        
    </xsl:template>
   
</xsl:stylesheet>