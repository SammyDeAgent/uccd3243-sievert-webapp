package model.sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import model.entity.DepartmentManager;

@Local
public interface DeptMngrSessionBeanLocal {
	public List<DepartmentManager> getAllDepartmentManagers() throws EJBException;
}
