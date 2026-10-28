package com.nationvk.pycodelab;

import android.app.Activity;
import android.os.Bundle;
import android.graphics.Color;
import android.webkit.JavascriptInterface;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Toast;
import com.chaquo.python.PyObject;
import com.chaquo.python.Python;
import com.chaquo.python.android.AndroidPlatform;

public class MainActivity extends Activity {
    private WebView webView;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setStatusBarColor(Color.rgb(10, 15, 30));
        getWindow().setNavigationBarColor(Color.rgb(10, 15, 30));
        getWindow().getDecorView().setSystemUiVisibility(0);

        if (!Python.isStarted()) {
            Python.start(new AndroidPlatform(this));
        }

        webView = new WebView(this);
        webView.setBackgroundColor(Color.rgb(10, 15, 30));
        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setDomStorageEnabled(true);
        webView.getSettings().setAllowFileAccess(true);
        webView.getSettings().setAllowContentAccess(false);
        webView.setWebChromeClient(new WebChromeClient());
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                // Keep navigation inside the bundled offline app.
                return !request.getUrl().toString().startsWith("file:///android_asset/");
            }
        });
        webView.addJavascriptInterface(new PythonBridge(), "PyBridge");
        setContentView(webView);
        webView.loadUrl("file:///android_asset/index.html");
    }

    public class PythonBridge {
        @JavascriptInterface
        public String run(String code, String input) {
            try {
                PyObject module = Python.getInstance().getModule("runner");
                return module.callAttr("run_code", code, input).toString();
            } catch (Exception e) {
                return "{\"stdout\":\"\",\"stderr\":\"Python runtime error: \" + " + quote(e.toString()) + ",\"ok\":false}";
            }
        }
    }

    private String quote(String value) {
        return "\"" + value.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r") + "\"";
    }

    @Override
    public void onBackPressed() {
        if (webView != null && webView.canGoBack()) {
            webView.goBack();
        } else {
            super.onBackPressed();
        }
    }
}
