@Recipies = new Meteor.Collection('recipies')
@RecipyTags = new Mongo.Collection('recipyTags')

Meteor.startup ->
  Meteor.publish "recipiesByTag", (tag) ->
    Recipies.find {tags: tag}, {limit: 5}, {fields: {title: 1, comment: 1}}
    
  Meteor.publish "recipies", ->
    Recipies.find {}, {limit: 5}, {fields: {title: 1, comment: 1}}

  Meteor.publish "tags", ->
    RecipyTags.find()

  Meteor.publish "recipy", (recipyId) ->
    Recipies.find _id: recipyId

Meteor.methods  
  createRecipyTags: (tags) ->   
    console.log 'createRecipyTags called'
    for tag in tags
      console.log "Insering tag: #{tag}"
      if RecipyTags.find(name: tag).count() is 0
        console.log 'Insert tag'
        RecipyTags.insert
          name: tag

    return 

  createRecipy: (title, comment, ingrediences, description, tags, slug) ->
    console.log ('createRecipy')

    Recipies.insert
      title: title,
      comment: comment, 
      ingrediences: ingrediences,
      description: description,
      tags: tags,
      slug: slug,
      createdDate: new Date()

    return
