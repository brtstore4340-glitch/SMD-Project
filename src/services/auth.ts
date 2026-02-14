import { supabase } from './supabase'
import { AuthError, User, Session } from '@supabase/supabase-js'

// --- Types ---
export type AuthResult<T> = {
  data: T | null
  error: AuthError | null
}

export interface SignInCredentials {
  email: string
  password: string
}

export interface SignUpCredentials {
  email: string
  password: string
  options?: {
    data?: {
      [key: string]: any
    }
  }
}

// --- Service (Effect Layer) ---
// Note: All functions here are async IO operations.
// They must NOT be called directly inside render or derived logic.

export const AuthService = {
  /**
   * Sign in with email and password
   */
  async signIn({ email, password }: SignInCredentials): Promise<AuthResult<{ user: User; session: Session }>> {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })
    return { data: data as any, error }
  },

  /**
   * Sign up with email and password
   */
  async signUp({ email, password, options }: SignUpCredentials): Promise<AuthResult<{ user: User | null; session: Session | null }>> {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options,
    })
    return { data, error }
  },

  /**
   * Sign out
   */
  async signOut(): Promise<{ error: AuthError | null }> {
    const { error } = await supabase.auth.signOut()
    return { error }
  },

  /**
   * Get current session
   */
  async getSession(): Promise<{ session: Session | null; error: AuthError | null }> {
    const { data, error } = await supabase.auth.getSession()
    return { session: data.session, error }
  },

  /**
   * Subscribe to auth state changes
   */
  onAuthStateChange(callback: (event: string, session: Session | null) => void) {
    const { data } = supabase.auth.onAuthStateChange((event, session) => {
      callback(event, session)
    })
    return data.subscription
  }
}
