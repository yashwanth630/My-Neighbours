/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package res;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author
 */
public class ProjectProperties {
    
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
}
