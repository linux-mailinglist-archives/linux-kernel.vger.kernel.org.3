Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2649847A4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbhLTGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:04:37 -0500
Received: from 113.196.136.146.ll.static.sparqnet.net ([113.196.136.146]:52720
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231863AbhLTGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:04:36 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(9381:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Mon, 20 Dec 2021 14:04:40 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 20 Dec 2021 14:04:39 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 20 Dec 2021 14:04:39 +0800
From:   =?big5?B?TGggS3VvILOipE+7qA==?= <lh.Kuo@sunplus.com>
To:     Mark Brown <broonie@kernel.org>, Li-hao Kuo <lhjeff911@gmail.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "andyshevchenko@gmail.com" <andyshevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v4 1/2] SPI: Add SPI driver for Sunplus SP7021
Thread-Topic: [PATCH v4 1/2] SPI: Add SPI driver for Sunplus SP7021
Thread-Index: AQHX7aQdqhfHTPMKakCCsqwpEyTHn6w2eE2AgAR4ksA=
Date:   Mon, 20 Dec 2021 06:04:39 +0000
Message-ID: <c2006b3f35ce4a2eb56d3dea534a3121@sphcmbx02.sunplus.com.tw>
References: <cover.1639123362.git.lhjeff911@gmail.com>
 <65fb77debacc95ed3f54adac978ba24f2470f92e.1639123362.git.lhjeff911@gmail.com>
 <YbzK/Xm8hONUc5w6@sirena.org.uk>
In-Reply-To: <YbzK/Xm8hONUc5w6@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTXIuIE1hcmsgQnJvd24NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4NCg0KSSB3aWxs
IGZpeCBpdCBpbiB0aGUgbmV4dCBzdWJtaXNzaW9uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KPiBTZW50OiBT
YXR1cmRheSwgRGVjZW1iZXIgMTgsIDIwMjEgMTozOCBBTQ0KPiBUbzogTGktaGFvIEt1byA8bGhq
ZWZmOTExQGdtYWlsLmNvbT4NCj4gQ2M6IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGFuZHlzaGV2
Y2hlbmtvQGdtYWlsLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBsaW51eC1zcGlAdmdlci5r
ZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgV2VsbHMgTHUgp2aq2sTLDQo+IDx3ZWxscy5sdUBzdW5wbHVzLmNvbT47IExo
IEt1byCzoqRPu6ggPGxoLkt1b0BzdW5wbHVzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NCAxLzJdIFNQSTogQWRkIFNQSSBkcml2ZXIgZm9yIFN1bnBsdXMgU1A3MDIxDQo+IA0KPiBPbiBG
cmksIERlYyAxMCwgMjAyMSBhdCAwNTowMjo0N1BNICswODAwLCBMaS1oYW8gS3VvIHdyb3RlOg0K
PiANCj4gPiArc3RhdGljIGlycXJldHVybl90IHNwNzAyMV9zcGlfc2xhX2lycShpbnQgaXJxLCB2
b2lkICpkZXYpIHsNCj4gPiArCXN0cnVjdCBzcDcwMjFfc3BpX2N0bHIgKnBzcGltID0gZGV2Ow0K
PiA+ICsJdW5zaWduZWQgaW50IGRhdGFfc3RhdHVzOw0KPiA+ICsNCj4gPiArCWRhdGFfc3RhdHVz
ID0gcmVhZGwocHNwaW0tPnNsYV9iYXNlICsgU1A3MDIxX0RBVEFfUkRZX1JFRyk7DQo+ID4gKwl3
cml0ZWwoZGF0YV9zdGF0dXMgfCBTUDcwMjFfU0xBX0NMUl9JTlQsIHBzcGltLT5zbGFfYmFzZSAr
IFNQNzAyMV9EQVRBX1JEWV9SRUcpOw0KPiA+ICsJY29tcGxldGUoJnBzcGltLT5zbGFfaXNyKTsN
Cj4gPiArCXJldHVybiBJUlFfTk9ORTsNCj4gPiArfQ0KPiANCj4gVGhpcyB3aWxsIGFsd2F5cyBy
ZXR1cm4gSVJRX05PTkUgZXZlbiBpZiB0aGUgaW50ZXJydXB0IGFjdHVhbGx5IGZpcmVkIC0gdGhh
dCBzaG91bGQgZXZlbnR1YWxseSBjYXVzZQ0KPiBnZW5pcnEgdG8gY29tcGxhaW4gdGhhdCB0aGVy
ZSdzIGEgcHJvYmxlbSB3aXRoIHRoZSBpbnRlcnJ1cHQgbmV2ZXIgYmVpbmcgaGFuZGxlZCBJIHRo
aW5rICh0aG91Z2ggcGVyaGFwcw0KPiBpZiB0aGUgaW50ZXJydXB0IHN0b3BzIGFzc2VydGluZyBp
dCdsbCBwaWNrIHVwIG9uIHRoYXQpLiAgSXQgc2hvdWxkIHJldHVybiBJUlFfSEFORExFRCBpZiB0
aGVyZSB3YXMNCj4gc29tZXRoaW5nIGFzc2VydGVkIGluIFNQNzAyMV9EQVRBX1JEWV9SRUcuDQo+
IA0KPiBBcGFydCBmcm9tIHRoYXQgb25lIHRoaW5nIHRoaXMgYWxsIGxvb2tzIGdvb2QgYXMgZmFy
IGFzIEkgY2FuIHNlZS4NCg==
