require 'spec_helper'

describe Chewy::Index::Settings do
  describe '#to_hash' do
    before { allow(Chewy).to receive_messages(config: Chewy::Config.send(:new)) }
    before { allow(Chewy).to receive_messages(repository: Chewy::Repository.send(:new)) }

    specify { expect(described_class.new.to_hash).to eq({}) }
    specify { expect(described_class.new(number_of_nodes: 3).to_hash).to eq({settings: {number_of_nodes: 3}}) }
    specify { expect(described_class.new(number_of_nodes: 3, analysis: {}).to_hash)
      .to eq({settings: {number_of_nodes: 3, analysis: {}}}) }
    specify { expect(described_class.new(number_of_nodes: 3, analysis: {filter: {filter1: {}}}).to_hash)
      .to eq({settings: {number_of_nodes: 3, analysis: {filter: {filter1: {}}}}}) }
    specify { expect(described_class.new(number_of_nodes: 3, analysis: {analyzer: {analyzer1: {}}}).to_hash)
      .to eq({settings: {number_of_nodes: 3, analysis: {analyzer: {analyzer1: {}}}}}) }
    specify { expect(described_class.new(number_of_nodes: 3, analysis: {
      analyzer: {analyzer1: {tokenizer: 'tokenizer1', filter: ['filter1', 'filter2']}}
    }).to_hash)
      .to eq({settings: {number_of_nodes: 3, analysis: {
        analyzer: {analyzer1: {tokenizer: 'tokenizer1', filter: ['filter1', 'filter2']}}
      }}}) }
    specify { expect(described_class.new(number_of_nodes: 3, analysis: {analyser: ['analyzer1']}).to_hash)
      .to eq({settings: {number_of_nodes: 3, analysis: {}}}) }

    context do
      before { Chewy.tokenizer :tokenizer1, {options: 42} }

      specify { expect(described_class.new(number_of_nodes: 3, analysis: {
        analyzer: {analyzer1: {tokenizer: 'tokenizer1', filter: ['filter1', 'filter2']}}
      }).to_hash)
        .to eq({settings: {number_of_nodes: 3, analysis: {
          analyzer: {analyzer1: {tokenizer: 'tokenizer1', filter: ['filter1', 'filter2']}},
          tokenizer: {tokenizer1: {options: 42}}
        }}}) }
    end

    context do
      before do
        Chewy.filter :filter2, {options: 42}
        Chewy.filter :filter3, {options: 43}
        Chewy.filter :filter5, {options: 44}
      end

      specify { expect(described_class.new(number_of_nodes: 3, analysis: {
        analyzer: {analyzer1: {tokenizer: 'tokenizer1', filter: ['filter1', 'filter2']}},
        filter: ['filter3', {filter4: {options: 45}}]
      }).to_hash)
        .to eq({settings: {number_of_nodes: 3, analysis: {
          analyzer: {analyzer1: {tokenizer: 'tokenizer1', filter: ['filter1', 'filter2']}},
          filter: {filter2: {options: 42}, filter3: {options: 43}, filter4: {options: 45}}
        }}}) }
    end

    context do
      before do
        Chewy.analyzer :analyzer1, {options: 42, tokenizer: 'tokenizer1'}
        Chewy.tokenizer :tokenizer1, {options: 43}
      end

      specify { expect(described_class.new(number_of_nodes: 3, analysis: {
        analyzer: ['analyzer1', {analyzer2: {options: 44}}]
      }).to_hash)
        .to eq({settings: {number_of_nodes: 3, analysis: {
          analyzer: {analyzer1: {options: 42, tokenizer: 'tokenizer1'}, analyzer2: {options: 44}},
          tokenizer: {tokenizer1: {options: 43}}
        }}}) }
    end

    context ':index' do
      specify { expect(described_class.new(index: {number_of_shards: 3}).to_hash)
        .to eq({settings: {index: {number_of_shards: 3}}}) }

      context do
        before { allow(Chewy).to receive_messages(configuration: {index: {number_of_shards: 7, number_of_replicas: 2}}) }

        specify { expect(described_class.new.to_hash)
          .to eq({settings: {index: {number_of_shards: 7, number_of_replicas: 2}}}) }
        specify { expect(described_class.new(index: {number_of_shards: 3}).to_hash)
          .to eq({settings: {index: {number_of_shards: 3, number_of_replicas: 2}}}) }
      end
    end
  end
end
