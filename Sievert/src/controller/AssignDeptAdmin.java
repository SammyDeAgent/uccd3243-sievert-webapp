package controller;

import java.io.IOException;

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
 * Servlet implementation class AssignDeptAdmin
 */
@WebServlet("/AssignDeptAdmin")
@Transactional
public class AssignDeptAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	@EJB
	private EmployeeSessionBeanLocal EmpBean;
	
	@EJB
	private DepartmentSessionBeanLocal DeptBean;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AssignDeptAdmin() {
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
		String deptId = request.getParameter("new_dept");
		String empId = request.getParameter("id");
		if(!deptId.equals("null")) {
			Department dept = DeptBean.getDepartmentById(deptId);
			EmpBean.updateDept(empId, dept);
		}else {
			EmpBean.updateDept(empId, null);
		}
		
		//Toast Flag
		session.setAttribute("EditProfileAdmin", 1);
						
		//Redirect
		response.sendRedirect("Profile?id="+empId);
	}

}
