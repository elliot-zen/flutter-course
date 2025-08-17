package com.example.favorite_places

import com.baidu.mapapi.base.BmfMapApplication
import com.baidu.mapapi.SDKInitializer

class MainApplication : BmfMapApplication() {
    override fun onCreate() {
        super.onCreate()
        println("==> Initialize bmap done")
    }
}