$("#student_course_tokens").tokenInput("/courses.json", {
  crossDomain: false,
  prePopulate: $("#student_course_tokens").data("pre"),
  preventDuplicates: true
});
