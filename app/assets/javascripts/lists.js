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
  initTaskList();
}

function initTaskButtonListener() {
  $("button.toggle-task").click(function(e) {
    var taskId = $(this).data('task-id');
    toggleTask(taskId);
  });
}

function initTaskList() {
  new TaskList("#task-list").render;
}

function TaskList(target) {
  this.tasks = JSON.parse($("#tasks-data").text());
  this.currentStatus = "incomplete"
  this.taskTemplate = $("#task-template").text();
  this.statusToggleTemplate = $("#status-toggle-template").text();
  this.$target = $(target);
  this.render(this.tasksByStatus(this.currentStatus));
  this.bindEventListeners();
}

TaskList.prototype.bindEventListeners = function() {
  $("#status-toggler").click(this.toggleStatusDisplay());
}

TaskList.prototype.toggleStatusDisplay = function() {
  var taskList = this;
  return function(event) {
    event.preventDefault();
    taskList.toggleStatus();
    taskList.render(taskList.tasksByStatus(taskList.currentStatus))
  }
}

TaskList.prototype.toggleStatus = function() {
  if(this.currentStatus === "complete") {
    this.currentStatus = "incomplete"
  } else {
    this.currentStatus = "complete"
  }
}

TaskList.prototype.statusToggleView = function() {
  return {viewingComplete: (this.status === "complete")};
}

TaskList.prototype.tasksByStatus = function(status) {
  return _.select(this.tasks, function(t) { return t.status == status });
}

TaskList.prototype.render = function(tasks) {
  var tl = this;
  $("#status-toggler").html(Mustache.render(this.statusToggleTemplate, this.statusToggleView()));
  this.$target.html(_.map(tasks, function(t) {
    return tl.renderTask(t);
  }));
}

TaskList.prototype.renderTask = function(task) {
  return Mustache.render(this.taskTemplate, task);
}




