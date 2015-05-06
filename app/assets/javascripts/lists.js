function removeTask(taskId) {
  $("#task-"+taskId).removeClass("incomplete");
  $("#task-"+taskId).addClass("complete");
}
function completeTask(taskId) {
  $.ajax({url: "/completed_tasks?task_id="+taskId, method: "POST"}).done(function(e) {
    removeTask(taskId);
  });
}

$(document).ready(function() {
  initListUi();
});

function initListUi() {
  initTaskButtonListener();
}

function initTaskButtonListener() {
  $("button.complete-task").click(function(e) {
    var taskId = $(this).data('task-id');
    completeTask(taskId);
  });
}
