Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5341D48E225
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbiANBbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:31:42 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:33994
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233397AbiANBbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:31:41 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(23036:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Fri, 14 Jan 2022 09:31:46 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 14 Jan 2022 09:31:41 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 14 Jan 2022 09:31:41 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v5 1/2] SPI: Add SPI driver for Sunplus SP7021
Thread-Topic: [PATCH v5 1/2] SPI: Add SPI driver for Sunplus SP7021
Thread-Index: AQHYBe35Zwa2WzVv80Wn8GSy7nUw5qxbkCcAgAYwGJA=
Date:   Fri, 14 Jan 2022 01:31:41 +0000
Message-ID: <7d79c45a37f64a41947f05b6cae96bd6@sphcmbx02.sunplus.com.tw>
References: <cover.1641797029.git.lhjeff911@gmail.com>
 <761604f7aa4d4df16637103ba10d34674faf3d9b.1641797029.git.lhjeff911@gmail.com>
 <CAHp75VecMe_KxgV1adr5Z7_EDz0s9MWB_RNeS4nY0m6e_eZ9Yw@mail.gmail.com>
In-Reply-To: <CAHp75VecMe_KxgV1adr5Z7_EDz0s9MWB_RNeS4nY0m6e_eZ9Yw@mail.gmail.com>
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

PiA+ICsgICAgICAgICAgICAgICB3cml0ZWwocmVhZGwocHNwaW0tPm1fYmFzZSArIFNQNzAyMV9J
TlRfQlVTWV9SRUcpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfCBTUDcwMjFfQ0xSX01B
U19JTlQsIHBzcGltLT5tX2Jhc2UgKw0KPiA+ICsgU1A3MDIxX0lOVF9CVVNZX1JFRyk7DQo+IA0K
PiBJdCdzIGJldHRlciB0byByZWFkIHdpdGggdGVtcG9yYXJ5IHZhcmlhYmxlIGJlaW5nIHVzZWQ6
DQo+IA0KPiAgICAgICAgICAgICAgdmFsdWUgPSByZWFkbChwc3BpbS0+bV9iYXNlICsgU1A3MDIx
X0lOVF9CVVNZX1JFRyk7DQo+ICAgICAgICAgICAgICB2YWx1ZSB8PSBTUDcwMjFfQ0xSX01BU19J
TlQ7DQo+ICAgICAgICAgICAgICB3cml0ZWwodmFsdWUsIHBzcGltLT5tX2Jhc2UgKyBTUDcwMjFf
SU5UX0JVU1lfUkVHKTsNCg0KSSB3aWxsIGFkZCBpdCBpbiBuZXh0IG5leHQgc3VibWlzc2lvbg0K
DQo+ID4gKyAgICAgICBwc3BpbS0+eGZlcl9jb25mIHw9ICgoY2xrX3NlbCAmIDB4ZmZmZikgPDwg
MTYpOw0KPiANCj4gSXMgeGZlcl9jb25mIGJpZ2dlciB0aGFuIDMyLWJpdD8gSWYgbm90LCB3aHkg
ZG8geW91IG5lZWQgdGhlICcgJiAweGZmZmYnIHBhcnQ/DQo+IA0KPiAuLi4NCg0KSSB3aWxsIGFk
ZCBpdCBpbiBuZXh0IG5leHQgc3VibWlzc2lvbg0KDQo+ID4gKyAgICAgICAgICAgICAgIG1vZGUg
PSBTUDcwMjFfU0xBVkVfTU9ERTsNCj4gDQo+IC4uLmJlbG9uZ3MgdG8gdGhpcyBjb25kaXRpb24s
IHNvIGRvIG5vdCBpbnRlcmxlYXZlIHRoZW0uDQo+IA0KPiBPbiB0b3Agb2YgdGhhdCB5b3UgbWF5
IHVzZSBkZXZpY2UgcHJvcGVydHkgQVBJOg0KPiANCj4gICAgIGlmIChkZXZpY2VfcHJvcGVydHlf
cmVhZF9ib29sKCZwZGV2LT5kZXYsICJzcGktc2xhdmUiKSkNCj4gICAgICAgICBtb2RlID0gU1A3
MDIxX1NMQVZFX01PREU7DQo+ICAgICBlbHNlDQo+ICAgICAgICAgbW9kZSA9IFNQNzAyMV9NQVNU
RVJfTU9ERTsNCg0KDQpJIHdpbGwgYWRkIGl0IGluIG5leHQgbmV4dCBzdWJtaXNzaW9uDQoNCg0K
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgInNwaV9y
ZWdpc3Rlcl9tYXN0ZXIgZmFpbFxuIik7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAg
ICAgcmV0dXJuIHJldDsNCj4gDQo+IHJldHVybiAwOw0KPiANCj4gLi4uDQo+IA0KPiA+ICtNT0RV
TEVfTElDRU5TRSgiR1BMIHYyIik7DQo+IA0KPiAiR1BMIiwgdGhlIG9uZSB5b3UgdXNlZCBpcyBs
ZWdhY3kuDQo+DQoNCg0KSSB3aWxsIGFkZCBpdCBpbiBuZXh0IG5leHQgc3VibWlzc2lvbg0KDQoN
Cg==
