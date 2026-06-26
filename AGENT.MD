# Quantum Microscope Qt GUI Migration Summary

## 1. 历史修改概览

本项目的主要历史修改目标，是把原有集中在 Tkinter 脚本中的显微镜控制界面，逐步迁移为 Qudi-like 的 Qt 应用。当前迁移成果集中在 `quantummicroscope/` package 下，根目录旧式脚本和 legacy 文件主要保留为参考。

### modern GUI configuration

这一阶段建立了第一版 Qt GUI 基础：

- 新增 `qt_app.py` 作为 Qt 启动入口。
- 新增早期的 `gui/`、`logic/`、`hardware/` 三层结构。
- 使用 `qtpy`、`QtWidgets` 和 `pyqtgraph` 替代 Tkinter/Matplotlib 嵌入式显示。
- 把扫描参数、分析参数、g2 参数和硬件配置抽象为 dataclass。
- 增加 dummy/offline hardware，使 GUI 在没有真实 LabJack、TimeTagger 的情况下也可以启动和演示扫描。
- 增加 `PLAN.md`，记录从 Tkinter 到 Qt 的增量迁移策略。

### modern gui commitment

这一阶段增强了现代化 GUI 和逻辑连接：

- 扩展扫描界面控件，覆盖 Acquisition、Scan Range、Motion、Analysis、g2 / Calibration、Log 和 Display 等区域。
- 增加更多 GUI 按钮到 logic 方法的连接，例如文件名生成、Start Scan、Stop、Analyze、Signal Counter、Move、Center、Find Peaks、g2 Measurement、Calibration Test。
- 强化 `ScannerLogic` 的信号：日志、错误、图像、计数、状态、文件名建议、剪贴板文本等都通过 Qt signals 返回 GUI。
- 使用 `QThread + ScanWorker` 承载扫描流程，避免扫描阻塞 GUI thread。
- 用 `pyqtgraph.ImageView` 显示扫描/分析图像，通过 `setImage()` 更新现有 widget。

### structured file organization

这一阶段把早期根目录迁移结构整理为正式 package：

- 新增 `quantummicroscope/app.py` 作为主 packaged entrypoint。
- 根目录 `qt_app.py` 改为兼容入口，只委托给 `quantummicroscope.app`。
- 将 GUI、logic、hardware、analysis、interface、core、config、legacy 整理到 `quantummicroscope/` 下。
- 新增 `quantummicroscope/ARCHITECTURE.md` 和 `quantummicroscope/legacy/MIGRATION_INDEX.md`，用于说明架构和旧文件到新文件的映射。
- 将旧 Tkinter 主程序移动到 `quantummicroscope/legacy/Microscope_GUI_ver2.py`，作为迁移参考，不作为新 GUI 的依赖。
- 将原有分析工具、ETA backend、TimeTagger/LabJack 相关代码按职责迁入 `analysis/` 和 `hardware/`。

## 2. 当前 GUI 架构

当前 Qt GUI 的主路径是：

```powershell
python -m quantummicroscope.app
```

兼容启动路径是：

```powershell
python qt_app.py
```

技术栈：

- Qt binding 通过 `qtpy` 访问：`from qtpy import QtCore, QtGui, QtWidgets`。
- GUI widget 使用 `QtWidgets`。
- 实时图像显示使用 `pyqtgraph.ImageView`。
- 扫描流程通过 `QThread + ScanWorker` 执行。
- GUI 与 logic 之间通过 Qt signals/slots 通信。

分层规则：

```text
quantummicroscope/gui/        Qt widgets、布局、用户交互、显示更新、QSS
quantummicroscope/logic/      实验 workflow、状态、参数、signals、worker 调度
quantummicroscope/hardware/   LabJack、TimeTagger、scanner、dummy hardware、socket/network helper
quantummicroscope/analysis/   ETA 分析、图像处理、peak/g2/filename/CNN 工具
quantummicroscope/interface/  logic 与 hardware/analysis 之间的协议接口
quantummicroscope/core/       Qudi-like BaseModule、Connector、status
quantummicroscope/config/     module wiring 与硬件/扫描配置
quantummicroscope/legacy/     原 Tkinter 代码和旧脚本参考
```

