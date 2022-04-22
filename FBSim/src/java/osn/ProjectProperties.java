/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package osn;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import static osn.Config.getMyIp;

/**
 *
 * @author
 */
public class ProjectProperties {

    public static String projectTitle = "Social Network";
    public static String drive = "C:\\Users\\GREESHMA\\OneDrive\\Desktop\\Yash\\Captsone\\CapstoneFinalImages";
    public static String siteName = "FBSim";

    public static String chatPort = "8086";
    public static String chatAPI = getMyIp() + ":" + chatPort;

    public static String getdbDriver() {
        String myUrl = "com.mysql.jdbc.Driver";
        return myUrl.trim();
    }

    public static String getDbUrl() {
        String myUrl = "jdbc:mysql://localhost/mpc";
        return myUrl;
    }

    public static String getDbUser() {
        String myUrl = "root";
        return myUrl;
    }

    public static String getDbPass() {
        String myUrl = "123456";
        return myUrl;
    }

    public static String getMusicStyles() {
        String htmlData = "";

        htmlData += "<select name=\"music\">";
        htmlData += "<option value=\"Select\">--Select--";
        htmlData += "</option>";
        htmlData += "<option value=\"bengali\">Bengali";
        htmlData += "</option>";
        htmlData += "<option value=\"bhojpuri\">Bhojpuri";
        htmlData += "</option>";
        htmlData += "<option value=\"carnatic\">Carnatic";
        htmlData += "</option>";
        htmlData += "<option value=\"fusion\">Fusion";
        htmlData += "</option>";
        htmlData += "<option value=\"gujarati\">Gujarati";
        htmlData += "</option>";
        htmlData += "<option value=\"hindi\">Hindi";
        htmlData += "</option>";
        htmlData += "<option value=\"hindustani\">Hindustani";
        htmlData += "</option>";
        htmlData += "<option value=\"kannada\">Kannada";
        htmlData += "</option>";
        htmlData += "<option value=\"malayalam\">Malayalam";
        htmlData += "</option>";
        htmlData += "<option value=\"marathi\">Marathi";
        htmlData += "</option>";
        htmlData += "<option value=\"nirvana\">Nirvana";
        htmlData += "</option>";
        htmlData += "<option value=\"punjabi\">Punjabi";
        htmlData += "</option>";
        htmlData += "<option value=\"rajasthani\">Rajasthani";
        htmlData += "</option>";
        htmlData += "<option value=\"sanskrit\">Sanskrit";
        htmlData += "</option>";
        htmlData += "<option value=\"tamil\">Tamil";
        htmlData += "</option>";
        htmlData += "<option value=\"telugu\">Telugu";
        htmlData += "</option>";
        htmlData += "<option value=\"worldmusic\">WorldMusic";
        htmlData += "</option>";
        htmlData += "</select>";

        return htmlData;
    }

    public static String getRelations() {
        String htmlData = "";

        htmlData += "<select name=\"relationship\">";
        htmlData += "<option>SelectRelationship</option>";
        htmlData += "<option>Single</option>";
        htmlData += "<option>In a relationship</option>";
        htmlData += "<option>Engaged</option>";
        htmlData += "<option>Married</option>";
        htmlData += "<option>In an open relationship</option>";
        htmlData += "<option>It's complicated</option>";
        htmlData += "<option>Separated</option>";
        htmlData += "<option>Divorced</option>";
        htmlData += "<option>Widowed</option>";
        htmlData += "</select>";

        return htmlData;
    }

