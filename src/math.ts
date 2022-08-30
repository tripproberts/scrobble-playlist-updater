export function add(...numbers: number[]): number {
  return numbers.reduce((a, b) => a + b);
}
