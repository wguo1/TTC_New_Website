# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener('turbolinks:load', ->
	`$(document).ready(function(){
		flatpickr('#flatpickr-birthday-input', {
		minDate: "1905.07.05",
		maxDate: "today",
		altInput: true,
		altFormat: "M j, Y",
		dateFormat: "Y-m-d",});
	});`
)

if !Turbolinks?
  location.reload

Turbolinks.dispatch("turbolinks:load")
