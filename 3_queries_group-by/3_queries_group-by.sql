SELECT day, COUNT(*) AS total_assignments
  FROM assignments
  GROUP BY day
  ORDER BY day;

SELECT day, COUNT(*) AS total_assignments
  FROM assignments
  GROUP BY day
  HAVING COUNT(*) >= 10
  ORDER BY day;

SELECT cohorts.name AS cohort_name, COUNT(students.*) AS student_count
  FROM cohorts
  JOIN students ON cohort_id = cohorts.id
  GROUP BY cohort_name
  HAVING COUNT(students.*) >= 18
  ORDER BY student_count;

SELECT cohorts.name AS cohort, COUNT(students.*) AS total_submissions
  FROM cohorts
  JOIN students ON cohort_id = cohorts.id
  JOIN assignment_submissions ON student_id = students.id
  GROUP BY cohort
  ORDER BY total_submissions DESC;

SELECT students.name AS student, AVG(assignment_submissions.duration) AS average_assignment_duration
  FROM assignment_submissions
  JOIN students ON students.id = student_id
  WHERE end_date IS NULL
  GROUP BY student
  ORDER BY average_assignment_duration DESC;

SELECT students.name AS student, AVG(assignment_submissions.duration) AS average_assignment_duration, AVG(assignments.duration) AS average_estimated_duration
  FROM assignment_submissions
  JOIN assignments ON assignments.id = assignment_id
  JOIN students ON students.id = student_id
  WHERE end_date IS NULL
  GROUP BY student
  HAVING AVG(assignment_submissions.duration) < AVG(assignments.duration)
  ORDER BY average_assignment_duration;