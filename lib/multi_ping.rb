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

    attr_accessor :results

    def initialize(options={})
      @count = options.fetch :count, MultiPing::DEFAULT[:count]
      @count = @count.to_i if @count.kind_of? String
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
              icmp = Net::Ping::ICMP.new(host)
              rtary = []
              pingfails = 0
              # puts 'starting to ping'
              (1..@count).each do
                if icmp.ping
                  rtary << icmp.duration
                else
                  pingfails += 1
                  if pingfails > @count / 10.0 # more than 10 is not acceptable
                    break
                    pingfails = @count # make it 0 connection
                  end
                end
              end
              if pingfails < @count
                avg = rtary.inject(0) {|sum, i| sum + i} * 1000/(@count - pingfails)
                quality = pingfails == 0 ? "Perfect!":"#{pingfails} within #{@count} packets were droped"
                puts "#{host} | Response Time : #{avg.round(2)} ms | #{quality}"  unless @list_only
                @results[host] = [avg, (@count - pingfails) * 100.0 / @count]
              else
                @results[host] = [avg, 0.0]
              end
            end
          rescue ThreadError
          end
        end
      end
      workers.map(&:join)
      self
    end
  end
end
