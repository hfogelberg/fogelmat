# Use Swedish translation for login/sign up
accountsUIBootstrap3.setLanguage('sv')

#Username and email used for accounts
Accounts.ui.config
  passwordSignupFields: "USERNAME_AND_EMAIL"

#Markdown options
marked.setOptions
  renderer: new (marked.Renderer)
  gfm: true
  tables: true
  breaks: false
  pedantic: false
  sanitize: true
  smartLists: true
  smartypants: false
