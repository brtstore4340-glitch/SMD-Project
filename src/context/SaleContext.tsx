import { createContext } from 'react';

export interface Sale {
  id: number;
  sales: number;
  date: string;
}

export interface SaleContextType {
  sales: Sale[];
  loading: boolean;
  error: string | null;
}

export const SaleContext = createContext<SaleContextType | undefined>(undefined);
