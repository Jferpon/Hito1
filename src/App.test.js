import { render, screen } from '@testing-library/react';
import App from './App';

test('muestra el texto OK', () => {
  render(<App />);
  const resultado = screen.getByTestId('resultado');
  expect(resultado).toHaveTextContent('OK');
});