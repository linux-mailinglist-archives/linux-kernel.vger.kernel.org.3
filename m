Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE20494A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiATJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:12:14 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:42006
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240065AbiATJML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:12:11 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(11289:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Thu, 20 Jan 2022 17:12:12 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Thu, 20 Jan 2022 17:12:11 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Thu, 20 Jan 2022 17:12:11 +0800
From:   =?big5?B?TGggS3VvILOipE+7qA==?= <lh.Kuo@sunplus.com>
To:     Mark Brown <broonie@kernel.org>, Li-hao Kuo <lhjeff911@gmail.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "andyshevchenko@gmail.com" <andyshevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Thread-Topic: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Thread-Index: AQHYDEdoNQA4Z8mYU0mSuzI8gOIgg6xohrWAgAMbElA=
Date:   Thu, 20 Jan 2022 09:12:11 +0000
Message-ID: <d202d04f32b8496293bd98e090322104@sphcmbx02.sunplus.com.tw>
References: <cover.1642494310.git.lhjeff911@gmail.com>
 <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
 <Yeb75aOOckAfNTTG@sirena.org.uk>
In-Reply-To: <Yeb75aOOckAfNTTG@sirena.org.uk>
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

SGkgTXIuIE1hcmsgQnJvd24gOg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudCwgSSB3aWxsIG1v
ZGlmeSBpdCBpbiBuZXh0IG5leHQgc3VibWlzc2lvbg0KDQo+IA0KPiA+ICsJZm9yIChpID0gMDsg
aSA8PSB4ZmVyX2NudDsgaSsrKSB7DQo+ID4gKwkJbXV0ZXhfbG9jaygmcHNwaW0tPmJ1Zl9sb2Nr
KTsNCj4gDQo+IFRoaXMgbG9jayBpcyByZWR1bmRhbnQ6IGl0IGlzIG9ubHkgZXZlciBoZWxkIGlu
IHRoaXMgZnVuY3Rpb24gd2hpY2ggaXMgZ3VhcmFudGVlZCBieSB0aGUgY29yZSB0byBuZXZlciBi
ZQ0KPiBjYWxsZWQgdHdpY2UgY29uY3VycmVudGx5Lg0KDQpJIHdpbGwgbW9kaWZ5IGl0IGluIG5l
eHQgbmV4dCBzdWJtaXNzaW9uDQoNCg0KPiA+ICsJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShkZXYs
IHBzcGltLT5tX2lycSwgc3A3MDIxX3NwaV9tYXN0ZXJfaXJxLA0KPiA+ICsJCQkgICAgICAgSVJR
Rl9UUklHR0VSX1JJU0lORywgcGRldi0+bmFtZSwgcHNwaW0pOw0KPiA+ICsJaWYgKHJldCkNCj4g
PiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2
LCBwc3BpbS0+c19pcnEsIHNwNzAyMV9zcGlfc2xhdmVfaXJxLA0KPiA+ICsJCQkgICAgICAgSVJR
Rl9UUklHR0VSX1JJU0lORywgcGRldi0+bmFtZSwgcHNwaW0pOw0KPiA+ICsJaWYgKHJldCkNCj4g
PiArCQlyZXR1cm4gcmV0Ow0KPiANCj4gQXJlIHlvdSBzdXJlIHRoZSBkcml2ZXIgaXMgcmVhZHkg
dG8gaGFuZGxlIGludGVycnVwdHMgd2l0aG91dCBhbnkgb2YgdGhlIG90aGVyIHJlc291cmNlcz8g
IE5vcm1hbGx5DQo+IGludGVycnVwdHMgYXJlIG9uZSBvZiB0aGUgbGFzdCB0aGluZ3MgdG8gYmUg
cmVxdWVzdGVkLg0KDQpJIHdpbGwgbW9kaWZ5IGl0IGluIG5leHQgbmV4dCBzdWJtaXNzaW9uDQoN
Cg0K
