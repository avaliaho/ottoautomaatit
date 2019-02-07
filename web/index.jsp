<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="ottoautomaatti" class="csv.Client"/>
<jsp:directive.page import="java.util.ArrayList" />
<jsp:directive.page import="org.apache.commons.csv.*"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

        <title>Ottoautomaatit</title>

    </head>
    <body>
        <div class="container">
            <h1>Ottoautomaatit</h1>

            <form class="form-inline">
                <div class="form-group mb-2">
                    <input type="text" class="form-control" placeholder="Postitoimipaikka" name="postitoimipaikka">
                </div>
                <div class="form-group mx-sm-1 mb-2">
                    <input type="hidden" name="sivu" value="0">                
                </div>
                <button type="submit" name="haku" class="btn btn-primary mb-2">Lähetä</button>
            </form>

            <%      if (request.getParameter("haku") != null) {
                    String postitoimipaikka = request.getParameter("postitoimipaikka");
                    int sivu = Integer.valueOf(request.getParameter("sivu"));
                    Iterable<CSVRecord> automaatit = ottoautomaatti.haeAutomaatit(postitoimipaikka, sivu);
                    String merkkijono = "<table class='table table-bordered'><tr><th>Osoite</th><th>Sijaintipaikka</th><th>Aukioloaika</th></tr>";

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
                    
                    out.println("Siirry sivulle: ");

                    for (int i = 0; i < linkkimaara; i++) {
                        out.println("<a href='http://localhost:8080/ottoautomaatit/?postitoimipaikka="
                                + postitoimipaikka + "&haku=Lähetä&sivu=" + i + "'>" + i + "</a>");
                    }
                    out.println("<br><br>");
                }
            %>
        </div>
    </body>
</html>