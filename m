Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1B469A75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347054AbhLFPIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:08:01 -0500
Received: from mswedge1.sunplus.com ([60.248.182.113]:37026 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346248AbhLFPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:06:12 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(5126:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 06 Dec 2021 23:02:38 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 6 Dec 2021 23:02:39 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Mon, 6 Dec 2021
 23:02:39 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX5/jPsCYr7BDcdE2zYDyk9FgNIqwgDd6AgATJzeD//7FbgIAAnEbw
Date:   Mon, 6 Dec 2021 15:02:38 +0000
Message-ID: <b16c466e2ce04687a5f0634c5294d226@sphcmbx02.sunplus.com.tw>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
 <Yanzu7/J75n/OCUY@kroah.com>
 <4bd765590e3e4a5da2cf79be921bac5b@sphcmbx02.sunplus.com.tw>
 <Ya22CT1pRO6NCYrC@kroah.com>
In-Reply-To: <Ya22CT1pRO6NCYrC@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBHcmVnIEtIOg0KDQo+ID4gPiBBbHNvLCBubyBuZWVkIGZvciBhIC5oIGZpbGUgZm9yIGEg
ZHJpdmVyIHRoYXQgb25seSBoYXMgb25lIC5jIGZpbGUuDQo+ID4gPg0KPiA+DQo+ID4gSSBuZWVk
IHRvIGtlZXAgc3VuZ2x1c19pb3AuaC4gT3RoZXIgZmlsZXMgd2lsbCB1c2UNCj4gPiBzcF9pb3Bf
cGxhdGZvcm1fZHJpdmVyX3Bvd2Vyb2ZmKHZvaWQpIGluIHBvd2Vyb2ZmIGZsb3cuDQo+IA0KPiBX
aGF0IG90aGVyIGZpbGVzPyAgVGhhdCBpcyBub3QgaW5jbHVkZWQgaGVyZSwgbm9yIHNob3VsZCBv
dGhlciBkcml2ZXJzIGJlDQo+IG1ha2luZyB0aGF0IGNhbGwsIHVzZSB0aGUgbm9ybWFsIHBvd2Vy
b2ZmIGxvZ2ljLg0KPiANCg0KT2theSwgSSB3aWxsIGNhbGwgdGhlIHNwX2lvcF9wbGF0Zm9ybV9k
cml2ZXJfcG93ZXJvZmYodm9pZCkgdGhyb3VnaCBub3JtYWwgcG93ZXJvZmYgbG9naWMuDQoNCg==
