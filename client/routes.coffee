@Recipies = new (Meteor.Collection)('recipies')

Router.configure layoutTemplate: 'layout'
Router.map ->
  @route 'home', path: '/'
  @route 'about'
  @route 'recipies',
    waitOn: ->
      return Meteor.subscribe('recipies')
      Meteor.subscribe 'tags'
    data: recipyList: ->
      Recipies.find()
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