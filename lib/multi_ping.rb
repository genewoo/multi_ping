require "multi_ping/version"
require 'net/ping'
require 'thread'

module MultiPing
  # Your code goes here...

  DEFAULT = {
              count: 20,
              parallel: 2
            }

  class Processor

    # attr_accessor :results

    def initialize(options={})
      @count = options.fetch :count, MultiPing::DEFAULT[:count]
      @count = @count.to_i if @count.kind_of? String
      @parallel = options.fetch :parallel, MultiPing::DEFAULT[:parallel]
      @verbose = options.fetch :verbose, false
      @threshold = options.fetch :threshold, @count
      @threshold = @threshold.to_i if @threshold.kind_of? String
      @hosts = options.fetch :hosts, []
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
              icmp = Net::Ping::ICMP.new(host)
              rtary = []
              pingfails = 0
              # puts 'starting to ping'
              (1..@count).each do
                if icmp.ping
                  rtary << icmp.duration
                else
                  pingfails += 1
                  if pingfails >= @threshold
                    pingfails = @count # make it all failed
                    break
                  end
                end
              end
              if pingfails < @count
                avg = rtary.inject(0) {|sum, i| sum + i} * 1000/(@count - pingfails)
                quality = pingfails == 0 ? "Perfect!":"#{pingfails} within #{@count} packets were droped"
                puts "#{host} | Response Time : #{avg.round(2)} ms | #{quality}"  if @verbose
                @results[host] = [avg, (@count - pingfails) * 100.0 / @count]
              else
                @results[host] = [9999, 0.0]
              end
            end
          rescue ThreadError
          end
        end
      end
      workers.map(&:join)
      self
    end

    def results
      @results.sort_by{|k,v| v[1] * - 100 - 100 / v[0]}
    end
  end
end
