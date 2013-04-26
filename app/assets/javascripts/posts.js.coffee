$(document).ready ->
  delay = (->
    timer = 0
    (callback, ms) ->
      clearTimeout timer
      timer = setTimeout(callback, ms)
      )()

  $("#search-button-grp button").on "click", ->
    # Set value of kind for search action
    $("#kind").val $(this).val()

    # Click opposite kind button in form when clicked in search
    if $(this).attr('id') == 'search-demand'
      $('#post-offer').click()
    if $(this).attr('id') == 'search-offer'
      $('#post-demand').click()

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

  $("#query").on "keyup", ->
    $("#post_message").val $(this).val()
    # Submit search on keyup
    $(this).submit()
    delay (->
      highlights = $("#post_message").val().split(" ")
      $('body > .container').highlight(highlights)
    ), 200
