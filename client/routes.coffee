@Recipies = new Meteor.Collection('recipies')
@RecipyTags = new Mongo.Collection('recipyTags')

Router.configure layoutTemplate: 'layout'
Router.map ->
  @route 'home', path: '/'

  @route 'about'

  @route 'recipies',    
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
        Recipies.find()
      tags: ->
        RecipyTags.find()

  @route 'recipy',
    path: '/recipy/:_id'
    template: 'recipyDetails'
    waitOn: ->
      Meteor.subscribe 'recipy', @params._id
    data: recipyList: ->
      Recipies.find()

  @route 'addRecipy'

  @route 'contact'
  
  return