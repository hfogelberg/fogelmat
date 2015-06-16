@Recipies = new Meteor.Collection('recipies')
@RecipyTags = new Mongo.Collection('recipyTags')

Meteor.startup ->
  Meteor.publish "recipiesByTag", (tag) ->
    Recipies.find {tags: tag}, {fields: {title: 1, comment: 1, slug: 1}}, {sort: {createdDate: 1}}
    
  Meteor.publish "recipies", ->
    Recipies.find {}, {fields: {title: 1, comment: 1, slug: 1}}, {sort: {createdDate: -1}}
    #Recipies.find {}, {limit: 5}, {fields: {title: 1, comment: 1, slug: 1}}

  Meteor.publish "tags", ->
    RecipyTags.find()

  Meteor.publish "recipy", (slug) ->
    Recipies.find slug: slug

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

  createRecipy: (title, comment, ingrediences, description, tags, username, owner, slug) ->
    console.log ('createRecipy')

    Recipies.insert
      title: title,
      comment: comment, 
      ingrediences: ingrediences,
      description: description,
      tags: tags,
      slug: slug,
      username: username,
      owner: owner,
      createdDate: new Date()

    return

  updateRecipy: (title, comment, ingrediences, description, tags, slug) ->
    console.log ('updateRecipy')
    Recipies.update {slug: slug}, {$set: {title: title, comment: comment, ingrediences: ingrediences, description: description, tags: tags}}
    return

