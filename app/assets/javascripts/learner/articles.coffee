# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $(document).on 'turbolinks:load', ->
#   $('#article-tags').tagit
#     fieldName: 'tags'
#     singleField: true
#   $('#article-tags').tagit()
#   get_tags = $('input[name="tags"]').val()
#   try
#     tags = get_tags.split(',')
#     for tag in tags
#       $('#article-tags').tagit 'createTag', tag
#   catch error

# inputの作成
$(document).on 'turbolinks:load', ->
  $('#article-tags').tagit
    fieldName: 'tags'
    singleField: true
