Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6890D4977AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 04:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbiAXD1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 22:27:54 -0500
Received: from mswedge1.sunplus.com ([60.248.182.113]:60700 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241038AbiAXD1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 22:27:53 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(11311:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Mon, 24 Jan 2022 11:27:51 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 24 Jan 2022 11:27:45 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 24 Jan 2022 11:27:45 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Li-hao Kuo <lhjeff911@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Thread-Topic: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Thread-Index: AQHYDEdoNQA4Z8mYU0mSuzI8gOIgg6xqY3GAgAE/t3D//4TFAIABjwHAgAAISoCABMfgEA==
Date:   Mon, 24 Jan 2022 03:27:45 +0000
Message-ID: <638055e6c4dd4f66bab98c12bd5bd74a@sphcmbx02.sunplus.com.tw>
References: <cover.1642494310.git.lhjeff911@gmail.com>
 <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
 <CAHp75VdKc3UDzaqM2G5J5+G90U6Spqyhz_vuOYKhqJ4V-uf=wg@mail.gmail.com>
 <a354d7c1dce4463ea57706dd5443fe7a@sphcmbx02.sunplus.com.tw>
 <CAHp75VcCpye1u3+PK=C3CT8fMHPSOsXTL5AhbLVy0YyGWfyfkQ@mail.gmail.com>
 <ee5838c307f84bb99ace070292167a26@sphcmbx02.sunplus.com.tw>
 <CAHp75VcmFPCC0kDxOma6gunwFRf-eXEr6+ZxQs1dt5GH2quT4Q@mail.gmail.com>
In-Reply-To: <CAHp75VcmFPCC0kDxOma6gunwFRf-eXEr6+ZxQs1dt5GH2quT4Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiA+ID4gKyAgICAgICBpZiAoeGZlci0+dHhfYnVmKQ0KPiA+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgIGRtYV91bm1hcF9zaW5nbGUoZGV2LCB4ZmVyLT50eF9kbWEsIHhmZXItPmxlbiwg
RE1BX1RPX0RFVklDRSk7DQo+ID4gPiA+ID4gPiArICAgICAgIGlmICh4ZmVyLT5yeF9idWYpDQo+
ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgZG1hX3VubWFwX3NpbmdsZShkZXYsIHhmZXItPnJ4
X2RtYSwgeGZlci0+bGVuLA0KPiA+ID4gPiA+ID4gKyBETUFfRlJPTV9ERVZJQ0UpOw0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gV2h5IGNhbid0IHlvdSB1c2UgU1BJIGNvcmUgRE1BIG1hcHBpbmcgY29k
ZT8NCj4gPiA+ID4NCj4gPiA+ID4gSSBkaWRuJ3QgZmluZCB0aGUgU1BJIGNvcmUgRE1BIG1hcHBp
bmcgY29kZSBmb3Igc2luZ2xlIG1hcGluZy4NCj4gPiA+ID4gVGhlIG1ldGhvZCBjdXJyZW50bHkg
dXNlZCBpcyB0aGUgZ2VuZXJhbCBETUEgc2luZ2xlLW1hcCBjb2RlIHVzYWdlIG1ldGhvZC4NCj4g
PiA+DQo+ID4gPiBXaHkgZG8geW91IG5lZWQgc2luZ2xlIHBhZ2UgbWFwcGluZz8NCj4gPiA+IFdo
YXQncyB3cm9uZyB3aXRoIFNHIG1hcHBpbmcgdGhhdCBTUEkgY29yZSBwcm92aWRlcz8NCj4gPg0K
PiA+IFNQNzAyMSBTUEkgc2xhdmUgZG1hIG9ubHkgc3VwcG9ydHMgc2luZ2xlIGRtYSBpbiBvbmUg
dHJpZ2dlci4NCj4gPiBJdCBpcyBub3Qgc3VpdGFibGUgZm9yIHVzaW5nIFNHIG1hcHBpbmcuDQo+
ID4gSWYgdGhlIGxlbmd0aCBvZiB0aGUgdHJhbnNmZXIgaXMgbGFyZ2VyIHRoYW4gdGhlIGxlbmd0
aCBvZiB0aGUNCj4gPiBTRy1tYXBwaW5nLCBTbGF2ZS1tb2RlIHdpbGwgZ2V0IGVycm9yIGluIHRo
ZSB0cmFuc2Zlci4NCj4gDQo+IFNhbWUgc3RvcnkgZm9yIFNQSSBEZXNpZ25XYXJlIG9uIEludGVs
IE1lZGZpZWxkLCB3aGVyZSBubyBTRyB0cmFuc2ZlcnMgYXJlIHN1cHBvcnRlZCBieSBoYXJkd2Fy
ZS4NCj4gTmV2ZXJ0aGVsZXNzLCB0aGUgRE1BIGRyaXZlciB0YWtlcyBjYXJlIG9mIHRoaXMgYW5k
IG9uIGVhY2ggaW50ZXJydXB0IHJlY2hhcmdlcyBhIGNoYW5uZWwgdG8gY29udGludWUuDQo+IFdo
eSBjYW4ndCB0aGUgc2FtZSBiZSBpbXBsZW1lbnRlZCBoZXJlPw0KPiANCj4gDQpJIHRoaW5rIGl0
IHNob3VsZCB3b3JrIGluIG1hc3Rlci4gc3BpIG1hc3RlciBtdXN0IGFjdGl2ZWx5IHNlbmQgY2xr
IGFuZCBkYXRlIHRvIHNsYXZlIGRldmljZS4NCkFuZCB5ZXMsIGluIHRoZSAibWFzdGVyIiBtb2Rl
IGl0IGNhbiBoYW5kbGUgU0ctRE1BIG9uIGVhY2ggaW50ZXJydXB0Lg0KQnV0IGlmIHdvcmtpbmcg
aW4gInNsYXZlIiBtb2RlLCB0aGUgbWFzdGVyIHdpbGwgbm90IGtub3cgdGhlIHN0YXRlIG9mIHRo
ZSBzbGF2ZS4gU2xhdmVzIHdvcmsgb24gaW50ZXJydXB0IGFuZCByZWNoYXJnZSBjaGFubmVscy4N
CldoZW4gbWFzdGVyIHNlbmQgY2xrIGFuZCBkYXRlIGluIHRoZSBzYW1lIHRpbWUuIEl0IG1heSBs
b3NlIGRhdGEgYW5kIGVycm9ycyBvY2N1cg0KDQoNCg==
