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
            <input type="hidden" name="sivu" value="0">
            <input type="submit" name="haku">
        </form><br>
        <%      if (request.getParameter("haku") != null) {
                String postitoimipaikka = request.getParameter("postitoimipaikka");
                int sivu = Integer.valueOf(request.getParameter("sivu"));
                Iterable<CSVRecord> automaatit = ottoautomaatti.haeAutomaatit(postitoimipaikka, sivu);
                String merkkijono = "<table border='1px' cellpadding='3'><tr><th>Osoite</th><th>Sijaintipaikka</th><th>Aukioloaika</th></tr>";

                long sivumaara = ottoautomaatti.getSivumaara(postitoimipaikka);
                long linkkimaara = 0;

                if (sivumaara % 100 > 0) {
                    linkkimaara = (sivumaara / 100) + 1;
                } else {
                    linkkimaara = sivumaara / 100;
                }
                
                out.println("Siirry sivulle: ");
                
                for (int i = 0; i < linkkimaara; i++) {
                    out.println("<a href='http://localhost:8080/ottoautomaatit/?postitoimipaikka=" 
                            + postitoimipaikka + "&haku=Lähetä&sivu=" + i + "'>" + i + "</a>");
                }
                
                out.println("<br><br>");

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