module.exports = {
  theme: {
    extend: {
      colors: {
        body: '#f4f4f0',
        pink: '#ff90e8',
      },
      screens: {
        xs: "460px",
      },
      boxShadow: {
        'navlink': '4px 4px 0px 1px rgba(0,0,0,1)',
        'linkButton': '4px 4px 0px 1px rgba(0,0,0,1)',
      }
    },
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ]
}
