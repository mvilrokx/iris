# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if browserSupportsSpeechInput()
    $('#speech-button').on('webkitspeechchange', speechChange)

browserSupportsSpeechInput = -> 
  if document.createElement('input').webkitSpeech==undefined
    alert "Sorry! Your browser does not support Speech Input"
    false
  else
    true

# Function called when a speech recognition result is received.
speechChange = (e) ->
  # Proposed Flow
  # 1. pass received text to service that can interpret the text
  # 2. when this service returns, do what it says to do (call another service)
  # 3. when this service returns, show results of this service in the stream
  e.preventDefault()
  if e.type == 'webkitspeechchange' && e.originalEvent.results
    topResult = e.originalEvent.results[0]
    # doThis = interpret(topResult);
    # for now, just echo the received text
    adjustStream(topResult.utterance)
    # submit the form to the proxy service
    $.get(
      $('#process_speech').attr('action'), 
      $('#process_speech').serialize(),
#      (data, textStatus, jqXHR) -> adjustStream(data.queryresult.pod[1].subpod.plaintext),
      (data, textStatus, jqXHR) -> adjustStream(img(data.queryresult.pod[1].subpod.img)),
      "json"
    )

adjustStream = (item) ->
  previous_items = $('[class^=stream-item]')
  $("<li class='stream-item'>#{item}</li>").hide().appendTo('#stream').show('fast', ->
    previous_items.delay(1500).slideUp('fast', -> previous_items.remove()))

img = (img) ->
  img_tag = "<img src=#{img.src} title=#{img.title} alt=#{img.alt} height=#{img.height} width=#{img.width} />"