    public static String getEducationAreas() {
        String htmlData = "";

        htmlData += "<select name=\"UGCOURSE\">";
        htmlData += "<option label=\"SelectBachelorDegree\">SelectBachelorDegree</option>";
        htmlData += "<option label=\"Not Pursuing Graduation\">Not Pursuing Graduation</option>";
        htmlData += "<option label=\"B.A\">B.A</option>";
        htmlData += "<option label=\"B.Arch\">B.Arch";
        htmlData += "</option>";
        htmlData += "<option label=\"BCA\">BCA";
        htmlData += "</option>";
        htmlData += "<option label=\"B.B.A\">B.B.A";
        htmlData += "</option>";
        htmlData += "<option label=\"B.Com\">B.Com";
        htmlData += "</option>";
        htmlData += "<option label=\"B.Ed\">B.Ed";
        htmlData += "</option>";
        htmlData += "<option label=\"BDS\">BDS";
        htmlData += "</option>";
        htmlData += "<option label=\"BHM\">BHM";
        htmlData += "</option>";
        htmlData += "<option label=\"B.Pharma\">B.Pharma";
        htmlData += "</option>";
        htmlData += "<option label=\"B.Sc\">B.Sc";
        htmlData += "</option>";
        htmlData += "<option label=\"B.Tech/B.E.\">B.Tech/B.E.";
        htmlData += "</option>";
        htmlData += "<option label=\"LLB\">LLB";
        htmlData += "</option>";
        htmlData += "<option label=\"MBBS\">MBBS";
        htmlData += "</option>";
        htmlData += "<option label=\"Diploma\">Diploma";
        htmlData += "</option>";
        htmlData += "<option label=\"BVSC\">BVSC";
        htmlData += "</option>";
        htmlData += "<option label=\"OtherBachelorDegree\">OtherBachelorDegree</option>";
        htmlData += "</select>";
        htmlData += "";
        htmlData += "<select name=\"PGCOURSE\">";
        htmlData += "<option label=\"SelectPG\">SelectPG</option>";
        htmlData += "<option label=\"CA\">CA";
        htmlData += "</option>";
        htmlData += "<option label=\"CS\">CS";
        htmlData += "</option>";
        htmlData += "<option label=\"ICWA\">ICWA";
        htmlData += "</option>";
        htmlData += "<option label=\"Integrated PG\">Integrated PG";
        htmlData += "</option>";
        htmlData += "<option label=\"LLM\">LLM";
        htmlData += "</option>";
        htmlData += "<option label=\"M.A\">M.A";
        htmlData += "</option>";
        htmlData += "<option label=\"M.Arch\">M.Arch";
        htmlData += "</option>";
        htmlData += "<option label=\"M.Com\">M.Com";
        htmlData += "</option>";
        htmlData += "<option label=\"M.Ed\">M.Ed";
        htmlData += "</option>";
        htmlData += "<option label=\"M.Pharma\">M.Pharma";
        htmlData += "</option>";
        htmlData += "<option label=\"M.Sc\">M.Sc";
        htmlData += "</option>";
        htmlData += "<option label=\"M.Tech\">M.Tech";
        htmlData += "</option>";
        htmlData += "<option label=\"MBA/PGDM\">MBA/PGDM";
        htmlData += "</option>";
        htmlData += "<option label=\"MCA\">MCA";
        htmlData += "</option>";
        htmlData += "<option label=\"MS\">MS";
        htmlData += "</option>";
        htmlData += "<option label=\"PG Diploma\">PG Diploma";
        htmlData += "</option>";
        htmlData += "<option label=\"MVSC\">MVSC";
        htmlData += "</option>";
        htmlData += "<option label=\"MCM\">MCM";
        htmlData += "</option>";
        htmlData += "<option label=\"OtherPG\">OtherPG</option>";
        htmlData += "</select>";
        htmlData += "";
        htmlData += "<select name=\"PPGCOURSE\">";
        htmlData += "<option label=\"SelectPPG\">SelectPPG</option>";
        htmlData += "<option label=\"Ph.D/Doctorate\">Ph.D/Doctorate</option>";
        htmlData += "<option label=\"MPHIL\">MPHIL</option>";
        htmlData += "<option label=\"OtherPPG\">OtherPPG</option>";
        htmlData += "</select>";

        return htmlData;
    }

