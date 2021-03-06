require 'spec_helper'

describe Chewy::Type::Witchcraft do
  def self.mapping(&block)
    before do
      stub_index(:products) do
        define_type :product do
          witchcraft!

          instance_exec(&block)
        end
      end
    end
  end

  describe '#cauldron' do
    let(:type) { ProductsIndex::Product }
    let(:object) { }

    context 'empty mapping' do
      mapping {}
      specify { expect(type.cauldron.brew(object)).to eq({}) }
    end

    context do
      mapping do
        field :name
        field :age
        field :tags
      end
      let(:attributes) { { name: 'Name', age: 13, tags: %w[Ruby RoR] } }

      context do
        let(:object) { double(attributes) }
        specify { expect(type.cauldron.brew(object)).to eq(attributes.as_json) }
      end

      context do
        let(:object) { attributes }
        specify { expect(type.cauldron.brew(object)).to eq(attributes.as_json) }
      end
    end

    context 'simple lambdas' do
      mapping do
        field :name
        field :age, value: -> (obj) {
          obj.age if obj
        }
        field :tags, value: -> { tags.map(&:to_sym) }
      end
      let(:attributes) { { name: 'Name', age: 13, tags: %w[Ruby RoR] } }

      context do
        let(:object) { double(attributes) }
        specify { expect(type.cauldron.brew(object)).to eq(attributes.merge(tags: [:Ruby, :RoR]).as_json) }
      end
    end

    context 'crutches' do
      mapping do
        field :name, value: -> (o, c) { c.names[0] }
      end
      let(:attributes) { { name: 'Name' } }

      context do
        let(:object) { double(attributes) }
        let(:crutches) { double(names: ['Other']) }
        specify { expect(type.cauldron.brew(object, crutches)).to eq({name: 'Other'}.as_json) }
      end
    end

    context 'nesting' do
      context do
        mapping do
          field :queries do
            field :title
            field :body, value: -> { "This #{self[:body]}" }
          end
        end

        let(:object) { double(queries: [
          {title: 'Title1', body: 'Body1'},
          {title: 'Title2', body: 'Body2'}
        ]) }
        specify { expect(type.cauldron.brew(object)).to eq({ queries: [
          {title: 'Title1', body: 'This Body1'},
          {title: 'Title2', body: 'This Body2'}
        ] }.as_json) }
      end

      context do
        mapping do
          field :queries do
            field :title
            field :body, value: -> { "This #{body}" }
          end
        end

        let(:object) { double(queries: [
          double(title: 'Title1', body: 'Body1'),
          double(title: 'Title2', body: 'Body2')
        ]) }
        specify { expect(type.cauldron.brew(object)).to eq({ queries: [
          {title: 'Title1', body: 'This Body1'},
          {title: 'Title2', body: 'This Body2'}
        ] }.as_json) }
      end

      context do
        mapping do
          field :queries, value: -> { queries } do
            field :title
            field :body, value: -> { "This #{body}" }
          end
        end

        let(:object) { double(queries: [
          double(title: 'Title1', body: 'Body1'),
          double(title: 'Title2', body: 'Body2')
        ]) }
        specify { expect(type.cauldron.brew(object)).to eq({ queries: [
          {title: 'Title1', body: 'This Body1'},
          {title: 'Title2', body: 'This Body2'}
        ] }.as_json) }
      end

      context do
        mapping do
          field :queries do
            field :fields, value: -> (o, q) { q.fields } do
              field :first
              field :second, value: -> (o, q, f, c) {
                q.value + (f.respond_to?(:second) ? f.second : c.second)
              }
            end
          end
        end

        let(:object) { double(queries: [
          double(value: 'Value1', fields: [double(first: 'First1', second: 'Second1'), {first: 'First2'}]),
          double(value: 'Value2', fields: double(first: 'First3', second: 'Second2', third: 'Third'))
        ]) }
        specify { expect(type.cauldron.brew(object, double(second: 'Crutch'))).to eq({queries: [
          {fields: [
            {first: 'First1', second: 'Value1Second1'},
            {first: 'First2', second: 'Value1Crutch'}
          ]},
          {fields: {first: 'First3', second: 'Value2Second2'}}
        ]}.as_json) }
      end
    end
  end
end
