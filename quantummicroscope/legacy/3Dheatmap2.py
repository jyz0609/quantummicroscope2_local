import tkinter as tk
from tkinter import filedialog, messagebox
import json
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk


class MatrixViewerApp:
    def __init__(self, root):
        self.root = root
        self.root.title("3D Matrix Viewer")

        self.matrix_3d = None
        self.slice_index = tk.IntVar(value=1)
        self.file_path = tk.StringVar(value="No file selected")
        self.cbar = None  # Reference to current colorbar

        self.create_widgets()

    def create_widgets(self):
        # Top control panel
        control_frame = tk.Frame(self.root)
        control_frame.pack(side=tk.TOP, fill=tk.X, padx=5, pady=5)

        tk.Button(control_frame, text="Load JSON", command=self.load_json).pack(side=tk.LEFT, padx=5)
        tk.Label(control_frame, text="Slice Index:").pack(side=tk.LEFT)
        tk.Entry(control_frame, textvariable=self.slice_index, width=5).pack(side=tk.LEFT)

        self.colormap = tk.StringVar(value="hot")
        tk.OptionMenu(control_frame, self.colormap, "hot", "viridis", "plasma", "gray").pack(side=tk.LEFT)

        tk.Button(control_frame, text="Show Heatmap", command=self.show_heatmap).pack(side=tk.LEFT, padx=5)

        self.file_label = tk.Label(control_frame, textvariable=self.file_path, fg="blue", anchor="w")
        self.file_label.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=10)

        # Main plot area
        plot_frame = tk.Frame(self.root)
        plot_frame.pack(side=tk.TOP, fill=tk.BOTH, expand=True)

        # Heatmap with toolbar
        heatmap_frame = tk.Frame(plot_frame)
        heatmap_frame.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        self.fig1, self.ax1 = plt.subplots()
        self.canvas1 = FigureCanvasTkAgg(self.fig1, master=heatmap_frame)
        self.canvas1.draw()
        self.canvas1.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=True)

        self.toolbar1 = NavigationToolbar2Tk(self.canvas1, heatmap_frame)
        self.toolbar1.update()
        self.toolbar1.pack(side=tk.TOP, fill=tk.X)

        self.canvas1.mpl_connect("button_press_event", self.on_click)

        # Lineplot with toolbar
        lineplot_frame = tk.Frame(plot_frame)
        lineplot_frame.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)

        self.fig2, self.ax2 = plt.subplots()
        self.canvas2 = FigureCanvasTkAgg(self.fig2, master=lineplot_frame)
        self.canvas2.draw()
        self.canvas2.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=True)

        self.toolbar2 = NavigationToolbar2Tk(self.canvas2, lineplot_frame)
        self.toolbar2.update()
        self.toolbar2.pack(side=tk.TOP, fill=tk.X)

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

        # Completely clear the figure (removes axes + colorbar)
        self.fig1.clf()
        self.ax1 = self.fig1.add_subplot(111)  # Create new axes

        # Global min/max for consistent color scale
        vmin = np.min(self.matrix_3d)
        vmax = np.max(self.matrix_3d)

        # Draw heatmap
        img = self.ax1.imshow(
            self.matrix_3d[i - 1],
            cmap=self.colormap.get(),
            interpolation='nearest',
            vmin=vmin,
            vmax=vmax
        )
        self.ax1.set_title(f"2D Heatmap - Slice {i}")

        # Add new colorbar and store reference
        self.cbar = self.fig1.colorbar(
            img,
            ax=self.ax1,
            orientation='vertical',
            fraction=0.046,  # width of the colorbar
            pad=0.04,        # space between plot and colorbar
            shrink=0.8       # shorten colorbar height
        )
        self.cbar.set_label("Intensity")

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