重要约束：

- 新 GUI 代码不应直接导入 Tkinter。
- GUI 不直接执行 DAQ、TimeTagger、socket 或长时间硬件循环。
- hardware 层不创建 Qt widgets。
- 阻塞扫描、文件分析、连续采集和真实硬件 workflow 应放到 logic worker 或 hardware adapter 后面。

## 3. GUI 模块、类和函数

### `quantummicroscope/app.py`

应用主入口，负责：

- `build_parser()`：创建 CLI 参数，目前支持 `--smoke`。
- `main(argv=None)`：
  - 初始化 logging。
  - 创建 `QtWidgets.QApplication`。
  - 调用 `apply_style(app)` 应用 QSS。
  - 创建 `QuantumMicroscopeMainWindow()`。
  - `--smoke` 模式下只构造窗口并退出。
  - 正常模式下 `window.show()` 并进入 Qt event loop。

### `qt_app.py`

根目录兼容入口：

- 从 `quantummicroscope.app` 导入 `build_parser` 和 `main`。
- 直接调用 `main()`。
- 新应用代码不应继续写入此文件，除非是兼容启动逻辑。

### `quantummicroscope/gui/main_window.py`

主窗口类是 `QuantumMicroscopeMainWindow(QtWidgets.QMainWindow)`。

主要职责：

- 设置窗口标题和尺寸。
- 加载 `HardwareConfig`。
- 创建 `ScannerLogic`。
- 创建 `ScannerGui(logic, config)`。
- 构建主 UI、toolbar、dock 和 status bar。

主要函数：

- `_build_ui()`：创建 central widget、actions、toolbar、dock、status bar。
- `_build_actions()`：创建主工具栏动作：
  - `Start Scan` -> `ScannerGui._start_scan`
  - `Stop` -> `ScannerLogic.cancel_scan`
  - `Filename` -> `ScannerGui._submit_and_suggest_filename`
  - `Analyze` -> `ScannerGui._analyze`
  - `Signal Counter` -> `ScannerLogic.count_signals`
- `_build_toolbar()`：把 actions 加入 `scan_ToolBar`。
- `_build_docks()`：创建 `scanner_DockWidget`，把 `ScannerGui` 放入 dock，并加入 View menu。
- `_connect_status()`：把 `ScannerLogic.sigStatusChanged` 和 `sigLog` 连接到 status bar。

### `quantummicroscope/gui/scanner_gui.py`

这是当前主要 GUI widget，类名为 `ScannerGui(QtWidgets.QWidget)`。

主要职责：

- 创建扫描、分析、运动、g2/校准、计数、日志和图像显示控件。
- 从控件读取参数，转换为 `ScanParameters`、`AnalysisParameters`、`G2Parameters`。
- 将用户动作提交给 `ScannerLogic`。
- 通过 slots 接收 logic 发回的日志、错误、图像、计数和运行状态。

主要 UI 分区：

- `Acquisition`：info、data folder、filename、mode、dim、dwell、freq、frames、offline/dummy、diagnostics。
- `Scan Range`：amp、min/max voltage、scope length、lens slope、step size、Set 50/100、Step Set/Get。
- `Motion`：X/Y pixel、Move、Center、Copy Info、Read Voltage、Lock Center。
- `Analysis`：timeres file、ETA recipe、save folder、bins、channel。
- `g2 / Calibration`：measurement time、calibration interval、peak number、multi peak、average count，以及 g2/calibration actions。
- 底部 actions：Filename、Start Scan、Stop、Analyze、Signal Counter。
- Display：`pyqtgraph.ImageView`。
- Counts/Log：`QTableWidget` 和 `QPlainTextEdit`。

核心函数：

