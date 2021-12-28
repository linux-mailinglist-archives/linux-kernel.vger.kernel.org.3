Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6667F48077C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhL1IpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:45:24 -0500
Received: from mswedge2.sunplus.com ([60.248.182.106]:37402 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231670AbhL1IpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:45:23 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(49508:0:AUTH_RELAY)
        (envelope-from <edwin.chiu@sunplus.com>); Tue, 28 Dec 2021 16:45:27 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Tue, 28 Dec 2021 16:45:21 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Tue, 28 Dec 2021 16:45:21 +0800
From:   =?big5?B?RWR3aW4gQ2hpdSCq9KurrnA=?= <edwin.chiu@sunplus.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] cpuidle:sunplus:create cpuidle driver for sunplus
 sp7021
Thread-Topic: [PATCH v2 2/2] cpuidle:sunplus:create cpuidle driver for sunplus
 sp7021
Thread-Index: AQHX9WEUrNii4YTVCkGIbW8MVVMb3Kw6xGIAgAzaWSA=
Date:   Tue, 28 Dec 2021 08:45:21 +0000
Message-ID: <0812c44f777d4026b79df2e3698294be@sphcmbx02.sunplus.com.tw>
References: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
 <6092f5f372851e2d6bf12b4b23209558038b9fda.1639971376.git.edwinchiu0505tw@gmail.com>
 <20211220121050.rnd3o7d5cksqbqnk@bogus>
In-Reply-To: <20211220121050.rnd3o7d5cksqbqnk@bogus>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.40]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VkZWVwIGFuZCBEYW5pZWw6DQoNClRoYW5rcyB5b3VyIHJlc3BvbnNlLg0KTXkgQ1BVIGlz
IGFybSBDQTcgdGhhdCBpcyAzMmJpdHMgY3B1Lg0KSWYgSSBkaXJlY3RseSB1c2VkIGNwdWlkbGUt
YXJtLmMgZnVuY3Rpb24gd2l0aCBlbmFibGUgIkdlbmVyaWMgQVJNL0FSTTY0IENQVSBpZGxlIERy
aXZlciIsDQp0aGUgY3B1aWRsZSBkcml2ZXIgbW91bnQgZmFpbCB3aXRoICJ1bnN1cHBvcnRlZCBl
bmFibGUtbWV0aG9kIHByb3BlcnR5Ii4NCg0KVGhpcyBpcyBkdWUgdG8gbGludXgga2VybmVsIG5v
IGludm9rZSBDUFVJRExFX01FVEhPRF9PRl9ERUNMQVJFIGZvciBhcm0gMzJiaXRzIGNwdS4NClRo
ZXJlIGhhdmUgbm8gZGVmaW5lIGNwdWlkbGVfb3BzLmluaXQgYW5kIGNwdWlkbGVfb3BzLnN1c3Bl
bmQgZnVuY3Rpb24gZm9yIGFybSAzMmJpdHMgY3B1IHRvby4NCg0KU28gSSBjcmVhdGUgY3B1aWRs
ZS1zdW5wbHVzLmMgdG8gZXhlY3V0ZSBteSBjcHVpZGxlIGZ1bmN0aW9uLg0KUGxlYXNlIGNvcnJl
Y3QgbWUgaWYgSSBnb3QgbWlzdGFrZS4NCg0KDQqq9KurrnAgRWR3aW5DaGl1DQq0vK/guUK64rFN
rtcNClQ6ICs4ODYtMy01Nzg2MDA1IGV4dC4yNTkwDQplZHdpbi5jaGl1QHN1bnBsdXMuY29tDQoz
MDAgt3Omy6zsvse26bDPs9C3c6RAuPQxObi5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4gU2VudDog
TW9uZGF5LCBEZWNlbWJlciAyMCwgMjAyMSA4OjExIFBNDQo+IFRvOiBFZHdpbiBDaGl1IDxlZHdp
bmNoaXUwNTA1dHdAZ21haWwuY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBFZHdpbiBD
aGl1IKr0q6uucCA8ZWR3aW4uY2hpdUBzdW5wbHVzLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyByYWZhZWxAa2VybmVsLm9y
ZzsgU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47DQo+IGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDIvMl0gY3B1aWRsZTpzdW5wbHVzOmNyZWF0ZSBjcHVpZGxlIGRyaXZlciBmb3Igc3Vu
cGx1cyBzcDcwMjENCj4gDQo+IE9uIE1vbiwgRGVjIDIwLCAyMDIxIGF0IDAxOjM3OjMyUE0gKzA4
MDAsIEVkd2luIENoaXUgd3JvdGU6DQo+ID4gQ3JlYXRlIGNwdWlkbGUgZHJpdmVyIGZvciBzdW5w
bHVzIHNwNzAyMSBjaGlwDQo+ID4NCj4gDQo+IEJhc2VkIG9uIHRoZSBkcml2ZXIgaGVyZSwgSSBj
b3VsZG4ndCB1bmRlcnN0YW5kIHdoeSB5b3UgY2FuJ3QgbWFrZSB1c2Ugb2YgZXhpc3RpbmcgY3B1
aWRsZS1hcm0uYyBkcml2ZXINCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0K
