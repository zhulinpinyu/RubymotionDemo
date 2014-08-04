class HomeScreen < PM::TableScreen
  title "ToDo"
  refreshable
  searchable placeholder: "Search todo"

  def on_load
    view.backgroundColor = UIColor.whiteColor
    @todos = []
    load_data
  end

  def show_help
    open HelpScreen
  end

  def table_data
    [{
      cells: @todos.map do |todo|
        {
          title: todo.content,
          action: :edit_task,
          editing_style: :delete,
          arguments: { todo: todo }
        }
      end
    }]
  end

  def on_refresh
    load_data
  end

  def load_data
    @todos = Todo.all
    stop_refreshing
    update_table_data
  end

  def my_delete_method(section, row)
    # the 2nd argument is optional. Defaults to :automatic
    delete_row(NSIndexPath.indexPathForRow(row, inSection:section), :fade)
  end

  def on_cell_deleted(cell)
      #RemoteObject.find(cell[:arguments][:id]).delete_remotely
      true
  end


end
