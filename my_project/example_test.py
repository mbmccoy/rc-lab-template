from my_project.example import example


def test_example():
    assert example() == "Hello, world!"
    assert example("test") == "Hello, test!"
