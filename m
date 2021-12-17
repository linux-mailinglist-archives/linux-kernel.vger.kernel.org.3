Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB54785FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhLQIKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:10:43 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:42970
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232474AbhLQIKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:10:42 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(7094:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Fri, 17 Dec 2021 16:10:50 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 17 Dec 2021 16:10:45 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 17 Dec 2021 16:10:45 +0800
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
Thread-Index: AQHX8xaG69RkrTnSM0GRURxouCuBCKw2RwtQ
Date:   Fri, 17 Dec 2021 08:10:45 +0000
Message-ID: <3a2820c389444f7db99712f7cd11de30@sphcmbx02.sunplus.com.tw>
References: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
 <c3a3b64c38807b2f344c3df500eb4c60b885eadf.1639557112.git.tonyhuang.sunplus@gmail.com>
 <YbrsbtBgUDnjZJ/o@kroah.com>
 <CAHpW4oRTcXq6k2o4cjFeHznZrR737947UPE60nWyPTRLPTR0Gw@mail.gmail.com>
In-Reply-To: <CAHpW4oRTcXq6k2o4cjFeHznZrR737947UPE60nWyPTRLPTR0Gw@mail.gmail.com>
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

RGVhciBHcmVna2g6DQoNCj4gPiArDQo+ID4gK3N0YXRpYyBzc2l6ZV90IHNwX2lvcF9zdGF0ZTFf
c2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0KPiA+ICtkZXZpY2VfYXR0cmlidXRlICph
dHRyLCBjaGFyICpidWYpIHsNCj4gPiArICAgICBzdHJ1Y3Qgc3BfaW9wICppb3AgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCj4gPiArICAgICBzc2l6ZV90IGxlbiA9IDA7DQo+ID4gKw0KPiA+ICsg
ICAgIHNwX2lvcF9zdGFuZGJ5X21vZGUoaW9wKTsNCj4gPiArICAgICBtZGVsYXkoMTApOw0KPiA+
ICsgICAgIHNwX2lvcF9zMW1vZGUoZGV2LCBpb3ApOw0KPiA+ICsgICAgIHJldHVybiBsZW47DQo+
ID4gK30NCj4gDQo+IFRoaXMgZnVuY3Rpb24gaXMgbm90IHNob3dpbmcgYW55dGhpbmcuDQo+IA0K
CQkJCQkJCQ0KVGhlIHB1cnBvc2Ugb2YgdGhpcyBmdW5jdGlvbjoJCQkJCQkJDQpTUDcwMjEgaGFz
IHRocmVlIHBvd2VyIHN0YXRlczpTMCwgUzEgYW5kIFMzLgkJCQkJCQkNClMwOkRlZmF1bHQgZG9t
YWluIGlzIG9uLiBJT1AgZG9tYWluIGlzIG9uLiBBTyBkb21haW4gaXMgb24uCQkJCQkJCQ0KUzE6
RGVmYXVsdCBkb21haW4gaXMgb2ZmLiBJT1AgZG9tYWluIGlzIG9uLiBBTyBkb21haW4gaXMgb24u
CQkJCQkJCQ0KUzM6RGVmYXVsdCBkb21haW4gaXMgb2ZmLiBJT1AgZG9tYWluIGlzIG9mZi4gQU8g
ZG9tYWluIGlzIG9uLgkJCQkJCQkNClN5c3RlbSBlbnRlciBTMSBtb2RlIHdoZW4gcmVhZCBzeXNm
cyBzcF9pb3Bfc3RhdGUxLAkJCQkJCQkNCgkJCQkJCQkNCkkgaG9wZSB0byBwcm92aWRlIHVzZXJz
IHdpdGggdGhlIGFiaWxpdHkgdG8gZW50ZXIgUzEgbW9kZSBieSB0aGVtc2VsdmVzLgkJCQkJCQkN
ClNvIEkgY2Fubm90IHVzZSBERVZJQ0VfQVRUUi4gSSBzaG91bGQgdXNlIGZpbGVfb3BlcmF0aW9u
cyBtZXRob2QuCQkJCQkJCQ0KDQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCBzcF9pb3Bfc3Rh
dGUxX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+IGRldmljZV9hdHRyaWJ1dGUg
KmF0dHIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAq
YnVmLCBzaXplX3QgY291bnQpIHsNCj4gPiArICAgICBzc2l6ZV90IGxlbiA9IDA7DQo+ID4gKw0K
PiA+ICsgICAgIHJldHVybiBsZW47DQo+ID4gK30NCj4gDQo+IFdoeSBkbyB5b3UgaGF2ZSBhbiBl
bXB0eSBzdG9yZSBmdW5jdGlvbj8NCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCBzcF9p
b3BfbW9kZV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gK2RldmljZV9hdHRy
aWJ1dGUgKmF0dHIsIGNoYXIgKmJ1Zikgew0KPiA+ICsgICAgIHN0cnVjdCBzcF9pb3AgKmlvcCA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsgICAgIHNzaXplX3QgbGVuID0gMDsNCj4gPiAr
DQo+ID4gKyAgICAgaWYgKGlvcC0+bW9kZSA9PSAwKQ0KPiA+ICsgICAgICAgICAgICAgZGV2X2lu
Zm8oZGV2LCAiaW9wX25vcm1hbF9tb2RlXG4iKTsNCj4gPiArICAgICBlbHNlIGlmIChpb3AtPm1v
ZGUgPT0gMSkNCj4gPiArICAgICAgICAgICAgIGRldl9pbmZvKGRldiwgImlvcF9zdGFuZGJ5X21v
ZGVcbiIpOw0KPiA+ICsgICAgIHJldHVybiBsZW47DQo+ID4gK30NCj4gDQo+IEFnYWluLCB0aGlz
IGlzIG5vdCByZXR1cm5pbmcgYW55dGhpbmcgaW4gc3lzZnMuDQo+IA0KPiBIb3cgd2FzIHRoaXMg
dGVzdGVkPz8/DQo+IA0KDQpJIHR5cGUgImVjaG8gMCA+IG1vZGUiLiBEZXZpY2UgZHJpdmVyIHdp
bGwgbG9hZCBub3JtYWwgLmJpbiBmb3IgODA1MSBpbiBzcF9pb3BfbW9kZV9zdG9yZSgpLgkJCQkJ
CQkJDQpJIHR5cGUgImVjaG8gMSA+IG1vZGUiLiBEZXZpY2UgZHJpdmVyIHdpbGwgbG9hZCBzdGFu
ZGJ5LmJpbiBmb3IgODA1MSBpbiBzcF9pb3BfbW9kZV9zdG9yZSgpLgkJCQkJCQkJDQpJIHR5cGUg
ImNhdCBtb2RlIi4gSSBjYW4ga25vdyB3aGV0aGVyIHRoZSBjdXJyZW50IGJpbiBjb2RlIGlzIG5v
cm1hbCBvciBzdGFuZGJ5IGluIDgwNTEuCQkJCQkJCQkNCgkJCQkJCQkJDQpJIGhvcGUgdG8gcHJv
dmlkZSB1c2VycyB3aXRoIHRoZSBhYmlsaXR5IHRvIHN3aXRjaCBiaW4gZmlsZXMgYnkgdGhlbXNl
bHZlcy4JCQkJCQkJCQ0KU28gSSBuZWVkIHRvIHVzZSBmaWxlX29wZXJhdGlvbnMgdG8gYWNoaWV2
ZSBteSBnb2FsLgkJCQkJCQkJDQpOb3QgdXNpbmcgREVWSUNFX0FUVFIuCVJpZ2h0PwkJCQkJCQkJ
DQoNCg0KPiA+ICtzdGF0aWMgc3NpemVfdCBzcF9pb3BfbW9kZV9zdG9yZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlDQo+ICphdHRyLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkgew0KPiA+
ICsgICAgIHN0cnVjdCBzcF9pb3AgKmlvcCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsg
ICAgIHVuc2lnbmVkIGNoYXIgcmV0ID0gY291bnQ7DQo+ID4gKw0KPiA+ICsgICAgIGlmIChidWZb
MF0gPT0gJzAnKSB7DQo+ID4gKyAgICAgICAgICAgICBzcF9pb3Bfbm9ybWFsX21vZGUoaW9wKTsN
Cj4gPiArICAgICAgICAgICAgIGRldl9pbmZvKGRldiwgIlN3aXRjaCB0byBub3JtYWwgbW9kZS5c
biIpOw0KPiA+ICsgICAgIH0gZWxzZSBpZiAoYnVmWzBdID09ICcxJykgew0KPiA+ICsgICAgICAg
ICAgICAgc3BfaW9wX3N0YW5kYnlfbW9kZShpb3ApOw0KPiA+ICsgICAgICAgICAgICAgZGV2X2lu
Zm8oZGV2LCAiU3dpdGNoIHRvIHN0YW5kYnkgbW9kZS5cbiIpOw0KPiA+ICsgICAgIH0gZWxzZSB7
DQo+ID4gKyAgICAgICAgICAgICBkZXZfaW5mbyhkZXYsICJlY2hvIDAgb3IgMSBtb2RlXG4iKTsN
Cj4gPiArICAgICAgICAgICAgIGRldl9pbmZvKGRldiwgIjA6bm9ybWFsIG1vZGVcbiIpOw0KPiA+
ICsgICAgICAgICAgICAgZGV2X2luZm8oZGV2LCAiMTpzdGFuZGJ5IG1vZGVcbiIpOw0KPiA+ICsg
ICAgIH0NCj4gPiArICAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+IA0KPiBkZXZfaW5mbygpIGlz
IE5PVCBmb3Igc3R1ZmYgbGlrZSB0aGlzIGF0IGFsbC4gIFlvdSBkbyBub3QgZGlzcGxheSBhICJo
ZWxwIiBmaWxlIG9yDQo+IGFueXRoaW5nIGVsc2UgbGlrZSB0aGF0IGluIHRoaXMgd2F5Lg0KPiAN
Cj4gUGxlYXNlIHVzZSBzeXNmcyBjb3JyZWN0bHkuDQo+IA0KPiBBbHNvLCB0aGVyZSBpcyBhIGZ1
bmN0aW9uIHRvIHJlYWQgMS8wIGZyb20gc3lzZnMsIHBsZWFzZSB1c2UgdGhhdC4NCj4gDQo=
