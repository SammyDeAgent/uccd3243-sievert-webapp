package filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class SignIn
 */
@WebFilter(urlPatterns= {"/SignOut","/SignOut.jsp"})
public class SignOut implements Filter {

    /**
     * Default constructor. 
     */
    public SignOut() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		try{
			int logged = (Integer) req.getSession().getAttribute("logged");
			if(logged == 1) {
				chain.doFilter(request, response);
			}else if(logged == 0) {
				((HttpServletResponse) response).sendError(HttpServletResponse.SC_FORBIDDEN);
			}
		}catch(NullPointerException ex) {
			int logged = 0;
			req.getSession().setAttribute("logged", logged);
			((HttpServletResponse) response).sendError(HttpServletResponse.SC_FORBIDDEN);
		}finally {
			
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
