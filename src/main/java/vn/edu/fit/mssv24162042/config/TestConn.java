package vn.edu.fit.mssv24162042.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class TestConn {
    public static void main(String[] args) {
        System.out.println("Testing SQL Server JDBC Connections...");
        
        // Test 1: integratedSecurity=true (requires auth dll or integrated auth)
        long t0 = System.currentTimeMillis();
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url1 = "jdbc:sqlserver://localhost:1433;databaseName=WebDB_24162042;encrypt=false;trustServerCertificate=true;integratedSecurity=true;";
            Connection c = DriverManager.getConnection(url1);
            System.out.println("Integrated Security SUCCESS in " + (System.currentTimeMillis() - t0) + " ms");
            c.close();
            return;
        } catch (Exception e) {
            System.out.println("Integrated Security failed: " + e.getMessage() + " (" + (System.currentTimeMillis() - t0) + " ms)");
        }

        // Test 2: sa auth
        String[] passes = {"123", "123456", "sa", "root", "admin"};
        for (String p : passes) {
            long t = System.currentTimeMillis();
            try {
                String url2 = "jdbc:sqlserver://localhost:1433;databaseName=WebDB_24162042;encrypt=false;trustServerCertificate=true;user=sa;password=" + p;
                Connection c = DriverManager.getConnection(url2);
                System.out.println("SA Auth SUCCESS with password '" + p + "' in " + (System.currentTimeMillis() - t) + " ms");
                c.close();
                return;
            } catch (Exception e) {
                System.out.println("SA pass '" + p + "' failed: " + e.getMessage() + " (" + (System.currentTimeMillis() - t) + " ms)");
            }
        }
    }
}
