# Final Assessment

For your final assessment, you'll be building a task management application.

## Base Expectations

* The application must be deployed and working in production.

### Lists

* A task list has a title.
* A task list can be archived.
* By default, users should only see unarchived task lists.
* A user can create a task list.
* A user can rename a task list.
* A user can archive a task list.
* A user can only delete a task list from the archive.
* A user can view archived task lists.

### Tasks

* A task has title, status (complete or incomplete) description, and a due date.
* A user can create a task.
* A user can update and adjust the properties of an existing task.
* A user can mark a task as completed.
* By default, users should only see incomplete tasks.
* A user can see completed tasks and mark them as incomplete.

### User Interface and Experience

<!--* A user should be able to change the status of a task without reloading the page.-->
<!--* A user should be able to sort the tasks in a list by title, status, and due date without reloading the page.-->
* A user should be able to filter the tasks in a list by name without reloading the page.
<!--* A user should be able to filter the tasks in a list by status without reloading the page.-->
<!--* A user should be able to see their archived tasks.-->

## Supporting Features

You application must include at least two of the supporting features below.

### Tags

* A user can add one or more tags to a task.
* When looking a list of tasks, a user should see all of the tags applied to those tasks.
* When looking at a list of tasks, a user can filter the lists of tasks by a tag.
* A user can see all of the tags applied to their tasks.
* A user can see a list of all of the tasks for a given tag as well as what list that task belongs to.

### Importing and Exporting

How you format your exported CSV is up to you, but you should be able to import whatever file you export and your exported file must include all of the data about the tasks and lists in your application.

* A user can download all of their tasks as a CSV file.
* A user can upload tasks via a CSV file.

### Email

* When a user enters `/cc email@example.com` in the title of a task, the application will send a email to the address with the title, description, due date, and status of the task.
* When the status of a task with a `/cc` is changed, the recipient will be updated via email.

### Add by SMS

* A user can text a number with the title of a task and it will be added to a designated list (e.g. "SMS Tasks").
* If the SMS message includes `/l listname`, it will be added to that list.
* When a user successfully submits a task via SMS, they will receive a confirmation text with the `id` of the text.

### WebSockets

* If a task is added in one window, the application will push the new task to all other open windows using a WebSocket connection.
* If a task is updated or removed in one window, the application will update all other open windows using a WebSocket connection.

### Client-Side Application

* The user interface is built in a client-side framework (e.g. Ember or Angular) that consumes an API provided by Rails to provide all of the features included in base expectations as well as one other extension.

### File Attachment

* The user can attach a file (e.g. a PDF or image) to a given task.
* A user can delete an attached file.

## Extensions

### Calendar

* The application provides an iCal endpoint that the user can subscribe to via Google Calendar or iCal.

### Update via Email

* In addition to receiving an email when a recipient is mentioned in a task, a recipient can reply to the email with the word `DONE` to mark the task as completed.

### Update via SMS

* A user can text `DONE` along with the `id` of a task to mark it as done.
* The user will receive confirmation via SMS when a task is marked as done.

## Rubric

### Features

* 4: All of the base expectations were completed and as well as more than two support features and extensions
* 3: All of the base expectations were met along with two supporting features
* 2: Missing one or two features from the base expectations
* 1: Missing more than two base expectations and/or the application is not deployed and working in production

### User Interface

* 4: The application is pleasant, logical, and easy to use
* 3: The application has many strong pages/interactions, but a few holes in lesser-used functionality
* 2: The application shows effort in the interface, but the result is not effective
* 1: The application is confusing or difficult to use

### Testing

* 4: Project has a running test suite that exercises the application at multiple levels
* 3: Project has a running test suite that tests and multiple levels but fails to cover some features
* 2: Project has sporadic use of tests and multiple levels
* 1: Project did not really attempt to use TDD

### Rails Style

* 4: Developer is able to craft Rails features that make smart use of Ruby, follow the principles of MVC, and push business logic down where it belongs
* 3: Developer generally writes clean Rails features that make smart use of Ruby, with some struggles in pushing logic down the stack
* 2: Developer struggles with some concepts of MVC and pushing logic down the stack
* 1: Developer shows little or no understanding of how to craft Rails applications

### Ruby Style

* 4: Developer writes code that is exceptionally clear and well-factored
* 3: Developer solves problems with a balance between conciseness and clarity and often extracts logical components
* 2: Developer writes effective code, but does not breakout logical components
* 1: Developer writes code with unnecessary variables, operations, or steps which do not increase clarity
* 0: Developer writes code that is difficult to understand


