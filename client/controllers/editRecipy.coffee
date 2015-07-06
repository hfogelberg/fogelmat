Template.editRecipy.events
  'click .updateRecipyBtn': (event, template) ->
      event.preventDefault
      tags = new Array()
      title = template.find(".title").value
      comment = template.find(".comment").value
      ingrediences = template.find(".ingrediences").value
      description = template.find(".description").value
      slug = Session.get 'slug'

      taglist = []
      tags = template.find(".tags").value.split(',')
      for tag in tags
        do ->
          tag = tag.trim()
          tag = tag.charAt(0).toUpperCase() + tag.substring(1)
          if tag
            taglist.push tag

      Meteor.call 'updateRecipy', title, comment, ingrediences, description, tags, slug, (error) ->
        Router.go("/recipy/#{slug}")
      return
