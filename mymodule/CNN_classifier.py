import os
import time

import numpy as np

_MODEL_CACHE = {}


def normalized(arr=np.zeros(50), model_name="CNN_model_0905_onmeasured_len50.h5"):
    """
    Takes a 1D NumPy array as input.
    If the array length is at least 50, uses the first 50 elements for the CNN classifier.
    """
    if not isinstance(arr, np.ndarray):
        raise TypeError("Input must be a NumPy array.")

    if arr.ndim != 1:
        raise ValueError(f"Expected a 1D array, got {arr.ndim}D.")

    if arr.size < 50:
        raise ValueError(f"Array length {arr.size} is smaller than 50.")

    sub_arr = arr[:50]
    model_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), model_name)
    print(f"model path is {model_path}")

    start = time.time()
    try:
        model = _MODEL_CACHE.get(model_path)
        if model is None:
            from tensorflow.keras.models import load_model
            model = load_model(model_path)
            _MODEL_CACHE[model_path] = model
            print("model loaded:", model_path)
    except Exception as e:
        raise RuntimeError(f"failed to load the model: {e}") from e

    end = time.time()
    print(f"loading time is {end - start:.4f}second")

    X = sub_arr.reshape(-1, 50, 1)
    pred_prob = model.predict(X, verbose=0)
    return round(pred_prob.item(), 4)
