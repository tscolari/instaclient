require 'spec_helper'
require 'json'

module Instaclient::Models
  RSpec.describe(Embed) do
    let(:input) { Hash.new }
    subject { Embed.new(input) }

    let(:input) do
      JSON.parse(<<-JSON)
      {
          "author_id": 9538472,
          "author_name": "diegoquinteiro",
          "author_url": "http://instagram.com/diegoquinteiro",
          "height": null,
          "html": "some html",
          "media_id": "558717847597368461_9538472",
          "provider_name": "Instagram",
          "provider_url": "http://instagram.com/",
          "title": "Wii Gato (Lipe Sleep)",
          "type": "rich",
          "thumbnail_url": "http://distilleryimage5.ak.instagram.com/5dceebb02c5811e3b57222000a9e07e9_8.jpg",
          "thumbnail_width": 640,
          "thumbnail_height": 640,
          "version": "1.0",
          "width": 658
      }
      JSON
    end

    it 'has the correct author name' do
      expect(subject.author_name).to eq('diegoquinteiro')
    end

    it 'has the correct title' do
      expect(subject.title).to eq('Wii Gato (Lipe Sleep)')
    end

    it 'has the correct thumbnail' do
      expect(subject.thumbnail).to eq('http://distilleryimage5.ak.instagram.com/5dceebb02c5811e3b57222000a9e07e9_8.jpg')
    end

    it 'has the correct author url' do
      expect(subject.author_url).to eq('http://instagram.com/diegoquinteiro')
    end

    it 'has the correct author id' do
      expect(subject.author_id).to eq(9538472)
    end

    it 'has the correct html' do
      expect(subject.html).to eq('some html')
    end

  end
end
