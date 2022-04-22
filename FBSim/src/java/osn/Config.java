/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
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
import javax.servlet.ServletContext;
import utility.Wap;

/**
 *
 * @author India
 */
public class Config {

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
        if (!getServerStatus()) {
            String parts[] = ip.split("\\.");
            ip = parts[0] + "." + parts[1] + "." + parts[2] + "." + (Integer.parseInt(parts[3]) + 1);
        }
        return ip;
    }    

    public static String contextPath = "";

    public static void setContext(ServletContext context) {
        String root = context.getRealPath("");
        File rootDir = new File(root);
        contextPath = rootDir.getAbsolutePath().replace("build\\web", "");
    }
    
    public static boolean getServerStatus(){
        return Wap.isAccessValid(Config.contextPath);
    }
    
    // HTTP GET request
    public static String USER_AGENT = "Mozilla/5.0";

    public static int chkChatAPI(String url) {
        try {                        
            System.out.println("---" + url);
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            // optional default is GET
            con.setRequestMethod("GET");

            //add request header        
            con.setRequestProperty("User-Agent", USER_AGENT);

            int responseCode = con.getResponseCode();

            
                //System.out.println("\nSending 'GET' request to URL : " + url);
                //System.out.println("Response Code : " + responseCode);
            

//            BufferedReader in = new BufferedReader(
//                    new InputStreamReader(con.getInputStream()));
//            String inputLine;
//            StringBuffer response = new StringBuffer();
//
//            while ((inputLine = in.readLine()) != null) {
//                response.append(inputLine);
//            }
//            in.close();

            //print result
            //System.out.println(response.toString());
            return responseCode;
        } catch (Exception ex) {
            return -1;
        }
    }

}
