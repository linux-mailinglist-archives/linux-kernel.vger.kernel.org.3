Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD346B4B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhLGH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:58:00 -0500
Received: from [113.204.237.245] ([113.204.237.245]:41268 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231681AbhLGH57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:57:59 -0500
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.27.96.203
        by cqmailgates with MailGates ESMTP Server V5.0(21476:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 07 Dec 2021 15:21:34 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Dec 2021 15:21:31 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Tue, 7 Dec 2021 15:21:31 +0800
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
Thread-Index: AQHX6BmLzMMFC/bfnUOF4rJ/hd0nkqwgNNgAgAZiSeA=
Date:   Tue, 7 Dec 2021 07:21:31 +0000
Message-ID: <88f8cc0b1334467aae7a5a4b0643176a@cqplus1.com>
References: <cover.1638515726.git.qinjian@cqplus1.com>
 <eabfe1b84b889e4aa95e24c30a114c68ef95fd07.1638515726.git.qinjian@cqplus1.com>
 <CAK8P3a1_coAnp8P3L2UA+smxuRL9widFQv9Y5ZZ0X_Sr9zsZtg@mail.gmail.com>
In-Reply-To: <CAK8P3a1_coAnp8P3L2UA+smxuRL9widFQv9Y5ZZ0X_Sr9zsZtg@mail.gmail.com>
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

PiA+ICtjb25maWcgQVJDSF9TVU5QTFVTDQo+ID4gKyAgICAgICBib29sICJTdW5wbHVzIFNvQ3Mi
DQo+ID4gKyAgICAgICBzZWxlY3QgQ0xLU1JDX09GDQo+ID4gKyAgICAgICBzZWxlY3QgQ09NTU9O
X0NMSw0KPiA+ICsgICAgICAgc2VsZWN0IEdFTkVSSUNfQ0xPQ0tFVkVOVFMNCj4gPiArICAgICAg
IHNlbGVjdCBHRU5FUklDX0lSUV9DSElQDQo+ID4gKyAgICAgICBzZWxlY3QgR0VORVJJQ19JUlFf
TVVMVElfSEFORExFUg0KPiA+ICsgICAgICAgc2VsZWN0IFVTRV9PRg0KPiA+ICsgICAgICAgc2Vs
ZWN0IFJUQ19DTEFTUw0KPiA+ICsgICAgICAgc2VsZWN0IFJFU0VUX1NVTlBMVVMNCj4gDQo+IFRo
aXMgaXMgaW4gdGhlIHdyb25nIHBsYWNlOiBtb3ZlIHRoZSBLY29uZmlnIGVudHJ5IGludG8NCj4g
YXJjaC9hcm0vbWFjaC1zdW5wbHVzL0tjb25maWcNCj4gYW5kIG1ha2UgaXQgJ2RlcGVuZHMgb24g
QVJDSF9NVUxUSV9WNycuDQo+IA0KPiBJIHRoaW5rIHlvdSBjYW4gcmVtb3ZlIGFsbCB0aGUgJ3Nl
bGVjdCcgbGluZXMgYXMgd2VsbCBiZWNhdXNlIHRoZXkgYXJlDQo+IGVpdGhlciBpbXBsaWVkIGJ5
DQo+IEFSQ0hfTVVMVElfVjcgb3Igbm90IGFjdHVhbGx5IG5lY2Vzc2FyeS4NCj4gLi4uLi4uDQoN
ClRoYW5rcyBmb3IgeW91ciByZXZpZXcsIEknbGwgY29ycmVjdCB0aGVzZSBhdCBuZXh0IGNvbW1p
dC4NCg0KPiANCj4gPiBAQCAtMTUyLDYgKzE1Miw3IEBAIHRleHRvZnMtJChDT05GSUdfQVJDSF9N
U004WDYwKSA6PSAweDAwMjA4MDAwDQo+ID4gIHRleHRvZnMtJChDT05GSUdfQVJDSF9NU004OTYw
KSA6PSAweDAwMjA4MDAwDQo+ID4gIHRleHRvZnMtJChDT05GSUdfQVJDSF9NRVNPTikgOj0gMHgw
MDIwODAwMA0KPiA+ICB0ZXh0b2ZzLSQoQ09ORklHX0FSQ0hfQVhYSUEpIDo9IDB4MDAzMDgwMDAN
Cj4gPiArdGV4dG9mcy0kKENPTkZJR19BUkNIX1NVTlBMVVMpIDo9IDB4MDAzMDgwMDANCj4gDQo+
IFdoYXQgaXMgdGhpcyBuZWVkZWQgZm9yPyBJZiBpdCBib290cyB3aXRob3V0IHRoaXMgbGluZSwg
YmV0dGVyIGF2b2lkDQo+IGFkZGluZyBpdCwgYmVjYXVzZQ0KPiBpdCB3aWxsIGluY3JlYXNlIHRo
ZSBrZXJuZWwgc2l6ZSBmb3IgZXZlcnlvbmUgZWxzZSAodW5sZXNzIHRoZXkgYWxzbyBlbmFibGUN
Cj4gQVhYSUEpLg0KPiANCg0KU1A3MDIxIHJlc2VydmVkIHRoZSAxc3QgMU1CIG1lbW9yeSBmb3Ig
QVJNOTI2QFAtQ2hpcCB1c2luZywNClRoZSAybmQgMU1CIG1lbW9yeSBmb3IgSU9QIGRldmljZSBh
bmQgdGhlIDNyZCAxTUIgbWVtb3J5IGZvciBib290bG9hZGVyLg0KSSdsbCBhZGQgdGhlc2UgY29t
bWVudHMgYXQgbmV4dCBjb21taXQuDQoNCg0K
