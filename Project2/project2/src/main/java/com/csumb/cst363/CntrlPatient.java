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
	   
            Doctor doctor = new Doctor();
            
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
//	                prepStatement.setString(8, patient.getPrimaryName());
	                
	                System.out.println(patient.getPrimaryName());
	                //gets the primary name to find doc
	                docFind.setString(1, patient.getPrimaryName());
	                ResultSet df = docFind.executeQuery();
	                df.next();
	                int docID = df.getInt("id");
	                
	                //sets the id of the primary doc
	                prepStatement.setInt(8, docID);
	                prepStatement.executeUpdate();
	                
	                ResultSet pf = prepStatement.getGeneratedKeys();
	                
	                if (pf.next())
	                {
	                   String primaryName = pf.getString(8);
	                   System.out.println("Primary name: " + primaryName);
	                   
	                }
	        
	             } catch (SQLException ex) {
	                model.addAttribute("message", "SQL Error."+ex.getMessage());
                        model.addAttribute("patient", patient);
                        return "patient_register";       
	             }
		// fake data for generated patient id.
      return null;

	}
	
	/*
	 * Search for patient by patient id and name.
	 */
	@PostMapping("/patient/show")
	public String getPatientForm(@RequestParam("patientId") String patientId, @RequestParam("name") String name,
			Model model) {

		// TODO

		/*
		 * code to search for patient by id and name retrieve patient data and primary
		 * doctor data create Patient object
		 */
		
		// return fake data for now.
		Patient p = new Patient();
		p.setPatientId(patientId);
		p.setName(name);
		p.setBirthdate("2001-01-01");
		p.setStreet("123 Main");
		p.setCity("SunCity");
		p.setState("CA");
		p.setZipcode("99999");
		p.setPrimaryID(11111);
		p.setPrimaryName("Dr. Watson");
		p.setSpecialty("Family Medicine");
		p.setYears("1992");

		model.addAttribute("patient", p);
		return "patient_show";
	}

	/*
	 * Search for patient by patient id.
	 */
	@GetMapping("/patient/edit/{patientId}")
	public String updatePatient(@PathVariable String patientId, Model model) {

		// TODO Complete database logic search for patient by id.

		// return fake data for now.
		Patient p = new Patient();
		p.setPatientId(patientId);
		p.setName("Alex Patient");
		p.setBirthdate("2001-01-01");
		p.setStreet("123 Main");
		p.setCity("SunCity");
		p.setState("CA");
		p.setZipcode("99999");
		p.setPrimaryID(11111);
		p.setPrimaryName("Dr. Watson");
		p.setSpecialty("Family Medicine");
		p.setYears("1992");

		model.addAttribute("patient", p);
		return "patient_edit";
	}
	
	
	/*
	 * Process changes to patient address and primary doctor
	 */
	@PostMapping("/patient/edit")
	public String updatePatient(Patient p, Model model) {

		// TODO

		/*
		 * validate primary doctor name and other data update databaser
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
