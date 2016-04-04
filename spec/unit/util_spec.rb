require "spec_helper"

describe "Utility methods" do
  describe "#to_snake_case" do
    context "PersonController" do
      it { expect("PersonController".to_snake_case).to eq "person_controller" }
    end

    context "Person" do
      it { expect("Person".to_snake_case).to eq "person" }
    end

    context "Todo::Person" do
      it { expect("Todo::Person".to_snake_case).to eq "todo/person" }
    end

    context "PERSONController" do
      it { expect("PERSONController".to_snake_case).to eq "person_controller" }
    end

    context "personcontroller" do
      it { expect("personcontroller".to_snake_case).to eq "personcontroller" }
    end

    context "person" do
      it { expect("person".to_snake_case).to eq "person" }
    end
  end

  describe "#to_camel_case" do
    context "person_controller" do
      it { expect("person_controller".to_camel_case).to eq "PersonController" }
    end

    context "person__todo_app" do
      it { expect("person__todo_app".to_camel_case).to eq "PersonTodoApp" }
    end

    context "person" do
      it { expect("person".to_camel_case).to eq "Person" }
    end
  end

  describe "#to_constant" do
    context "`Hash`" do
      it { expect("Hash".to_constant).to eq Hash }
    end

    context "`String`" do
      it { expect("String".to_constant).to eq String }
    end

    context "`Array`" do
      it { expect("Array".to_constant).to eq Array }
    end
  end

  describe "#to_plural" do
    context "girl" do
      it { expect("girl".to_plural).to eq "girls" }
    end

    context "buzz" do
      it { expect("buzz".to_plural).to eq "buzzes" }
    end

    context "story" do
      it { expect("story".to_plural).to eq "stories" }
    end

    context "toy" do
      it { expect("toy".to_plural).to eq "toys" }
    end

    context "scarf" do
      it { expect("scarf".to_plural).to eq "scarves" }
    end

    context "analysis" do
      it { expect("analysis".to_plural).to eq "analyses" }
    end

    context "curriculum" do
      it { expect("curriculum".to_plural).to eq "curricula" }
    end

    context "criterion" do
      it { expect("criterion".to_plural).to eq "criteria" }
    end

    context "amoeba" do
      it { expect("amoeba".to_plural).to eq "amoebae" }
    end

    context "focus" do
      it { expect("focus".to_plural).to eq "foci" }
    end

    context "bureau" do
      it { expect("bureau".to_plural).to eq "bureaux" }
    end
  end
end
