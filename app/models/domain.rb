class Domain < ActiveRecord::Base
  validates_presence_of :user_id, :domain
  validates_uniqueness_of :domain, :scope => :user_id

  default_scope :order => 'expiration_date ASC'


  def check_domain_now
    w = Whois.whois(self.domain)
    #rescue Whois::Error => self.check_domain_now
    self.registration_date = w.created_on
    self.expiration_date = w.expires_on
    self.save
    puts "DID A CHECK FROM MODEL"
  end

  def run_cron_now
    Rake::Task["cron"].execute
  end


end
