package controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import model.entity.Department;
import model.entity.DepartmentEmployee;
import model.entity.Employee;
import model.entity.Salary;
import model.entity.Title;
import model.sessionbean.DepartmentSessionBeanLocal;
import model.sessionbean.EmployeeSessionBeanLocal;

/**
 * Servlet implementation class Profile
 */
@WebServlet("/Profile")
@Transactional
public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@EJB
	private EmployeeSessionBeanLocal empBean;
	
	@EJB
	private DepartmentSessionBeanLocal deptBean;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Profile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String keyword = null;
		keyword = request.getParameter("id");
		if(keyword != null) {
			Employee emp = null;
			try {
				emp = empBean.getEmployeeById(keyword);
				request.setAttribute("data", emp);
			}catch(EJBException ex) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			if(emp == null) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}else {
				
				List<Title> rows1 = emp.getTitles();
				List<String> arrTitles = new ArrayList<String>();
				for(Title title: rows1) {
					arrTitles.add(title.getId().getTitle());
				}
				request.setAttribute("titles", arrTitles);
				
				String cur_id=null;
				
				List<DepartmentEmployee> rows2 = emp.getDepartmentEmployees();
				List<String> arrDept = new ArrayList<String>();
				for(DepartmentEmployee deptEmp : rows2) {
					cur_id = deptEmp.getDepartment().getId();
					arrDept.add(deptEmp.getDepartment().getDeptName());
				}
				request.setAttribute("depts", arrDept);
				
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
				request.setAttribute("salaries", arrSal);
				
				//Assignment Department Form Setup		
				List<Department> rows4 = deptBean.getAllDepartments();
				List<List<String>> deptForm = new ArrayList<List<String>>();
				for(Department d : rows4) {
					List<String> temp = new ArrayList<String>();
					temp.add(d.getId());
					temp.add(d.getDeptName());
					deptForm.add(temp);
				}
				request.setAttribute("curId", cur_id);
				request.setAttribute("deptForm", deptForm);
				
				RequestDispatcher RD = request.getRequestDispatcher("Profile.jsp");
				RD.forward(request, response);
			}
		}else {
			 response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}
