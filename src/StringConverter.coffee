root = exports ? this

root.evalu = () ->  
	equation = $(".equation").val()
	calculate(equation)

root.calculate = (equation) ->
	while (root.hasNext(equation))
		equation = root.pemdas(equation)
	root.set_results_html(equation)
	return +equation


root.set_results_html = (number) ->
	try
		$(".results").text(number)
	catch e
		console.log("NO JQUERY FOR TESTS: " + e)

root.nextOp = (equation) ->
	index0 = equation.indexOf('^')
	index1 = equation.indexOf('*')
	index2 = equation.indexOf('/')
	index3 = equation.indexOf('+')
	index4 = equation.indexOf('-')
	if (index0 != -1)
		return '^'
	else if (index1 >= 0 && index2 >= 0)
		if (index1 > index2 )
			return '/'
		else
			return '*'
	else if (index1 >= 0)
		return '*'
	else if (index2 >= 0)
		return '/'
	else if (index3 >= 0 && index4 >= 0)
		if (index3 > index4)
			return '-'
		else
			return '+'
	else if (index3 >= 0)
		return '+'
	else if (index4 >= 0)
		return '-'
	else 
		return -1


			
root.pemdas = (equation) ->
	equation = "~" + equation + "~"
	op = root.nextOp(equation)
	if (op != -1)
		index = equation.indexOf(op)
		next = root.getnext(op,equation,index)
		next_index = equation.indexOf(next)
		equation = equation.substring(0,next_index) + (root.math(next, op)) + equation.substring(next_index + next.length)
		next = equation.substring(1,equation.length-1)
		return next
	else
		return equation

root.getnext = (op, equation, index) ->
	before = root.before(equation,index) + 1
	after = root.after(equation,index)
	next = equation.substring(before,after)
	console.log(next)
	return next

root.hasNext = (equation) ->
	has = false
	if (equation.indexOf('^') != -1)
		has = true
	if (equation.indexOf('*') != -1)
		has = true
	if (equation.indexOf('/') != -1)
		has = true
	if (equation.indexOf('+') != -1)
		has = true
	if (equation.indexOf('-') != -1)
		has = true
	return has

root.math = (next,op) ->
	op_index = next.indexOf(op)
	num1 = next.substring(0,op_index)
	num2 = next.substring(op_index + 1)
	if (op == '^')
		return Math.pow(num1,num2)
	else if (op == '*')
		return num1 * num2
	else if (op == '/')
		return num1 / num2
	else if (op == '+')
		return +num1 + +num2
	else if (op == '-')
		return num1 - num2

root.before = (equation, index, i = -1) ->
	numbers = 
	[0,1,2,3,4,
	5,6,7,8,9,
	'0','1','2','3',
	'4','5','6','7',
	'8','9', ' ', '.']
	if equation.charAt((index + i)) in numbers
		i = i-1
		root.before(equation,index,i)
	else
		return (index + i)

root.after = (equation, index, i = 1) ->
	equation = equation + '~'
	numbers = 
	[0, 1, 2, 3, 4
	5, 6, 7, 8, 9
	'0','1','2','3',
	'4','5','6','7',
	'8','9', ' ', '.']
	if equation.charAt(index + i) in numbers
		root.after(equation,index,i+1)
	else
		return index + i



	