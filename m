Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85511489062
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiAJGve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:51:34 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:36202 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbiAJGvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:51:32 -0500
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24953:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Mon, 10 Jan 2022 14:36:57 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 10 Jan 2022 14:37:01 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Mon, 10 Jan 2022 14:37:01 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v7 06/10] clk: Add Sunplus SP7021 clock driver
Thread-Topic: [PATCH v7 06/10] clk: Add Sunplus SP7021 clock driver
Thread-Index: AQHX9wMzddZ4i1EhDk6U/miEAgqwiKxUuIQAgAKMxICAAJdxAIAEBmcQ
Date:   Mon, 10 Jan 2022 06:37:01 +0000
Message-ID: <739d561357814c31a530b327480e1212@cqplus1.com>
References: <cover.1640154492.git.qinjian@cqplus1.com>
 <7f8302e2c1d02141dd69d2524eaa857d6494fdc7.1640154492.git.qinjian@cqplus1.com>
 <20220106004249.90484C36AEB@smtp.kernel.org>
 <51a2cbddc978400086271fc735493566@cqplus1.com>
 <20220108004112.2AB34C36AE9@smtp.kernel.org>
In-Reply-To: <20220108004112.2AB34C36AE9@smtp.kernel.org>
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

PiA+ID4gPiArDQo+ID4gPiA+ICtDTEtfT0ZfREVDTEFSRV9EUklWRVIoc3BfY2xrYywgInN1bnBs
dXMsc3A3MDIxLWNsa2MiLCBzcF9jbGtfc2V0dXApOw0KPiA+ID4NCj4gPiA+IFdoeSBDTEtfT0Zf
REVDTEFSRV9EUklWRVI/IFRoZXJlIHNob3VsZCBiZSBhIGNvbW1lbnQgYnV0IGJldHRlciB3b3Vs
ZCBiZQ0KPiA+ID4gdG8gbWFrZSBhIHBsYXRmb3JtIGRyaXZlciBpbnN0ZWFkLiBJZiB0aGUgcGxh
dGZvcm0gZHJpdmVyIGNhbid0IGJlIHVzZWQsDQo+ID4gPiB3ZSBuZWVkIHRvIGtub3cgd2hhdCBv
dGhlciBkZXZpY2UgZHJpdmVyIGlzIHByb2JpbmcgYmFzZWQgb24gdGhpcyBjbGtjDQo+ID4gPiBj
b21wYXRpYmxlIHN0cmluZy4NCj4gPg0KPiA+IERlYXIgU3RlcGhlbiwNCj4gPg0KPiA+IFNvcnJ5
LCBJIGRvbid0IHVuZGVyc3RhbmQgeW91ciBjb21tZW50Lg0KPiA+IERpZCB5b3UgbWVhbiwgbGlr
ZSBiZWxvdzoNCj4gPg0KPiA+IHN0YXRpYyBpbnQgc3A3MDIxX2Nsa19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+IHsNCj4gPiAgICAgICAgIC4uLi4uLg0KPiA+ICAgICAg
ICAgc3BfY2xrX2RhdGEtPm51bSA9IENMS19NQVg7DQo+ID4gICAgICAgICByZXR1cm4gZGV2bV9v
Zl9jbGtfYWRkX2h3X3Byb3ZpZGVyKGRldiwgb2ZfY2xrX2h3X29uZWNlbGxfZ2V0LCBzcF9jbGtf
ZGF0YSk7DQo+ID4gfQ0KPiA+DQo+ID4gc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
c3A3MDIxX2Nsa19kdF9pZHNbXSA9IHsNCj4gPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAic3Vu
cGx1cyxzcDcwMjEtY2xrYyIsIH0sDQo+ID4gICAgICAgICB7IH0NCj4gPiB9Ow0KPiA+IE1PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIHNwNzAyMV9jbGtfZHRfaWRzKTsNCj4gPg0KPiA+IHN0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHNwNzAyMV9jbGtfZHJpdmVyID0gew0KPiA+ICAgICAgICAg
LnByb2JlICA9IHNwNzAyMV9jbGtfcHJvYmUsDQo+ID4gICAgICAgICAuZHJpdmVyID0gew0KPiA+
ICAgICAgICAgICAgICAgICAubmFtZSA9ICJzcDcwMjEtY2xrIiwNCj4gPiAgICAgICAgICAgICAg
ICAgLm9mX21hdGNoX3RhYmxlID0gc3A3MDIxX2Nsa19kdF9pZHMsDQo+ID4gICAgICAgICB9LA0K
PiA+IH07DQo+ID4gYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIoc3A3MDIxX2Nsa19kcml2ZXIpOw0K
PiA+DQo+ID4NCj4gPiBCdXQsIEl0J3MgZG9lc24ndCB3b3JrLg0KPiANCj4gV2h5IGRvZXNuJ3Qg
aXQgd29yaz8NCj4gDQo+ID4gTW9zdCBvdGhlciBjbGsgZHJpdmVycyB1c2VkIENMS19PRl9ERUNM
QVJFX0RSSVZFUiBvciBDTEtfT0ZfREVDTEFSRS4NCj4gPiBJIGp1c3QgdGFrZSB0aGVzZSBhcyB0
aGUgcmVmZXJlbmNlIGFuZCBpdCdzIHdvcmtpbmcuDQo+IA0KPiBDTEtfT0ZfREVDTEFSRSBpcyBm
b3IgY2xrcyB0aGF0IG5lZWQgdG8gYmUgcmVnaXN0ZXJlZCBzbyB0aGUgbWFpbg0KPiBpcnFjaGlw
IGFuZC9vciBjbG9ja3NvdXJjZS9jbG9ja2V2ZW50IGNhbiBvcGVyYXRlIHByb3Blcmx5Lg0KPiBD
TEtfT0ZfREVDTEFSRV9EUklWRVIgaXMgZm9yIHRoZSBjYXNlIHRoYXQgdGhlcmUncyBhbm90aGVy
IGRyaXZlciB0aGF0DQo+IHdpbGwgYXR0YWNoIHRvIHRoZSBkZXZpY2Ugbm9kZSB0aGF0IGhhcyB0
aGUgY29tcGF0aWJsZSBzdHJpbmcuDQoNCkFmdGVyIHNvbWUgdHJhY2UsIEkgZm91bmQ6DQpJbiBv
dXIgZHRzLCAnY2xrYycgbm9kZSBkZWZpbmVkIEAgY2xvY2tzOg0KCWNsb2NrcyB7DQoJCS4uLg0K
CQljbGtjOiBjbG9jay1jb250cm9sbGVyQDljMDAwMDAwIHsNCgkJCSNjbG9jay1jZWxscyA9IDwx
PjsNCgkJCWNvbXBhdGlibGUgPSAic3VucGx1cyxzcDcwMjEtY2xrYyI7DQoJCQlyZWcgPSA8MHg5
YzAwMDAwMCAweDI4MD47IC8vIEcwOkNMS0VOIH4gRzQ6UExMDQoJCQljbG9ja3MgPSA8JmV4dGNs
az4sIDwmY2xrYyBQTExfU1lTPjsNCgkJCWNsb2NrLW5hbWVzID0gImV4dGNsayIsICJwbGxzeXMi
Ow0KCQl9Ow0KCX07DQoJc29jIHsNCgkJLi4uDQoJfQ0KSW4gdGhpcyBjYXNlLCBjbGsgZHJpdmVy
IHdyaXRlIGFzIHBsYXRmb3JtIGRyaXZlciBub3Qgd29yayAoc3A3MDIxX2Nsa19wcm9iZSBub3Qg
Y2FsbGVkKQ0KQnV0LCBDTEtfT0ZfREVDTEFSRSBhbmQgQ0xLX09GX0RFQ0xBUkVfRFJJVkVSIGJv
dGggd29ya2VkIChjYWxsZWQgZnJvbSBjbGtfb2ZfaW5pdCkNCg0KVGhlbiwgSSBtb3ZlIHRoZSAn
Y2xrYycgbW9kZSBmcm9tICdjbG9ja3MnIHRvICdzb2MnOg0KCWNsb2NrcyB7DQoJCS4uLg0KCX07
DQoJc29jIHsNCgkJLi4uDQoJCWNsa2M6IGNsb2NrLWNvbnRyb2xsZXJAOWMwMDAwMDAgew0KCQkJ
I2Nsb2NrLWNlbGxzID0gPDE+Ow0KCQkJY29tcGF0aWJsZSA9ICJzdW5wbHVzLHNwNzAyMS1jbGtj
IjsNCgkJCXJlZyA9IDwweDljMDAwMDAwIDB4MjgwPjsgLy8gRzA6Q0xLRU4gfiBHNDpQTEwNCgkJ
CWNsb2NrcyA9IDwmZXh0Y2xrPiwgPCZjbGtjIFBMTF9TWVM+Ow0KCQkJY2xvY2stbmFtZXMgPSAi
ZXh0Y2xrIiwgInBsbHN5cyI7DQoJCX07DQoJfQ0KSW4gdGhpcyBjYXNlLCBjbGsgZHJpdmVyIHdy
aXRlIGFzIHBsYXRmb3JtIGRyaXZlciB3b3JrZWQgKGNhbGxlZCBmcm9tIHBsYXRmb3JtX3Byb2Jl
KQ0KQ0xLX09GX0RFQ0xBUkUgYW5kIENMS19PRl9ERUNMQVJFX0RSSVZFUiBhbHNvIGJvdGggd29y
a2VkLiAoc3RpbGwgY2FsbGVkIGZyb20gY2xrX29mX2luaXQsIG1vcmUgZWFybHkgdGhhbiBwbGF0
Zm9ybV9wcm9iZSkNCg0KSXQgbG9va3MgbGlrZSBDTEtfT0ZfREVDTEFSRS9DTEtfT0ZfREVDTEFS
RV9EUklWRVIgaXMgYmV0dGVyIHRoYW4gcGxhdGZvcm0gZHJpdmVyLg0KV2h5IHlvdSBwcmVmZXIg
cGxhdGZvcm0gZHJpdmVyPw0KDQoNCg==
