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

root.pemdas = (equation) ->
	equation = "~" + equation + "~"
	op = ''
	ops = ['*', '/', '+', '-']
	for op in ops
		if (equation.indexOf(op) != -1)
			index = equation.indexOf(op)
			next = root.getnext(op, equation, index)
			break
	next_index = equation.indexOf(next)
	equation = equation.substring(0,next_index) + (root.math(next, op)) + equation.substring(next_index + next.length)
	next = equation.substring(1,equation.length-1)
	return next

root.getnext = (op, equation, index) ->
	before = root.before(equation,index) + 1
	after = root.after(equation,index)
	next = equation.substring(before,after)
	return next

root.hasNext = (equation) ->
	has = false
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

	if (op == '*')
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
	'8','9', ' ']
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
	'8','9', ' ']
	if equation.charAt(index + i) in numbers
		root.after(equation,index,i+1)
	else
		return index + i



	