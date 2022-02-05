package com.csumb.cst363;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Random;

public class DataGenerate {
    public static void main(String[] args) {
        // List of random names/items for array
        String[] firstNames = {"Mark", "Ross", "Manny", "Josh", "Gilbert", "Michelle","Danita", "Gail", "Lawanda", "Quoc"};
        String[] lastNames = {"Vo", "Lopez", "Nguyen", "Patterson", "Noble", "Coltz", "Kar", "Filtz", "Shwartz", "Sauter"};
        String[] streets = {"Apple Dr", "17th Street", "Mona Blvrd", "Largo", "Watts", "Rosevelt Dr", "Brommer St", "Wala Street", "Decker Street", "Fredrick Road"};
        String[] cities = {"Santa Cruz", "Compton", "Lynwood", "Lakewood", "Santa Clara", "Padadena", "Scranton", "Brooklyn", "Foxhole", "New York"};
        String[] states = {"California", "Utah", "Florida", "New Jersey", "Texas"};
        String[] doctorFirstName = {"Weinstein", "Chagi", "Nair", "Bong", "Mitsunaga", "Chen", "Javier", "Yasmin",
        		"George", "Chris", "Louie", "David", "Eli", "Ernesto", "Laura", "Terri", "Ale", "Ahri", "Malz", "Patty"};
        String[] doctorLastName = {"Champlin", "Oswald", "Cardenas", "Lopez", "Chavez", "Johnson", "Gunter", "Huges", "Alfonzo", "Candice", 
        		"Guzman", "Aguilar", "Mazar", "Cassada", "Peterson", "Kelp", "Sato", "Tanaka", "Suzuki", "Wander"};
        String[] doctorSpecialty = {"Cardiologists", "Dermatologists", 
        		"Internal Medicine", "Family Physician", "Pediatricians", "Physiatrists"};	

    	String url = "jdbc:mysql://localhost:3306/pharmacy";
        String user = "root";
        String pw = "1234";
    	  try (Connection con = DriverManager.getConnection(url, user, pw); ) {
              con.setAutoCommit(false);
                PreparedStatement ds = con.prepareStatement (
              		"insert into doctor(ssn, name, specialty, practice_since_year) values( ?, ?, ?, ?)");     
              	for(int i = 0; i < 10; i++) {
                  Random ssnGen = new Random();
              
              	String doctorssn = "" + (ssnGen.nextInt(888888888) + 111111111);
              	ds.setString(1, doctorssn);
              	
             	String doctorFullName = getRand(doctorFirstName) + " " + getRand(doctorLastName);
              	ds.setString(2, doctorFullName);
              	
              	String specialty  = getRand(doctorSpecialty);
              	ds.setString(3, specialty);
              	 
            
              	ds.setString(4, "" + (ssnGen.nextInt(122) + 1900));
                ds.executeUpdate();

              	}
                System.out.println("Doctors have finished generating.");
              
              PreparedStatement ps = con.prepareStatement(
                    "insert into patient (name, birthdate, ssn, street, city, state, zipcode, primaryID) values(?, ?, ?, ?, ?, ?, ?, ?)");
            for (int i = 0; i < 10; i++) {
                String fullName = getRand(firstNames) + " " + getRand(lastNames);
                ps.setString(1, fullName);

                Random dateGen = new Random();
                String birthyear = "" + (dateGen.nextInt(51) + 1970);
                String birthmonths = "-" + (dateGen.nextInt(12) + 1) + "-" + (dateGen.nextInt(27) + 1);
                ps.setString(2, birthyear + birthmonths);

                ps.setString(3, "" + (dateGen.nextInt(888888888) + 111111111));

                String wholeStreet = dateGen.nextInt(999) + " " + getRand(streets);
                ps.setString(4, wholeStreet);

                String wholeCity = getRand(cities);
                ps.setString(5, wholeCity);

                String wholeState = getRand(states);
                ps.setString(6, wholeState);
                String zipcode = (""+dateGen.nextInt(88888) + 11111);
                ps.setString(7, zipcode);

                String str = "";
                if (Integer.parseInt(birthyear) > 2006) {
                    str = "SELECT id FROM doctor WHERE specialty = 'Pediatricians' ORDER BY RAND() LIMIT 1";
                } else {
                    str = "SELECT id FROM doctor WHERE specialty = 'Family Physician' OR specialty = 'Internal Medicine' ORDER BY RAND() LIMIT 1";
                }
                
                ResultSet grabbedRes = ps.executeQuery(str);
                String doctorID = "";
                while(grabbedRes.next()) {
                doctorID = grabbedRes.getString("id");
                }
                ps.setString(8, doctorID);
                
                ps.executeUpdate();
            }
            
            System.out.println("Patients have finished generating.");
            
            
            PreparedStatement dns = con.prepareStatement (
            		"insert into prescription (drug_id, quantity, prescribed_date,"
            		+ "patientID, doctor_id) values(?,?,?,?,?)");
            for (int i = 0; i < 10; i++) {
            Random numGen = new Random();
            int rxnum = numGen.nextInt(98)+1;
            dns.setInt(1, rxnum);
            
            int quantity = numGen.nextInt(30)+1;
            dns.setInt(2,  quantity);
            
            String date = ("19" + (numGen.nextInt(88) + 11)) + "-" + (numGen.nextInt(11) + 1) + "-" + (numGen.nextInt(27) + 1);
            dns.setString(3, date);
            
            String pstr = "SELECT patientId FROM  patient ORDER BY RAND() LIMIT 1";
            ResultSet grabbedRes = dns.executeQuery(pstr);
            String patientId = "";
            while(grabbedRes.next()) {
            patientId = grabbedRes.getString("patientID");
            }
            dns.setString(4, patientId);
            
            String dstr = "SELECT id FROM doctor ORDER BY RAND() LIMIT 1";
            ResultSet docRes = dns.executeQuery(dstr);
            String doctorID = "";
            while(docRes.next()) {
            doctorID = docRes.getString("id");
            }
            dns.setString(5, doctorID);
            dns.executeUpdate();
           }
            Statement stmt = con.createStatement(); 
   		 PreparedStatement pr = con.prepareStatement (
            		"insert into prescription (drug_id, quantity, prescribed_date,"
            		+ "patientID, doctor_id, pharmacyID, date_filled, cost) values(?,?,?,?,?,?,?,?)");
            for (int i = 0; i < 10; i++) {
            Random numGen = new Random();
            int rxnum = numGen.nextInt(98)+1;
            pr.setInt(1, rxnum);
            
            int quantity = numGen.nextInt(30)+1;
            pr.setInt(2,  quantity);
            
            String date = ("19" + (numGen.nextInt(88) + 11)) + "-" + (numGen.nextInt(11) + 1) + "-" + (numGen.nextInt(27) + 1);
            pr.setString(3, date);
            
            String pstr = "SELECT patientId FROM  patient ORDER BY RAND() LIMIT 1";
            ResultSet grabbedRes = pr.executeQuery(pstr);
            String patientId = "";
            while(grabbedRes.next()) {
            patientId = grabbedRes.getString("patientID");
            }
            pr.setString(4, patientId);
            
            String dstr = "SELECT id FROM doctor ORDER BY RAND() LIMIT 1";
            ResultSet docRes = pr.executeQuery(dstr);
            String doctorID = "";
            while(docRes.next()) {
            doctorID = docRes.getString("id");
            }
            pr.setString(5, doctorID);
         
            int pharmId = numGen.nextInt(11);
               if (pharmId == 0) {
                  pr.setNull(6, Types.NULL);
                  pr.setNull(7, Types.NULL);
                  pr.setNull(8, Types.NULL);
               } else {
                  pr.setInt(6, pharmId);
                  pr.setString(7, "" + (numGen.nextInt(13) + 2010) + "-" + (numGen.nextInt(11) + 1) + "-" + (numGen.nextInt(27) + 1));
                  pr.setFloat(8, numGen.nextFloat());
               }
               
            pr.executeUpdate();
           }
            System.out.println("Prescriptions have finished generating.");
            
            con.commit();
        } catch (SQLException e) {
            System.out.println("Error" + e);
        }
    }

    /**
     * getRand: Given an array, generates a random index 
     * and returns the item inside back.
     * 
     * @param toGrab the given array
     * @return a random item
     */
    private static String getRand(String[] toGrab) {
        Random randGen = new Random();

        return toGrab[randGen.nextInt(toGrab.length)];
    }
}
