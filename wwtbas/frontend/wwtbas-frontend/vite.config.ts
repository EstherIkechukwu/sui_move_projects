import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      '/sui-proxy': {
        target: 'https://fullnode.testnet.sui.io/v2/gas',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/sui-proxy/, ''),
      }
    }
  }
})