    public static String getWorkAreas() {
        String htmlData = "";
        htmlData += "<select name=\"work\">";
        htmlData += "<option label=\"Select\">Select</option>";
        htmlData += "<optgroup label=\"Top Categories\">Top Categories</optgroup>";
        htmlData += "<option label=\"Accounts, Finance, Tax, Company Secretary, Audit\">Accounts, Finance, Tax, Company Secretary, Audit</option>";
        htmlData += "<option label=\"Financial Services, Banking, Investments, Insurance\">Financial Services, Banking, Investments, Insurance</option>";
        htmlData += "<option label=\"ITES, BPO, KPO, LPO, Customer Service, Operations\">ITES, BPO, KPO, LPO, Customer Service, Operations</option>";
        htmlData += "<option label=\"HR, Recruitment, Administration, IR\">HR, Recruitment, Administration, IR</option>";
        htmlData += "<option label=\"Marketing, Advertising, MR, PR, Media Planning\" >Marketing, Advertising, MR, PR, Media Planning</option>";
        htmlData += "<option label=\"Production, Manufacturing, Maintenance\" >Production, Manufacturing, Maintenance</option>";
        htmlData += "<option label=\"Site Engineering, Project Management\" >Site Engineering, Project Management</option>";
        htmlData += "<option label=\"Engineering Design, R&D\" >Engineering Design, R&D</option>";
        htmlData += "<option label=\"Sales, Retail, Business Development\" >Sales, Retail, Business Development</option>";
        htmlData += "<option label=\"IT Software - All Jobs\" >IT Software - All Jobs</option>";
        htmlData += "<option label=\"Analytics & Business Intelligence\" >Analytics & Business Intelligence</option>";
        htmlData += "<option label=\"Shipping\" >Shipping</option>";
        htmlData += "<optgroup label=\"IT Software Categories\">IT Software Categories</optgroup>";
        htmlData += "<option label=\"IT Software - Application Programming, Maintenance\" >IT Software - Application Programming, Maintenance </option>";
        htmlData += "<option label=\"IT Software - Client/Server Programming\" >IT Software - Client/Server Programming</option>";
        htmlData += "<option label=\"IT Software - DBA, Datawarehousing\">IT Software - DBA, Datawarehousing</option>";
        htmlData += "<option label=\"IT Software - ERP, CRM\" >IT Software - ERP, CRM</option>";
        htmlData += "<option label=\"IT Software - Embedded, EDA, VLSI, ASIC, Chip Design\" >IT Software - Embedded, EDA, VLSI, ASIC, Chip Design</option>";
        htmlData += "<option label=\"IT Software - Network Administration, Security\" >IT Software - Network Administration, Security</option>";
        htmlData += "<option label=\"IT Software - QA & Testing\" >IT Software - QA & Testing</option>";
        htmlData += "<option label=\"IT Software - System Programming\" >IT Software - System Programming</option>";
        htmlData += "<option label=\"IT Software - Telecom Software\" >IT Software - Telecom Software</option>";
        htmlData += "<option label=\"IT Software - Systems, EDP, MIS\" >IT Software - Systems, EDP, MIS</option>";
        htmlData += "<option label=\"IT Software - eCommerce, Internet Technologies\" >IT Software - eCommerce, Internet Technologies</option>";
        htmlData += "<option label=\"IT Software - Mainframe\" >IT Software - Mainframe</option>";
        htmlData += "<option label=\"IT Software - Mobile\" >IT Software - Mobile</option>";
        htmlData += "<option label=\"IT Software - Middleware\" >IT Software - Middleware</option>";
        htmlData += "<option label=\"IT Software - Other\" >IT Software - Other</option>";
        htmlData += "<optgroup label=\"More Categories\">More Categories</optgroup>";
        htmlData += "<option label=\"Architecture, Interior Design\" >Architecture, Interior Design</option>";
        htmlData += "<option label=\"Design, Creative, User Experience\" >Design, Creative, User Experience</option>";
        htmlData += "<option label=\"Hotels, Restaurants\" >Hotels, Restaurants</option>";
        htmlData += "<option label=\"Journalism, Editing, Content\" >Journalism, Editing, Content</option>";
        htmlData += "<option label=\"Strategy, Management Consulting, Corporate Planning\" >Strategy, Management Consulting, Corporate Planning</option>";
        htmlData += "<option label=\"Self Employed, Entrepreneur, Independent Consultant\" >Self Employed, Entrepreneur, Independent Consultant</option>";
        htmlData += "<option label=\"Export, Import, Merchandising\" >Export, Import, Merchandising</option>";
        htmlData += "<option label=\"Executive Assistant, Front Office, Data Entry\" >Executive Assistant, Front Office, Data Entry</option>";
        htmlData += "<option label=\"Legal, Regulatory, Intellectual Property\" >Legal, Regulatory, Intellectual Property</option>";
        htmlData += "<option label=\"Supply Chain, Logistics, Purchase, Materials\" >Supply Chain, Logistics, Purchase, Materials</option>";
        htmlData += "<option label=\"Medical, Healthcare, R&D, Pharmaceuticals, Biotechnology\" >Medical, Healthcare, R&D, Pharmaceuticals, Biotechnology</option>";
        htmlData += "<option label=\"Packaging\" >Packaging</option>";
        htmlData += "<option label=\"Teaching, Education, Training, Counselling\" >Teaching, Education, Training, Counselling</option>";
        htmlData += "<option label=\"IT Hardware, Technical Support, Telecom Engineering\" >IT Hardware, Technical Support, Telecom Engineering</option>";
        htmlData += "<option label=\"Other\" >Other</option>";
        htmlData += "<option label=\"Fashion Designing, Merchandising\" >Fashion Designing, Merchandising</option>";
        htmlData += "<option label=\"TV, Films, Production, Broadcasting\" >TV, Films, Production, Broadcasting</option>";
        htmlData += "<option label=\"Travel, Tours, Ticketing, Airlines\" >Travel, Tours, Ticketing, Airlines</option>";
        htmlData += "<option label=\"Defence Forces, Security Services\" >Defence Forces, Security Services</option>";
        htmlData += "<option label=\"Top Management - IT Jobs\" >Top Management - IT Jobs</option>";
        htmlData += "<option label=\"Top Management - Non IT\" >Top Management - Non IT</option>";
        htmlData += "<option label=\"Government, Defence\" >Government, Defence</option>";
        htmlData += "<option label=\"Overseas, International Jobs\" >Overseas, International Jobs</option>";
        htmlData += "<option label=\"Retail, Wholesale\" >Retail, Wholesale</option>";
        htmlData += "<option label=\"Pharma, Biotechnology, Clinical Research\" >Pharma, Biotechnology, Clinical Research</option>";
        htmlData += "<option label=\"Freshers\" >Freshers</option>";
        htmlData += "</select>";
        return htmlData;
    }

