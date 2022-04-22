/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package res;

import java.io.File;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletContext;

/**
 *
 * @author India
 */
public class Config {

    public static String projectTitle = "WebServer-TomCatEmbed";
    public static String projectContext = "";
    public static String mainRootFolder = "web/";

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
        /*
        if (!getServerStatus()) {
            String parts[] = ip.split("\\.");
            ip = parts[0] + "." + parts[1] + "." + parts[2] + "." + (Integer.parseInt(parts[3]) + 1);
        }*/
        return ip;
    }
    public static String contextPath = "";

    public static void setContext(ServletContext context) {
        String root = context.getRealPath("");
        File rootDir = new File(root);
        contextPath = rootDir.getAbsolutePath().replace("build\\web", "");
    }

    public static boolean getServerStatus() {
        //return Wap.isAccessValid(Config.contextPath);
        return true;
    }

    public static String drive = "E:/";
    public static String siteName = "AppStorage";
    public static String picRepo = drive + siteName + "/";
    public static String getPhotoResources() {
        File f = new File(picRepo);
        if (f.exists() && f.isDirectory()) {
            return f.getAbsolutePath();
        } else {
            f.mkdirs();
            return f.getAbsolutePath();
        }
    }
}
