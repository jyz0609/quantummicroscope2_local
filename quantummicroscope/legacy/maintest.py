import numpy as np

import peak_analysis
import matplotlib.pyplot as plt
def main():
    # 输入参数设置
    matrix_path = "nonspeedmatrix2.txt"  # 修改为你的文件路径
    adaptive_params = {
        'adaptive_block_size': 13,
        'adaptive_C': -4,
        'min_area': 3,
        'window_size': 7
    }
    inputmatrix= np.loadtxt(matrix_path)
    # 处理矩阵

    matrix, results = peak_analysis.process_matrix_universalthresh(inputmatrix)#, **adaptive_params)

    # 打印结果
    '''print(f"发现 {len(results)} 个有效峰")
    for i, res in enumerate(results, 1):
        print(f"\n峰 {i}:")
        print(f"位置: {res['position']}")
        print(f"FWHM (x, y): {res['fwhm']}")
        print(f"最大强度: {res['intensity']:.2f}")
        print(f"区域面积: {res['area']} 像素")'''


    print(results)
    # 可视化
    peak_analysis.visualize_results(matrix, results)








if __name__ == "__main__":
    main()