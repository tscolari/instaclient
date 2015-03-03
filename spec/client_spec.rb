require 'spec_helper'

module Instaclient
  RSpec.describe Client do
    let(:client_id) { "12345" }
    let(:client_secret) { "abcde" }

    subject { Client.new(client_id, client_secret) }

    describe "#recent" do

      let(:response) do
        <<-RESPONSE
          {
              "data": [{
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
              },
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
            ]
          }
        RESPONSE
      end

      let(:url) do
        "https://api.instagram.com/v1/users/user1234/media/recent/?count=50&client_id=12345"
      end

      before do
        stub_request(:get, url).to_return(body: response)
      end

      it "sends the correct request" do
        subject.recent("user1234", 50)
        expect(WebMock).to have_requested(:get, url)
      end

      it "parses the response into 2 objects" do
        media = subject.recent("user1234", 50)
        expect(media.size).to eq(2)
      end

      it "parses the response into Media objects" do
        media = subject.recent("user1234", 50)

        media.each do |m|
          expect(m).to be_a(Models::Media)
        end

        image_media = media[0]
        video_media = media[1]
        expect(image_media.id).to eq("22721881")
        expect(video_media.id).to eq("363839373298")
      end

      context 'when response code is 404' do
        it 'raises an RequestError' do
          stub_request(:get, url).to_return(status: 404)
          expect {
            subject.recent("user1234", 50)
          }.to raise_error(Client::RequestError, "Got 404 from instagram. Maybe wrong user_id?")
        end
      end
    end
  end
end
