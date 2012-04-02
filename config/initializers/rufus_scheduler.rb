require 'rufus/scheduler'

if !Rails.env.test?

  scheduler = Rufus::Scheduler.start_new

  scheduler.cron '0 4 * * *' do
    p "starting information scrape at #{Time.now}"
    Scraper.scrape_information
    p "successfully scraped information at #{Time.now}"
  end

  scheduler.every '1m' do
    p "starting enrollment scrape at #{Time.now}"
    Scraper.scrape_enrollments
    p "successfully scraped enrollments at #{Time.now}"
  end

end