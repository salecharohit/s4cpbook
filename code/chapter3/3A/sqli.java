// https://raw.githubusercontent.com/returntocorp/semgrep-rules/develop/java/lang/security/audit/sqli/jdbc-sqli.java

package testcode.sqli;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Jdbc {

    Connection con;

    public void query1(String input) throws SQLException {
        Statement stmt = con.createStatement();
        // ruleid: jdbc-sqli
        ResultSet rs = stmt.executeQuery("select * from Users where name = '"+input+"'");
    }

    public void query2(String input) throws SQLException {
        Statement stmt = con.createStatement();
        String sql = "select * from Users where name = '" + input + "'";
        // ruleid: jdbc-sqli
        ResultSet rs = stmt.executeQuery(sql);
    }
    
}