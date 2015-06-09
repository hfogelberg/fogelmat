@Recipies = new (Meteor.Collection)('recipies')

Meteor.startup ->
  Meteor.publish "recipies", ->
    Recipies.find {}, {limit: 5}, {fields: {title: 1, comment: 1}}

  Meteor.publish "recipy", (recipyId) ->
    Recipies.find _id: recipyId

Meteor.methods  
  createRecipyTags: (tags) ->   
    for tag in tags
      console.log(tag)
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
