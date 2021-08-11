package model.sessionbean;

import java.math.BigInteger;
import java.util.Date;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import model.entity.Department;
import model.entity.DepartmentEmployee;
import model.entity.DepartmentEmployeePK;
import model.entity.Employee;

/**
 * Session Bean implementation class EmployeeSessionBean
 */
@Stateless
public class EmployeeSessionBean implements EmployeeSessionBeanLocal {
	
	@PersistenceContext(unitName="Sievert")
    EntityManager em;
	
    /**
     * Default constructor. 
     */
    public EmployeeSessionBean() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public List<Employee> getAllEmployees() throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Employee.findAll").getResultList();
	}
	
	@Override
	public Employee getEmployeeById(String id) throws EJBException {
		// TODO Auto-generated method stub
		Query q = em.createNamedQuery("Employee.findById");
		q.setParameter("id", Long.valueOf(id));
		return (Employee) q.getSingleResult();
	}

	@Override
	public void updateProfile(String id, String fname, String gender, Date birthDate, Date hireDate) throws EJBException {
		// TODO Auto-generated method stub
		Employee emp = getEmployeeById(id);
		emp.setFirstName(fname);
		emp.setGender(gender);
		emp.setBirthDate(birthDate);
		emp.setHireDate(hireDate);
		em.persist(emp);
	}
	
	@Override
	public int getRows(String keyword) throws EJBException {
		// TODO Auto-generated method stub
		Query q = null;
		if(keyword.isEmpty()) {
			q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM employees.employee");
		}else {
			q = em.createNativeQuery("SELECT COUNT(*) AS totalrow from employees.employee WHERE lower(concat(id,first_name,last_name,gender)) LIKE ?");
			q.setParameter(1, "%" + keyword.toLowerCase() + "%");
		}
		
		BigInteger results = (BigInteger) q.getSingleResult();
		int i = results.intValue();
		return i;
	}
	
	@Override
	public List<Employee> read(int CP, int RPP, String keyword, String order) throws EJBException {
		// TODO Auto-generated method stub
		
		Query q  = null;
		int start = 0;
		
		order = " " + order;
		
		if(keyword.isEmpty()) {
			q = em.createNativeQuery("SELECT * FROM employees.employee order by id" + order , Employee.class);
			start = CP * RPP - RPP;
		}else {
			q = em.createNativeQuery("SELECT * FROM employees.employee WHERE lower(concat(id,first_name,last_name,gender)) LIKE ? order by id " + order , Employee.class);
			start = CP * RPP - RPP;
			q.setParameter(1, "%"+keyword.toLowerCase()+"%" );
		}
		
		List<Employee> results = q.setFirstResult(start).setMaxResults(RPP).getResultList();
		return results;
	}
	
	@Override
	public List<Employee> readByDept(int CP, int RPP, String deptId) throws EJBException {
		// TODO Auto-generated method stub
		
		Query q  = null;
		int start = 0;
		
		q = em.createNativeQuery("SELECT * FROM employees.employee emp JOIN employees.department_employee deptEmp ON deptEmp.employee_id = emp.id AND deptEmp.department_id = ? ORDER by emp.id"  , Employee.class);
		start = CP * RPP - RPP;
		q.setParameter(1, deptId);
			
		List<Employee> results = q.setFirstResult(start).setMaxResults(RPP).getResultList();
		return results;
	}
	
	@Override
	public int getRowsByDept(String deptId) throws EJBException {
		// TODO Auto-generated method stub
		Query q = null;

		q = em.createNativeQuery("SELECT COUNT(*) AS totalrow from employees.employee emp JOIN employees.department_employee deptEmp ON deptEmp.employee_id = emp.id AND deptEmp.department_id = ?");
		q.setParameter(1, deptId);

		BigInteger results = (BigInteger) q.getSingleResult();
		int i = results.intValue();
		return i;
	}

	@Override
	public void updateProfileAdmin(String id, String fname, String lname, String gender, Date birthDate, Date hireDate)
			throws EJBException {
		// TODO Auto-generated method stub
		Employee emp = getEmployeeById(id);
		emp.setFirstName(fname);
		emp.setLastName(lname);
		emp.setGender(gender);
		emp.setBirthDate(birthDate);
		emp.setHireDate(hireDate);
		em.persist(emp);
		
	}

	@Override
	public void deleteEmployee(String id) throws EJBException {
		// TODO Auto-generated method stub
		Employee emp = getEmployeeById(id);
		em.remove(emp);
	}

	@Override
	public void addEmployee(String fname, String lname, String gender, Date birthDate, Date hireDate, Department dept)
			throws EJBException {
		// TODO Auto-generated method stub
		Employee emp = new Employee();
		emp.setFirstName(fname);
		emp.setLastName(lname);
		emp.setGender(gender);
		emp.setBirthDate(birthDate);
		emp.setHireDate(hireDate);
		em.persist(emp);		
		
		if(dept!=null) {
			DepartmentEmployeePK dePK = new DepartmentEmployeePK();
			dePK.setDepartmentId(dept.getId());
			dePK.setEmployeeId(emp.getId());
			
			DepartmentEmployee deptEmp = new DepartmentEmployee();
			deptEmp.setId(dePK);
			deptEmp.setDepartment(dept);
			deptEmp.setFromDate(new Date());
			deptEmp.setToDate(new Date());
			deptEmp.setEmployee(emp);
			em.persist(deptEmp);
		}
	}

	@Override
	public void updateDept(String id, Department dept) {
		// TODO Auto-generated method stub
		Employee emp = getEmployeeById(id);
		Query q = em.createNativeQuery("DELETE FROM employees.department_employee DE WHERE DE.employee_id = :id");
    	q.setParameter("id", emp.getId());
    	q.executeUpdate();
		
		if(dept!=null) {
			DepartmentEmployeePK dePK = new DepartmentEmployeePK();
			dePK.setDepartmentId(dept.getId());
			dePK.setEmployeeId(emp.getId());
			
			DepartmentEmployee deptEmp = new DepartmentEmployee();
			deptEmp.setId(dePK);
			deptEmp.setDepartment(dept);
			deptEmp.setFromDate(new Date());
			deptEmp.setToDate(new Date());
			deptEmp.setEmployee(emp);
			em.persist(deptEmp);
		}else {
			q = em.createNativeQuery("DELETE FROM employees.department_employee DE WHERE DE.employee_id = :id");
	    	q.setParameter("id", emp.getId());
	    	q.executeUpdate();
		}
	}

}
