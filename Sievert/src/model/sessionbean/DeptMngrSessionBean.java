package model.sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import model.entity.DepartmentManager;

/**
 * Session Bean implementation class DeptMngrSessionBean
 */
@Stateless
public class DeptMngrSessionBean implements DeptMngrSessionBeanLocal {

    /**
     * Default constructor. 
     */
    public DeptMngrSessionBean() {
        // TODO Auto-generated constructor stub
    }
    
    @PersistenceContext(unitName="Sievert")
    EntityManager em;
    
	@Override
	public List<DepartmentManager> getAllDepartmentManagers() throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("DepartmentManager.findAll").getResultList();
	}

}
