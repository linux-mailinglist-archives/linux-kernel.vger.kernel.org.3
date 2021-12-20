Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7447A4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhLTGCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:02:01 -0500
Received: from 113.196.136.146.ll.static.sparqnet.net ([113.196.136.146]:52610
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231863AbhLTGB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:01:59 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(9394:0:AUTH_RELAY)
        (envelope-from <wells.lu@sunplus.com>); Mon, 20 Dec 2021 14:02:05 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 20 Dec 2021 14:02:04 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 20 Dec 2021 14:02:04 +0800
From:   =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Wells Lu <wellslutw@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>
Subject: RE: [PATCH v4 2/2] pinctrl: Add driver for Sunplus SP7021
Thread-Topic: [PATCH v4 2/2] pinctrl: Add driver for Sunplus SP7021
Thread-Index: AQHX8Njs3eYLUHU9OEqH4rkPVxFQUqwyGPCAgAC/HYCAABecAIAAvwoggAc5FSA=
Date:   Mon, 20 Dec 2021 06:02:04 +0000
Message-ID: <b5f9e73ed23447a7a4d5bfef0a209ad4@sphcmbx02.sunplus.com.tw>
References: <1639479189-6693-1-git-send-email-wellslutw@gmail.com>
 <1639479189-6693-3-git-send-email-wellslutw@gmail.com>
 <CAHp75VcnkZmzZE5C5z+kyrJoGRx8t60e_vDrw4HXOocY=Mjqsw@mail.gmail.com>
 <83d865b82e574ab49ae0c5fc160774c0@sphcmbx02.sunplus.com.tw>
 <CAHp75VcU_2HR2qamGmuYBjXtaG_b55vgAUv20rb7LfPo3q-HYA@mail.gmail.com> 
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.39]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KDQo+ID4gPiA+ID4gKy8qIEZJUlNUIHJlZ2lzdGVyOg0KPiA+ID4gPiA+ICsg
KiAgIDA6IE1VWA0KPiA+ID4gPiA+ICsgKiAgIDE6IEdQSU8vSU9QDQo+ID4gPiA+ID4gKyAqICAg
MjogTm8gY2hhbmdlDQo+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPg0KPiA+ID4gPiBGb3IgYWxsIGNv
bW1lbnRzIHN0YXJ0aW5nIGZyb20gaGVyZSBhbmQgZm9yIHNpbWlsYXIgY2FzZXMgZWxzZXdoZXJl
Og0KPiA+ID4gPiAgLSB3aHkgaXQgaXMgbm90IGluIGtlcm5lbCBkb2M/DQo+ID4gPiA+ICAtIHdo
YXQgdGhlIHZhbHVlIHRoYXQgYWRkPw0KPiA+ID4gPiAoU29tZSBvZiB0aGVtIHNvIGNyeXB0aWMg
b3Igc28gb2J2aW91cykNCj4gPiA+DQo+ID4gPiBUaGUgY29tbWVudCBleHBsYWlucyB1c2FnZSBv
ZiAnZW51bSBtdXhfZl9tZycNCj4gPiA+IFRoZSAnZW51bScgaXMgb25seSB1c2VkIGluIHRoZSBk
cml2ZXIuDQo+ID4gPiBJdCBoZWxwcyBwcm9ncmFtbWVycyB0byByZW1lbWJlciBvciBsb29rLXVw
IHRoZSBkZWZpbmUgb2YgdGhlIGVudW0uDQo+ID4gPiBOZWVkIHdlIGFkZCB0aGlzIGtpbmQgb2Yg
Y29tbWVudCB0byBrZXJuZWwgZG9jPw0KPiA+DQo+ID4gV2h5IG5vdD8NCg0KRG9lcyB0aGUga2Vy
ZW5sIGRvYyBtZWFuIGR0LWJpbmRpbmcgZG9jdW1lbnQ/DQoNCklmIG5vdCwgY291bGQgeW91IHBs
ZWFlIHRlbGwgbWUgd2hlcmUgc2hvdWxkIEkgcHV0IHRoZSBrZXJuZWwgZG9jdW1lbnQ/DQpBbnkg
cmVmZXJlbmNlcyBmb3IgcGluY3RybCBkcml2ZXJzPw0KDQpDYW4gSSBhZGQgbW9yZSBjb21tZW50
cyBmb3IgdGhlIGVudW0gaW4gYyBmaWxlLCBpbnN0ZWFkIG9mIGNyZWF0aW5nIG5ldw0Ka2VybmVs
IGRvYz8NCg0KDQoNCkJlc3QgcmVnYXJkcywNCg0KV2VsbHMgTHUNCg0KU21hcnQgQ29tcHV0aW5n
IFByb2dyYW0NCkhvbWUgRW50ZXJ0YWlubWVudCBCdXNpbmVzcyBVbml0DQpTdW5wbHVzIFRlY2hu
b2xvZ3kgQ28uLCBMdGQuDQoxOSwgSW5ub3ZhdGlvbiAxc3QgUm9hZCwNClNjaWVuY2UtYmFzZWQg
SW5kdXN0cmlhbCBQYXJrDQpIc2luLUNodSwgVGFpd2FuIDMwMA0KVEVM77yaODg2LTMtNTc4NjAw
NSBleHQuIDI1ODANCg0K
