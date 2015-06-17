Router.configure layoutTemplate: 'layout'
Router.map ->
  @route 'home', 
    path: '/',
    template: 'recipies'
    subscriptions:->
      @subscribe 'recipies'
      @subscribe 'tags'
    data: 
      recipyList: ->
        Recipies.find()
      tags: ->
        RecipyTags.find()

  @route 'recipiesByTag',
    path: 'recipies/:tag',
    template: 'recipies'

    subscriptions:->
      tag = @params.tag
      @subscribe 'recipiesByTag', @params.tag
      @subscribe 'tags'
    data: 
      recipyList: ->
        recipy = Recipies.find()
      tags: ->
        RecipyTags.find()

  @route 'recipy',
    path: '/recipy/:slug'
    template: 'recipyDetails'
    waitOn: ->
      Meteor.subscribe 'recipy', @params.slug
    data: recipyList: ->
      Recipies.find()

  @route 'editRecipy',
    path: 'editRecipy/:slug',
    template: 'editRecipy'
    waitOn: ->
      Meteor.subscribe 'recipy', @params.slug
      Session.set 'slug', @params.slug
    data: recipyList: ->
      Recipies.find()

  @route 'about'

  @route 'addRecipy'

  @route 'contact'
  
  return




# waitOn: ->
#   return [Meteor.subscribe('recipies'), Meteor.subscribe('tags')]