package model.sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import model.entity.Department;

/**
 * Session Bean implementation class DepartmentSessionBean
 */
@Stateless
public class DepartmentSessionBean implements DepartmentSessionBeanLocal {

    /**
     * Default constructor. 
     */
    public DepartmentSessionBean() {
        // TODO Auto-generated constructor stub
    }
    
    @PersistenceContext(unitName="Sievert")
    EntityManager em;

	@Override
	public List<Department> getAllDepartments() throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Department.findAll").getResultList();
	}

	@Override
	public Department getDepartmentById(String keyword) throws EJBException {
		// TODO Auto-generated method stub
		Query q = em.createNamedQuery("Department.findById");
		q.setParameter("id", keyword);
		Department dept = (Department) q.getSingleResult();
		return dept;
	}
}
