import tkinter as tk
from tkinter import filedialog, messagebox
import json
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.backends.backend_tkagg import NavigationToolbar2Tk


class MatrixViewerApp:
    def __init__(self, root):
        self.root = root
        self.root.title("3D Matrix Viewer")

        self.matrix_3d = None
        self.slice_index = tk.IntVar(value=1)
        self.file_path = tk.StringVar(value="No file selected")

        self.create_widgets()

    def create_widgets(self):
        control_frame = tk.Frame(self.root)
        control_frame.pack(side=tk.TOP, fill=tk.X, padx=5, pady=5)

        tk.Button(control_frame, text="Load JSON", command=self.load_json).pack(side=tk.LEFT, padx=5)
        tk.Label(control_frame, text="Slice Index:").pack(side=tk.LEFT)
        tk.Entry(control_frame, textvariable=self.slice_index, width=5).pack(side=tk.LEFT)
        tk.Button(control_frame, text="Show Heatmap", command=self.show_heatmap).pack(side=tk.LEFT, padx=5)

        plot_frame = tk.Frame(self.root)
        plot_frame.pack(side=tk.TOP, fill=tk.BOTH, expand=True)

        self.fig1, self.ax1 = plt.subplots()
        self.canvas1 = FigureCanvasTkAgg(self.fig1, master=plot_frame)
        self.canvas1.draw()
        canvas1_widget = self.canvas1.get_tk_widget()
        canvas1_widget.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        self.canvas1.mpl_connect("button_press_event", self.on_click) #"""check if the click event still works"""

        # 创建 heatmap 工具栏，并放在图下方
        toolbar1_frame = tk.Frame(plot_frame)
        toolbar1_frame.pack(side=tk.LEFT, fill=tk.X)
        self.toolbar1 = NavigationToolbar2Tk(self.canvas1, toolbar1_frame)
        self.toolbar1.update()

        # Lineplot 图和 Toolbar
        self.fig2, self.ax2 = plt.subplots()
        self.canvas2 = FigureCanvasTkAgg(self.fig2, master=plot_frame)
        self.canvas2.draw()
        canvas2_widget = self.canvas2.get_tk_widget()
        canvas2_widget.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)

        # 创建 lineplot 工具栏，并放在图下方
        toolbar2_frame = tk.Frame(plot_frame)
        toolbar2_frame.pack(side=tk.RIGHT, fill=tk.X)
        self.toolbar2 = NavigationToolbar2Tk(self.canvas2, toolbar2_frame)
        self.toolbar2.update()

        self.file_label = tk.Label(control_frame, textvariable=self.file_path, fg="blue", anchor="w")
        self.file_label.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=10)

    def load_json(self):
        file_path = filedialog.askopenfilename(filetypes=[("JSON Files", "*.json")])
        if file_path:
            try:
                with open(file_path, 'r') as file:
                    data = json.load(file)
                    self.matrix_3d = np.array(data["matrix3D"])
                    self.file_path.set(f"Loaded: {file_path}")
                    messagebox.showinfo("Success", f"Loaded matrix with shape {self.matrix_3d.shape}")
            except Exception as e:
                messagebox.showerror("Error", f"Failed to load JSON file:\n{e}")

    def show_heatmap(self):
        if self.matrix_3d is None:
            messagebox.showerror("Error", "No matrix loaded.")
            return

        i = self.slice_index.get()
        if i < 1 or i > self.matrix_3d.shape[0]:
            messagebox.showerror("Error", f"Slice index out of range. Must be 1 to {self.matrix_3d.shape[0]}.")
            return

        self.ax1.clear()
        self.ax1.imshow(self.matrix_3d[i-1], cmap='hot', interpolation='nearest')
        self.ax1.set_title(f"2D Heatmap - Slice {i}")
        self.canvas1.draw()

    def on_click(self, event):
        if event.inaxes != self.ax1 or self.matrix_3d is None:
            return

        x = int(event.xdata + 0.5)
        y = int(event.ydata + 0.5)

        if 0 <= y < self.matrix_3d.shape[1] and 0 <= x < self.matrix_3d.shape[2]:
            values = self.matrix_3d[:, y, x]
            self.ax2.clear()
            self.ax2.plot(values, marker='o')
            self.ax2.set_title(f"1D Plot at ({y}, {x})")
            self.ax2.set_xlabel("Slice Index")
            self.ax2.set_ylabel("Value")
            self.canvas2.draw()

if __name__ == "__main__":
    root = tk.Tk()
    app = MatrixViewerApp(root)
    root.mainloop()
