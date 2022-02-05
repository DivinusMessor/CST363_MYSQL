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
import org.springframework.web.bind.annotation.RequestParam;

/*
 * Controller class for patient interactions.
 *   register as a new patient.
 *   update patient profile.
 */
@Controller
public class ControllerPatient {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/*
	 * Request patient_register form.
	 */
	@GetMapping("/patient/new")
	public String newPatient(Model model) {
		// return blank form for new patient registration
		model.addAttribute("patient", new Patient());
		return "patient_register";
	}
	
	/*
	 * Request form to search for patient.
	 */
	@GetMapping("/patient/edit")
	public String getPatientForm(Model model) {
		// prompt for patient id and name
		return "patient_get";
	}
	
	/*
	 * Process a form to create new patient.
	 */
	@PostMapping("/patient/new")
	public String newPatient(Patient patient, Model model) {
	   
          
	     try (Connection con = getConnection(); ) {
	     
                
	        String Query = "insert into patient (name, birthdate, ssn, street, city, state, zipcode, primaryID) values (?,?,?,?,?,?,?,?)";
	        String doc = "select id from doctor WHERE name = ?";
	        PreparedStatement docFind = con.prepareStatement(doc);
	        //PreparedStatement pat = con.prepareStatement(Query, Statement.RETURN_GENERATED_KEYS);
	               PreparedStatement prepStatement = con.prepareStatement(Query, Statement.RETURN_GENERATED_KEYS);
	                prepStatement.setString(1, patient.getName());
	                prepStatement.setString(2, patient.getBirthdate());
	                prepStatement.setString(3, patient.getSsn());
	                prepStatement.setString(4, patient.getStreet());
	                prepStatement.setString(5, patient.getCity());
	                prepStatement.setString(6, patient.getState());
	                prepStatement.setString(7, patient.getZipcode());
	                docFind.setString(1,  patient.getPrimaryName());
//	                prepStatement.setString(8, patient.getPrimaryName());
	                
	                System.out.println(patient.getPrimaryName());
	                ResultSet res = docFind.executeQuery();
		            while(res.next()) {
		            	prepStatement.setString(8, res.getString("id"));
		            }
	                
	                //sets the id of the primary doc
	               // prepStatement.setInt(8, docID);
	                prepStatement.executeUpdate();
	                
	                ResultSet pf = prepStatement.getGeneratedKeys();
	                if (pf.next())
	                {
	                
	                   patient.setPatientId(pf.getString(1));
//	                   String primaryName = pf.getString(8);
//	                   System.out.println("Primary name: " + primaryName);
	                }
	                model.addAttribute("patient", patient);
	                return "patient_show";
	             } catch (SQLException ex) {
	                model.addAttribute("message", "SQL Error."+ex.getMessage());
                        model.addAttribute("patient", patient);
                        return "patient_register";       
	             }
	}
	
	/*
	 * Search for patient by patient id and name.
	 */
	@PostMapping("/patient/show")
	public String getPatientForm(@RequestParam("patientId") String patientId, @RequestParam("name") String name,
			Model model) {
        Patient patient = new Patient();

        try (Connection con = getConnection();) {
            
            System.out.println("start getPatient " + name); // for DEBUG

            PreparedStatement ps = con
                    .prepareStatement("SELECT p.birthdate, p.ssn, p.street, p.city, p.state, p.zipcode, p.primaryID, d.name FROM patient p INNER JOIN doctor d ON p.primaryID=d.id where p.patientID=? AND p.name=?");
            // Set the Query vals w the given params
            ps.setString(1, patientId); 
            ps.setString(2, name);
            // Create a new patient obj to display

            // Run the query & then process the results
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { // Case for found Patient
                // Bulk of sets from the given query results
                patient.setPatientId(patientId);
                patient.setName(name);
                patient.setBirthdate(rs.getString(1));
                patient.setSsn(rs.getString(2));
                patient.setStreet(rs.getString(3));
                patient.setCity(rs.getString(4));
                patient.setState(rs.getString(5));
                patient.setZipcode(rs.getString(6));
                patient.setPrimaryID(rs.getInt(7));
                patient.setPrimaryName(rs.getString(8));

                // Update model, debug log, then return out.
                model.addAttribute("patient", patient);
                System.out.println("end getPatient " + patient); // for DEBUG
                return "patient_show";
            } else { // Case for nothing found
                model.addAttribute("message", "Patient not found.");
                return "patient_get";
            }
        } catch (SQLException e) {
            System.out.println("SQL error in getPatient " + e.getMessage());
            model.addAttribute("message", "SQL Error." + e.getMessage());
            model.addAttribute("patient", patient);
            return "patient_get";
        }
	}

