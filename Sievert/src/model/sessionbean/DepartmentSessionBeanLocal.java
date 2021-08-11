package model.sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import model.entity.Department;

@Local
public interface DepartmentSessionBeanLocal {
	public List<Department> getAllDepartments() throws EJBException;
	public Department getDepartmentById(String keyword) throws EJBException;
}
