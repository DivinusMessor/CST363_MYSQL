package com.csumb.cst363;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;
import java.sql.PreparedStatement;
import java.util.Random;
import java.sql.*;


public class ManagerReport {
	public static void main(String[] args)
	{
		String url = "jdbc:mysql://localhost:3306/pharmacy";
        String user = "root";
        String password = "Sultana123!";
    	try (Connection con = DriverManager.getConnection(url, user, password); ){
                con.setAutoCommit(false);
              Scanner keyboard = new Scanner(System.in);
              System.out.println("Enter the pharmacy ID ");
              String pharmacyid = keyboard.next();
              System.out.println("Enter a start date: ");
              String startDate = keyboard.next();
              System.out.println("Enter an end date: ");
              String endDate = keyboard.next();
              


              String output = "select trade_name, quantity, date_filled, pharmacyID from prescription NATURAL JOIN drug NATURAL JOIN pharmacy where pharmacyID = ?"
              		 			+ "AND date_filled >=? AND date_filled <=? ORDER BY trade_name";
              PreparedStatement stmt = con.prepareStatement(output);
              stmt.setString(1, pharmacyid );
              stmt.setString(2,  startDate );
              stmt.setString(3,  endDate);
              ResultSet res = stmt.executeQuery();
              while(res.next()) {
            	  String output1 = res.getString("trade_name");
            	  String output2 = res.getString("quantity");
            	  String output3 = res.getString("date_filled");
            	  String output4 = res.getString("pharmacyID");
            	  System.out.println("\nDrug Name: " + output1 + "\nTrade Name: " + output2 + ", " + output3 + " " + output4);
              }
           
              con.commit();
        }catch (SQLException e) {
              System.out.println("Error" + e);
          }
	}

}
