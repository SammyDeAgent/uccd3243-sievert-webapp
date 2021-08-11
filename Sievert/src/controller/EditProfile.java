package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.entity.Employee;
import model.sessionbean.EmployeeSessionBeanLocal;

/**
 * Servlet implementation class EditProfile
 */
@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private EmployeeSessionBeanLocal EmpBean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		//Get Parms
		HttpSession session = request.getSession();
		String fName = request.getParameter("new_fName");
		String gender = request.getParameter("new_gender");
		int day = Integer.valueOf(request.getParameter("new_day"));
		int month = Integer.valueOf(request.getParameter("new_month"));
		int year = Integer.valueOf(request.getParameter("new_year"));
		int day2 = Integer.valueOf(request.getParameter("new_day2"));
		int month2 = Integer.valueOf(request.getParameter("new_month2"));
		int year2 = Integer.valueOf(request.getParameter("new_year2"));
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		String dateStr = day + "-" + month + "-" + year;
		String hiredStr = day2 + "-" + month2 + "-" + year2;
		Date dob = null;
		try {
			dob = dateFormat.parse(dateStr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Date hired = null;
		try{
			hired = dateFormat.parse(hiredStr);
		}catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//Update methods
		EmpBean.updateProfile((String) String.valueOf(session.getAttribute("empId")), fName, gender, dob, hired);
		
		//Update Session Parms
		session.setAttribute("fName", fName);
		session.setAttribute("gender", gender);
		session.setAttribute("dob", dob);
		session.setAttribute("hired", hired);
		
		//Toast Flag
		session.setAttribute("EditProfile", 1);
		
		//Redirect
		response.sendRedirect("Console");
	}

}
