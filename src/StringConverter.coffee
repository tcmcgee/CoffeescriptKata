root = exports ? this

root.eval = () ->  
	equation = $(".equation").val()
	calculate(equation)


root.calculate = (equation) ->
	symbol = equation.split (0-9)+
	alert(symbol)
	numbers = equation.split ('+'|'-'|'*'|'/'|'('|')')
	for number, index in numbers
		numbers[index] = number.replace /^\s+|\s+$/g, ""
		numbers[index] = +numbers[index]
	numbers.unshift(symbol)
	answer = root.operator_map(numbers)
	return answer

root.operator_map = (equation_array)->
	op = equation_array.shift()
	finalnum = equation_array.shift()
	for num in equation_array
		finalnum = root.string_math(op, finalnum, num)
	return finalnum

root.string_math = (op, num1, num2) ->
	if (op == '+')
		return num1 + num2
	else if (op == '-')
		return num1 - num2


	