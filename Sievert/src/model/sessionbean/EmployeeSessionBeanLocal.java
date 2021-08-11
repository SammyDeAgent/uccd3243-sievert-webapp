package model.sessionbean;

import java.util.Date;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import model.entity.Department;
import model.entity.Employee;

@Local
public interface EmployeeSessionBeanLocal {
	public List<Employee> getAllEmployees() throws EJBException;
	public Employee getEmployeeById(String id) throws EJBException;
	public void updateProfile(String id, String fname, String gender, Date birthDate, Date hireDate) throws EJBException;
	public void updateProfileAdmin(String id, String fname, String lname, String gender, Date birthDate, Date hireDate) throws EJBException;
	public int getRows(String keyword) throws EJBException;
	public int getRowsByDept(String deptId) throws EJBException;
	public List<Employee> read(int CP, int RPP, String keyword, String order) throws EJBException;
	public List<Employee> readByDept(int CP, int RPP, String deptId) throws EJBException;
	public void deleteEmployee(String id) throws EJBException;
	public void addEmployee(String fname, String lname, String gender, Date birthDate, Date hireDate, Department dept) throws EJBException;
	public void updateDept(String id, Department dept);
}
