validateName = ->
  name = document.getElementById('contact-name').value
  if name.length == 0
    producePrompt 'Indiquer votre nom', 'name-error', 'red'
    return false
  producePrompt 'Valid', 'name-error', 'green'
  true

validateEmail = ->
  email = document.getElementById('contact-email').value
  if email.length == 0
    producePrompt 'Indiquer votre adresse email', 'email-error', 'red'
    return false
  if !email.match(/^[A-Za-z\._\-[0-9]*[@][A-Za-z]*[\.][a-z]{2,4}$/)
    producePrompt 'Email Invalid', 'email-error', 'red'
    return false
  producePrompt 'Valid', 'email-error', 'green'
  true

validateMessage = ->
  message = document.getElementById('contact-message').value
  required = 1
  left = required - (message.length)
  if left > 0
    producePrompt left + 'Quel est votre message ?', 'message-error', 'red'
    return false
  producePrompt 'Valid', 'message-error', 'green'
  true

validateForm = ->
  if !validateName() or !validateEmail() or !validateMessage()
    jsShow 'submit-error'
    producePrompt 'Veuillez vérifier les champs ci-dessus', 'submit-error', 'red'
    setTimeout (->
      jsHide 'submit-error'
      return
    ), 2000
    return false
  else
  return

jsShow = (id) ->
  document.getElementById(id).style.display = 'inline-block'
  return

jsHide = (id) ->
  document.getElementById(id).style.display = 'none'
  return

producePrompt = (message, promptLocation, color) ->
  document.getElementById(promptLocation).innerHTML = message
  document.getElementById(promptLocation).style.color = color
  return