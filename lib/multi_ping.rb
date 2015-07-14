require "multi_ping/version"
require 'thread'

module MultiPing
  # Your code goes here...

  DEFAULT = {
              count: 10,
              size: 56,
              parallel: 2
            }

  class Processor
    def initialize(options={})
      @count = options.fetch :count, MultiPing::DEFAULT[:count]
      @size = options.fetch :size, MultiPing::DEFAULT[:size]
      @parallel = options.fetch :parallel, MultiPing::DEFAULT[:parallel]
      @hosts = options.fetch :hosts, []
      @list_only = options.fetch :list_only, false
      @results = {}
      @queue = Queue.new
      @hosts.each { |host| @queue << host }
    end


    def process
      workers = (0..@parallel.to_i).map do
        Thread.new do
          begin
            while host = @queue.pop(true)
              host = host.gsub("\n", '')
              @results[host] = `ping -c #{@count} -s #{@size} #{host} || echo ERROR`.split("\n")
            end
          rescue ThreadError
          end
        end
      end
      workers.map(&:join)
      self
    end

    def report
      sorted_result.each do |server, result|
        puts "#{server}"

        unless @list_only
          if result[0] =~ /ERROR/
            puts "SOMETHING WRONG"
            puts "ERROR"
          else
            puts result[-2..-1]
          end
        end
      end
    end

    def sorted_result
      percentage_regexp = /(\d*\.\d*)%/
      avg_regexp = /\/(\d*\.\d*).*ms/
      @results.sort_by { |server, result|
        if result.join =~ /ERROR/ ||
          "000999".to_i
        else
          percentage = "%03d" % percentage_regexp.match(result[-2])[1].to_f
          avg = avg_regexp.match(result[-1])[1].to_f
          avg = 999 if avg > 999
          avg = "%03d" % (1000 - avg)
          # p [percentage,avg]
          "#{percentage}|#{avg}".to_i
        end
      }
    end
  end
end
