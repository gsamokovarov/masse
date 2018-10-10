require "test_helper"

class MasseTest < Minitest::Test
  def test_string_message_mass_matching
    sloppy_runtime_errors = Masse[
      "Access Denied",
      "Cannot find remote server",
    ]

    assert_raises sloppy_runtime_errors do
      raise "Access Denied"
    end

    assert_raises sloppy_runtime_errors do
      raise "Cannot find remote server"
    end
  end

  def test_regexp_message_mass_matching
    bad_errors = Masse[/Bad/]

    assert_raises bad_errors do
      raise "Bad error messages, everywhere"
    end
  end

  def test_dynamic_errors_mass_matching
    bad_errors = Masse[
      -> raised { raised.to_s == "Bad error?" },
    ]

    assert_raises bad_errors do
      raise "Bad error?"
    end
  end
end
