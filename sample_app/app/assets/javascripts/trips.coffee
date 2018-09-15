# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener('turbolinks:load', ->
	`$(document).ready(function(){
		flatpickr('#flatpickr-input', {
		minDate: "today",
		maxDate: new Date().fp_incr(365),
		enableTime: true,
		altInput: true,
		altFormat: "M j, Y h:i K",
		dateFormat: "Y-m-d H:i",});
	});`
)

if !Turbolinks?
  location.reload

Turbolinks.dispatch("turbolinks:load")