- `_build_ui()`：创建全部控件、布局和按钮连接。
- `_connect_logic()`：连接 logic signals：
  - `sigLog` -> `append_log`
  - `sigError` -> `show_error`
  - `sigImageUpdated` -> `update_image`
  - `sigCountsUpdated` -> `update_counts`
  - `sigSuggestedFilename` -> filename field
  - `sigCopyText` -> clipboard
  - `sigScanStarted/sigScanFinished` -> `_set_running`
- `_load_defaults()`：把 `ScannerLogic` 中的默认 dataclass 参数填入 GUI 控件。
- `_read_scan_params()`：从 GUI 控件构造 `ScanParameters`。
- `_read_analysis_params()`：从 GUI 控件构造 `AnalysisParameters`。
- `_read_g2_params()`：从 GUI 控件构造 `G2Parameters`。
- `_submit_forms()`：把三类参数和当前 pixel 坐标提交给 logic。
- `_submit_and_suggest_filename()`：提交表单后调用 `logic.suggest_filename()`。
- `_start_scan()`：提交表单后调用 `logic.start_scan()`。
- `_analyze()`：提交表单后调用 `logic.analyze_current_file()`。
- `_move_to_pixel(center=False)`：更新 pixel 坐标并调用 `logic.move_to_pixel()`。
- `_sync_derived_ranges()`：根据 amp、lens slope、dim 同步 min/max voltage、scope length 和 step size。
- `append_log(message)`：把用户可见日志追加到 `QPlainTextEdit`。
- `show_error(message)`：显示错误日志和 `QMessageBox.critical`。
- `update_image(image)`：将 numpy-like image 转为 array 后调用 `self.image_view.setImage(array.T, autoLevels=True, autoRange=True)`。
- `update_counts(counts)`：更新 1-4 channel 的 count table。
- `_set_running(running)`：扫描运行时禁用 start/analyze，启用 stop；扫描结束后恢复。

### `quantummicroscope/gui/style.py`

负责应用全局 QSS：

- `APP_QSS`：深色/中性实验仪器风格 stylesheet。
- `apply_style(app)`：
  - `app.setStyleSheet(APP_QSS)`
  - `app.setFont(QtGui.QFont("Segoe UI", 10))`

### `quantummicroscope/gui/widgets/`

当前包含若干轻量 dock shell：

- `scan_control_dock.py` -> `ScanControlDockWidget`
- `scan_display_dock.py` -> `ScanDisplayDockWidget`
- `analysis_control_dock.py` -> `AnalysisControlDockWidget`
- `g2_control_dock.py` -> `G2ControlDockWidget`
- `log_dock.py` -> `LogDockWidget`

这些类目前主要封装 `QtWidgets.QDockWidget` 标题、objectName 和 child widget。当前主窗口实际把完整 `ScannerGui` 放入一个 `scanner_DockWidget`，这些 dock shell 为后续进一步拆分 GUI 面板预留。

## 4. Logic、Worker 与 Hardware 调用链

当前主调用链：

```text
app.main()
  -> apply_style(app)
  -> QuantumMicroscopeMainWindow()
  -> ScannerGui(logic, config)
  -> ScannerGui._submit_forms()
  -> ScannerLogic.start_scan()
  -> ScanWorker.run()
  -> DummyScannerHardware.start_scan()
  -> sigImageUpdated / sigCountsUpdated / sigLog / sigError
  -> ScannerGui.update_image() / update_counts() / append_log() / show_error()
```

### `quantummicroscope/logic/models.py`

集中定义当前 GUI 和 logic 使用的参数模型：

- `HardwareConfig`
  - 从 `quantummicroscope/config/microscope_table_setup.json` 读取 `x_offset`、`y_offset`、`calibrated_lenslope`、`host`。
  - 文件不存在时使用安全默认值。
- `ScanParameters`
  - 保存 scan clue、data folder、filename、speed mode、dim、dwell、freq、frames、amp、range、scope length、lens slope、step size、offline mode 等。
  - `defaults(config)` 根据硬件配置生成默认 min/max voltage、scope length 和 step size。
  - `suggested_filename()` 保留旧 GUI 的 timeres 文件命名结构。
