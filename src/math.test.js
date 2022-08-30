import { add } from '.';

test('adds two numbers', () => {
  expect(add(1, 1)).toBe(2);
});

test('adds three numbers', () => {
  expect(add(1, 2, 3)).toBe(6);
});
