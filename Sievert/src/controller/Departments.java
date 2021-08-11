package controller;

import java.io.IOException;
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
import model.entity.Employee;
import model.sessionbean.DepartmentSessionBeanLocal;
import model.sessionbean.EmployeeSessionBeanLocal;

/**
 * Servlet implementation class DisplayDepartment
 */
@WebServlet("/Departments")
@Transactional
public class Departments extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	@EJB
	private DepartmentSessionBeanLocal deptBean;
	
	@EJB
	private EmployeeSessionBeanLocal empBean;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Departments() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String keyword = null;
		keyword = request.getParameter("dept");
		if(keyword != null) {
			Department dept = null;
			try {
				dept = deptBean.getDepartmentById(keyword);
				request.setAttribute("data1", dept);
			}catch(EJBException ex) {
				 response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			if(dept == null) {
				 response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}else {
				int pages = 0;
				
				int cur_page = 0;
				try {
					cur_page = Integer.parseInt(request.getParameter("cur_page"));
				}catch(NumberFormatException e) {
					cur_page = 1;
				}
				
				int recordsPerPage = 50; //Change if necessary

				try {
					//Pagination Calculation
					int rows = empBean.getRowsByDept(keyword);
					request.setAttribute("count", rows);
					pages = rows/recordsPerPage;
					
					if(rows % recordsPerPage != 0) {
						pages++;
					}
					
					if(cur_page > pages && pages != 0) {
						cur_page = pages;
					}
					
					List<Employee> emp = empBean.readByDept(cur_page,recordsPerPage, keyword );
					request.setAttribute("paginated_emp", emp);
				}catch(EJBException ex) {
					
				}
				
				request.setAttribute("pages", pages);
				request.setAttribute("cur_page", cur_page);
				request.setAttribute("recordsPerPage", recordsPerPage);
				request.setAttribute("deptId", keyword);
				
				RequestDispatcher RD1 = request.getRequestDispatcher("Department.jsp");
				RD1.forward(request, response);
			}
		}else {
			try {
				List<Department> dept = deptBean.getAllDepartments();
				request.setAttribute("data2", dept);
				
			}catch(EJBException ex) {
				
			}
			RequestDispatcher RD2 = request.getRequestDispatcher("DepartmentList.jsp");
			RD2.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
	}

}
