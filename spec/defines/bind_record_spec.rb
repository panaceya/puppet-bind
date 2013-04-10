require 'spec_helper'

describe 'bind::record' do
  let (:title) { 'CNAME foo.example.com' }
  let (:facts) { {
    :osfamily        => 'Debian',
    :operatingsystem => 'Debian'
  } }

  context 'when using a wrong ensure value' do
    let (:params) { {
      :ensure      => 'running',
      :zone        => 'foo.example.com',
      :hash_data   => {},
      :record_type => 'CNAME'
    } }

    it 'should fail' do
      expect { should contain_concat__fragment('') 
      }.to raise_error(Puppet::Error, /\$ensure must be either.* got 'running'/)
    end
  end

  context 'when zone is not specified' do
    let (:params) { {
      :hash_data   => {},
      :record_type => 'CNAME'
    } }

    it 'should fail' do
      expect { should contain_concat__fragment('') 
      }.to raise_error(Puppet::Error, /Must pass zone to Bind::Record/)
    end
  end

  context 'when hash_data is not specified' do
    let (:params) { {
      :zone        => 'foo.example.com',
      :record_type => 'CNAME'
    } }

    it 'should fail' do
      expect { should contain_concat__fragment('') 
      }.to raise_error(Puppet::Error, /Must pass hash_data to Bind::Record/)
    end
  end

  context 'when record_type is not specified' do
    let (:params) { {
      :zone        => 'foo.example.com',
      :hash_data   => {}
    } }

    it 'should fail' do
      expect { should contain_concat__fragment('') 
      }.to raise_error(Puppet::Error, /Must pass record_type to Bind::Record/)
    end
  end

  context 'when using default content_template' do
    let (:params) { {
      :zone        => 'foo.example.com',
      :hash_data   => {},
      :record_type => 'CNAME'
    } }

    it { should contain_concat__fragment('foo.example.com.CNAME.CNAME foo.example.com') }
  end
end