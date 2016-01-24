require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  def setup
    @review = Review.new(title: 'review title', body: 'review body for something')
  end

  test "review should be valid" do
    assert @review.valid?
  end

  test "title should be present" do
    @review.title = ""
    assert_not @review.valid?
  end

  test "title should have a minimum length" do
    @review.title = "a" * 4
    assert_not @review.valid?
  end

  test "body should be present" do
    @review.body = ""
    assert_not @review.valid?
  end

  test "body should have a minimum length" do
    @review.body = "a" * 19
    assert_not @review.valid?
  end

end