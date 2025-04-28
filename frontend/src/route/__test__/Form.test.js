import { render, screen } from '@testing-library/react';
import Form from '../AgregarPalabras/Form';

test('renders learn react link', () => {
  render(<Form />);
  const linkElement = screen.getByText(/Significado/i);
  expect(linkElement).toBeInTheDocument();
});
