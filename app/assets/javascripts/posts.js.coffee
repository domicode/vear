# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("#post-kind button").on "click", ->
    $("#post_kind").val $(this).val()
    $("#kind").val $(this).val()

  $("#post-message textarea").on "change", ->
    $("#post_message").val $(this).val()
    $("#query").val $(this).val()