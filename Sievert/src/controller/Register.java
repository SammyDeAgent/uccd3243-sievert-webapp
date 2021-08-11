package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import model.entity.Department;
import model.sessionbean.DepartmentSessionBeanLocal;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
@Transactional
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private DepartmentSessionBeanLocal DeptBean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		List<Department> matrix = DeptBean.getAllDepartments();
		List<List<String>> deptInfo = new ArrayList<List<String>>();
		for(Department cell :  matrix) {
			List<String> temp = new ArrayList<String>();
			temp.add(cell.getId());
			temp.add(cell.getDeptName());
			deptInfo.add(temp);
		}
		request.setAttribute("deptInfo", deptInfo);
		
		RequestDispatcher RD = request.getRequestDispatcher("Register.jsp");
		RD.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}
