package model.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the department database table.
 * 
 */
@Entity
@Table(name="department", schema="employees")
@NamedQuery(name="Department.findAll", query="SELECT d FROM Department d ORDER BY d.id")
@NamedQuery(name="Department.findById", query="SELECT d FROM Department d WHERE d.id = :id")
public class Department implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;

	@Column(name="dept_name")
	private String deptName;

	//bi-directional many-to-one association to DepartmentEmployee
	@OneToMany(mappedBy="department")
	private List<DepartmentEmployee> departmentEmployees;

	//bi-directional many-to-one association to DepartmentManager
	@OneToMany(mappedBy="department")
	private List<DepartmentManager> departmentManagers;

	public Department() {
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDeptName() {
		return this.deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public List<DepartmentEmployee> getDepartmentEmployees() {
		return this.departmentEmployees;
	}

	public void setDepartmentEmployees(List<DepartmentEmployee> departmentEmployees) {
		this.departmentEmployees = departmentEmployees;
	}

	public DepartmentEmployee addDepartmentEmployee(DepartmentEmployee departmentEmployee) {
		getDepartmentEmployees().add(departmentEmployee);
		departmentEmployee.setDepartment(this);

		return departmentEmployee;
	}

	public DepartmentEmployee removeDepartmentEmployee(DepartmentEmployee departmentEmployee) {
		getDepartmentEmployees().remove(departmentEmployee);
		departmentEmployee.setDepartment(null);

		return departmentEmployee;
	}

	public List<DepartmentManager> getDepartmentManagers() {
		return this.departmentManagers;
	}

	public void setDepartmentManagers(List<DepartmentManager> departmentManagers) {
		this.departmentManagers = departmentManagers;
	}

	public DepartmentManager addDepartmentManager(DepartmentManager departmentManager) {
		getDepartmentManagers().add(departmentManager);
		departmentManager.setDepartment(this);

		return departmentManager;
	}

	public DepartmentManager removeDepartmentManager(DepartmentManager departmentManager) {
		getDepartmentManagers().remove(departmentManager);
		departmentManager.setDepartment(null);

		return departmentManager;
	}

}