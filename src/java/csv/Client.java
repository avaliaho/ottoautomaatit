package csv;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.net.*;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

public class Client {

    protected URL urli = null;
    protected URL polku = null;
    protected FileReader tiedosto = null;
    protected BufferedReader lukija = null;
    protected CSVFormat csvformaatti = null;
    protected CSVParser csvrakentaja = null;
    protected Iterable<CSVRecord> automaatit = null;
    protected long kokonaismaara = 0;
    
    public long getKokonaismaara() {
        return this.kokonaismaara;
    }
    
    public void setKokonaismaara(long koko) {
        this.kokonaismaara = koko;
    }

    public Client() {
        try {
            polku = Client.class.getResource("ottokoordinaatit2018_12_29_fi.csv");
            tiedosto = new FileReader(polku.getFile());
            Iterable<CSVRecord> automaatit = CSVFormat.EXCEL.withHeader().parse(tiedosto);

            long luku = 0;
            for (CSVRecord automaatti : automaatit) {
                luku = automaatti.getRecordNumber();
            }
            this.setKokonaismaara(luku);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Iterable<CSVRecord> haeAutomaatit(String paikkakunta, long sivu) {
        try {
            if (paikkakunta == null) {
                urli = new URL("http://localhost:8080/ottoautomaatit/webservice?sivu="+sivu);
                lukija = new BufferedReader(new InputStreamReader(urli.openStream()));
                automaatit = CSVFormat.EXCEL.withHeader().parse(lukija);
            } else {
                urli = new URL("http://localhost:8080/ottoautomaatit/webservice?postitoimipaikka="
                        + URLEncoder.encode(paikkakunta, "UTF-8") + "&sivu=" + sivu);
                lukija = new BufferedReader(new InputStreamReader(urli.openStream()));
                automaatit = CSVFormat.EXCEL.withHeader().parse(lukija);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return automaatit;
    }

}
