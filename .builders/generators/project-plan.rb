KManager.action :project_plan do
  action do

    DrawioDsl::Drawio
      .init(k_builder, on_exist: :write, on_action: :execute)
      .diagram(rounded: 1, glass: 1)
      .page('In progress', theme: :style_03, margin_left: 0, margin_top: 0) do

        grid_layout(y: 90, direction: :horizontal, grid_h: 80, grid_w: 320, wrap_at: 3, grid: 0)

      end
      .page('To Do', theme: :style_02, margin_left: 0, margin_top: 0) do

        grid_layout(y: 90, direction: :horizontal, grid_h: 80, grid_w: 320, wrap_at: 3, grid: 0)

        todo(title: 'Support the different engines: [Ada, Babbage, Curie, Davinci]')

      end
      .page('Done', theme: :style_06, margin_left: 0, margin_top: 0) do

        # h5(x: 300, y: 0, w: 400, h: 80, title: 'Gpt3 Builder')

        grid_layout(y:90, direction: :horizontal, grid_h: 80, grid_w: 320, wrap_at: 3, grid: 0)

      end
      .cd(:docs)
      .save('project-plan/project.drawio')
      .export_svg('project-plan/project_in_progress', page: 1)
      .export_svg('project-plan/project_todo'       , page: 2)
      .export_svg('project-plan/project_done'       , page: 3)
  end
end
