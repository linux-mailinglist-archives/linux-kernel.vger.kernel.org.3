Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86AB479AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhLRMxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:53:17 -0500
Received: from 113.196.136.146.ll.static.sparqnet.net ([113.196.136.146]:51350
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231748AbhLRMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:53:16 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(9379:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Sat, 18 Dec 2021 20:53:10 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Sat, 18 Dec 2021 20:53:09 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Sat, 18 Dec 2021 20:53:09 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     gregkh <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX7Nr0VlQujKq+xkKIOnlLCZbqnqwpZLYAgA1h0BD//4/vAIABgUbA
Date:   Sat, 18 Dec 2021 12:53:08 +0000
Message-ID: <6257a7c929064569aa46826d1bba9a2f@sphcmbx02.sunplus.com.tw>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
 <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a2UGr6ZbHk6G=wh5XG_EGdJxGf6SfyN1sTb4aaUgiK8Lw@mail.gmail.com>
 <5c01390c485a44b6913dcb42e3677ed1@sphcmbx02.sunplus.com.tw>
 <YbytSBN+4M2JKAuJ@kroah.com>
In-Reply-To: <YbytSBN+4M2JKAuJ@kroah.com>
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

RGVhciBncmVna2gsIGFybmQ6DQoNCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBJT1Ag
KElPIFByb2Nlc3NvcikgZW1iZWRkZWQgaW5zaWRlIFNQNzAyMSB3aGljaCBpcyB1c2VkIGFzDQo+
ID4gPiA+IFByb2Nlc3NvciBmb3IgSS9PIGNvbnRyb2wsIFJUQyB3YWtlLXVwIGFuZCBjb29wZXJh
dGlvbiB3aXRoIENQVSAmDQo+ID4gPiA+IFBNQyBpbiBwb3dlciBtYW5hZ2VtZW50IHB1cnBvc2Uu
DQo+ID4gPiA+IFRoZSBJT1AgY29yZSBpcyBEUTgwNTEsIHNvIGFsc28gbmFtZWQgSU9QODA1MSwg
aXQgc3VwcG9ydHMNCj4gPiA+ID4gZGVkaWNhdGVkIEpUQUcgZGVidWcgcGlucyB3aGljaCBzaGFy
ZSB3aXRoIFNQNzAyMS4NCj4gPiA+ID4gSW4gc3RhbmRieSBtb2RlIG9wZXJhdGlvbiwgdGhlIHBv
d2VyIHNwZWMgcmVhY2ggNDAwdUEuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRv
bnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGFu
a3MgZm9yIHRoZSBpbXByb3ZlbWVudHMsIHRoaXMgYWdhaW4gbG9va3MgYmV0dGVyIHRoYW4gdGhl
IHByZXZpb3VzDQo+IHZlcnNpb24uDQo+ID4gPiBJIHN0aWxsIGhhdmUgc29tZSBtaW5vciBjb21t
ZW50cywgYW5kIHRoZXJlIGFyZSBhIGNvdXBsZSBvZiBkZXRhaWxzDQo+ID4gPiBJIGhhdmUgY29t
bWVudGVkIG9uIGJlZm9yZSB0aGF0IHdvdWxkIG5lZWQgdG8gYmUgYWRkcmVzc2VkLCBidXQNCj4g
PiA+IGxldCdzIGZvY3VzIG9uIHRoZSBvbmUgbWFpbiBpc3N1ZSBmb3Igbm93Og0KPiA+ID4NCj4g
PiA+IFRoZSBkcml2ZXIgc3RpbGwgZG9lc24ndCBhY3R1YWxseSAvZG8vIGFueXRoaW5nOiB5b3Ug
bG9hZCB0aGUNCj4gPiA+IGZpcm13YXJlIHdoZW4gdGhlIGRyaXZlciBpcyBsb2FkZWQsIGFuZCB5
b3Ugc2h1dCBpdCBkb3duIHdoZW4gdGhlDQo+ID4gPiBkcml2ZXIgaXMgcmVtb3ZlZCwgYnV0IG90
aGVyd2lzZSB0aGVyZSBpcyBubyB3YXkgdG8gaW50ZXJhY3Qgd2l0aA0KPiA+ID4gdGhlIGlvcC4g
WW91IGhhZCB0aGUgbWlzY2RldmljZSBlYXJsaWVyLCBhbmQgeW91IHN0aWxsIHJlZ2lzdGVyDQo+
ID4gPiB0aGF0LCBidXQgdGhlcmUgYXJlIG5vIGZpbGVfb3BlcmF0aW9ucyBhc3NvY2lhdGVkIHdp
dGggaXQsIHNvIGl0IHN0aWxsIGRvZXNuJ3QNCj4gaGF2ZSBhbnkgZWZmZWN0Lg0KPiA+ID4NCj4g
PiA+IEluIHRoZSBvcmlnaW5hbCB2ZXJzaW9uIHlvdSBoYWQgYSBjb3VwbGUgb2YgdXNlci1zaWRl
IGludGVyZmFjZXMsDQo+ID4gPiBmb3Igd2hpY2ggR3JlZyBhbmQgSSBjb21tZW50ZWQgdGhhdCB0
aGV5IHdlcmUgbm90IHVzaW5nIHRoZSBjb3JyZWN0DQo+ID4gPiBhYnN0cmFjdGlvbnMsIGFuZCB5
b3Ugc3RpbGwgbGlzdCB0aGVtIGluIHRoZSBjaGFuZ2Vsb2cgdGV4dCBhcyAiSS9PDQo+ID4gPiBj
b250cm9sLCBSVEMgd2FrZS11cCBhbmQgY29vcGVyYXRpb24gd2l0aCBDUFUgJiBQTUMgaW4gcG93
ZXINCj4gbWFuYWdlbWVudCIuDQo+ID4gPg0KPiA+ID4gSWYgeW91IHdhbnQgdG8gbWFrZSBhbnkg
cHJvZ3Jlc3Mgd2l0aCBhZGRpbmcgdGhlIGRyaXZlciwgSSdkIHNheSB5b3UNCj4gPiA+IHNob3Vs
ZCBpbXBsZW1lbnQgYXQgbGVhc3QgdHdvIG9mIHRob3NlIGhpZ2gtbGV2ZWwgaW50ZXJmYWNlcyB0
aGF0DQo+ID4gPiBpbnRlcmFjdCB3aXRoIHRoZSByZXNwZWN0aXZlIGtlcm5lbCBzdWJzeXN0ZW1z
IGluIG9yZGVyIHRvIHNob3cgdGhhdCB0aGUNCj4gYWJzdHJhY3Rpb24gd29ya3MuDQo+ID4gPg0K
PiA+DQo+ID4gUToid2l0aCByZXNwZWN0aXZlIGtlcm5lbCBzdWJzeXN0ZW1zIGluIG9yZGVyIHRv
IHNob3cgdGhhdCB0aGUgYWJzdHJhY3Rpb24NCj4gd29ya3MuIg0KPiA+IE1heSBJIGFzayB5b3Ug
YWJvdXQgcmVwZWN0aXZlIGtlcm5lbCBzdWJzeXN0ZW0uDQo+ID4gSWYgSSB1c2UgdGhlIGZpbGVf
b3BlcmF0aW9uIG1ldGhvZA0KPiA+IFByb3ZpZGUgdXNlciBjYW4gcmVhZCBhbmQgd3JpdGUgSU9Q
KDgwNTEpJ3MgcmVnaXN0ZXIuDQo+ID4gSXMgdGhpcyBhIHJlcGVjdGl2ZSBrZXJuZWwgc3Vic3lz
dGVtPw0KPiA+IGlmIG5vdA0KPiA+IFRoZXJlIGFyZSBvdGhlciBkcml2ZXIgY29kZSBjYW4gZ2l2
ZSBtZSByZWZlcmVuY2UNCj4gPg0KPiANCj4gSSBzdGlsbCBkbyBub3QgdW5kZXJzdGFuZCB3aGF0
IHRoZSBnb2FsIG9mIHRoaXMgZHJpdmVyIGlzLg0KPiANCg0KV2hlbiB0aGUgcG93ZXJvZmYgY29t
bWFuZCBpcyBleGVjdXRlZC4NCjEuVGhlIDgwNTEgaGFzIGEgcmVnaXN0ZXIgdG8gY29udHJvbCB0
aGUgcG93ZXItb24gYW5kIHBvd2VyLW9mZiBvZiB0aGUgc3lzdGVtKExpbnV4IGtlcm5lbCkuDQog
SWYgeW91IHR1cm4gb2ZmIHRoZSBwb3dlciB0aHJvdWdoIHRoZSA4MDUxIHJlZ2lzdGVyKERFRl9Q
V1JfRU5fMD0wKSwNCiBUaGUgY3VycmVudCBtZWFzdXJlZCBieSB0aGUgY2lyY3VpdCBib2FyZCBp
cyAwLjRtQSBvbmx5LiBJbiBvcmRlciB0byBzYXZlIHBvd2VyLg0KMi5UaGUgcG93ZXIgaXMgbm90
IHR1cm5lZCBvZmYgdGhyb3VnaCB0aGUgODA1MSByZWdpc3Rlci4NCiBUaGUgY3VycmVudCBtZWFz
dXJlZCBvbiB0aGUgY2lyY3VpdCBib2FyZCBpcyAzM21BDQozLldoZW4gdGhlIHN5c3RlbSBsaW51
eCBrZXJlbmwgaXMgcG93ZXJlZCBvZmYuIC9kcml2ZXIvcnRjLCAvZHJpdmVyL2dwaW8gY2Fubm90
IG9wZXJhdGUuDQogIDgwNTEgaXMgc3RpbGwgYWxpdmUgYW5kIG9wZXJhdGlvbmFsDQogIDgwNTEg
aGFzIFJUQyByZWdpc3Rlci4gV2hlbiB0aGUgdGltZSBpcyB1cCwgODA1MSBwb3dlcnMgb24gdGhl
IHN5c3RlbQ0KICBUaGUgODA1MSBjYW4gZGV0ZWN0IEdQSU8wfjcgcGlucywgYW5kIEdQSU8gcGlu
IGhpZ2gvbG93IGNhbiBiZSB1c2VkIGFzIGEgcG93ZXItb24ganVkZ21lbnQgbWVjaGFuaXNtIGZv
ciB0aGUgc3lzdGVtLg0KDQo+IFdoYXQgaXMgdGhlIHByb2JsZW0gdGhhdCB5b3UgYXJlIG5lZWRp
bmcgdG8gc29sdmU/ICBXaGF0IG5lZWRzIHRvIGFjY2Vzcw0KPiB0aGlzIGhhcmR3YXJlLCBhbmQg
d2hhdCBleGFjdGx5IHdhcyB0aGlzIGhhcmR3YXJlIGRlc2lnbmVkIHRvIGRvPw0KPiANCg0KZm9y
IGV4YW1wbGU6CQ0KU1A3MDIxIDgwNTEgaGFzIHRocmVlIHBvd2VyIHN0YXRlczpTMCwgUzEgYW5k
IFMzLgkNClMwOkRlZmF1bHQgZG9tYWluKGxpbnV4IGtlcm5lbCkgaXMgb24uIElPUCBkb21haW4g
b2YgODA1MSBpcyBvbi4gQU8gZG9tYWluIG9mIDgwNTEgaXMgb24uCQ0KUzE6RGVmYXVsdCBkb21h
aW4obGludXgga2VybmVsKSBpcyBvZmYuIElPUCBkb21haW4gb2YgODA1MSBpcyBvbi4gQU8gZG9t
YWluIG9mIDgwNTEgaXMgb24uCQ0KUzM6RGVmYXVsdCBkb21haW4obGludXgga2VybmVsKSBpcyBv
ZmYuIElPUCBkb21haW4gb2YgODA1MSBpcyBvZmYuIEFPIGRvbWFpbiBvZiA4MDUxIGlzIG9uLgkN
ClRoZSB1c2VyIGNhbiB1c2UgdGhlIDEyYnl0ZXMgbWFpbGJveCByZWdpc3RlciB0byBub3RpZnkg
ODA1MS44MDUxIG5lZWRzIHRvIHR1cm4gb2ZmIHdoaWNoIGRvbWFpbi4JDQpJIG5lZWQgY3VzdG9t
IG1pc2NkZXZpY2UuDQpVc2VyPC0tLT5taXNjL3N1bnBsdXNfaW9wPC0tLT5IYXJkd2FyZSg4MDUx
KQ0K