- `AnalysisParameters`
  - 保存 timeres data file、ETA recipe、save folder、bins、channel selection。
- `G2Parameters`
  - 保存 g2 measurement time、calibration interval、peak number、multi peak enable、average count per bin 等。

### `quantummicroscope/logic/scanner_logic.py`

`ScannerLogic(BaseModule)` 是当前主要 workflow 类。

核心职责：

- 保存 `scan_params`、`analysis_params`、`g2_params`。
- 通过 Qudi-like `Connector` 持有 `scanner` 和 `counter`。
- 默认连接 `DummyScannerHardware`，使应用可在 offline mode 下运行。
- 将 GUI 请求转成 logic 操作。
- 将状态、日志、图像、计数和错误通过 Qt signals 发回 GUI。

主要 signals：

- `sigStatusChanged(str)`
- `sigLog(str)`
- `sigError(str)`
- `sigScanStarted()`
- `sigScanFinished(str)`
- `sigImageUpdated(object)`
- `sigCountsUpdated(object)`
- `sigImageReady(object)`
- `sigCountsReady(object)`
- `sigSuggestedFilename(str)`
- `sigCopyText(str)`

核心函数：

- `update_scan_parameters(params)`：接收 GUI 表单中的 `ScanParameters`。
- `update_analysis_parameters(params)`：接收 GUI 表单中的 `AnalysisParameters`。
- `update_g2_parameters(params)`：接收 GUI 表单中的 `G2Parameters`。
- `update_current_position(x, y)`：保存当前 pixel 坐标。
- `suggest_filename()`：生成 timeres 文件名并发出 `sigSuggestedFilename`。
- `start_scan()`：
  - 防止重复启动扫描。
  - 自动补齐 filename。
  - 发出 Running 状态和 scan started signal。
  - 创建 `QThread`。
  - `scanner().configure_scan(scan_params)`。
  - 创建 `ScanWorker(scanner, counter, scan_params)` 并 move 到 thread。
  - 连接 worker 的 log/error/image/count/finished signals。
  - 启动 thread。
- `cancel_scan()`：通过 queued connection 调用 worker 的 `cancel()`。
- `move_to_pixel(x, y)`：调用 scanner backend 的 `move_to_pixel()` 并记录 voltage。
- `count_signals()`：调用 counter backend 的 `read_counts()`。
- `analyze_current_file()`：当前为 placeholder，生成一个示例 Gaussian image 并通过 image signal 显示。
- `write_single_g2_coordinate()` / `clear_g2_coordinate_file()`：调用 `analysis/g2_coordinates.py` 中的 coordinate 文件工具。
- `find_peaks()`、`run_g2_measurement_peaks()`、`run_g2_measurement_one()`、`run_calibration_test()`：当前已接入 logic 和日志，但真实硬件 workflow 仍待迁移到 worker 后执行。
- `_handle_worker_finished()`、`_handle_worker_error()`、`_cleanup_thread()`：处理 worker 生命周期。

### `quantummicroscope/logic/workers.py`

`ScanWorker(QtCore.QObject)` 用于在线程中执行扫描。

主要函数：

- `run()`：
  - 创建 `ScanCallbacks`，把 image/log/cancel callback 传给 scanner。
  - 调用 `self._scanner.start_scan(self._params, callbacks)`。
  - 扫描结束后发出最终 image 和 counts。
  - 发出 `Scan finished` 或 `Scan cancelled`。
  - 捕获异常并通过 `sigError` 返回 traceback 摘要。
- `cancel()`：
  - 设置 `_cancel_requested = True`。
  - 如果 scanner backend 有 `stop_scan()`，则调用它。

### `quantummicroscope/hardware/scanner/dummy_scanner_hardware.py`

当前默认可运行硬件 backend。

主要职责：

- `configure_scan(params)`：记录 dummy scan 配置。
- `start_scan(params, callbacks)`：转入 `run_scan()`。
- `run_scan(...)`：
  - 生成模拟二维 scan image。
  - 按 row 渐进更新 image callback。
  - 检查 cancel callback。
  - 用短 sleep 模拟 dwell time。
