// tests/app.test.js — Jest unit tests
const { add, subtract, divide } = require("../src/app");

describe("Calculator", () => {
  test("add: 2 + 3 = 5", () => {
    expect(add(2, 3)).toBe(5);
  });

  test("subtract: 10 - 4 = 6", () => {
    expect(subtract(10, 4)).toBe(6);
  });

  test("divide: 10 / 2 = 5", () => {
    expect(divide(10, 2)).toBe(5);
  });

  test("divide: throws on divide by zero", () => {
    expect(() => divide(5, 0)).toThrow("Cannot divide by zero");
  });

  test("add: throws on non-numbers", () => {
    expect(() => add("a", 1)).toThrow(TypeError);
  });
});