	/*
	 * Search for patient by patient id.
	 */
	@GetMapping("/patient/edit/{patientId}")
	public String updatePatient(@PathVariable String patientId, Model model) {
		Patient patient = new Patient();

        try (Connection con = getConnection();) {
            

            PreparedStatement ps = con
                    .prepareStatement("SELECT p.birthdate, p.ssn, p.street, p.city, p.state, p.zipcode, p.primaryID, d.name, p.name, d.specialty, d.practice_since_year FROM patient p INNER JOIN doctor d ON p.primaryID=d.id where p.patientID=?");
            // Set the Query vals w the given params
            ps.setString(1, patientId); 
            // Create a new patient obj to display

            // Run the query & then process the results
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { // Case for found Patient
                // Bulk of sets from the given query results
                patient.setPatientId(patientId);
                patient.setBirthdate(rs.getString(1));
                patient.setSsn(rs.getString(2));
                patient.setStreet(rs.getString(3));
                patient.setCity(rs.getString(4));
                patient.setState(rs.getString(5));
                patient.setZipcode(rs.getString(6));
                patient.setPrimaryID(rs.getInt(7));
                patient.setPrimaryName(rs.getString(8));
                patient.setName(rs.getString(9));
                patient.setSpecialty(rs.getString(10));
                patient.setYears(rs.getString(11));

                
                // Update model, debug log, then return out.
                model.addAttribute("patient", patient);
                System.out.println("end getPatient " + patient); // for DEBUG
                return "patient_edit";
            } else { // Case for nothing found
                model.addAttribute("message", "Patient not found. ");
                return "patient_get";
            }
        } catch (SQLException e) {
            System.out.println("SQL error in getPatient " + e.getMessage());
            model.addAttribute("message", "SQL Error." + e.getMessage());
            model.addAttribute("patient", patient);
            return "patient_get";
        }
	}
	
	
	/*
	 * Process changes to patient address and primary doctor
	 */
	@PostMapping("/patient/edit")
	public String updatePatient(Patient p, Model model) {
		// TODO
        System.out.println(p);
		  try (Connection con = getConnection();) {
	            
		        String doc = "select id from doctor WHERE name = ?";
	              PreparedStatement stmt = con.prepareStatement(doc);
	            PreparedStatement ps = con
	                    .prepareStatement("UPDATE patient SET street=?, city=?, state=?, zipcode=?, primaryID=? WHERE patientID=?");
	            ps.setString(1, p.getStreet());
	            ps.setString(2, p.getCity());
	            ps.setString(3, p.getState());
	            ps.setString(4,  p.getZipcode());
	            ps.setString(6, p.getPatientId());
	            stmt.setString(1, p.getPrimaryName());
	            
	            ResultSet res = stmt.executeQuery();
	            while(res.next()) {
	            	ps.setString(5, res.getString("id"));
	            }
	            ps.executeUpdate();
	            
		  }catch (SQLException e) {
	            System.out.println("SQL error in getPatient " + e.getMessage());
	            model.addAttribute("message", "SQL Error." + e.getMessage());
	            model.addAttribute("patient", p);
	            return "patient_get";
	        }
		/*
		 * validate primary doctor name and other data update database
		 */

		model.addAttribute("patient", p);
		return "patient_show";
	}

	/*
	 * return JDBC Connection using jdbcTemplate in Spring Server
	 */

	private Connection getConnection() throws SQLException {
		Connection conn = jdbcTemplate.getDataSource().getConnection();
		return conn;
	}

}
