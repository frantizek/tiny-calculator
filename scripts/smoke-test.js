#!/usr/bin/env node
// scripts/smoke-test.js
// Smoke test: quick sanity checks after a deployment.
// Think of this as "did the app survive the trip?" — not full testing, just: is it alive?

const { add, divide } = require("../src/app");

let passed = 0;
let failed = 0;

function check(label, fn) {
  try {
    fn();
    console.log(`  ✅ PASS  ${label}`);
    passed++;
  } catch (err) {
    console.error(`  ❌ FAIL  ${label}`);
    console.error(`          ${err.message}`);
    failed++;
  }
}

console.log("\n🔥 Running smoke tests...\n");

check("add() returns correct value", () => {
  const result = add(1, 1);
  if (result !== 2) throw new Error(`Expected 2, got ${result}`);
});

check("divide() works for happy path", () => {
  const result = divide(10, 2);
  if (result !== 5) throw new Error(`Expected 5, got ${result}`);
});

check("divide() throws on zero", () => {
  try {
    divide(1, 0);
    throw new Error("Should have thrown");
  } catch (e) {
    if (!e.message.includes("Cannot divide by zero")) throw e;
  }
});

console.log(`\n📊 Results: ${passed} passed, ${failed} failed\n`);

if (failed > 0) {
  console.error("💥 Smoke tests FAILED. Do not proceed with deployment.\n");
  process.exit(1);
} else {
  console.log("🎉 All smoke tests passed!\n");
  process.exit(0);
}
