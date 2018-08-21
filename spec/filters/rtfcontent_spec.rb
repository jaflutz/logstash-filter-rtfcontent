# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/rtfcontent"

describe LogStash::Filters::Rtfcontent do
  describe "RTF containing only one word" do
    #let(:config) do <<-CONFIG
    config <<-CONFIG
      filter {
        rtfcontent {
          input_field => "attachment.content_input"
          output_field => "attachment.content_output"
        }
      }
    CONFIG
    #end

    #sample({"attachment.content" => "{\\rtf1\\ansi\\deff0 {\\fonttbl {\\f0 Times New Roman;}}\\f0\\fs60 teste}"}) do
    #sample("{\\rtf1\\ansi\\deff0 {\\fonttbl {\\f0 Times New Roman;}}\\f0\\fs60 teste}") do
    #sample({"attachment.content_input" => "teste"}) do
      expect(subject).to include("attachment.content")
      expect(subject.get('attachment.content_output')).to eq('teste')
    end

  end
end
