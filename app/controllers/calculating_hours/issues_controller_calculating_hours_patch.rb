require_dependency 'issues_controller'

module CalculatingHours
  module IssuesControllerCalculatingHoursPatch
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        before_action :authorize, :except => [:index, :new, :create, :calculate_due_date]

        def calculate_due_date
          start_date = Date.parse(params[:start_date])
          estimated_hours = params[:estimated_hours].to_f
          occupancy = params[:performer_occupancy].to_f
          # просто считаем количество рабочих дней
          period1 =  (estimated_hours / (8.0 * (1 -(occupancy / 100)))).ceil
          #через спецальный гем российский производственный календарь добываем список выходных дней
          # https://github.com/heckfy/russian_workdays
          holidays = RussianWorkdays::Collection.new(start_date..(start_date + period1))
          # складываем дни + выходные
          period2 = period1 + holidays.holidays.size
          # получаем итоговую дату и проверяем что бы она не была выходным днём
          end_date1 = start_date + period2
          #цикл для поиска рабочего дня
          x = 0
          while x == 0 do
            date_r = RussianWorkdays::Day.new(end_date1.to_date)
            if date_r.work?
              due_date = end_date1
              x = 1
            else
              end_date1 = end_date1 + 1.day
            end
          end
          render json: { due_date: due_date.strftime('%Y-%m-%d') }
        end
      end
    end

    module InstanceMethods
      # Extra methods if needed...
    end
  end
end

IssuesController.send(:include, CalculatingHours::IssuesControllerCalculatingHoursPatch)
