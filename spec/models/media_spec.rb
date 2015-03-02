require 'spec_helper'
require 'json'
require 'pry'
require 'pry-nav'

module Instaclient::Models
  RSpec.describe(Media) do
    let(:input) { Hash.new }
    subject { Media.new(input) }

    context 'video' do
      let(:input) do
        JSON.parse(<<-JSON)
          {
            "videos": {
              "low_resolution": {
                  "url": "http://distilleryvesper9-13.ak.instagram.com/090d06dad9cd11e2aa0912313817975d_102.mp4",
                  "width": 480,
                  "height": 480
              },
              "standard_resolution": {
                  "url": "http://distilleryvesper9-13.ak.instagram.com/090d06dad9cd11e2aa0912313817975d_101.mp4",
                  "width": 640,
                  "height": 640
              }
            },
            "comments": {
              "data": [{
                "created_time": "1279332030",
                "text": "Love the sign here",
                "from": {
                    "username": "mikeyk",
                    "full_name": "Mikey Krieger",
                    "id": "4",
                    "profile_picture": "http://distillery.s3.amazonaws.com/profiles/profile_1242695_75sq_1293915800.jpg"
                },
                "id": "8"
                },
                {
                  "created_time": "1279341004",
                  "text": "Chilako taco",
                  "from": {
                      "username": "kevin",
                      "full_name": "Kevin S",
                      "id": "3",
                      "profile_picture": "..."
                  },
                  "id": "3"
                }],
              "count": 2
            },
            "caption": null,
            "likes": {
                "count": 1,
                "data": [{
                    "username": "mikeyk",
                    "full_name": "Mikeyk",
                    "id": "4",
                    "profile_picture": "..."
                }]
            },
            "link": "http://instagr.am/p/D/",
            "created_time": "1279340983",
            "images": {
                "low_resolution": {
                    "url": "http://distilleryimage2.ak.instagram.com/11f75f1cd9cc11e2a0fd22000aa8039a_6.jpg",
                    "width": 306,
                    "height": 306
                },
                "thumbnail": {
                    "url": "http://distilleryimage2.ak.instagram.com/11f75f1cd9cc11e2a0fd22000aa8039a_5.jpg",
                    "width": 150,
                    "height": 150
                },
                "standard_resolution": {
                    "url": "http://distilleryimage2.ak.instagram.com/11f75f1cd9cc11e2a0fd22000aa8039a_7.jpg",
                    "width": 612,
                    "height": 612
                }
            },
            "type": "video",
            "users_in_photo": null,
            "filter": "Vesper",
            "tags": [],
            "id": "363839373298",
            "user": {
                "username": "kevin",
                "full_name": "Kevin S",
                "profile_picture": "http://distillery.s3.amazonaws.com/profiles/profile_3_75sq_1295574122.jpg",
                "id": "3"
            },
            "location": null
          }
        JSON
      end

      it 'is of the right type' do
        expect(subject.type).to eq('video')
      end

      it 'has the correct id' do
        expect(subject.id).to eq('363839373298')
      end

      it 'has the correct caption' do
        expect(subject.caption).to eq('')
      end

      it 'has the correct link' do
        expect(subject.link).to eq('http://instagr.am/p/D/')
      end

      it 'has the correct created_time' do
        expect(subject.created_time).to eq(Time.at(1279340983))
      end

      describe('#image_url') do
        context('when the resolution is valid') do
          it 'returns the correct thumbnail url' do
            expect(subject.image_url(:thumbnail))
              .to eq("http://distilleryimage2.ak.instagram.com/11f75f1cd9cc11e2a0fd22000aa8039a_5.jpg")
          end

          it 'returns the correct standard_resolution url' do
            expect(subject.image_url(:standard_resolution))
              .to eq("http://distilleryimage2.ak.instagram.com/11f75f1cd9cc11e2a0fd22000aa8039a_7.jpg")
          end

          it 'returns the correct low_resolution url' do
            expect(subject.image_url(:low_resolution))
              .to eq("http://distilleryimage2.ak.instagram.com/11f75f1cd9cc11e2a0fd22000aa8039a_6.jpg")
          end
        end

        context("when the resolution isn't valid") do
          it 'returns a InvalidResolutionError' do
            expect {
              subject.image_url('not_valid')
            }.to raise_error(Media::InvalidResolutionError)
          end
        end
      end

      describe('#video_url') do
        context('when the resolution is valid') do
          it 'returns the correct standard_resolution url' do
            expect(subject.video_url(:standard_resolution))
              .to eq("http://distilleryvesper9-13.ak.instagram.com/090d06dad9cd11e2aa0912313817975d_101.mp4")
          end

          it 'returns the correct low_resolution url' do
            expect(subject.video_url(:low_resolution))
              .to eq("http://distilleryvesper9-13.ak.instagram.com/090d06dad9cd11e2aa0912313817975d_102.mp4")
          end
        end

        context("when the resolution isn't valid") do
          it 'returns a InvalidResolutionError' do
            expect {
              subject.video_url('not_valid')
            }.to raise_error(Media::InvalidResolutionError)
          end
        end
      end
    end

    context 'image' do
      let(:input) do
        JSON.parse(<<-JSON)
          {
            "comments": {
                "data": [],
                "count": 0
            },
            "caption": {
                "created_time": "1296710352",
                "text": "Inside le truc #foodtruck",
                "from": {
                    "username": "kevin",
                    "full_name": "Kevin Systrom",
                    "type": "user",
                    "id": "3"
                },
                "id": "26621408"
            },
            "likes": {
                "count": 15,
                "data": [{
                    "username": "mikeyk",
                    "full_name": "Mike Krieger",
                    "id": "4",
                    "profile_picture": "..."
                }]
            },
            "link": "http://instagr.am/p/BWrVZ/",
            "user": {
                "username": "kevin",
                "profile_picture": "http://distillery.s3.amazonaws.com/profiles/profile_3_75sq_1295574122.jpg",
                "id": "3"
            },
            "created_time": "1296710327",
            "images": {
                "low_resolution": {
                    "url": "http://distillery.s3.amazonaws.com/media/2011/02/02/6ea7baea55774c5e81e7e3e1f6e791a7_6.jpg",
                    "width": 306,
                    "height": 306
                },
                "thumbnail": {
                    "url": "http://distillery.s3.amazonaws.com/media/2011/02/02/6ea7baea55774c5e81e7e3e1f6e791a7_5.jpg",
                    "width": 150,
                    "height": 150
                },
                "standard_resolution": {
                    "url": "http://distillery.s3.amazonaws.com/media/2011/02/02/6ea7baea55774c5e81e7e3e1f6e791a7_7.jpg",
                    "width": 612,
                    "height": 612
                }
            },
            "type": "image",
            "users_in_photo": [],
            "filter": "Earlybird",
            "tags": ["foodtruck"],
            "id": "22721881",
            "location": {
                "latitude": 37.778720183610183,
                "longitude": -122.3962783813477,
                "id": "520640",
                "street_address": "",
                "name": "Le Truc"
            }
          }
        JSON
      end

      it 'is of the right type' do
        expect(subject.type).to eq('image')
      end

      it 'has the correct id' do
        expect(subject.id).to eq('22721881')
      end

      it 'has the correct caption' do
        expect(subject.caption).to eq('Inside le truc #foodtruck')
      end

      it 'has the correct link' do
        expect(subject.link).to eq('http://instagr.am/p/BWrVZ/')
      end

      it 'has the correct created_time' do
        expect(subject.created_time).to eq(Time.at(1296710327))
      end

      describe('#image_url') do
        context('when the resolution is valid') do
          it 'returns the correct thumbnail url' do
            expect(subject.image_url(:thumbnail))
              .to eq("http://distillery.s3.amazonaws.com/media/2011/02/02/6ea7baea55774c5e81e7e3e1f6e791a7_5.jpg")
          end

          it 'returns the correct standard_resolution url' do
            expect(subject.image_url(:standard_resolution))
              .to eq("http://distillery.s3.amazonaws.com/media/2011/02/02/6ea7baea55774c5e81e7e3e1f6e791a7_7.jpg")
          end

          it 'returns the correct low_resolution url' do
            expect(subject.image_url(:low_resolution))
              .to eq("http://distillery.s3.amazonaws.com/media/2011/02/02/6ea7baea55774c5e81e7e3e1f6e791a7_6.jpg")
          end
        end

        context("when the resolution isn't valid") do
          it 'returns a InvalidResolutionError' do
            expect {
              subject.image_url('not_valid')
            }.to raise_error(Media::InvalidResolutionError)
          end
        end
      end

      describe('#video_url') do
        it 'raises an wrong media type error' do
          expect {
            subject.video_url(:standard_resolution)
          }.to raise_error(Media::WrongMediaTypeError)
        end
      end
    end
  end
end
