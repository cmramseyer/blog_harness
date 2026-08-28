require "rails_helper"
require "fileutils"
require "open3"
require "tmpdir"

RSpec.describe "bin/verify" do
  def run_verify(environment = {})
    Open3.capture3(
      environment.merge("PATH" => "#{temporary_directory}:#{ENV.fetch("PATH")}", "CALLS_FILE" => calls_file.to_s),
      Rails.root.join("bin/verify").to_s,
      chdir: Rails.root.to_s
    )
  end

  def write_bundle_stub
    File.write(
      temporary_directory.join("bundle"),
      <<~RUBY
        #!/usr/bin/env ruby
        File.write(ENV.fetch("CALLS_FILE"), "\#{ARGV.join(" ")}\n", mode: "a")
        exit 1 if ARGV == ["exec", "rubocop"] && ENV["RUBOCOP_FAILURE"]
        exit 1 if ARGV == ["exec", "rspec"] && ENV["RSPEC_FAILURE"]
      RUBY
    )
    FileUtils.chmod("u+x", temporary_directory.join("bundle"))
  end

  around do |example|
    Dir.mktmpdir do |directory|
      @temporary_directory = Pathname.new(directory)
      @calls_file = @temporary_directory.join("calls")
      write_bundle_stub
      example.run
    end
  end

  attr_reader :calls_file, :temporary_directory

  it "runs RuboCop and RSpec" do
    _output, _error, status = run_verify

    expect(status).to be_success
    expect(calls_file.readlines(chomp: true)).to eq([ "exec rubocop", "exec rspec" ])
  end

  it "stops when RuboCop fails" do
    _output, _error, status = run_verify("RUBOCOP_FAILURE" => "1")

    expect(status).not_to be_success
    expect(calls_file.readlines(chomp: true)).to eq([ "exec rubocop" ])
  end

  it "fails when RSpec fails" do
    _output, _error, status = run_verify("RSPEC_FAILURE" => "1")

    expect(status).not_to be_success
    expect(calls_file.readlines(chomp: true)).to eq([ "exec rubocop", "exec rspec" ])
  end
end
