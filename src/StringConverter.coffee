root = exports ? this

root.evalu = () ->  
	equation = $(".equation").val()
	equation = equation.replace /ans/g, $(".results").text()
	calculate(equation)

root.ans = () ->
	results = $(".results").text()
	$(".equation").val('ans')

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
	indexperen = equation.indexOf(')')
	indexpow = equation.indexOf('^')
	indexmult = equation.indexOf('*')
	indexdiv = equation.indexOf('/')
	indexplus = equation.indexOf('+')
	indexmin = equation.indexOf('-')
	if (indexperen != -1)
		return ')'
	else if (indexpow != -1)
		return '^'
	else if (indexmult >= 0 && indexdiv >= 0)
		if (indexmult > indexdiv )
			return '/'
		else
			return '*'
	else if (indexmult >= 0)
		return '*'
	else if (indexdiv >= 0)
		return '/'
	else if (indexplus >= 0 && indexmin >= 0)
		if (indexplus > indexmin)
			return '-'
		else
			return '+'
	else if (indexplus >= 0)
		return '+'
	else if (indexmin >= 0)
		return '-'
	else 
		return -1


			
root.pemdas = (equation) ->
	parens = false
	equation = "~" + equation + "~"
	op = root.nextOp(equation)
	if (op != -1)
		index = equation.indexOf(op)
		next = root.getnext(op,equation,index)

		if (op == ')')
			parens = true
			op = root.nextOp(next)
			index = equation.indexOf(op)
		next_index = equation.indexOf(next)

		if (parens == false)
			equation = equation.substring(0,next_index) + (root.math(next, op)) + equation.substring(next_index + next.length)
		else
			equation = equation.substring(0,next_index - 1) + (root.math(next, op)) + equation.substring(next_index + next.length + 1)
		next = equation.substring(1,equation.length-1)
		return next
	else
		return equation

root.getnext = (op, equation, index) ->
	if (op == ')')
		before = root.closeParen(equation,index) + 1
		next = equation.substring(before,index)
	else
		before = root.before(equation,index) + 1
		after = root.after(equation,index)
		next = equation.substring(before,after)
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

root.closeParen = (equation, index, i = -1) ->
	if (equation.charAt((index + i)) != '(')
		i = i-1
		root.closeParen(equation,index,i)
	else
		return (index + i)

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



	