package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.persistence.NoResultException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import model.entity.DepartmentEmployee;
import model.entity.Employee;
import model.entity.Salary;
import model.entity.Title;
import model.sessionbean.DepartmentSessionBeanLocal;
import model.sessionbean.EmployeeSessionBeanLocal;

import org.wildfly.security.json.*;

/**
 * Servlet implementation class SignIn
 */
@WebServlet("/SignIn")
@Transactional
public class SignIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private EmployeeSessionBeanLocal EmpBean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignIn() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
		response.sendRedirect("SignIn.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
		
		String empId = request.getParameter("empId");
		String lname = request.getParameter("lname");
				
		try {
			Employee emp = EmpBean.getEmployeeById(empId);
			
			String authId = String.valueOf(emp.getId());
			String authlN = emp.getLastName();
			
			if(authId.equals(empId) && authlN.equals(lname)) {
				// response.getWriter().write("You are signed in. Welcome to Sievert, "+emp.getFirstName()+ " "+emp.getLastName());
				
				// Servlet Session Creation + Session Informations
				HttpSession session = request.getSession();
				session.setAttribute("logged", 1);
				session.setAttribute("fName", emp.getFirstName());
				session.setAttribute("lName", emp.getLastName());
				session.setAttribute("empId", emp.getId());
				session.setAttribute("gender", emp.getGender());
				session.setAttribute("dob",emp.getBirthDate());
				session.setAttribute("hired",emp.getHireDate());
				
				List<Title> rows1 = emp.getTitles();
				List<String> arrTitles = new ArrayList<String>();
				for(Title title: rows1) {
					arrTitles.add(title.getId().getTitle());
				}
				session.setAttribute("titles", arrTitles);
				
				List<DepartmentEmployee> rows2 = emp.getDepartmentEmployees();
				List<String> arrDept = new ArrayList<String>();
				for(DepartmentEmployee deptEmp : rows2) {
					arrDept.add(deptEmp.getDepartment().getDeptName());
				}
				session.setAttribute("depts", arrDept);
				
				List<Salary> rows3 = emp.getSalaries();
				DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy"); 
				List<List<String>> arrSal = new ArrayList<List<String>>();
				for(Salary sal : rows3) {
					List<String> temp = new ArrayList<String>();
					temp.add(String.valueOf(sal.getAmount()));
					temp.add(dateFormat.format(sal.getId().getFromDate()));
					temp.add(dateFormat.format(sal.getToDate()));
					arrSal.add(temp);
				}
				session.setAttribute("salaries", arrSal);
				
				//Flag generation
				session.setAttribute("EditProfile",0);
				session.setAttribute("EditProfileAdmin",0);
				session.setAttribute("RemoveProfileAdmin",0);
				session.setAttribute("AddProfileAdmin", 0);
	
				// Transfer control to another servlet
				response.sendRedirect("Console");
			}else {
				// response.getWriter().write("Authentication Error: Incorrect ID or Lastname. Code: Unmatched");
				request.setAttribute("authError", 1);
				RequestDispatcher RD = request.getRequestDispatcher("SignIn.jsp");
				RD.include(request, response);
			}
		}catch(EJBException ex){
			// response.getWriter().write("Authentication Error: Incorrect ID or Lastname. Code: Unknown");
			request.setAttribute("authError", 1);
			RequestDispatcher RD = request.getRequestDispatcher("SignIn.jsp");
			RD.include(request, response);
		}finally {
			
		}
	
	}

}
