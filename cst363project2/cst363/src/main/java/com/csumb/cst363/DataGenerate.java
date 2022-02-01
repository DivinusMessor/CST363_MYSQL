package com.csumb.cst363;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Random;

public class DataGenerate {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public static void main(String[] args) {
        String[] firstNames = {"Bob", "Ryan", "Ellis", "Joe", "Stan", "Pam","Gunter", "Jackie", "Cyrus", "Walter"};
        String[] lastNames = {"Magee", "Smith", "Jackson", "Anderson", "Caroll", "Coates", "Carr", "Timm", "Jacobs", "Wilson"};
        String[] streets = {"Deercove Dr", "Fincham Road", "Bartlett Ave", "Roosevelt Road", "Bombadier Way", "Fittro Street", "Elkview Drive", "Milford Street", "Waldeck Street", "Fieldcrest Road"};
        String[] cities = {"Houston", "Waseca", "Salinas", "Carmel", "Stamford", "La Grange", "Somers", "Brooklyn", "Fort Worth", "Chicago"};
        String[] states = {"California", "Nevada", "New York", "Oregon", "Washington"};
        String[] doctorFirstName = {"Lacie", "Ellesse", "Saqib", "Forrest", "Roma", "Ihsan", "Bill", "Yasmin",
        		"Nicolas", "Veer", "Bob", "Ryan", "Ellis", "Joe", "Stan", "Pam","Gunter", "Jackie", "Cyrus", "Walter"};
        String[] doctorLastName = {"Andrews", "Paul", "Cardenas", "Oconnell", "Salter", "Britt", "Martinez", "Hills", "Alfaro", "Frye", 
        		"Magee", "Smith", "Jackson", "Anderson", "Caroll", "Coates", "Carr", "Timm", "Jacobs", "Wilson"};
        String[] doctorSpecialty = {"Allergists" ,"Anesthesiologists" , "Cardiologists", "Dermatologists", 
        		"Endocrinologists", "Family Physician", "Hematologists", "Neurologist", 
        		"Gynecologists", "Ophthalmologists", "Pediatricians", "Physiatrists"};	

    	String url = "jdbc:mysql://localhost:3306/bigpharma";
        String user = "root";
        String password = "1234";
    	  try (Connection con = DriverManager.getConnection(url, user, password); ) {
              con.setAutoCommit(false);
               PreparedStatement ds = con.prepareStatement (
              		"insert into doctor(ssn, name, specialty, practice_since_year) values ( ?, ?, ?, ?)");     
              	for(int i = 0; i < 10; i++) {
                  Random ssnGen = new Random();
              	String doctorssn = "" + (ssnGen.nextInt(888888888) + 111111111);
              	ds.setString(1, doctorssn);
              	
             	String doctorFullName = getRand(doctorFirstName) + " " + getRand(doctorLastName);
              	ds.setString(2, doctorFullName);
              	
              	String specialty  = getRand(doctorSpecialty);
              	ds.setString(3, specialty);
              	 
            
              	ds.setString(4, "" + (ssnGen.nextInt(122) + 1900));

              	}
              	String doctorInfo = "select * from doctor limit 10";
              	ResultSet drSet = ds.executeQuery(doctorInfo);
              	System.out.println("\nDoctor's Info");
              	while(drSet.next()) {
              		System.out.println(drSet.getInt("id") + ", " + drSet.getString("ssn") + ", " + 
              	drSet.getString("name") + ", " + drSet.getString("specialty") 
              	+ ", " + drSet.getString("practice_since_year"));
              	}
               ds.executeUpdate();
              
               PreparedStatement ps = con.prepareStatement(
                     "insert into patient (name, birthdate, ssn, street, city, state, zipcode, primaryID) values(?, ?, ?, ?, ?, ?, ?, ?)");
               for (int i = 0; i < 1; i++) {
                  String fullName = getRand(firstNames) + " " + getRand(lastNames);
                  ps.setString(1, fullName);

                  Random dateGen = new Random();
                  String birthdate = "19" + (dateGen.nextInt(88) + 11) + "-" + (dateGen.nextInt(11) + 1) + "-" + (dateGen.nextInt(27) + 1);
                  ps.setString(2, birthdate);

                  ps.setString(3, "" + (dateGen.nextInt(888888888) + 111111111));

                  String wholeStreet = dateGen.nextInt(999) + " " + getRand(streets);
                  ps.setString(4, wholeStreet);

                  String wholeCity = getRand(cities);
                  ps.setString(5, wholeCity);

                  String wholeState = getRand(states);
                  ps.setString(6, wholeState);
                  String zipcode = (""+dateGen.nextInt(88888) + 11111);
                  ps.setString(7, zipcode);
                  String doctorID = ("" + (dateGen.nextInt(9) + 1));
                  ps.setString(8, doctorID);
                  
                  ps.executeUpdate();

            }
            
            String str = "select * from patient limit 10";
            ResultSet rset = ps.executeQuery(str);
            System.out.println("\nPatient's Info");
            while(rset.next()) {
            	 System.out.println(rset.getString("name") + ", " +
                 rset.getString("birthdate") + ", " + rset.getString("ssn") + 
                 ", " + rset.getString("street") + ", " + rset.getString("city") + 
                 ", " + rset.getString("state") + ", " + rset.getString("zipcode") + 
                 ", " + rset.getInt("primaryID"));
            }
            
            con.commit();
            
           
        } catch (SQLException e) {
            System.out.println("Error" + e);
        }
    }

    private static String getRand(String[] toGrab) {
        Random randGen = new Random();

        return toGrab[randGen.nextInt(toGrab.length)];
    }

    /*
     * return JDBC Connection using jdbcTemplate in Spring Server
     */
    private Connection getConnection() throws SQLException {
        Connection conn = jdbcTemplate.getDataSource().getConnection();
        return conn;
    }
}
