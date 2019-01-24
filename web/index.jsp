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
            Sivunumero: <select name="sivu">
                <%                    
                    long kokonaismaara = ottoautomaatti.getKokonaismaara();
                    int per_sivu = 100;
                    
                    for (int i = 0; i < (kokonaismaara/per_sivu); i++) {
                        out.println("<option value='" + i + "'>" + i + "</option>");
                    }
                %>
            </select>
            <input type="submit" name="haku">
        </form><br>

        <%
            Iterable<CSVRecord> automaatit = ottoautomaatti.haeAutomaatit("", 0);
            System.out.println(automaatit);
            String merkkijono = "<table border='1' cellpadding='3'><tr><th>Osoite</th><th>Sijaintipaikka</th><th>Aukioloaika</th></tr>";
            
            if (request.getParameter("sivu") != null) {
                String postitoimipaikka = request.getParameter("postitoimipaikka");
                int sivu = Integer.valueOf(request.getParameter("sivu"));
                automaatit = ottoautomaatti.haeAutomaatit(postitoimipaikka, sivu);
            }

            for (CSVRecord automaatti : automaatit) {                
                merkkijono += "<tr><td>" + automaatti.get("Kohteen osoite") 
                        + "<br>" + automaatti.get("Postinumero")
                        + "<br>" + automaatti.get("Postitoimipaikka") + "</td>"
                        + "<td>" + automaatti.get("Sijaintipaikka") + 
                        "<br>" + automaatti.get("Sijaintipaikan tyyppi") + "</td>"
                        + "<td>" + automaatti.get("Aukioloaika")
                        + "<br>" + automaatti.get("Aukioloaika (lisätiedot)")
                        + "</td></tr>";                
            }
            
            merkkijono += "</table>";
            out.println(merkkijono);

        %>
    </body>
</html>
