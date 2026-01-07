import yaml

def test_sanitized_output():
    with open("sanitized_output.txt") as f:
        content = f.read()

    assert "***" in content
    assert "hack" not in content.lower()
    assert "exploit" not in content.lower()

def test_status_file():
    with open("status.txt") as f:
        status = f.read().strip()

    assert status == "unsafe"

def test_audit_log_appended():
    with open("audit.log") as f:
        lines = f.readlines()

    assert len(lines) >= 2
    assert lines[-1].startswith("status=unsafe;blocked_count=")

def test_blocked_count_consistency():
    with open("audit.log") as f:
        last_line = f.readlines()[-1]

    blocked_count = int(last_line.split("blocked_count=")[1])

    with open("sanitized_output.txt") as f:
        masked_count = f.read().count("***")

    assert blocked_count == masked_count
