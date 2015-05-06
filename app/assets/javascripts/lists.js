$(document).ready(function() {
  initTaskList();
});

function initTaskList() {
  new TaskList("#task-list").render;
}

function TaskList(target) {
  this.tasks = JSON.parse($("#tasks-data").text());
  this.currentStatus = "incomplete"
  this.taskTemplate = $("#task-template").text();
  this.statusToggleTemplate = $("#status-toggle-template").text();
  this.$target = $(target);
  this.render(this.currentTasks());
  this.bindEventListeners();
}

TaskList.prototype.bindEventListeners = function() {
  $("#status-toggler").click(this.toggleStatusDisplay());
  $("#search-box").keyup(this.searchKeyPressed());
  $(".sorter").click(this.sort());
  this.$target.click(this.toggleTask());
}

TaskList.prototype.searchKeyPressed = function() {
  var taskList = this;
  return function(event) {
    var query = $("#search-box").val();
    var matches = _.filter(taskList.currentTasks(), function(t) { return t.description.indexOf(query) > -1 });
    taskList.render(matches);
  }
}

TaskList.prototype.sort = function() {
  var taskList = this;
  return function(event) {
    var attribute = $(event.target).data("attribute");
    var sorted = _.sortBy(taskList.currentTasks(), attribute);
    taskList.render(sorted);
    event.preventDefault();
  }
}

TaskList.prototype.taskById = function(taskId) {
  return _.find(this.tasks, function(t) { return t.id == taskId });
}

TaskList.prototype.toggleTask = function() {
  var taskList = this;
  return function(event) {
    if ($(event.target).hasClass("toggle-task")) {
      var taskId = $(event.target).data("task-id");
      var settings = {
        url: "/completed_tasks?task_id="+taskId,
        method: "POST",
        success: function(e) {
          var task = taskList.taskById(e.task.id);
          task.status = e.task.status;
          taskList.render(taskList.currentTasks())
        }
      };
      $.ajax(settings);
      event.preventDefault();
    }
  }
}

TaskList.prototype.toggleStatusDisplay = function() {
  var taskList = this;
  return function(event) {
    event.preventDefault();
    taskList.toggleStatus();
    taskList.render(taskList.currentTasks())
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
  return {viewingComplete: (this.currentStatus === "complete")};
}

TaskList.prototype.currentTasks = function() {
  return this.tasksByStatus(this.currentStatus);
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




