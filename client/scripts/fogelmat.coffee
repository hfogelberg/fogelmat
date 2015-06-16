# Use Swedish translation for login/sign up
accountsUIBootstrap3.setLanguage('sv')

#Username and email used for accounts
Accounts.ui.config
  passwordSignupFields: "USERNAME_AND_EMAIL"

Template.editRecipy.events
    'click .updateRecipyBtn': (event, template) ->
        event.preventDefault
        alert 'Update'
        tags = new Array()
        title = template.find(".title").value
        comment = template.find(".comment").value
        ingrediences = template.find(".ingrediences").value
        description = template.find(".description").value
        slug = Session.get 'slug'

        alert "Slug: #{slug}"

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

Template.addRecipy.events
  'click .addRecipy': (event, template) ->
    event.preventDefault
    
    tags = new Array()
    title = template.find(".title").value
    comment = template.find(".comment").value
    ingrediences = template.find(".ingrediences").value
    description = template.find(".description").value
    
    owner = Meteor.userId()
    username = Meteor.user().username

    alert "#{owner} #{username}"

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
    Meteor.call 'createRecipy', title, comment, ingrediences, description, taglist, username, owner, slug, (error) ->

    Router.go('/')
    return