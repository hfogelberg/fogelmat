Template.addRecipy.events
  'click .btn': (event, template) ->
    event.preventDefault
    
    tags = new Array()
    title = template.find(".title").value
    comment = template.find(".comment").value
    ingrediences = template.find(".ingrediences").value
    description = template.find(".description").value

    #Split string to array, remove any white space and capitalize first letter
    taglist = []
    tags = template.find(".tags").value.split(',')
    for tag in tags
        do ->
            tag = tag.trim()
            tag = tag.charAt(0).toUpperCase() + tag.substring(1)
            if tag
                taglist.push tag

    slug = slugify(title + ' ' + template.find(".tags").value + ' ' + ingrediences.split(' '))

    Meteor.call 'createRecipyTags', taglist, (error) ->
    Meteor.call 'createRecipy', title, comment, ingrediences, description, taglist, slug, (error) ->

    Router.go('recipies')
    return