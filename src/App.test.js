import { render, screen } from '@testing-library/react';
import App from './App';

// Test roto a propósito para el mini-reto
test('mini-reto: test roto a propósito', () => {
  render(<App />);
  // Esto va a fallar porque el texto 'ERROR' no existe
  const resultado = screen.getByTestId('resultado');
  expect(resultado).toHaveTextContent('ERROR');
});