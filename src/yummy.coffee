entryElement = document.getElementById 'entry'
linesElement = document.getElementById 'lines'

entryElement.addEventListener 'blur', (evt) ->
  entryElement.focus()

resolve = (cmd, args) ->
  console.log args
  switch cmd
    when "echo" then return [(args.join ' ')]
    when "ping" then return ["You're online!"]
    else return ["Unknown command: #{cmd}"]

exec = (pseudocommand) ->
  newLine = document.createElement 'code'
  newLine.innerHTML = pseudocommand

  linesElement.appendChild newLine

  [cmd, args...] = pseudocommand.split ' '

  result = resolve cmd, args

  for line in result
    do (line) ->
      resultLine = document.createElement 'span'
      resultLine.innerHTML = line
      linesElement.appendChild resultLine


entryElement.addEventListener 'keydown', (evt) ->
  if (evt.key == 'Enter')
    evt.preventDefault()
    exec entryElement.innerHTML
    entryElement.innerHTML = ''
  else if (evt.key == 'ArrowLeft' || evt.key == 'ArrowRight')
    evt.preventDefault()

