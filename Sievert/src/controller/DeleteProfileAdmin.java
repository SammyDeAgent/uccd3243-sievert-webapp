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

import model.sessionbean.EmployeeSessionBeanLocal;

/**
 * Servlet implementation class DeleteProfileAdmin
 */
@WebServlet("/DeleteProfileAdmin")
@Transactional
public class DeleteProfileAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB 
	private EmployeeSessionBeanLocal EmpBean;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProfileAdmin() {
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
		String id = request.getParameter("id");
		
		//Cascade-Delete method
		EmpBean.deleteEmployee(id);
		
		//Toast Flag
		session.setAttribute("RemoveProfileAdmin", 1);
		
		//Redirect
		response.sendRedirect("Employees");
	}

}
