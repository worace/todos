function updateTaskView(taskId) {
  $("#task-"+taskId).toggleClass("hidden");
}
function toggleTask(taskId) {
  $.ajax({url: "/completed_tasks?task_id="+taskId, method: "POST"}).done(function(e) {
    updateTaskView(taskId);
  });
}

$(document).ready(function() {
  initListUi();
});

function initListUi() {
  initTaskButtonListener();
  initTaskToggle();
}

function initTaskToggle() {
  $(".toggle-tasks").click(function(e) {
    e.preventDefault();
    $(".task").toggleClass("hidden");
    $(".toggle-tasks").toggleClass("hidden");
  });
}

function initTaskButtonListener() {
  $("button.toggle-task").click(function(e) {
    var taskId = $(this).data('task-id');
    toggleTask(taskId);
  });
}
