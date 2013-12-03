module FCReminder
  module Providers
    class LiveScore < Base
      BASE_URL = "http://www.livescore.com"

      def url
        "#{BASE_URL}/soccer/#{Time.now.strftime("%Y-%m-%d")}"
      end

      def run(team_name: team_name)
        cell = search(page: client.get(url), team_name: team_name.downcase)
        cell.nil? ? super : prepare_output_from(cell)
      end

      private

        def search(page: page, team_name: team_name)
          page.search(".content table.league-table td").find do |td|
            has_team?(td) and team_match?(td, team_name)
          end
        end

        def has_team?(cell)
          %w(fh fa).include? cell.attributes["class"].value
        end

        def team_match?(cell, team_name)
          cell.text.strip.downcase == team_name
        end

        def prepare_output_from(cell)
          r = Hash.new
          r.merge!(fetch(attrs: league_attrs, source: cell.parent.parent))
          r.merge!(fetch(attrs: match_attrs, source: cell.parent))
          r
        end

        def fetch(attrs: attrs, source: source)
          attrs.inject({}) { |h,(k,v)| h[k] = source.search(v).text.strip; h }
        end

        def league_attrs
          {
            country: 'span.league > a',
            league: 'span.league > span > a',
          }
        end

        def match_attrs
          {
            time: 'td.fd',
            team1: 'td.fh',
            team2: 'td.fa'
          }
        end
    end
  end
end

