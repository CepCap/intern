def check_password(password)
  if password.length >= 10 &&
     password.count('A-ZА-Я') >= 2 &&
     password.count('а-яА-Я') > 0 &&
     password.count('a-zA-Z') > 0 &&
     password.count('0-9') >= 2 &&
     password.count('?<>,?[]}{=)(*&^%$#`~{}') >= 2
    :strong
  else
    :weak
  end
end

p check_password('Hi') == :weak
p check_password('asdBCапртс98%$') == :strong
