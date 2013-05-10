$(document).ready ->
  # Set value of type for user search action
  $("#user-nav button").on "click", ->
    $("#user-type").val $(this).val()
    $('#submit-user-posts').submit()

  # Set value of type for search action
  $("#search-button-grp button").on "click", ->
    $("#search-type").val $(this).val()

    # Click opposite type button in form when clicked in search
    if !$('#new-form').hasClass('make-visible')
      if $(this).attr('id') == 'search-demand'
        $('#post-offer').click()
        $('#post-button').val('Create Offer')
      if $(this).attr('id') == 'search-offer'
        $('#post-demand').click()
        $('#post-button').val('Create Demand')

  # Change Button text when form is visible
  $('#post-demand').on "click", ->
    $('#post-button').val('Create Demand')
  $('#post-offer').on "click", ->
    $('#post-button').val('Create Offer')

  # Set value of type for new post action
  $("#post-button-grp button").on "click", ->
    $("#post_type").val $(this).val()

  # Tooltip on deactivated new button
  $('#no-post').tooltip()

  # Toggle class on new button to make form visible
  $("#new-post").on "click", ->
    $("#new-form.dropdown-menu").toggleClass('make-visible')
    $("#new-post").toggleClass('active')
    $("#new-post i")
      .toggleClass('icon-plus')
      .toggleClass('icon-remove')

    # Set value to form type button
    if $('#post_type').val() == ''
      $('#post-offer').click()

  # Toggle class on sign button to make form visible
  $("#sign").on "click", ->
    $("#sign-form.dropdown-menu").toggleClass('make-visible')
    $("#sign").toggleClass('active')
    $("#sign i")
      .toggleClass('icon-user')
      .toggleClass('icon-remove')

  # Counter and create button enabling
  $('input[type=submit]#post-button').attr("disabled", "disabled")
  $("#post_message").on "keyup", ->
    charsentered = $("#post_message").val().length
    charsleft = 140 - charsentered
    if charsleft > 135 || charsleft < 5
      if charsleft > 135
        $('.counter p').text('min 5 Characters')
        $('input[type=submit]#post-button').attr("disabled", "disabled")
      else
        $('.counter p').text('Message is too long')
        $('input[type=submit]#post-button').attr("disabled", "disabled")
    else
      $('.counter p').text(charsleft)
      $('input[type=submit]#post-button').removeAttr("disabled")

  # Make Login/Register tabbable
  $('#sign-in-up-button-grp').on "click", ->
    $("#login-form").toggleClass('make-visible')
    $("#register-form").toggleClass('make-visible')

  # Remove flash-message when clicked on close
  $('#flash-messages .close').on "click", ->
    $('#flash-messages').remove()
