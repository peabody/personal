<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:h="http://www.w3.org/1999/xhtml"
>
    
    <!--
    
    My personal reference for the all xslt functions (for xslt 1.0 anyway)
    
    First for the node tests.  These aren't technically functions.  Rather they
    are functions that can be applied to a node list to retrieve child node types.
    
    *                        - all child elements
    text()                   - all child text nodes
    processing-instruction() - all xml processing instructions
    comment()                - all child comments of the every node in the list
    node()                   - the collection of all node types
    namespace-node()         - namespace node which applies to current element
    @*                       - nodes which have attributes
    
    axes
    
    child::              - (default)
    parent::             - Can be abbreviated to '..'
    self::               - Can be abbreviated to '.'
    attributes::         - Can be abbreviated to '@'
    descendant::         - All recursively descended nodes excluding self
    descendant-or-self:: - All recursively descended nodes including self
    ancestor::           - All recursive parents excluding self
    ancestor-or-self::   - All recursive parents including self
    following::          - All following siblings and their descendants
    preceding::          - All preceding siblings and their descendants
    following-siblings:: - Only following siblings
    preceding-siblings:: - Only preceding siblings
    namespace::          - Namespace node
    
    functions
    
    position()            - current node's position (in document order) among siblings, starting from 1
    name(arg?)            - name of the current node (including mapped namespace prefix)
    local-name(arg?)      - the local name of an element or attribute (no namespace prefix)
    current()             - current context node (usually only relevant within xslt)
    count(arg?)           - the current count of nodes for the given context node
    string-length(string) - the length of a strings
    ceil(arg?)            - round up to nearest integer (implies interpretation as number)
    floor(arg?)           - round down to nearest integer (implies interpretation as number)
    translate(string, src, dst) - perform character translation
    string(arg?)          - force interpretation as string (generally only used for comparison operators)
    number()              - forces interpretation as number (generally only used for comparison operators)
    format-number()       - #,. (#! for literal hash mark)
    format-time()         -
    format-date()         -
    format-dateTime()     -
    not()
    starts-with()
    
    operators
    
    +     Add                    - Self explanitory
    -     Subtract               - Self explanitory
    div   divide                 - Floating point division (always)
    mod   modulus                - Integer based modulous division
    =     equality               - Equality comparison (automatic type conversion involved)
    !=    not equal              - Non equality comparison (automatic type conversion involved)
    &gt;  greater than           - Same idea
    &lt;  less than              - Same idea
    &gt;= greater than or equal  - Same idea
    &lt;= less than or equal     - Same idea
    
    Type conversion rules
    - Strings convert to numbers
    
    quirks with expressions in xslt
    
    - Expressions that start with a '/' are always absolute (they disregard the
      current context). This means that '//' is always from the top of the
      document, regardless of the current context node. This requires you to
      make use of the rarely used 'self' axis ('.//').
      
    - Using brackets ([]) to denote a predicate expression is unnecessary in the
      "test" attribute of the xsl:if tag.
      
    - <xsl:value-of select="body"/> implicitly outputs the descendant text
      nodes, concatenated.
      
    - The "match" attribute of the xsl:template tag does not take a full XPath
      expression. Rather, it takes an element identifier, a node test, or a
      union of such things.  Several other xsl elements have attributes which
      take elements like this (xsl:number's "count" argument, just to name one).
      
    - If more than one template matches an expression the template which matches
      the more specific (smaller node set) group of nodes applies.
    
    -->
    
    <xsl:template match="/" name="main">
        <test-reformat>
            <xsl:apply-templates select="h:html/h:body/h:div[@class='document']/*" />
        </test-reformat>
    </xsl:template>
    
    <xsl:template match="h:h1">
        <section-heading>
            <xsl:value-of select="." />
        </section-heading>
    </xsl:template>
    
    <xsl:template match="h:h2">
        <!-- <xsl:if test="string-length(@name) > 0"> -->
            <section>
                <heading>
                    <xsl:value-of select="." />
                </heading>
                <content>
                    <xsl:call-template name="processParagraphs" >
                        <xsl:with-param name="siblings" select="following-sibling::*[1]" />
                    </xsl:call-template>
                </content>
            </section>
        <!-- </xsl:if> -->
    </xsl:template>
    
    <xsl:template name="processParagraphs">
        <xsl:param name="siblings" />

        <xsl:for-each select="$siblings">
            <xsl:if test="local-name() != 'h2'">
                <xsl:copy-of select="." />
                <xsl:call-template name="processParagraphs">
                    <xsl:with-param name="siblings" select="following-sibling::*[1]" />
                </xsl:call-template>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
   
</xsl:stylesheet>