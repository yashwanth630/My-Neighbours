/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package res;

import javax.servlet.ServletException;

import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.Context;
import java.io.File;
import java.net.MalformedURLException;

public class Main {

    public static void main(String[] args) throws Exception, LifecycleException {
        new Main().start();
    }

    public void start() throws ServletException, LifecycleException,
            MalformedURLException {

        // Define a folder to hold web application contents.
        String webappDirLocation = Config.mainRootFolder;
        Tomcat tomcat = new Tomcat();

        // Define port number for the web application
        String webPort = System.getenv("PORT");
        if (webPort == null || webPort.isEmpty()) {
            webPort = "8086";
        }
        // Bind the port to Tomcat server
        tomcat.setPort(Integer.valueOf(webPort));

        // Define a web application context.
        Context context = tomcat.addWebapp(Config.projectContext,new File(webappDirLocation).getAbsolutePath());

        String url = "http://"+Config.getMyIp()+":"+webPort+"/"+Config.projectContext;
        System.out.println(url);
        
        // Define and bind web.xml file location.
        File configFile = new File(webappDirLocation+"WEB-INF/web.xml");
        context.setConfigFile(configFile.toURI().toURL());
        try {
            tomcat.start();
        } catch (LifecycleException e) {
            System.err.println("Tomcat could not be started.");
            //e.printStackTrace();
        }        
        tomcat.getServer().await();
    }

}