    public static String getProfilePicResources() {
        String myUrl = drive + "/" + siteName + "/users/";
        File f = new File(myUrl);
        if (f.exists() && f.isDirectory()) {
            return f.getAbsolutePath();
        } else {
            f.mkdirs();
            return f.getAbsolutePath();
        }
    }

    public static String genRandIndex() {
        ArrayList<String> numbers = new ArrayList<String>();
        ArrayList<String> characters = new ArrayList<String>();

        for (int i = 0; i < 9; i++) {
            numbers.add(Integer.toString(i + 1));
        }
        char ch;

        for (ch = 'a'; ch <= 'z'; ch++) {
            characters.add(Character.toString(ch));
        }
        for (ch = 'A'; ch <= 'Z'; ch++) {
            characters.add(Character.toString(ch));
        }

        Collections.shuffle(numbers);
        Collections.shuffle(characters);

        String randBatchFileName = "";

        for (int j = 0; j < 3; j++) {
            randBatchFileName += characters.get(j);
        }
        for (int j = 0; j < 3; j++) {
            randBatchFileName += numbers.get(j);
        }
        return randBatchFileName;
    }

    public static String getPhotoResources() {
        String myUrl = drive + "/" + siteName + "/photos/";
        File f = new File(myUrl);
        if (f.exists() && f.isDirectory()) {
            return f.getAbsolutePath();
        } else {
            f.mkdirs();
            return f.getAbsolutePath();
        }
    }

