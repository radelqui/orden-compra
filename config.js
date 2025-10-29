// Configuración de Supabase
const SUPABASE_URL = 'https://trgqcvfhmrkceyguckol.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRyZ3FjdmZobXJrY2V5Z3Vja29sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE2NjY1NzgsImV4cCI6MjA3NzI0MjU3OH0.8xueTL8TpQSxeKHsiRkJSdgCkpufNFcfUu86_4KStBI';

// Variable global para el cliente de Supabase
let supabase;

// Inicializar cuando la página cargue
document.addEventListener('DOMContentLoaded', function() {
    if (typeof window.supabase !== 'undefined') {
        supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
        console.log('✅ Supabase inicializado correctamente');
        console.log('🔑 URL:', SUPABASE_URL);
    } else {
        console.error('❌ Error: Librería de Supabase no cargada');
        console.log('Verifica que el script de Supabase esté cargando correctamente');
    }
});
