Meteor.startup ->
  Meteor.publish "recipiesByTag", (tag) ->
    Recipies.find {tags: tag}
    
  Meteor.publish "recipies", ->
    Recipies.find {}, {sort: {createdDate: -1}}
  
  Meteor.publish "tags", ->
    RecipyTags.find()

  Meteor.publish "recipy", (slug) ->
    Recipies.find slug: slug

  Meteor.publish "recipyByUser", (username) ->
    Recipies.find username: username

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
    hasSlug = false
    slugCount = 0
    loop
        foundSlugs = Recipies.find(slug: slug).count()
        console.log 'Found slugs ' + foundSlugs
        if foundSlugs == 0
            console.dir 'Unique slug. Breaking out'
            break
        else
            console.dir 'Slug exists'
            hasSlug = true
            slugCount = slugCount + 1
            slug = slug + slugCount
            console.dir 'New slug is ' + slug

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

