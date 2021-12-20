Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9239F47A612
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhLTIfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:35:20 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:39592
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229718AbhLTIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:35:19 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(4597:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 20 Dec 2021 16:35:20 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 20 Dec 2021 16:35:15 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 20 Dec 2021 16:35:15 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     gregkh <gregkh@linuxfoundation.org>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        =?utf-8?B?6buD5oe35Y6a?= <tonyhuang.sunplus@gmail.com>
Subject: RE: [PATCH v4 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v4 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX8xaG69RkrTnSM0GRURxouCuBCKw2RwtQ//+LwYCABT7skA==
Date:   Mon, 20 Dec 2021 08:35:15 +0000
Message-ID: <bdb3687ec29f4360b626822c5756443e@sphcmbx02.sunplus.com.tw>
References: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
 <c3a3b64c38807b2f344c3df500eb4c60b885eadf.1639557112.git.tonyhuang.sunplus@gmail.com>
 <YbrsbtBgUDnjZJ/o@kroah.com>
 <CAHpW4oRTcXq6k2o4cjFeHznZrR737947UPE60nWyPTRLPTR0Gw@mail.gmail.com>
 <3a2820c389444f7db99712f7cd11de30@sphcmbx02.sunplus.com.tw>
 <YbxJSxjumZ8nkOm8@kroah.com>
In-Reply-To: <YbxJSxjumZ8nkOm8@kroah.com>
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

RGVhciBncmVwa2g6DQoNCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIHNzaXplX3Qgc3BfaW9w
X3N0YXRlMV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gPiA+ICtkZXZpY2Vf
YXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpIHsNCj4gPiA+ID4gKyAgICAgc3RydWN0IHNwX2lv
cCAqaW9wID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gPiA+ICsgICAgIHNzaXplX3QgbGVu
ID0gMDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBzcF9pb3Bfc3RhbmRieV9tb2RlKGlvcCk7
DQo+ID4gPiA+ICsgICAgIG1kZWxheSgxMCk7DQo+ID4gPiA+ICsgICAgIHNwX2lvcF9zMW1vZGUo
ZGV2LCBpb3ApOw0KPiA+ID4gPiArICAgICByZXR1cm4gbGVuOw0KPiA+ID4gPiArfQ0KPiA+ID4N
Cj4gPiA+IFRoaXMgZnVuY3Rpb24gaXMgbm90IHNob3dpbmcgYW55dGhpbmcuDQo+ID4gPg0KPiA+
DQo+ID4gVGhlIHB1cnBvc2Ugb2YgdGhpcyBmdW5jdGlvbjoNCj4gPiBTUDcwMjEgaGFzIHRocmVl
IHBvd2VyIHN0YXRlczpTMCwgUzEgYW5kIFMzLg0KPiA+IFMwOkRlZmF1bHQgZG9tYWluIGlzIG9u
LiBJT1AgZG9tYWluIGlzIG9uLiBBTyBkb21haW4gaXMgb24uDQo+IA0KPiA+IFMxOkRlZmF1bHQg
ZG9tYWluIGlzIG9mZi4gSU9QIGRvbWFpbiBpcyBvbi4gQU8gZG9tYWluIGlzIG9uLg0KPiANCj4g
PiBTMzpEZWZhdWx0IGRvbWFpbiBpcyBvZmYuIElPUCBkb21haW4gaXMgb2ZmLiBBTyBkb21haW4g
aXMgb24uDQo+IA0KPiA+IFN5c3RlbSBlbnRlciBTMSBtb2RlIHdoZW4gcmVhZCBzeXNmcyBzcF9p
b3Bfc3RhdGUxLA0KPiANCj4gDQo+IFRoYXQgaXMgbm90IHdoYXQgc3lzZnMgaXMgZm9yLCBzb3Jy
eS4NCg0KSSB3aWxsIG1vZGlmeSB0aGlzIGZ1bmN0aW9uLg0KDQo+IA0KPiA+IEkgaG9wZSB0byBw
cm92aWRlIHVzZXJzIHdpdGggdGhlIGFiaWxpdHkgdG8gZW50ZXIgUzEgbW9kZSBieSB0aGVtc2Vs
dmVzLg0KPiANCj4gPiBTbyBJIGNhbm5vdCB1c2UgREVWSUNFX0FUVFIuIEkgc2hvdWxkIHVzZSBm
aWxlX29wZXJhdGlvbnMgbWV0aG9kLg0KPiANCj4gDQo+IE5vLCBwbGVhc2UgdXNlIHRoZSBub3Jt
YWwgcG93ZXIgbWFuYWdlbWVudCBjYWxsYmFja3MgZm9yIHlvdXIgZHJpdmVyIHRoYXQNCj4gYWxs
IG90aGVyIGRyaXZlcnMgdXNlIGluIHRoZSBrZXJuZWwuICBUaGVyZSBpcyBub3RoaW5nIHNwZWNp
YWwgYWJvdXQgdGhpcyBvbmUNCj4gZHJpdmVyIHRvIHdhcnJhbnQgYSB0b3RhbGx5IG5ldyB1c2Vy
L2tlcm5lbCBhcGkgZm9yIGl0Lg0KPiANCg0KT0ssIEkgdW5kZXJzdGFuZC4NCg0KVGhhbmtzDQoN
Cg==
