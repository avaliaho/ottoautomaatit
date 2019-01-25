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
            Postitoimipaikka: <input type="text" name="postitoimipaikka">
            <input type="submit" name="haku">
        </form><br>
        <%            if (request.getParameter("haku") != null) {
                String postitoimipaikka = request.getParameter("postitoimipaikka");
                Iterable<CSVRecord> automaatit = ottoautomaatti.haeAutomaatit(postitoimipaikka, 0);
                String merkkijono = "<table border='1px' cellpadding='3'><tr><th>Osoite</th><th>Sijaintipaikka</th><th>Aukioloaika</th></tr>";

                for (CSVRecord automaatti : automaatit) {
                    merkkijono += "<tr><td>" + automaatti.get("Kohteen osoite") + ", "
                            + automaatti.get("Postinumero") + " " 
                            + automaatti.get("Postitoimipaikka")
                            + "</td><td>" + automaatti.get("Sijaintipaikan tyyppi") + ", "
                            + automaatti.get("Sijaintipaikka") + "</td><td>"
                            + automaatti.get("Aukioloaika") + "</td></tr>";
                }

                merkkijono += "</table>";
                out.println(merkkijono);
            }

        %>
    </body>
</html>
