require File.expand_path('../abstract_unit', __FILE__)

class TestAcceptsNestedAttributesFor < ActiveSupport::TestCase
  def setup
    @project = Project.create!(
      project_id: 1,
      account_id: 1,
      name: 'rad project'
    )
    @bug = Bug.create!(
      project_id: 1,
      name: 'radbug',
      description: 'something'
    )
  end

  def test_create
    assert_equal 1, Project.count
    assert_equal 1, Bug.count
  end

  def test_create_nested_record
    @project.update_attributes(bugs_attributes: [{name: 'anotherbug', description: 'really good description'}])
    assert_equal 2, @project.reload.bugs.count
  end

  def test_update_nested_record
    @project.update_attributes(bugs_attributes: [{id: @bug.id, description: 'updated!'}])
    assert_equal @bug.reload.description, 'updated!'
  end

  def test_update_nested_record_with_manually_constructed_array_for_id
    @project.update_attributes(bugs_attributes: [{id: [@bug.project_id, 'radbug'], description: 'updated!'}])
    assert_equal @bug.reload.description, 'updated!'
  end

  def test_destroy_nested_record
    @project.update_attributes(bugs_attributes: [{'id' => @bug.id, '_destroy' => true}])
    assert_equal 0, Bug.count
  end
end
