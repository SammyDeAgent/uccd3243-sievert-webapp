package model.sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import model.entity.DepartmentEmployee;

/**
 * Session Bean implementation class DeptEmpSessionBean
 */
@Stateless
public class DeptEmpSessionBean implements DeptEmpSessionBeanLocal {
	
	@PersistenceContext(unitName="Sievert")
    EntityManager em;
	
    /**
     * Default constructor. 
     */
    public DeptEmpSessionBean() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public DepartmentEmployee findDataByEmpId(String empId) {
		// TODO Auto-generated method stub
		Query q = null;
		
		q=em.createNativeQuery("SELECT * FROM employees.department_employee DE WHERE DE.employee_id = ?");
		q.setParameter(1, empId);
		
		DepartmentEmployee result = (DepartmentEmployee) q.getSingleResult();
		
		System.out.println(result);

		return result;
	}

	@Override
	public void updateDept(String empId, String deptId) throws EJBException {
		// TODO Auto-generated method stub
		DepartmentEmployee DE = findDataByEmpId(empId);
		DE.getId().setDepartmentId(deptId);
		em.persist(DE);
	}

	@Override
	public void removeData(String empId) throws EJBException {
		// TODO Auto-generated method stub
		DepartmentEmployee DE = findDataByEmpId(empId);
		em.remove(DE);
	}

}
