entryElement = document.getElementById 'entry'
linesElement = document.getElementById 'lines'

homeDir = '/home/leozqi'
currentDir = '/home/leozqi'


entryElement.addEventListener 'blur', (evt) ->
  entryElement.focus()


traverse = (path) ->
  if path == '/'
    chunks = ['']
  else
    chunks = (path.split '/')

  tree = filesystem
  for folder in chunks
    if folder of tree
      tree = tree[folder]
    else
      return []

  if typeof tree is 'string'
    tree
  else
    [k for k, v of tree]


cat = (args) ->
  path = "#{currentDir}/#{args[0]}"
  findit = traverse path
  if typeof findit is 'string'
    return findit.split '\n'
  else
    return ["cat: #{args[0]}: No such file or directory"]


ls = (args) ->
  inDir = []
  if "-a" in args
    inDir.push ".", ".."

  return [ (inDir.concat (traverse currentDir)).join ' ']

resolve = (cmd, args) ->
  switch cmd
    when "echo" then return [(args.join ' ')]
    when "ping" then return ["You're online!"]
    when "ls" then return (ls args)
    when "cat" then return (cat args)
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
    line = entryElement.innerHTML
    entryElement.innerHTML = ''
    exec line
  else if (evt.key == 'ArrowLeft' || evt.key == 'ArrowRight')
    evt.preventDefault()

# Demo command that user sees on logon
exec "cat about-me.txt"
exec "ls"

