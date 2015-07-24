describe("Calculator", function() {

	var calculator = require('../lib/StringConverter.js');
	var $ = require('../lib/jquery-1.11.3.js');

  	it("should have true equal true", function() {
  		expect(true).toEqual(true);
  	});

	it("should return a number if given just that", function() {
  		expect(calculator.calculate("2")).toEqual(2);
  	});

  	it("should be able to add 1+1 with whitespace", function() {
  		expect(calculator.calculate("1        + 1")).toEqual(2);
  	});


  	it("should be able to add 1+1+1 with whitespace", function() {
  		expect(calculator.calculate("1    +   1 + 1")).toEqual(3);
  	});

  	it("should be able to subtract 2-1 with whitespace", function() {
  		expect(calculator.calculate("2    -   1 ")).toEqual(1);
  	});


   	it("should be able to calculate 10 + 2 - 1 with whitespace", function() {
  		expect(calculator.calculate("10 + 2 - 1 ")).toEqual(11);
  	});

  	it("should be able to calculate 10 * 7 with whitespace", function() {
  		expect(calculator.calculate("10 * 7 ")).toEqual(70);
  	});

   	it("should be able to calculate 10 * 2 - 1 with whitespace", function() {
  		expect(calculator.calculate("10 * 2 - 1 ")).toEqual(19);
  	});

    it("should be able to calculate 10 / 2 with whitespace", function() {
  		expect(calculator.calculate("10 /2 ")).toEqual(5);
  	});

    it("should be able to calculate 10 + 15 / 2 with whitespace", function() {
  		expect(calculator.calculate("10 + 15 / 2 ")).toEqual(17.5);
  	});

    it("should be able to calculate 1000 / 10 + 5 with whitespace", function() {
  		expect(calculator.calculate("1000 / 10 + 5")).toEqual(105);
  	});

    it("should be able to calculate 1000 / 10 * 10 + 5 with whitespace", function() {
  		expect(calculator.calculate("1000 / 10 * 10 + 5")).toEqual(1005);
  	});

    it("should be follow the order of operations", function() {
  		expect(calculator.calculate("10 - 2 + 1")).toEqual(9);
  	});

    it("should be able to use carrot (^) as power", function() {
  		expect(calculator.calculate("10 ^ 2")).toEqual(100);
  	});

  	it ("should use ^ with the order of operations", function() {
  		expect(calculator.calculate("10 ^ 2 + 1")).toEqual(101);
  	});
});
