<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

    <xsl:output
        method="html"
    />

    <xsl:template match="expenses">
        <html lang="en">
            <head>
                <title>Expense Report</title>
            </head>
            <body>
                <h1>Expense Report</h1>
                <table>
                    <thead>
                        <tr><th scope="col">Type</th><th scope="col">Amount</th><th scope="col">Over Limit</th></tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="expense">
                            <tr>
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="@type = 'DINNER'">
                                            <xsl:text>Dinner</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'BREAKFAST'">
                                            <xsl:text>Breakfast</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'CAR_RENTAL'">
                                            <xsl:text>Car Rental</xsl:text>
                                        </xsl:when>
                                    </xsl:choose>
                                </td>
                                <td><xsl:value-of select="@amount"/></td>
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="@type = 'DINNER' and @amount > 5000 or @type = 'BREAKFAST' and @amount > 1000">
                                            <xsl:text>X</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
                <p>Meal Expenses: <xsl:value-of select="sum(expense[@type = 'DINNER' or @type = 'BREAKFAST']/@amount)"/></p>
                <p>Total Expenses: <xsl:value-of select="sum(expense/@amount)"/></p>
            </body>
        </html>
    </xsl:template>

</xsl:transform>
