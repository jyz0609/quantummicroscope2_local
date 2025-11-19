import tkinter as tk
from tkinter import filedialog, messagebox
import json
import os
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk

from matplotlib.ticker import MaxNLocator


class MatrixViewerApp:
    def __init__(self, root):
        self.root = root
        self.root.title("3D Matrix Viewer")

        self.matrix_3d = None
        self.recipe = None
        self.slice_index = tk.IntVar(value=1)
        self.file_path = tk.StringVar(value="No file selected")
        self.recipe_path = tk.StringVar(value="Default: ./spectrumrecipe.json")
        self.wavelength_range = tk.StringVar(value="Wavelength: (N/A, N/A)")
        self.cbar = None

        self.create_widgets()
        self.try_load_default_recipe()

    def create_widgets(self):
        # 第一行：按钮和输入
        top_frame = tk.Frame(self.root)
        top_frame.pack(side=tk.TOP, fill=tk.X, padx=5, pady=5)

        tk.Button(top_frame, text="Load JSON", command=self.load_json).pack(side=tk.LEFT, padx=5)
        tk.Button(top_frame, text="Load Recipe", command=self.load_recipe).pack(side=tk.LEFT, padx=5)

        tk.Label(top_frame, text="Slice Index:").pack(side=tk.LEFT)
        self.slice_slider = tk.Scale(top_frame, from_=1, to=1, orient=tk.HORIZONTAL, variable=self.slice_index,
                                     length=100)
        self.slice_slider.pack(side=tk.LEFT)

        self.colormap = tk.StringVar(value="hot")
        tk.OptionMenu(top_frame, self.colormap, "hot", "viridis", "plasma", "gray").pack(side=tk.LEFT)

        tk.Button(top_frame, text="Show Heatmap", command=self.show_heatmap).pack(side=tk.LEFT, padx=5)

        # 新增 wavelength 输入和跳转按钮
        self.wavelength_input = tk.StringVar()
        tk.Label(top_frame, text="Wavelength:").pack(side=tk.LEFT)
        tk.Entry(top_frame, textvariable=self.wavelength_input, width=8).pack(side=tk.LEFT)
        tk.Button(top_frame, text="Go", command=self.wavelength_to_slice).pack(side=tk.LEFT, padx=3)

        # 第二行：路径和状态信息
        bottom_frame = tk.Frame(self.root)
        bottom_frame.pack(side=tk.TOP, fill=tk.X, padx=5, pady=2)

        self.file_label = tk.Label(bottom_frame, textvariable=self.file_path, fg="blue", anchor="w")
        self.file_label.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)

        self.recipe_label = tk.Label(bottom_frame, textvariable=self.recipe_path, fg="green", anchor="w")
        self.recipe_label.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)

        self.wavelength_label = tk.Label(bottom_frame, textvariable=self.wavelength_range, fg="darkgreen", anchor="w")
        self.wavelength_label.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)

        # Plot frame（保持不变）
        plot_frame = tk.Frame(self.root)
        plot_frame.pack(side=tk.TOP, fill=tk.BOTH, expand=True)

        # Heatmap
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

        # Lineplot
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
                    # Update slice scale
                    slice_count = self.matrix_3d.shape[0]
                    self.slice_index.set(1)
                    for widget in self.root.winfo_children():
                        for sub in widget.winfo_children():
                            if isinstance(sub, tk.Scale):
                                sub.config(to=slice_count)
            except Exception as e:
                messagebox.showerror("Error", f"Failed to load JSON file:\n{e}")

    def load_recipe(self):
        file_path = filedialog.askopenfilename(filetypes=[("JSON Files", "*.json")], initialfile="spectrumrecipe.json")
        if file_path:
            try:
                with open(file_path, 'r') as file:
                    self.recipe = json.load(file)
                self.recipe_path.set(f"Recipe: {file_path}")
                start = self.recipe.get("wavelength_start", "N/A")
                end = self.recipe.get("wavelength_end", "N/A")
                self.wavelength_range.set(f"Wavelength: ({start}, {end})")
            except Exception as e:
                messagebox.showerror("Error", f"Failed to load recipe:\n{e}")

    def try_load_default_recipe(self):
        default_path = "spectrumrecipe.json"
        if os.path.exists(default_path):
            try:
                with open(default_path, 'r') as f:
                    self.recipe = json.load(f)
                self.recipe_path.set(f"Recipe: {default_path}")
                start = self.recipe.get("wavelength_start", "N/A")
                end = self.recipe.get("wavelength_end", "N/A")
                self.wavelength_range.set(f"Wavelength: ({start}, {end})")
            except:
                pass

    def show_heatmap(self):
        if self.matrix_3d is None:
            messagebox.showerror("Error", "No matrix loaded.")
            return

        i = self.slice_index.get()
        if i < 1 or i > self.matrix_3d.shape[0]:
            messagebox.showerror("Error", f"Slice index out of range. Must be 1 to {self.matrix_3d.shape[0]}.")
            return

        self.fig1.clf()
        self.ax1 = self.fig1.add_subplot(111)

        vmin = np.min(self.matrix_3d)
        vmax = np.max(self.matrix_3d)

        img = self.ax1.imshow(
            self.matrix_3d[i - 1],
            cmap=self.colormap.get(),
            interpolation='nearest',
            vmin=vmin,
            vmax=vmax
        )
        self.ax1.set_title(f"2D Heatmap - Slice {i}")

        self.cbar = self.fig1.colorbar(img, ax=self.ax1, orientation='vertical', fraction=0.046, pad=0.04, shrink=0.8)
        self.cbar.set_label("Intensity")

        self.canvas1.draw()

    def on_click(self, event):
        if event.inaxes != self.ax1 or self.matrix_3d is None:
            return

        # x = int(event.xdata + 0.5)
        # y = int(event.ydata + 0.5)
        x = int(event.xdata + 0.5)
        y = int(event.ydata + 0.5)

        if 0 <= y < self.matrix_3d.shape[1] and 0 <= x < self.matrix_3d.shape[2]:
            values = self.matrix_3d[:, y, x]
            self.ax2.clear()

            if self.recipe and "wavelength_start" in self.recipe and "wavelength_end" in self.recipe:
                wl_start = float(self.recipe["wavelength_start"])
                wl_end = float(self.recipe["wavelength_end"])
                num_slices = self.matrix_3d.shape[0]
                wavelengths = np.linspace(wl_start, wl_end, num_slices)
                self.ax2.plot(wavelengths, values, marker='o')
                self.ax2.set_xlabel("Wavelength")
            else:
                self.ax2.plot(values, marker='o')
                self.ax2.set_xlabel("Slice Index")

            self.ax2.set_title(f"1D Plot at ({y}, {x})")
            self.ax2.xaxis.set_major_locator(MaxNLocator(nbins=5))
            self.ax2.set_ylabel("Value")
            self.canvas2.draw()

    def wavelength_to_slice(self):
        if self.matrix_3d is None or self.recipe is None:
            messagebox.showerror("Error", "Matrix or recipe not loaded.")
            return

        try:
            wl = float(self.wavelength_input.get())
            wl_start = float(self.recipe["wavelength_start"])
            wl_end = float(self.recipe["wavelength_end"])
            n = self.matrix_3d.shape[0]

            if not (wl_start <= wl <= wl_end):
                messagebox.showwarning("Out of range", f"Input wavelength is outside ({wl_start}, {wl_end})")
                return

            slice_idx = round((wl - wl_start) / (wl_end - wl_start) * (n - 1)) + 1
            self.slice_index.set(slice_idx)
            self.slice_slider.set(slice_idx)
            self.show_heatmap()
        except Exception as e:
            messagebox.showerror("Error", f"Invalid wavelength input:\n{e}")


if __name__ == "__main__":
    root = tk.Tk()
    app = MatrixViewerApp(root)
    root.mainloop()
