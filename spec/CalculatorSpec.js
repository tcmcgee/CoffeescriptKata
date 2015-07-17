describe("Calculator", function() {

	var calculator = require('../lib/StringConverter');

  	it("should have true equal true", function() {
  		expect(true).toEqual(true);
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
});
