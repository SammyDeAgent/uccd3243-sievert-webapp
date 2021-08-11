package controller;

import java.io.IOException;
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
import javax.transaction.Transactional;

import model.entity.Department;
import model.sessionbean.DepartmentSessionBeanLocal;
import model.sessionbean.EmployeeSessionBeanLocal;

/**
 * Servlet implementation class RegProfileAdmin
 */
@WebServlet("/RegProfileAdmin")
@Transactional
public class RegProfileAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private EmployeeSessionBeanLocal EmpBean;
	
	@EJB
	private DepartmentSessionBeanLocal DeptBean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegProfileAdmin() {
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
		String fName = request.getParameter("RegFName");
		String lName = request.getParameter("RegLName");
		String gender = request.getParameter("RegGender");
		
		int RegDOBDay = Integer.valueOf(request.getParameter("RegDOBDay"));
		int RegDOBMonth = Integer.valueOf(request.getParameter("RegDOBMonth"));
		int RegDOBYear = Integer.valueOf(request.getParameter("RegDOBYear"));
		
		int RegHiredDay = Integer.valueOf(request.getParameter("RegHiredDay"));
		int RegHiredMonth = Integer.valueOf(request.getParameter("RegHiredMonth"));
		int RegHiredYear = Integer.valueOf(request.getParameter("RegHiredYear"));
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		String dateStr = RegDOBDay + "-" + RegDOBMonth + "-" + RegDOBYear;
		String hiredStr = RegHiredDay + "-" + RegHiredMonth + "-" + RegHiredYear;
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
		
		String deptId= request.getParameter("RegDeptId");
		Department dept = null;
		if(!deptId.equals("null")) {
			dept = DeptBean.getDepartmentById(deptId);
		}
		else {
			
		}
		
		//Insert Method
		EmpBean.addEmployee(fName, lName, gender, dob, hired, dept);
		
		//Toast Flag
		session.setAttribute("AddProfileAdmin", 1);
						
		//Redirect
		response.sendRedirect("Register");
	}

}