    public static String getMyIp() {
        InetAddress ipa;
        String ip = "";
        try {

            ipa = InetAddress.getLocalHost();
            ip = ipa.getHostAddress();
            //System.out.println("Current IP address : " + ip);

        } catch (UnknownHostException e) {
            return e.toString();
        }
        return ip;
    }

    public static String USER_AGENT = "Mozilla/5.0";

    // HTTP GET request
    public static String sendGet(String url) throws Exception {
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        // optional default is GET
        con.setRequestMethod("GET");

        //add request header
        con.setRequestProperty("User-Agent", USER_AGENT);

        int responseCode = con.getResponseCode();
        System.out.println("\nSending 'GET' request to URL : " + url);
        System.out.println("Response Code : " + responseCode);

        BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        //print result
        System.out.println(response.toString());
        return response.toString();
    }

    public static String historyAssesment(String other, String me) throws Exception {
        String res = "";

        String qy = "select count(*) from tagMatrix where status='Y' and email='" + other + "' and tid in (select tid from taginfo where friendMail='" + me + "')";
        String qn = "select count(*) from tagMatrix where status='N' and email='" + other + "' and tid in (select tid from taginfo where friendMail='" + me + "')";

        System.out.println(qy);
        System.out.println(qn);

        DataBase db = new DataBase();
        db.createConnection();
        ResultSet rs = db.queryRecord(qy);
        int y = 0;
        int n = 0;

        if (rs.next()) {
            try {
                y = Integer.parseInt(rs.getString(1).trim());
            } catch (Exception e) {
                y = 0;
            }
        }

        rs = db.queryRecord(qn);
        if (rs.next()) {
            try {
                n = Integer.parseInt(rs.getString(1).trim());
            } catch (Exception e) {
                n = 0;
            }
        }

        db.closeConnection();

        System.out.println(me + " accepted " + other + " = " + y);
        System.out.println(me + " rejected " + other + " = " + n);

        if (n > y) {
            res = "";
        } else {
            res = "checked";
        }

        return res;
    }

    public static String genRandToken() {
        //define ArrayList to hold Integer objects
        ArrayList<String> numbers = new ArrayList<String>();
        ArrayList<String> characters = new ArrayList<String>();

        for (int i = 0; i < 9; i++) {
            numbers.add(Integer.toString(i + 1));
        }
        char ch;

        for (ch = 'a'; ch <= 'z'; ch++) {
            characters.add(Character.toString(ch));
        }
        for (ch = 'A'; ch <= 'Z'; ch++) {
            characters.add(Character.toString(ch));
        }

        Collections.shuffle(numbers);
        Collections.shuffle(characters);

        String randBatchFileName = "";

        for (int j = 0; j < 3; j++) {
            randBatchFileName += characters.get(j);
        }
        for (int j = 0; j < 3; j++) {
            randBatchFileName += numbers.get(j);
        }
        DateFormat dateFormat = new SimpleDateFormat("yyddmm");
        Date date = new Date();
        String dt = String.valueOf(dateFormat.format(date));
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat time = new SimpleDateFormat("HHmm");
        String tm = String.valueOf(time.format(new Date()));//time in 24 hour format
        String id = dt + tm;

        return id + "_" + randBatchFileName;
    }

    public static boolean isFriends(String me, String friend) throws Exception {

        DataBase dbfunc = new DataBase();
        dbfunc.createConnection();
        String query = "select * from friends where email='" + me + "' and friendMail='" + friend + "' and status='1'";
        System.out.println(query);
        ResultSet rset = dbfunc.queryRecord(query);
        boolean found = rset.next();
        dbfunc.closeConnection();
        return found;
    }

