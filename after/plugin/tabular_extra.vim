if !exists(':Tabularize')
  finish
endif

AddTabularPattern! doxyparam /\(^\s*\*\s*@param\S*\)\@<=\s\+\|\(^\s*\*\s*@param\S*\s\+\S\+\)\@<=\s\+/l0
