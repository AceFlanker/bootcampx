const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

const cohortDate = process.argv[2];

pool.query(`
SELECT teachers.name AS teacher, cohorts.name AS cohort, COUNT(assistance_requests) AS total_assistances
  FROM assistance_requests
  JOIN teachers ON teachers.id = teacher_id
  JOIN students ON students.id = student_id
  JOIN cohorts ON cohorts.id = cohort_id
  WHERE cohorts.name = '${cohortDate || 'JUL02'}' 
  GROUP BY teacher, cohort
  ORDER BY teacher;
`)
.then(res => {
  res.rows.forEach(teacher => {
    console.log(`${teacher.cohort}: ${teacher.teacher}`);
  })
})
.catch(err => console.error('query error', err.stack));

// pool.end();