    public static String getMessage(String token, String user) throws Exception {
        String resultantHtml = "";
        String parts[] = token.split("_");
        //System.out.println(token + "  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ " + parts.length);
        if (parts.length == 2) {
            DataBase dbfunc = new DataBase();
            dbfunc.createConnection();

            String query = "select * from wallmessages where siteType='" + token + "' order by msgDate desc";
            System.out.println(query);

            ResultSet rset = dbfunc.queryRecord(query);
            boolean found = rset.next();

            if (found) {
                rset.last();
                int count = rset.getRow();
                int row = 0;
                String line = "";
                rset.beforeFirst();
                while (rset.next()) {
                    String fromMail = rset.getString("fromMail");
                    String message = rset.getString("message");
                    String publishDate = rset.getString("msgDate");

                    resultantHtml += "<div class=\"wallpost\">";
                    resultantHtml += "<div>";
                    resultantHtml += "<h3><a href=\"#\">New Message from : " + fromMail + "</a></h3>";
                    resultantHtml += "<div><p><font color='red'>" + message + "</font></p></div>";
                    resultantHtml += "<h3>My Time Line</h3>";
                    resultantHtml += "<div><p>" + publishDate + "</p></div>";
                    resultantHtml += "</div>";
                    resultantHtml += "</div>";

                }
            }
            dbfunc.closeConnection();
        }
        if (parts.length == 4) {
            String groupTable = parts[2];
            groupTable = groupTable.replace("$", "_");
            String subGroup = parts[3];
            if (isUserBelongsToGroup(groupTable, subGroup, user)) {
                DataBase dbfunc = new DataBase();
                dbfunc.createConnection();

                String query = "select * from wallmessages where siteType='" + token + "' order by msgDate desc";
                System.out.println(query);

                ResultSet rset = dbfunc.queryRecord(query);
                boolean found = rset.next();

                if (found) {
                    rset.last();
                    int count = rset.getRow();
                    int row = 0;
                    String line = "";
                    rset.beforeFirst();
                    while (rset.next()) {
                        String fromMail = rset.getString("fromMail");
                        String message = rset.getString("message");
                        String publishDate = rset.getString("msgDate");

                        resultantHtml += "<div class=\"wallpost\">";
                        resultantHtml += "<div>";
                        resultantHtml += "<h3><a href=\"#\">New Message from : " + fromMail + "</a></h3>";
                        resultantHtml += "<div><p><font color='red'>" + message + "</font></p></div>";
                        resultantHtml += "<h3>My Time Line</h3>";
                        resultantHtml += "<div><p>" + publishDate + "</p></div>";
                        resultantHtml += "</div>";
                        resultantHtml += "</div>";

                    }
                }
                dbfunc.closeConnection();
            } else {
//                resultantHtml += "<div class=\"wallpost\">";
//                resultantHtml += "<div>";
//                resultantHtml += "<h3><a href=\"#\">Message Redacted</a></h3>";
//                resultantHtml += "<div><p><font color='red'>Redacted Message</font></p></div>";                
//                resultantHtml += "</div>";
//                resultantHtml += "</div>";
            }
        }
        return resultantHtml;
    }

    public static boolean isUserBelongsToGroup(String groupTable, String subGroup, String user) throws Exception {
        DataBase dbfunc = new DataBase();
        dbfunc.createConnection();
        String query = "select * from " + groupTable + " where usid='" + user + "' and groupname='" + subGroup + "' and status='1'";
        //System.out.println("  $$$$$$$$$$$$$$$$$ ----------------- "+query);
        ResultSet rset = dbfunc.queryRecord(query);
        boolean found = rset.next();
        dbfunc.closeConnection();
        System.out.println("----------"+found);
        return found;
    }
}
