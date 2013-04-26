$(document).ready ->
  $("#search-button-grp button").on "click", ->
    # Set value of kind for search action
    $("#kind").val $(this).val()

    # Click opposite kind button in form when clicked in search
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

  # Set value of kind for new post action
  $("#post-button-grp button").on "click", ->
    $("#post_kind").val $(this).val()

  # Toggle class on new button to make form visible
  $("#new-post").on "click", ->
    $(".dropdown-menu").toggleClass('make-visible')
    $("#new-post").toggleClass('active')
    $("#new-post i")
      .toggleClass('icon-plus')
      .toggleClass('icon-remove')

  $("#query").on "keydown", (e) ->
    # Submit search on space or enter
    if e.keyCode == 32 || e.keyCode == 13
      $(this).submit()

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
