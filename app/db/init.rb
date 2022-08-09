# frozen_string_literal: true

require_relative 'create_table'

table_name = 'quitter-posts'

create_table(table_name)

# def migrate
#   create_table()
#   @dynamo_scheme = {
#     user_login: 'S',
#     user_passwd: 'S',
#     user_email: 'S',
#     user_phone: 'S',
#     user_followers: 'S',
#     user_following: 'S',
#     post_visibility: 'S',
#     post_message: 'S',
#     post_media: 'S'
#   }
# end
