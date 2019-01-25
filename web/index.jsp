<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="ottoautomaatti" class="csv.Client"/>
<jsp:directive.page import="java.util.ArrayList" />
<jsp:directive.page import="org.apache.commons.csv.*"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ottoautomaatit</title>
    </head>
    <body>
        <h1>Ottoautomaatit</h1>

        <form method="get">
            <input type="text" name="postitoimipaikka">
            <input type="number" name="sivu">
            <input type="submit" name="haku">
        </form><br>
        <%
        
        if (request.getParameter("haku") != null) {
            String postitoimipaikka = request.getParameter("postitoimipaikka");
            int sivu = Integer.valueOf(request.getParameter("sivu"));
            Iterable<CSVRecord> automaatit = ottoautomaatti.haeAutomaatit(postitoimipaikka, sivu);
            
            for (CSVRecord automaatti: automaatit) {
                out.println(automaatti);
            }
        }
        
        %>
    </body>
</html>
