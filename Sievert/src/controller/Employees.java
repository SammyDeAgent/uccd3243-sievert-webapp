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

import model.entity.Employee;
import model.sessionbean.EmployeeSessionBeanLocal;

/**
 * Servlet implementation class Employees
 */
@WebServlet("/Employees")
public class Employees extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private EmployeeSessionBeanLocal empBean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Employees() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//Pagination
		String keyword = request.getParameter("keyword");
		if(keyword == null) {
			keyword = "";
		}
		
		String order = request.getParameter("order");
		if(order == null) {
			order = "ASC";
		}
		
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
			int rows = empBean.getRows(keyword);
			pages = rows/recordsPerPage;
			
			if(rows % recordsPerPage != 0) {
				pages++;
			}
			
			if(cur_page > pages && pages != 0) {
				cur_page = pages;
			}
			
			List<Employee> emp = empBean.read(cur_page,recordsPerPage, keyword, order);
			request.setAttribute("data", emp);
		}catch(EJBException ex) {
			
		}
		
		request.setAttribute("pages", pages);
		request.setAttribute("cur_page", cur_page);
		request.setAttribute("recordsPerPage", recordsPerPage);
		request.setAttribute("keyword", keyword);
		request.setAttribute("order", order);
		
		RequestDispatcher RD = request.getRequestDispatcher("EmployeeList.jsp");
		RD.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);
	}

}
