

CREATE TABLE IF NOT EXISTS employee (
	employee_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	department VARCHAR(60) NOT NULL,
	chief_id INT NOT NULL REFERENCES employee(employee_id)
);
