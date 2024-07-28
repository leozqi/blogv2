entryElement = document.getElementById 'entry'
linesElement = document.getElementById 'lines'

homeDir = '/home/leozqi'
currentDir = '/home/leozqi'


entryElement.addEventListener 'blur', (evt) ->
  entryElement.focus()


traverse = (path) ->
  chunks = (path.split '/')

  tree = filesystem
  for folder in chunks
    tree = tree[folder]

  console.log(tree)
  [k for k, v of tree]


resolve = (cmd, args) ->
  switch cmd
    when "echo" then return [(args.join ' ')]
    when "ping" then return ["You're online!"]
    when "ls" then return (traverse currentDir)

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

# Demo command that user sees on logon
exec "ls -a"

