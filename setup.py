import json

# Example variables
x_offset = 0.59
y_offset = -0.289
calibrated_lenslope = 313
# Combine into a dictionary (JSON stores key-value pairs)
data = {
    "x_offset": x_offset,
    "y_offset": y_offset,
    "calibrated_lenslope": calibrated_lenslope,
    "host": "130.237.35.177"
}

# Save to JSON file
with open("microscope_table_setup.json", "w") as f:
    json.dump(data, f, indent=4)  # indent=4 makes it pretty
