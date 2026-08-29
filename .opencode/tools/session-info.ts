import { tool } from "@opencode-ai/plugin"

export default tool({
  description: "Return the current OpenCode session ID",
  args: {},

  async execute(args, context) {
    return context.sessionID
  },
})
