SELECT COUNT(assistance_requests.*) AS total_assistances, name
  FROM assistance_requests
  JOIN teachers ON teachers.id = teacher_id
  WHERE name = 'Waylon Boehm'
  GROUP BY name;

SELECT COUNT(assistance_requests.*) AS total_assistances, name
  FROM assistance_requests
  JOIN students ON students.id = student_id
  WHERE name = 'Elliot Dickinson'
  GROUP BY name;

SELECT teachers.name AS teacher, students.name AS student, assignments.name AS assignment, (assistance_requests.completed_at - assistance_requests.started_at) AS duration
  FROM teachers
  JOIN assistance_requests ON teacher_id = teachers.id
  JOIN assignments ON assignments.id = assignment_id
  JOIN students ON students.id = student_id
  ORDER BY duration;

SELECT AVG(assistance_requests.completed_at - assistance_requests.started_at) AS average_assistance_request_duration
  FROM assistance_requests;

SELECT cohorts.name AS name, AVG(assistance_requests.completed_at - assistance_requests.started_at) AS average_assistance_time
  FROM cohorts
  JOIN students ON cohort_id = cohorts.id
  JOIN assistance_requests ON student_id = students.id
  GROUP BY cohorts.name
  ORDER BY average_assistance_time;

-- SELECT MAX(average_assistance_times.average_assistance_time) AS test1
--   FROM (
--     SELECT cohorts.name AS name, AVG(assistance_requests.completed_at - assistance_requests.started_at) AS average_assistance_time
--     FROM cohorts
--     JOIN students ON cohort_id = cohorts.id
--     JOIN assistance_requests ON student_id = students.id
--     GROUP BY cohorts.name
--     ORDER BY average_assistance_time) AS average_assistance_times;

SELECT cohorts.name AS name, AVG(assistance_requests.completed_at - assistance_requests.started_at) AS average_assistance_time
  FROM cohorts
  JOIN students ON cohort_id = cohorts.id
  JOIN assistance_requests ON student_id = students.id
  GROUP BY cohorts.name
  ORDER BY average_assistance_time DESC
  LIMIT 1;

SELECT AVG(assistance_requests.started_at - assistance_requests.created_at) AS average_wait_time
    FROM assistance_requests;

SELECT cohorts.name AS name, SUM(assistance_requests.completed_at - assistance_requests.started_at) AS total_duration
  FROM cohorts
  JOIN students ON cohort_id = cohorts.id
  JOIN assistance_requests ON student_id = students.id
  GROUP BY cohorts.name
  ORDER BY total_duration;

SELECT AVG(total_duration) AS average_total_duration
  FROM (
    SELECT cohorts.name AS name, SUM(completed_at - started_at) AS total_duration
    FROM cohorts
    JOIN students ON cohort_id = cohorts.id
    JOIN assistance_requests ON student_id = students.id
    GROUP BY cohorts.name
    ORDER BY total_duration
  ) AS total_assistance_durations;

SELECT assignments.id AS id, name, day, chapter, COUNT(assistance_requests) AS total_requests
  FROM assignments
  JOIN assistance_requests ON assignment_id = assignments.id
  GROUP BY assignments.id
  ORDER BY total_requests DESC;

SELECT day, COUNT(assignments) AS number_of_assignments, SUM(duration) as duration
  FROM assignments
  GROUP BY day
  ORDER BY day;

SELECT DISTINCT teachers.name AS teacher, cohorts.name AS cohort
  FROM assistance_requests
  JOIN teachers ON teachers.id = teacher_id
  JOIN students ON students.id = student_id
  JOIN cohorts ON cohorts.id = cohort_id
  WHERE cohorts.name = 'JUL02'
  ORDER BY teacher;

SELECT teachers.name AS teacher, cohorts.name AS cohort, COUNT(assistance_requests) AS total_assistances
  FROM assistance_requests
  JOIN teachers ON teachers.id = teacher_id
  JOIN students ON students.id = student_id
  JOIN cohorts ON cohorts.id = cohort_id
  WHERE cohorts.name = 'JUL02'
  GROUP BY teacher, cohort
  ORDER BY teacher;