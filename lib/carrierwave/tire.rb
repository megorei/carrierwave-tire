# encoding: utf-8
require "carrierwave/tire/version"
require "carrierwave/validations/active_model"

module CarrierWave
  module Tire

    def self.included(base)
      base.extend CarrierWave::Mount
      base.extend ClassMethods
      base.class_eval do

        def read_uploader(attribute)
          instance_variable_get(:"@#{attribute}")
        end

        def write_uploader(attribute, identifier)
          instance_variable_set(:"@#{attribute}", identifier)
        end

      end

    end

    module ClassMethods

      def mount_uploader(column, uploader=nil, options={}, &block)
        super

        after_save :"store_#{column}!"
        before_save :"write_#{column}_identifier"
        after_destroy :"remove_#{column}!"

        include CarrierWave::Validations::ActiveModel

        validates_integrity_of column   if uploader_option(column.to_sym, :validate_integrity)
        validates_processing_of column  if uploader_option(column.to_sym, :validate_processing)
        validates_download_of column    if uploader_option(column.to_sym, :validate_download)


        class_eval <<-RUBY, __FILE__, __LINE__+1
          def remove_#{column}!
            super
            _mounter(:#{column}).remove = true
            _mounter(:#{column}).write_identifier
            FileUtils.rm_rf File.dirname(send('#{column}').file.path) if send('#{column}').file.present?
          end

          def serializable_hash(options=nil)
            hash = {}

            except = options && options[:except] && Array.wrap(options[:except]).map(&:to_s)
            only   = options && options[:only]   && Array.wrap(options[:only]).map(&:to_s)

            self.class.uploaders.each do |column, uploader|
              if (!only && !except) || (only && only.include?(column.to_s)) || (!only && except && !except.include?(column.to_s))
                hash[column.to_s] = _mounter(column).uploader.serializable_hash
              end
            end
            super(options).merge(hash)
          end
        RUBY

      end

    end

  end
end