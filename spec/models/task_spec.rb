require_relative '../spec_helper'

RSpec.describe "Test" do
  it 'assigns attributes correctly' do
    task = Task.new({"title"       => "a title",
                     "description" => "a description"
                    })

    expect(task.title).to eq("a title")
    expect(task.description).to eq("a description")
  end

  it 'saves a task to the database' do
    task = Task.new({"title"       => "a title",
                     "description" => "a description"
                    })
    task.save

    task_from_db = Task.all.last

    expect(task_from_db.title).to eq("a title")
    expect(task_from_db.description).to eq("a description")

  end

  it 'finds all tasks' do
    expect(Task.all.count).to eq(0)

    5.times do
      Task.new({"title"       => "a title",
                "description" => "a description"}).save
    end

    expect(Task.all.count).to eq(5)
  end

  it 'finds a task' do
    Task.new({"title"       => "task one",
              "description" => "a description"}).save
    task_id = Task.all.last.id

    expect(Task.find(task_id).title).to eq("task one")
  end

  it 'updates task' do
    Task.new({"title"       => "a title",
              "description" => "a description"}).save
    task_id = Task.all.last.id
    Task.update(task_id, {title: "new title", description: "new description"})
    last_task = Task.all.last
    expect(last_task.title).to eq("new title")
    expect(last_task.description).to eq("new description")
  end

  it 'deletes a task' do
    Task.new({"title"       => "a title",
              "description" => "a description"}).save
    expect(Task.all.count).to eq(1)
    task_id = Task.all.last.id
    Task.destroy(task_id)
    
    expect(Task.all.count).to eq(0)
  end

end
