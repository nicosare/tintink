/**
 * Точка входа Tintink.
 * PM2 / `node index.js` / deploy.bat — всё стартует отсюда.
 */
require('./src/config'); // dotenv + константы первыми
const { start } = require('./src/app');

start().catch((err) => {
  console.error('[fatal]', err);
  process.exit(1);
});
