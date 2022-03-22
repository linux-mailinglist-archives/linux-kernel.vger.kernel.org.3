Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297124E374D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiCVDNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbiCVDNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:13:00 -0400
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2852650464;
        Mon, 21 Mar 2022 20:11:30 -0700 (PDT)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(29435:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Tue, 22 Mar 2022 10:55:33 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Tue, 22 Mar 2022 10:55:27 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Tue, 22 Mar 2022 10:55:27 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v5 1/2] thermal: Add thermal driver for Sunplus SP7021
Thread-Topic: [PATCH v5 1/2] thermal: Add thermal driver for Sunplus SP7021
Thread-Index: AQHYOOIj2xpFGzmabEWuBVS5oWPniazBrPKAgAkQncA=
Date:   Tue, 22 Mar 2022 02:55:27 +0000
Message-ID: <4c05e7767bfe401b8c139e159855fe77@sphcmbx02.sunplus.com.tw>
References: <cover.1647399369.git.lhjeff911@gmail.com>
 <a658d7513a62e067086d8e2a73920bb892293569.1647399369.git.lhjeff911@gmail.com>
 <9b263f80-15df-efd3-2682-0adda06f5b5f@canonical.com>
In-Reply-To: <9b263f80-15df-efd3-2682-0adda06f5b5f@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAw
KTsNCj4gPiArCWlmIChJU19FUlIocmVzKSkNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgm
cGRldi0+ZGV2LCBQVFJfRVJSKHJlcyksICJyZXNvdXJjZSBnZXQNCj4gPiArZmFpbFxuIik7DQo+
ID4gKw0KPiA+ICsJc3BfZGF0YS0+cmVncyA9IGRldm1faW9yZW1hcCgmcGRldi0+ZGV2LCByZXMt
PnN0YXJ0LCByZXNvdXJjZV9zaXplKHJlcykpOw0KPiA+ICsJaWYgKElTX0VSUihzcF9kYXRhLT5y
ZWdzKSkNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCBQVFJfRVJSKHNw
X2RhdGEtPnJlZ3MpLCAibWFzX2Jhc2UNCj4gPiArZ2V0IGZhaWxcbiIpOw0KPiANCj4gVXNlIGRl
dm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpIGluc3RlYWQuDQo+DQoNCk90aGVyIGRyaXZl
cnMgbXVzdCBhbHNvIGFjY2VzcyB0aGVzZSByZWdpc3RlcnMuDQpXYXJuaW5nIHdoZW4gdXNpbmcg
ZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlDQpDYW4gSSBrZWVwIHRoZSBvcmlnaW5hbCBz
ZXR0aW5ncz8NCg0KDQo=
