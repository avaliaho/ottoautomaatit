package csv;

import java.util.*;
import java.net.URL;
import java.io.*;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

public class Webservice extends HttpServlet {

    CSVFormat csvformaatti = null;
    URL polku = null;
    Reader tiedosto = null;
    CSVParser csvrakentaja = null;
    BufferedReader input = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter kirjoittaja = response.getWriter();
        response.setContentType("text/plain");

        // vaatii oikeamuotoista csv-dataa
        polku = Webservice.class.getResource("ottokoordinaatit2018_12_29_fi.csv");
        tiedosto = new FileReader(polku.getFile());
        Iterable<CSVRecord> automaatit = CSVFormat.EXCEL.withHeader().parse(tiedosto);

        if (request.getParameter("postitoimipaikka") != null
                && !request.getParameter("postitoimipaikka").isEmpty()
                && request.getParameter("sivu") == null) {
            String haku = request.getParameterValues("postitoimipaikka")[0];

            kirjoittaja.println("Indeksi,Kohteen osoite,Postinumero,"
                    + "Postitoimipaikka,Sijaintipaikan tyyppi,Sijaintipaikka,Aukioloaika,"
                    + "Aukioloaika (lisätiedot)");
            int indeksi = 0;
            for (CSVRecord automaatti : automaatit) {
                if (Objects.equals(automaatti.get("Postitoimipaikka"),
                        request.getParameterValues("postitoimipaikka")[0].toUpperCase())) {
                    kirjoittaja.println(
                            indeksi + ","
                            + automaatti.get("Kohteen osoite") + ","
                            + automaatti.get("Postinumero") + ","
                            + automaatti.get("Postitoimipaikka") + ","
                            + automaatti.get("Sijaintipaikan tyyppi") + ","
                            + automaatti.get("Sijaintipaikka") + ","
                            + automaatti.get("Aukioloaika") + ","
                            + automaatti.get("Aukioloaika (lisätiedot)"));
                    indeksi += 1;
                }
            }

        }

        if (request.getParameter("postitoimipaikka") != null
                && request.getParameter("sivu") != null) {

            int sivu = Integer.valueOf(request.getParameter("sivu"));
            int indeksi = 0;
            int per_sivu = 100;

            kirjoittaja.println("Indeksi,Kohteen osoite,Postinumero,"
                    + "Postitoimipaikka,Sijaintipaikan tyyppi,Sijaintipaikka,Aukioloaika,"
                    + "Aukioloaika (lisätiedot)");
            for (CSVRecord automaatti : automaatit) {
                if (Objects.equals(automaatti.get("Postitoimipaikka"),
                        request.getParameterValues("postitoimipaikka")[0].toUpperCase())) {
                    if (indeksi >= (sivu * per_sivu) && indeksi < (sivu + 1) * per_sivu) {
                        kirjoittaja.println(indeksi + ","
                                + automaatti.get("Kohteen osoite") + ","
                                + automaatti.get("Postinumero") + ","
                                + automaatti.get("Postitoimipaikka") + ","
                                + automaatti.get("Sijaintipaikan tyyppi") + ","
                                + automaatti.get("Sijaintipaikka") + ","
                                + automaatti.get("Aukioloaika") + ","
                                + automaatti.get("Aukioloaika (lisätiedot)"));
                    }
                }
                indeksi += 1;
            }
        }

        if (request.getParameter("postitoimipaikka") != null
                && request.getParameter("sivu") != null) {

            int sivu = Integer.valueOf(request.getParameter("sivu"));
            int indeksi = 0;
            int per_sivu = 100;
            for (CSVRecord automaatti2 : automaatit) {
                if (indeksi >= (sivu * per_sivu) && indeksi < (sivu + 1) * per_sivu) {
                    kirjoittaja.println(indeksi + ","
                            + automaatti2.get("Kohteen osoite") + ","
                            + automaatti2.get("Postinumero") + ","
                            + automaatti2.get("Postitoimipaikka") + ","
                            + automaatti2.get("Sijaintipaikan tyyppi") + ","
                            + automaatti2.get("Sijaintipaikka") + ","
                            + automaatti2.get("Aukioloaika") + ","
                            + automaatti2.get("Aukioloaika (lisätiedot)"));
                }
                indeksi += 1;
            }
        }

        if (request.getParameter("postitoimipaikka") == null
                || request.getParameter("postitoimipaikka").isEmpty()) {

            if (request.getParameter("sivu") != null) {

                int sivu = Integer.valueOf(request.getParameter("sivu"));
                kirjoittaja.println("Indeksi,Kohteen osoite,Postinumero,"
                        + "Postitoimipaikka,Sijaintipaikan tyyppi,Sijaintipaikka,Aukioloaika,"
                        + "Aukioloaika (lisätiedot)");
                int indeksi = 0;
                int per_sivu = 100;
                for (CSVRecord automaatti : automaatit) {
                    if (indeksi >= (sivu * per_sivu) && indeksi < (sivu + 1) * per_sivu) {
                        kirjoittaja.println(indeksi + ","
                                + automaatti.get("Kohteen osoite") + ","
                                + automaatti.get("Postinumero") + ","
                                + automaatti.get("Postitoimipaikka") + ","
                                + automaatti.get("Sijaintipaikan tyyppi") + ","
                                + automaatti.get("Sijaintipaikka") + ","
                                + automaatti.get("Aukioloaika") + ","
                                + automaatti.get("Aukioloaika (lisätiedot)"));
                    }
                    indeksi += 1;
                }

            } else {
                kirjoittaja.println("Kohteen osoite,Postinumero,"
                        + "Postitoimipaikka,Sijaintipaikan tyyppi,Sijaintipaikka,Aukioloaika,"
                        + "Aukioloaika (lisätiedot)");
                for (CSVRecord automaatti : automaatit) {
                    kirjoittaja.println(automaatti.get("Kohteen osoite") + ","
                            + automaatti.get("Postinumero") + ","
                            + automaatti.get("Postitoimipaikka") + ","
                            + automaatti.get("Sijaintipaikan tyyppi") + ","
                            + automaatti.get("Sijaintipaikka") + ","
                            + automaatti.get("Aukioloaika") + ","
                            + automaatti.get("Aukioloaika (lisätiedot)"));
                }
            }

        }
    }
}
