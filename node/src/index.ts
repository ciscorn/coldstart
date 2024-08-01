import { serve } from "@hono/node-server";
import { Hono } from "hono";

import { foo } from "./hoge";

const app = new Hono();

app.get("/", (c) => {
  return c.text("Hello, Node!" + foo());
});

const port = 8080;
console.log(`Server is running on port ${port}`);

serve({
  fetch: app.fetch,
  port,
});
