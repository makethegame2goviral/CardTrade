import { createClient } from '@supabase/supabase-js';
export const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://nhfabpzmvmgtsdntwstq.supabase.co';
export const supabaseKey = import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY || 'sb_publishable_VTuKf5UBy5LOm9RyweLK-A_zri_CwDG';
export const supabase = createClient(supabaseUrl, supabaseKey);