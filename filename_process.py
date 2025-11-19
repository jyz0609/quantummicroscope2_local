import re


def extract_info(filepath: str) -> str:
    """
    Extracts the info part (e.g., chip16_3.22_scan2) from the given file path.
    """
    # Extract date from the path
    date_match = re.search(r'/(\d{6})/', filepath)
    if not date_match:
        return ""  # Return empty if no date is found
    date = date_match.group(1)

    # Extract the info part using the date as a reference point
    info_match = re.search(rf'/{date}/([^/]+)_date\({date}\)', filepath)
    return info_match.group(1) if info_match else ""


def g2_filename_withcoordinate (x,y, text):

    new_text = text.replace('date(', f"coordinate({x},{y})_" + 'date(')
    new_text = new_text.replace('/Data/', '/g2_Data/')
    new_text = new_text.split('_scantime', 1)[0]
    new_text = new_text + '.timeres'

    if new_text == text+ '.timeres' :
        print(f"Error: filename is not replaced in the original string.")

    return new_text

if __name__ == "__main__":

    # Example usage
    filepath = "K:/Microscope/Data/250310/infotest_date(250310)_time(15h57m14s)_scantime(200.0)_dwellTime(0.005)_xAmp(0.31949)_yAmp(0.31949)_xyDim(200).timeres"
    info = extract_info(filepath)
    print(info)  # Expected output: chip16_3.22_scan2


    g2filename = g2_filename_withcoordinate(1,1,filepath)
    print(g2filename)