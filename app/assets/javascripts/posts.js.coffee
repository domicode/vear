$(document).ready ->
  # Set browser url
  if history and history.pushState
    $ ->
      $("body").on "click", "a", ->
        $.getScript @href
        history.pushState null, "", @href

        $(window).bind "popstate", ->
          $.getScript location.href

    # Set value of kind for user search action
    $("#user-nav button").on "click", ->
      $("#user-kind").val $(this).val()
      $('#submit-user-posts').submit()

    # Set value of kind for search action
    $("#search-button-grp button").on "click", ->
      $("#search-kind").val $(this).val()
      $('#user-nav').remove()
      $('#submit-search').submit()

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

    # Tooltip on deactivated new button
    $('#no-post').tooltip()

    # Toggle class on new button to make form visible
    $("#new-post").on "click", ->
      $("#new-form.dropdown-menu").toggleClass('make-visible')
      $("#new-post").toggleClass('active')
      $("#new-post i")
        .toggleClass('icon-plus')
        .toggleClass('icon-remove')

      # Set value to form kind button
      if $('#post_kind').val() == ''
        $('#post-offer').click()

    # Submit search on space or enter
    $("#query").on "keydown", (e) ->
      $('#user-nav').remove()
      if e.keyCode == 32 || e.keyCode == 13
        $(this).submit()

    # Close form when post button is clicked
    $('#post-button').on "click", (e) ->
      e.preventDefault()
      $(".dropdown-menu").toggleClass('make-visible')
      $("#new-post").toggleClass('active')
      $("#new-post i")
        .toggleClass('icon-plus')
        .toggleClass('icon-remove')
      $('#post-button').submit()
      $("#post_message").val("")
      $('.counter p').text('min 5 Characters')

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
