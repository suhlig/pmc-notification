# frozen_string_literal: true

require 'spec_helper'
require 'yaml'

# rubocop:disable Metrics/BlockLength
describe Bitbar::Thyme::StatusPresenter do
  subject(:status) do
    thyme = YAML.load_file(fixture(status_fixture))[:thyme]
    Bitbar::Thyme::StatusPresenter.new(thyme)
  end

  context 'within a pomodoro' do
    let(:status_fixture) { 'pomodoro-863.yml' }

    it 'exists' do
      expect(status).to be
    end

    it 'has the total duration' do
      expect(status.total_duration).to eq(1500)
    end

    it 'has the elapsed time' do
      expect(status.total_seconds_elapsed).to eq(637)

      expect(status.minutes_elapsed).to eq(10)
      expect(status.seconds_elapsed).to eq(37)

      expect(status.time_elapsed).to eq('10:37')
    end

    it 'has the time left' do
      expect(status.total_seconds_left).to eq(863)

      expect(status.minutes_left).to eq(14)
      expect(status.seconds_left).to eq(23)

      expect(status.time_left).to eq('14:23')
    end

    it 'presents the current status' do
      expect(status.summary).to include('🍅')
    end

    it 'presents the time left as summary' do
      expect(status.summary).to include('14:23')
    end

    it 'presents the elapsed time as details' do
      expect(status.details).to include('10:37')
    end
  end

  context 'within a break' do
    let(:status_fixture) { 'break-281.yml' }

    it 'exists' do
      expect(status).to be
    end

    it 'has the total duration' do
      expect(status.total_duration).to eq(300)
    end

    it 'has the elapsed time' do
      expect(status.total_seconds_elapsed).to eq(19)

      expect(status.minutes_elapsed).to eq(0)
      expect(status.seconds_elapsed).to eq(19)

      expect(status.time_elapsed).to eq('0:19')
    end

    it 'has the time left' do
      expect(status.total_seconds_left).to eq(281)

      expect(status.minutes_left).to eq(4)
      expect(status.seconds_left).to eq(41)

      expect(status.time_left).to eq('4:41')
    end

    it 'presents the current status' do
      expect(status.summary).to include('🍏')
    end

    it 'presents the time left as summary' do
      expect(status.summary).to include('4:41')
    end

    it 'presents the elapsed time as details' do
      expect(status.details).to include('0:19')
    end
  end

  context 'after a complete pomodoro' do
    let(:status_fixture) { 'idle-after-pomodoro-0.yml' }

    it 'exists' do
      expect(status).to be
    end

    it 'has the total duration' do
      expect(status.total_duration).to eq(1500)
    end

    it 'has the elapsed time' do
      expect(status.total_seconds_elapsed).to eq(1500)

      expect(status.minutes_elapsed).to eq(25)
      expect(status.seconds_elapsed).to eq(0)

      expect(status.time_elapsed).to eq('25:00')
    end

    it 'has the time left' do
      expect(status.total_seconds_left).to eq(0)

      expect(status.minutes_left).to eq(0)
      expect(status.seconds_left).to eq(0)

      expect(status.time_left).to eq('0:00')
    end

    it 'presents the current status' do
      expect(status.summary).to eq('Idle')
    end

    it 'presents the previous elapsed time as details' do
      expect(status.details).to include('Pomodoro')
      expect(status.details).to include('25:00')
    end
  end

  context 'after a complete break' do
    let(:status_fixture) { 'idle-after-break-0.yml' }

    it 'exists' do
      expect(status).to be
    end

    it 'has the total duration' do
      expect(status.total_duration).to eq(300)
    end

    it 'has the elapsed time' do
      expect(status.total_seconds_elapsed).to eq(300)

      expect(status.minutes_elapsed).to eq(5)
      expect(status.seconds_elapsed).to eq(0)

      expect(status.time_elapsed).to eq('5:00')
    end

    it 'has the time left' do
      expect(status.total_seconds_left).to eq(0)

      expect(status.minutes_left).to eq(0)
      expect(status.seconds_left).to eq(0)

      expect(status.time_left).to eq('0:00')
    end

    it 'presents the current status' do
      expect(status.summary).to eq('Idle')
    end

    it 'presents the previous elapsed time as details' do
      expect(status.details).to include('Break')
      expect(status.details).to include('5:00')
    end
  end

  context 'after an incomplete pomodoro' do
    let(:status_fixture) { 'idle-after-pomodoro-247.yml' }

    it 'exists' do
      expect(status).to be
    end

    it 'has the total duration' do
      expect(status.total_duration).to eq(1500)
    end

    it 'has the elapsed time' do
      expect(status.total_seconds_elapsed).to eq(1500 - 247)

      expect(status.minutes_elapsed).to eq(20)
      expect(status.seconds_elapsed).to eq(53)

      expect(status.time_elapsed).to eq('20:53')
    end

    it 'has the time left' do
      expect(status.total_seconds_left).to eq(247)

      expect(status.minutes_left).to eq(4)
      expect(status.seconds_left).to eq(7)

      expect(status.time_left).to eq('4:07')
    end

    it 'presents the current status' do
      expect(status.summary).to eq('Idle')
    end

    it 'presents the previous elapsed time as details' do
      expect(status.details).to include('Pomodoro')
      expect(status.details).to include('20:53')
    end
  end

  context 'after an incomplete break' do
    let(:status_fixture) { 'idle-after-break-142.yml' }

    it 'exists' do
      expect(status).to be
    end

    it 'has the total duration' do
      expect(status.total_duration).to eq(300)
    end

    it 'has the elapsed time' do
      expect(status.total_seconds_elapsed).to eq(300 - 142)

      expect(status.minutes_elapsed).to eq(2)
      expect(status.seconds_elapsed).to eq(38)

      expect(status.time_elapsed).to eq('2:38')
    end

    it 'has the time left' do
      expect(status.total_seconds_left).to eq(142)

      expect(status.minutes_left).to eq(2)
      expect(status.seconds_left).to eq(22)

      expect(status.time_left).to eq('2:22')
    end

    it 'presents the current status' do
      expect(status.summary).to eq('Idle')
    end

    it 'presents the previous elapsed time as details' do
      expect(status.details).to include('Break')
      expect(status.details).to include('')
    end
  end
end
