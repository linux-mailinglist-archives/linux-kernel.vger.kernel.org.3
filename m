Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA59469160
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbhLFI1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:27:15 -0500
Received: from mswedge1.sunplus.com ([60.248.182.113]:48298 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239064AbhLFI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:27:14 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(5125:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 06 Dec 2021 16:23:46 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 6 Dec 2021 16:23:41 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Mon, 6 Dec 2021
 16:23:42 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX5/jPsCYr7BDcdE2zYDyk9FgNIqwgKW+AgASqFlD//8YkAIAAizsw
Date:   Mon, 6 Dec 2021 08:23:41 +0000
Message-ID: <7e53f347462143669242f9937330fbde@sphcmbx02.sunplus.com.tw>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a2XW=9ch58x7Shjd1ZeFka67sxEb5ZfJy-ZNtQe-j7xVg@mail.gmail.com>
 <9233c42fc4714122a3054a6c5bda0d3e@sphcmbx02.sunplus.com.tw>
 <CAK8P3a2AgO2R-yQsT6nkiVU0J6pXa-bMnckrShey2EUZjAq3Uw@mail.gmail.com>
In-Reply-To: <CAK8P3a2AgO2R-yQsT6nkiVU0J6pXa-bMnckrShey2EUZjAq3Uw@mail.gmail.com>
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

RGVhciBBcm5kOg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgNiwgMjAy
MSA0OjA0IFBNDQo+IFRvOiBUb255IEh1YW5nIOm7g+aHt+WOmiA8dG9ueS5odWFuZ0BzdW5wbHVz
LmNvbT4NCj4gQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBUb255IEh1YW5nDQo+
IDx0b255aHVhbmcuc3VucGx1c0BnbWFpbC5jb20+OyBEZXJlayBLaWVybmFuIDxkZXJlay5raWVy
bmFuQHhpbGlueC5jb20+Ow0KPiBEcmFnYW4gQ3ZldGljIDxkcmFnYW4uY3ZldGljQHhpbGlueC5j
b20+OyBncmVna2gNCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgTGludXggS2VybmVs
IE1haWxpbmcgTGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFJvYiBIZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBEVE1MDQo+IDxkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZz47IFdlbGxzIEx1IOWRguiKs+mosCA8d2VsbHMubHVAc3VucGx1cy5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBtaXNjOiBBZGQgaW9wIGRyaXZlciBmb3IgU3VucGx1cyBT
UDcwMjENCj4gDQo+IE9uIE1vbiwgRGVjIDYsIDIwMjEgYXQgNDo0MiBBTSBUb255IEh1YW5nIOm7
g+aHt+WOmg0KPiA8dG9ueS5odWFuZ0BzdW5wbHVzLmNvbT4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyIDIvMl0gbWlzYzogQWRkIGlvcCBkcml2ZXIgZm9yIFN1bnBsdXMgU1A3
MDIxDQo+ID4gPiBPbiBGcmksIERlYyAzLCAyMDIxIGF0IDQ6NDggQU0gVG9ueSBIdWFuZw0KPiA8
dG9ueWh1YW5nLnN1bnBsdXNAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgc3BfaW9wX2ZvcHMgPSB7DQo+ID4g
PiA+ICsgICAgICAgLm93bmVyICAgICAgICAgICAgICAgICAgPSBUSElTX01PRFVMRSwNCj4gPiA+
ID4gKyAgICAgICAub3BlbiAgICAgICAgICAgICAgICAgICA9IHNwX2lvcF9vcGVuLA0KPiA+ID4g
PiArICAgICAgIC5yZWFkICAgICAgICAgICAgICAgICAgID0gc3BfaW9wX3JlYWQsDQo+ID4gPiA+
ICsgICAgICAgLndyaXRlICAgICAgICAgICAgICAgICAgPSBzcF9pb3Bfd3JpdGUsDQo+ID4gPiA+
ICsgICAgICAgLnJlbGVhc2UgICAgICAgICAgICAgICAgPSBzcF9pb3BfcmVsZWFzZSwNCj4gPiA+
ID4gK307DQo+ID4gPg0KPiA+ID4gVGhpcyBkb2VzIG5vdGhpbmcgYmVjYXVzZSBhbGwgdGhlIGNh
bGxiYWNrcyBhcmUgZW1wdHkuIFlvdSByZW1vdmVkDQo+ID4gPiB0aGUgaW5hcHByb3ByaWF0ZSB1
c2VyIHNwYWNlIGludGVyZmFjZXMgYXMgSSBhc2tlZCB5b3UgdG8sIGJ1dCBpZg0KPiA+ID4gdGhl
cmUgaXMgbm8gd2F5IGZvciBlaXRoZXIga2VybmVsIG9yIHVzZXIgc3BhY2UgdG8gaW50ZXJhY3Qg
d2l0aCB0aGUNCj4gPiA+IGhhcmR3YXJlLCBJIGRvbid0IHNlZSBhIHBvaW50IGluIG1lcmdpbmcg
dGhlIGRyaXZlciB1bnRpbCB5b3UgYWRkIGEgbmV3DQo+IGludGVyZmFjZSB0aGF0IGlzIHVzYWJs
ZS4NCj4gPiA+DQo+ID4NCj4gPiBJIHdpbGwgbW9kaWZ5IHNwX2lvcF9yZWFkKCkgdG8gbW9uaXRv
ciBJT1AgbWFpbGJveCBkYXRhLg0KPiANCj4gV2h5IGlzIHRoaXMgYSB1c2VmdWwgaW50ZXJmYWNl
IHRvIGhhdmU/IElmIHRoaXMgaXMgb25seSBmb3IgZGVidWdnaW5nLCBhIHRyYWNlcG9pbnQNCj4g
bWF5IGJlIG1vcmUgdXNlZnVsIHRoYW4gYSBmdWxsIGNoYXJhY3RlciBkZXZpY2UuDQo+IA0KDQpZ
ZXMsIGl0IGlzIGZvciBkZWJ1Z2dpbmcuDQoNCj4gPiA+IFNvbWV0aGluZyBsb29rcyB3cm9uZyBo
ZXJlLCBtYXliZSByZXJlYWQgdGhlIGRvY3VtZW50YXRpb24gZm9yDQo+ID4gPiBydW50aW1lIHBv
d2VyIG1hbmFnZW1lbnQgdG8gZmluZCBhIHdheSBvZiBwdXR0aW5nIHRoZSBkZXZpY2UgaW50bw0K
PiA+ID4gbG93LXBvd2VyIG1vZGUgd2hlbiBpdCBpcyB1bnVzZWQuDQo+ID4gPg0KPiA+DQo+ID4g
V2hlbiB0aGUgcG93ZXJvZmYgY29tbWFuZCBpcyBleGVjdXRlZCwgdGhlIHJ1bg0KPiA+IHNwX2lv
cF9wbGF0Zm9ybV9kcml2ZXJfcG93ZXJvZmYodm9pZCkNCj4gPiBmdW5jdGlvbiB3aWxsIGVudGVy
IHRoZSBzdGFuZGJ5IG1vZGUuIFRoZSBwb3dlciBvZmYgd2lsbCBiZSBleGVjdXRlZC4NCj4gPiBJ
biB0aGUgc3lzdGVtLCBJT1AgY2FuIGNvbnRpbnVlIHRvIHdvcmsgd2hlbiBvdGhlciBtb2R1bGVz
IGluIHRoZQ0KPiA+IHN5c3RlbSBlbnRlciBzdGFuZGJ5IC8gcG93ZXIgZG93biBtb2RlcyB0byBt
b25pdG9yIHdoZXRoZXIgdGhlIHN5c3RlbQ0KPiB3YWtlcyB1cCB0aHJvdWdoIFJUQy4NCj4gDQo+
IE9rLCBpbiB0aGF0IGNhc2UgeW91IGNhbiBwcm9iYWJseSBqdXN0IHJlbW92ZSB0aGUgZW1wdHkg
Y2FsbGJhY2sgZnVuY3Rpb25zLg0KPiANCj4gICAgICAgICAgQXJuZA0K
