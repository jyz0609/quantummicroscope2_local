from datetime import datetime
def write_single_coordinate(x,y,timeresfile= "Error, no timeres file"):
    with open("coordinate_g2.txt", "r") as file:
        content = file.read()
        if not content:  # Empty string means the file is empty
            with open("coordinate_g2.txt", "w") as file:
                file.write(timeresfile + "\n")
                info_line = f"Recorded at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} | Version: 1.0"
                file.write(info_line + "\n")
                file.write(f"{x},{y}\n")

        else:
            with open("coordinate_g2.txt", "a") as file:
                file.write(f"{x},{y}\n")


def clear_coord_file():
    with open("coordinate_g2.txt", "w") as file:
            pass
    print("file has been cleared")
def save_coords_to_file(filename, timeresfile,results):
    with open(filename, "w") as file:
        # Write the information line (record message)
        file.write(timeresfile + "\n")
        info_line = f"Recorded at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} | Version: 1.0"
        file.write(info_line + "\n")

        # Write each coordinate and its intensity on a new line
        try:
            for res in results:
                x, y = res["position"]

                file.write(f"{x},{y}\n")
        except Exception as e:
            print(f"Error: key is not {e}, will not wirte")
            return  f"Error: {e}"

    print("Data written to results.txt.")
    return 0

def read_coord_from_file(filename,data):
    with open(filename, "r") as file:
        # Read the information line separately
        file.readline().strip()
        info = file.readline().strip()
        print("Info Line:", info)

        # Read the remaining lines for coordinates
        try:
            for line in file:
                # Each line is expected to be in the format: x,y,intensity
                parts = line.strip().split(",")

                if len(parts) == 2:
                    x, y = parts
                    print(f"Coordinate: ({x}, {y}) ")
                    data.append({'position': (x, y)})
        except FileNotFoundError:
            return "Error: File not found."

        except Exception as e :
            return f"Error: {e}"
    return 0





if __name__ == "__main__":
    # Example data: a list of dictionaries with coordinates and intensity
    results = [
        {"position": (2, 2)},
        {"position": (1, 2)}
    ]
    results2 = []
    filename = "coordinate_g2.txt"
    timeres_data_filename = 'test_date(250324)_time(17h03m03s)_scantime(50.0)_dwellTime(0.005)_xAmp(0.3)_yAmp(0.3)_xyDim(100).timeres'
    # --- Writing to the file ---

    # save_coord_to_file(filename=filename, timeresfile=timeres_data_filename, results=results2)
    clear_coord_file()
    write_single_coordinate(3, 4)
    write_single_coordinate(4, 5, timeres_data_filename)

    # --- Reading from the file ---

    data = []
    err = read_coord_from_file("coordinate_g2.txt", data)
    if err != 0:
        print(err)

    with open("coordinate_g2.txt", "r") as file:
        content = file.read()

    if not content:  # Empty string means the file is empty
        print("The file is empty.")
    else:
        print("The file has content.")