- `move_to_pixel(x, y, params)`：根据 scan min/max voltage 计算 pixel 对应 voltage。
- `read_counts()`：基于当前 pixel 返回 1-4 channel 的模拟 counts。

### `quantummicroscope/hardware/scanner/microscope_scanner_hardware.py`

真实 scanner adapter 的迁移目标。

当前状态：

- `move_to_pixel()` 已委托给 `LabJackT7`。
- `stop_scan()` 调用 `labjack.close()`。
- `start_scan()` 尚未完成真实 LabJack streaming scan 迁移，会抛出 `NotImplementedError`。

因此当前不能声称真实 LabJack streaming scan 已完成。实际可运行路径默认依赖 dummy/offline backend。

## 5. 文件层次

当前有效结构以 `quantummicroscope/` 为主：

```text
D:\quantummicroscope2_local
|-- AGENTS.md                         # 项目开发约束和 agent 指令，保持不动
|-- AGENT.MD                          # 本文档：历史修改与 Qt GUI 架构总结
|-- PLAN.md                           # 原始迁移计划
|-- qt_app.py                         # 兼容入口，委托给 quantummicroscope.app
|-- run_qt_gui.bat                    # Qt GUI 启动脚本
|-- requirements.txt
|-- quantummicroscope/
|   |-- app.py                        # packaged Qt application entrypoint
|   |-- ARCHITECTURE.md               # 当前架构说明
|   |-- config/
|   |   |-- module_config.yaml
|   |   |-- microscope_table_setup.json
|   |   `-- microscope_control_bluefors_scan_setup.json
|   |-- core/
|   |   |-- connector.py
|   |   |-- module.py
|   |   `-- status.py
|   |-- gui/
|   |   |-- main_window.py
|   |   |-- scanner_gui.py
|   |   |-- scanner_main_window.py
|   |   |-- style.py
|   |   `-- widgets/
|   |       |-- scan_control_dock.py
|   |       |-- scan_display_dock.py
|   |       |-- analysis_control_dock.py
|   |       |-- g2_control_dock.py
|   |       `-- log_dock.py
|   |-- logic/
|   |   |-- scanner_logic.py
|   |   |-- workers.py
|   |   |-- models.py
|   |   |-- counter_logic.py
|   |   |-- analysis_logic.py
|   |   |-- g2_logic.py
|   |   |-- calibration_logic.py
|   |   |-- save_logic.py
|   |   `-- measure_save_classify.py
|   |-- hardware/
|   |   |-- scanner/
|   |   |   |-- dummy_scanner_hardware.py
|   |   |   `-- microscope_scanner_hardware.py
|   |   |-- labjack/
|   |   |   |-- labjack_t7.py
|   |   |   `-- dummy_labjack.py
|   |   |-- timetagger/
|   |   |   |-- dummy_timetagger.py
|   |   |   |-- swabian_timetagger.py
|   |   |   |-- swabian_countrate.py
|   |   |   `-- swabian_filewriter_test.py
|   |   `-- network/
|   |       `-- qutag_socket_server.py
|   |-- interface/
|   |   |-- scanner_interface.py
|   |   |-- counter_interface.py
|   |   |-- labjack_interface.py
|   |   |-- timetagger_interface.py
|   |   `-- analysis_interface.py
|   |-- analysis/
|   |   |-- eta_analysis.py
|   |   |-- image_processing.py
|   |   |-- peak_analysis.py
|   |   |-- g2_coordinates.py
|   |   |-- filename_tools.py
|   |   |-- swabian_image_analysis.py
|   |   |-- cnn_classifier.py
|   |   |-- heatmap_viewer.py
|   |   `-- etabackend/
|   `-- legacy/
|       |-- Microscope_GUI_ver2.py
|       `-- MIGRATION_INDEX.md
```

