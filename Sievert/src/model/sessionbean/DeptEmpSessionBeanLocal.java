package model.sessionbean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import model.entity.DepartmentEmployee;

@Local
public interface DeptEmpSessionBeanLocal {
	public DepartmentEmployee findDataByEmpId(String empId);
	public void updateDept(String empId, String deptId ) throws EJBException;
	public void removeData(String empId) throws EJBException;
}
