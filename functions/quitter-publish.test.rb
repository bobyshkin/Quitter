# frozen_string_literal: true

require_relative 'quitter-publish'
require 'test/unit'
require 'json'
require 'logger'

class TestFunction < Test::Unit::TestCase
  logger = Logger.new($stdout)

  def test_invoke
    event = {
      user_id: 'Test Guy',
      date: 'date',
      message: 'Test Message',
      rating: 5
    }
    context = nil
    result = publish_user_post(event: event, context: context)
    assert_match('function_count', result.to_s, 'Should match')
  end
end