旧的根目录 `gui/`、`logic/`、`hardware/` 曾经用于早期迁移阶段；当前正式代码路径应优先使用 `quantummicroscope/gui/`、`quantummicroscope/logic/`、`quantummicroscope/hardware/`。

特别注意：当前 GUI 主界面文件是 `quantummicroscope/gui/scanner_gui.py`，不是旧路径 `gui/scan_tab.py`。

## 6. GUI 配色与风格选择

当前 GUI 样式定义在 `quantummicroscope/gui/style.py` 的 `APP_QSS`。

整体设计目标：

- 深色/中性主题。
- 适合实验室仪器控制，不做消费级炫彩视觉效果。
- 控件间距清晰，输入框可读，按钮状态明确。
- Start 和 Stop 使用明显的功能色区分。
- 日志区域使用等宽字体，方便查看状态和错误。

主要颜色：

| 用途 | 颜色 |
| --- | --- |
| 主背景 | `#151a20` |
| 面板 / GroupBox 背景 | `#1b222b` |
| 输入框 / 日志背景 | `#10151b` |
| GroupBox 边框 | `#2b3542` |
| 输入框边框 | `#344150` |
| 普通按钮背景 | `#263241` |
| 普通按钮 hover | `#304052` |
| 普通按钮 pressed | `#1f2a36` |
| Start 按钮背景 | `#176b52` |
| Start 按钮边框 | `#22906f` |
| Stop 按钮背景 | `#8f2d34` |
| Stop 按钮边框 | `#c44852` |
| 选中文本背景 | `#2f80ed` |
| 主文字 | `#d9e2ec` / `#eef4f8` |
| 禁用文字 | `#7d8b99` |

字体：

- 全局字体：`Segoe UI`, 10 pt。
- 日志字体：`Consolas` 或 `"Courier New"`。

控件风格：

- `QGroupBox` 使用 6 px radius、轻边框和深色面板背景。
- `QLineEdit`、`QSpinBox`、`QDoubleSpinBox`、`QComboBox` 使用 4 px radius。
- `QPushButton` 使用 5 px radius。
- `QPlainTextEdit` 用于用户可见日志。
- `QScrollArea#controlsScroll` 和 `QWidget#controlsPanel` 与主背景一致，避免嵌套面板过重。

## 7. 当前迁移状态和后续注意点

已经完成：

- Qt 应用可以通过 package entrypoint 构造。
- 主窗口、工具栏、dock、ScannerGui、QSS 已建立。
- GUI 控件已基本覆盖原 Tkinter 工作流的主要入口。
- GUI 到 logic 的调用链已经建立。
- logic 到 GUI 的日志、错误、图像、计数、状态 signals 已建立。
- dummy/offline scan backend 可以产生图像和 counts。
- g2 coordinate 文件写入/清空已通过 logic 接入。
- 旧代码已经移入 `legacy/`，并建立迁移索引。

尚未完全完成：

- 真实 LabJack streaming scan 仍是迁移目标，`MicroscopeScannerHardware.start_scan()` 尚未实现。
- 真实 TimeTagger/g2 多峰测量、单峰测量、校准测试等 workflow 已有 GUI 和 logic 入口，但仍需迁入 worker-backed 硬件执行路径。
- `analyze_current_file()` 当前仍是 placeholder，只显示模拟 Gaussian image；完整 ETA 分析应继续从 `analysis/eta_analysis.py` 等模块迁入 logic/worker。
- `gui/widgets/` 中的 dock shell 已创建，但当前主 UI 仍主要集中在 `ScannerGui` 中；后续可以继续拆成更细的 dock widgets。

后续修改原则：

- 优先修改 `quantummicroscope/` 下的正式 package，不要继续扩展旧根目录结构。
- 新 GUI 功能先接入 logic，再由 logic 调用 hardware/analysis。
- 长时间运行代码必须放入 worker 或硬件 adapter，不要直接放在 GUI slot 中。
- 保留 dummy hardware，确保离线 smoke test 和 UI 开发可用。
- 不要静默改变现有 `.timeres` 文件命名、recipe 路径、coordinate 文件格式或分析输出格式。
