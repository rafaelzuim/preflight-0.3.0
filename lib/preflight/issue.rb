# encoding: utf-8

module Preflight
  class Issue

    attr_reader :critical, :href, :description, :rule, :attributes

    def initialize(critical, href, description, rule, attributes = {})
      #novos atributos para direcionamento de erros
      @critical = critical
      @href = href
      @description = description

      if rule.is_a?(Class)
        @rule = rule.to_s.to_sym
      else
        @rule        = rule.class.to_s.to_sym
      end
      @attributes  = attributes || {}

      attach_attributes

    end

    def to_s
      @description
    end

    private

    def attach_attributes
      singleton = class << self; self end

      @attributes.each do |key, value|
        singleton.send(:define_method, key, lambda { value })
      end
    end

  end
end
