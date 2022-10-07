require "swagger_helper"

describe "Wheather API" do
  let!(:indications) do
    [
      Indication.create!(temperature: "10.8", unit: "C", epochTime: 1665075480),
      Indication.create!(temperature: "10.9", unit: "C", epochTime: 1665071880),
      Indication.create!(temperature: "11.5", unit: "C", epochTime: 1665068340),
    ]
  end

  let(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }

  path "/api/v1/health" do
    get "return status" do
      response "200", "successful request" do
        schema type: :object,
          items: {
            type: :object,
            properties: {
              message: { type: :string, description: "service is working" },
            },
            required: %i[message]
          }

        let(:expected_response) do
          {
            "message": "Service is working !"
          }
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end
    end
  end

  path "/api/v1/wheather/historical" do
    get "return indications list" do
      response "200", "successful request" do
        schema type: :object,
          items: {
            type: :object,
            properties: {
              action: { type: :string, description: "action message" },
              data: { type: :array, description: "indications" },
            },
            required: %i[action data]
          }

        let(:expected_response) do
          {
            "action": "temperature by 24 hours in Moscow",
            "data": [
                {
                    "temperature": 10.8,
                    "unit": "C",
                    "epochTime": 1665075480
                },
                {
                    "temperature": 10.9,
                    "unit": "C",
                    "epochTime": 1665071880
                },
                {
                    "temperature": 11.5,
                    "unit": "C",
                    "epochTime": 1665068340
                }
            ]
          }
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end
    end
  end

  path "/api/v1/wheather/historical/min" do
    get "return min temperature by 24 hours in Moscow " do
      response "200", "successful request" do
        schema type: :object,
          items: {
            type: :object,
            properties: {
              action: { type: :string, description: "action message" },
              data: { type: :object, description: "indications" },
            },
            required: %i[action data]
          }

        let(:expected_response) do
          {
            "action": "min temperature by 24 hours in Moscow",
            "data": {
                "temperature": 10.8,
                "unit": "C",
                "epochTime": 1665075480
            }
          }
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end
    end
  end

  path "/api/v1/wheather/historical/max" do
    get "return min temperature by 24 hours in Moscow " do
      response "200", "successful request" do
        schema type: :object,
          items: {
            type: :object,
            properties: {
              action: { type: :string, description: "action message" },
              data: { type: :object, description: "indications" },
            },
            required: %i[action data]
          }

        let(:expected_response) do
          {
            "action": "max temperature by 24 hours in Moscow",
            "data": {
                "temperature": 11.5,
                "unit": "C",
                "epochTime": 1665068340
            }
          }
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end
    end
  end

  path "/api/v1/wheather/historical/avg" do
    get "return min temperature by 24 hours in Moscow " do
      response "200", "successful request" do
        schema type: :object,
          items: {
            type: :object,
            properties: {
              action: { type: :string, description: "action message" },
              data: { type: :integer, description: "avg" },
            },
            required: %i[action data]
          }

        let(:expected_response) do
          {
            "action": "avg temperature by 24 hours in Moscow",
            "data": 1.38
          }
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end
    end
  end

  path "/api/v1/wheather/by_time/{epochTime}" do
    get "return temperature by this time" do
      parameter name: :epochTime, in: :path, required: true,
        schema: { type: :integer }, description: "time"

      response "200", "successful request" do
        schema type: :object,
          items: {
            type: :object,
            properties: {
              action: { type: :string, description: "action message" },
              data: { type: :object, description: "temperaute by this time" },
            },
            required: %i[action data]
          }

        let(:epochTime) { 1665068340 }
        let(:expected_response) do
          {
            "action": "temperature by this time in Moscow",
            "data": {
                "temperature": 11.5,
                "unit": "C",
                "epochTime": 1665068340
            }
        }
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end
    end
  end

  path "/api/v1/wheather/by_time/{epochTime}" do
    get "return temperature by this time" do
      parameter name: :epochTime, in: :path, required: true,
        schema: { type: :integer }, description: "time"

      response "404", "bad request" do
        schema type: :object,
          items: {
            type: :object,
            properties: {
              message: { type: :string, description: "error message" },
            },
            required: %i[action data]
          }

        let(:epochTime) { 1665067340 }
        let(:expected_response) do
          {
            "message": "temperature by this time is not found"
          }
        end

        run_test! do
          expect(parsed_response).to eq(expected_response)
        end
      end
    end
  end
end
