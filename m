Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3581246E4A1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhLIIzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:55:11 -0500
Received: from [106.84.20.49] ([106.84.20.49]:9167 "EHLO test.cqplus1.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232177AbhLIIzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:55:10 -0500
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by cqmailgates with MailGates ESMTP Server V5.0(8764:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 09 Dec 2021 16:49:59 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 16:49:55 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Thu, 9 Dec 2021 16:49:55 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v5 09/10] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
Thread-Topic: [PATCH v5 09/10] ARM: sunplus: Add initial support for Sunplus
 SP7021 SoC
Thread-Index: AQHX6BmLzMMFC/bfnUOF4rJ/hd0nkqwgNNgAgAZiSeD//6d5gIADTshg
Date:   Thu, 9 Dec 2021 08:49:55 +0000
Message-ID: <6a8271f5c6b74ce7874b7583b8d7eee4@cqplus1.com>
References: <cover.1638515726.git.qinjian@cqplus1.com>
 <eabfe1b84b889e4aa95e24c30a114c68ef95fd07.1638515726.git.qinjian@cqplus1.com>
 <CAK8P3a1_coAnp8P3L2UA+smxuRL9widFQv9Y5ZZ0X_Sr9zsZtg@mail.gmail.com>
 <88f8cc0b1334467aae7a5a4b0643176a@cqplus1.com>
 <CAK8P3a1-4XnrkWc_0SPns9xj9Yp4xWhEahLOkeafXmAYWfbYJA@mail.gmail.com>
In-Reply-To: <CAK8P3a1-4XnrkWc_0SPns9xj9Yp4xWhEahLOkeafXmAYWfbYJA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIERlYyA3LCAyMDIxIGF0IDg6MjEgQU0gcWluamlhblvopoPlgaVdIDxxaW5qaWFu
QGNxcGx1czEuY29tPiB3cm90ZToNCj4gPiA+ID4gQEAgLTE1Miw2ICsxNTIsNyBAQCB0ZXh0b2Zz
LSQoQ09ORklHX0FSQ0hfTVNNOFg2MCkgOj0gMHgwMDIwODAwMA0KPiA+ID4gPiAgdGV4dG9mcy0k
KENPTkZJR19BUkNIX01TTTg5NjApIDo9IDB4MDAyMDgwMDANCj4gPiA+ID4gIHRleHRvZnMtJChD
T05GSUdfQVJDSF9NRVNPTikgOj0gMHgwMDIwODAwMA0KPiA+ID4gPiAgdGV4dG9mcy0kKENPTkZJ
R19BUkNIX0FYWElBKSA6PSAweDAwMzA4MDAwDQo+ID4gPiA+ICt0ZXh0b2ZzLSQoQ09ORklHX0FS
Q0hfU1VOUExVUykgOj0gMHgwMDMwODAwMA0KPiA+ID4NCj4gPiA+IFdoYXQgaXMgdGhpcyBuZWVk
ZWQgZm9yPyBJZiBpdCBib290cyB3aXRob3V0IHRoaXMgbGluZSwgYmV0dGVyIGF2b2lkDQo+ID4g
PiBhZGRpbmcgaXQsIGJlY2F1c2UNCj4gPiA+IGl0IHdpbGwgaW5jcmVhc2UgdGhlIGtlcm5lbCBz
aXplIGZvciBldmVyeW9uZSBlbHNlICh1bmxlc3MgdGhleSBhbHNvIGVuYWJsZQ0KPiA+ID4gQVhY
SUEpLg0KPiA+ID4NCj4gPg0KPiA+IFNQNzAyMSByZXNlcnZlZCB0aGUgMXN0IDFNQiBtZW1vcnkg
Zm9yIEFSTTkyNkBQLUNoaXAgdXNpbmcsDQo+ID4gVGhlIDJuZCAxTUIgbWVtb3J5IGZvciBJT1Ag
ZGV2aWNlIGFuZCB0aGUgM3JkIDFNQiBtZW1vcnkgZm9yIGJvb3Rsb2FkZXIuDQo+ID4gSSdsbCBh
ZGQgdGhlc2UgY29tbWVudHMgYXQgbmV4dCBjb21taXQuDQo+IA0KPiBJIHRoaW5rIHlvdSBjYW4g
anVzdCByZW1vdmUgdGhlIG1lbW9yeSBmcm9tIHRoZSBzeXN0ZW0gbWVtb3J5IG1hcCBpbiB0aGUN
Cj4gZGV2aWNlIHRyZWUgYW5kIHByZXRlbmQgaXQgb25seSBzdGFydHMgYWZ0ZXIgdGhlIGJvb3Rs
b2FkZXIuIEl0J3MgYmVlbiBhIHdoaWxlDQo+IHNpbmNlIEkgbG9va2VkIGF0IHRoaXMgdGhvdWdo
LCBzbyBJIGNvdWxkIGJlIG1pc3JlbWVtYmVyaW5nIHdoYXQgdGhlIG1pbmltdW0NCj4gYm91bmRh
cmllcyBhcmUgZm9yIGRvaW5nIHRoaXMuDQo+IA0KPiAgICAgICAgIEFybmQNCg0KSSBoYXZlIHRl
c3QgZm9sbG93aW5nIDMgbWV0aG9kczoNCg0KMS4gY3VycmVudCBwYXRjaA0KRFQ6DQoJbWVtb3J5
IHsNCgkJcmVnID0gPDB4MDAwMDAwMDAgMHgyMDAwMDAwMD47IC8qIDUxMk1CICovDQoJfTsNCg0K
CXJlc2VydmVkLW1lbW9yeSB7DQoJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KCQkjc2l6ZS1jZWxs
cyA9IDwxPjsNCgkJcmFuZ2VzOw0KDQoJCWlvcF9yZXNlcnZlOiBpb3BfZGV2aWNlIHsNCgkJCW5v
LW1hcDsNCgkJCXJlZyA9IDwweDAwMTAwMDAwIDB4MDAxMDAwMDA+OyANCgkJfTsNCgkJYTkyNl9y
ZXNlcnZlOiBhOTI2X21lbW9yeSB7DQoJCQluby1tYXA7DQoJCQlyZWcgPSA8MHgwMDAwMDAwMCAw
eDAwMTAwMDAwPjsNCgkJfTsNCgl9Ow0KYXJjaC9hcm0vTWFrZWZpbGU6DQoJdGV4dG9mcy0kKENP
TkZJR19BUkNIX1NVTlBMVVMpIDo9IDB4MDAzMDgwMDANCg0KYm9vdGxvZyAmIG1lbWluZm8gOg0K
WyAgICAwLjAwMDAwMF0gWm9uZSByYW5nZXM6DQpbICAgIDAuMDAwMDAwXSAgIE5vcm1hbCAgIFtt
ZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDAxZmZmZmZmZl0NClsgICAgMC4wMDAwMDBd
IE1vdmFibGUgem9uZSBzdGFydCBmb3IgZWFjaCBub2RlDQpbICAgIDAuMDAwMDAwXSBFYXJseSBt
ZW1vcnkgbm9kZSByYW5nZXMNClsgICAgMC4wMDAwMDBdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAw
MDAwMDAwMDAwMDAwLTB4MDAwMDAwMDAwMDFmZmZmZl0NClsgICAgMC4wMDAwMDBdICAgbm9kZSAg
IDA6IFttZW0gMHgwMDAwMDAwMDAwMjAwMDAwLTB4MDAwMDAwMDAxZmZmZmZmZl0NClsgICAgMC4w
MDAwMDBdIEluaXRtZW0gc2V0dXAgbm9kZSAwIFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAw
MDAwMDAxZmZmZmZmZl0NCg0KfiAjIGNhdCAvcHJvYy9tZW1pbmZvDQpNZW1Ub3RhbDogICAgICAg
ICA1MTQwMDgga0INCk1lbUZyZWU6ICAgICAgICAgIDQ5MTk2MCBrQg0KTWVtQXZhaWxhYmxlOiAg
ICAgNDg4NjA4IGtCDQoNCg0KDQoyLiBEVCBzYW1lIGFzIGNhc2UgMSwgYnV0IG5vIG1vZGlmeSBA
IGFyY2gvYXJtL01ha2VmaWxlDQoNCmJvb3Rsb2cgJiBtZW1pbmZvIDoNClsgICAgMC4wMDAwMDBd
IE9GOiBmZHQ6IFJlc2VydmVkIG1lbW9yeTogZmFpbGVkIHRvIHJlc2VydmUgbWVtb3J5IGZvciBu
b2RlICdpb3BfZGV2aWNlJzogYmFzZSAweDAwMTAwMDAwLCBzaXplIDEgTWlCDQpbICAgIDAuMDAw
MDAwXSBPRjogZmR0OiBSZXNlcnZlZCBtZW1vcnk6IGZhaWxlZCB0byByZXNlcnZlIG1lbW9yeSBm
b3Igbm9kZSAnYTkyNl9tZW1vcnknOiBiYXNlIDB4MDAwMDAwMDAsIHNpemUgMSBNaUINCi4uLg0K
WyAgICAwLjAwMDAwMF0gWm9uZSByYW5nZXM6DQpbICAgIDAuMDAwMDAwXSAgIE5vcm1hbCAgIFtt
ZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDAxZmZmZmZmZl0NClsgICAgMC4wMDAwMDBd
IE1vdmFibGUgem9uZSBzdGFydCBmb3IgZWFjaCBub2RlDQpbICAgIDAuMDAwMDAwXSBFYXJseSBt
ZW1vcnkgbm9kZSByYW5nZXMNClsgICAgMC4wMDAwMDBdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAw
MDAwMDAwMDAwMDAwLTB4MDAwMDAwMDAxZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdIEluaXRtZW0g
c2V0dXAgbm9kZSAwIFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDAxZmZmZmZmZl0N
Cg0KfiAjIGNhdCAvcHJvYy9tZW1pbmZvDQpNZW1Ub3RhbDogICAgICAgICA1MTYwNTYga0INCk1l
bUZyZWU6ICAgICAgICAgIDQ5MzkyOCBrQg0KTWVtQXZhaWxhYmxlOiAgICAgNDkwNTcyIGtCDQoN
Cg0KDQozLiBEVDoNCgltZW1vcnkgew0KCQlyZWcgPSA8MHgwMDMwMDAwMCAweDFGRDAwMDAwPjsg
LyogNTEyIC0gMyBNQiAqLw0KCX07DQpubyBtb2RpZnkgQCBhcmNoL2FybS9NYWtlZmlsZQ0KDQpi
b290bG9nICYgbWVtaW5mbyA6DQpbICAgIDAuMDAwMDAwXSBab25lIHJhbmdlczoNClsgICAgMC4w
MDAwMDBdICAgTm9ybWFsICAgW21lbSAweDAwMDAwMDAwMDA0MDAwMDAtMHgwMDAwMDAwMDFmZmZm
ZmZmXQ0KWyAgICAwLjAwMDAwMF0gTW92YWJsZSB6b25lIHN0YXJ0IGZvciBlYWNoIG5vZGUNClsg
ICAgMC4wMDAwMDBdIEVhcmx5IG1lbW9yeSBub2RlIHJhbmdlcw0KWyAgICAwLjAwMDAwMF0gICBu
b2RlICAgMDogW21lbSAweDAwMDAwMDAwMDA0MDAwMDAtMHgwMDAwMDAwMDFmZmZmZmZmXQ0KWyAg
ICAwLjAwMDAwMF0gSW5pdG1lbSBzZXR1cCBub2RlIDAgW21lbSAweDAwMDAwMDAwMDA0MDAwMDAt
MHgwMDAwMDAwMDFmZmZmZmZmXQ0KDQp+ICMgY2F0IC9wcm9jL21lbWluZm8NCk1lbVRvdGFsOiAg
ICAgICAgIDUxMTk2NCBrQg0KTWVtRnJlZTogICAgICAgICAgNDg5NjM2IGtCDQpNZW1BdmFpbGFi
bGU6ICAgICA0ODYyOTIga0INCg0KDQoNCkkgdGhpbmsgbWV0aG9kIDEgc2hvdWxkIGJlIGNvcnJl
Y3QgKGNvbXBhcmUgbWV0aG9kIDIpICYgYmV0dGVyIChjb21wYXJlIG1ldGhvZCAzKS4NCg0K
