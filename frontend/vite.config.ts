// import { defineConfig } from 'vite'
// import react from '@vitejs/plugin-react'

// export default defineConfig({
//   plugins: [react()],
//   server: {
//     proxy: {
//       '/api': 'http://127.0.0.1:8000',
//       '/static': 'http://127.0.0.1:8000',
//     },
//   },
// })

import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],

  server: {
    // !!!! Это самое главное изменение
    host: true,           // или '0.0.0.0' — одно и то же
    // host: '0.0.0.0',   // можно и так писать

    port: 5173,           // можно явно указать, если хочешь

    proxy: {
      '/api': {
        target: 'http://127.0.0.1:8000',
        changeOrigin: true,
        secure: false,
      },
      '/static': {
        target: 'http://127.0.0.1:8000',
        changeOrigin: true,
        secure: false,
      },
    },

    // Очень полезно при использовании домена
    allowedHosts: [
      'localhost',
      '127.0.0.1',
      'arcdle.online',          // ← добавь свой домен сюда
      'arcdle.online',
    ],

    // Если будешь использовать https в dev-режиме (не обязательно)
    // https: true,
  },
})