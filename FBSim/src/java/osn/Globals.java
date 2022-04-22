/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package osn;

import java.sql.SQLException;

/**
 *
 * @author india
 */
public class Globals {

    public static void saveActions(String actioned, String actioner, String action, String actionertype, String sensitiveaction) {
        if (actioned.trim().equals(actioner.trim())) {
            return;
        }
        try {
            DataBase dbfunc = new DataBase();
            dbfunc.createConnection();
            String query = "insert into actionsmonitor(`actioned`,`actioner`,`action`,`actionon`,`actionertype`,`sensitiveaction`) values('" + actioned.trim() + "','" + actioner + "','" + action + "',now(),'" + actionertype + "','" + sensitiveaction + "')";
            System.out.println(query);
            dbfunc.updateRecord(query);
            dbfunc.closeConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
