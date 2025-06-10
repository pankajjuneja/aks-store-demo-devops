'use strict'

const path = require('path')
const AutoLoad = require('@fastify/autoload')

module.exports = async function (fastify, opts) {
  // Add health check endpoint
  fastify.get('/health', async (request, reply) => {
    return { status: 'healthy', version: process.env.APP_VERSION }
  })

  fastify.register(require('@fastify/cors'), {
    origin: '*'
  })

  // Do not touch the following lines

  // This loads all plugins defined in plugins
  // those should be support plugins that are reused
  // through your application
  fastify.register(AutoLoad, {
    dir: path.join(__dirname, 'plugins'),
    options: Object.assign({}, opts)
  })

  // This loads all plugins defined in routes
  // define your routes in one of these
  fastify.register(AutoLoad, {
    dir: path.join(__dirname, 'routes'),
    options: Object.assign({}, opts)
  })

  // Set port to 8080
  fastify.listen({ port: 8080 })
}
