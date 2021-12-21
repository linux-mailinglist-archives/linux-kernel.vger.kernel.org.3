Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A8347BB25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhLUHdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:33:20 -0500
Received: from mail.emtrion.de ([87.139.198.129]:44325 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232745AbhLUHdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:33:19 -0500
Received: from EMT-KA-S004.emtrion.local (2003:f9:5824:1:c59f:32f4:72e5:b9e1)
 by EMT-KA-S004.emtrion.local (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 21 Dec
 2021 08:33:16 +0100
Received: from EMT-KA-S004.emtrion.local ([fe80::c59f:32f4:72e5:b9e1]) by
 EMT-KA-S004.emtrion.local ([fe80::c59f:32f4:72e5:b9e1%11]) with mapi id
 15.02.0922.019; Tue, 21 Dec 2021 08:33:16 +0100
From:   "Mueller, Reinhold" <Reinhold.Mueller@emtrion.de>
To:     'Fabio Estevam' <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH v4 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
Thread-Topic: [PATCH v4 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
Thread-Index: AQHX9XKJlzVF8fJ5YEOzNVjKch3kBaw8AYeAgACLvEA=
Date:   Tue, 21 Dec 2021 07:33:16 +0000
Message-ID: <e6adf5d9473e417d85a1845b007a4ee1@emtrion.de>
References: <20211220072332.81072-1-reinhold.mueller@emtrion.com>
 <20211220072332.81072-3-reinhold.mueller@emtrion.com>
 <CAOMZO5BvLZYh3=q_-XNcw-v5wDcBpR3Qo26Gd3hTtJ_a-FQiuA@mail.gmail.com>
In-Reply-To: <CAOMZO5BvLZYh3=q_-XNcw-v5wDcBpR3Qo26Gd3hTtJ_a-FQiuA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2003:f9:5824:1:602d:8cff:3d08:141a]
x-c2processedorg: 5b249fcb-306f-4927-9982-5d11b1d300ce
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCnRoYW5rcyBmb3IgdGhlIGZhc3QgZmVlZGJhY2suDQpCZWxvdyBpIGhhdmUg
Y29tbWVudGVkIHlvdXIgaXNzdWUgZm9yIGNsYXJpZmljYXRpb24uDQoNClJlZ2FyZHMNClJlaW5o
b2xkDQoNCg0KUmVpbmhvbGQgTXVlbGxlcg0KU29mdHdhcmUgZW5naW5lZXINCg0KDQplbXRyaW9u
IEdtYkgNCkFtIEhhc2VuYmllbCA2IHwgNzYyOTcgU3R1dGVuc2VlIHwgR2VybWFueQ0KDQpQaG9u
ZSArNDkgNzI0NCA2MjY5NCAyMA0KRmF4ICs0OSA3MjQ0IDYyNjk0IDE5DQpFbWFpbCBSZWluaG9s
ZC5NdWVsbGVyQGVtdHJpb24uZGUNCk9ubGluZSB3d3cuZW10cmlvbi5kZQ0KDQoqKiogTWVycnkg
WC1NYXMgJiBIYXBweSBOZXcgWWVhciAyMDIyICoqKg0KDQoNCmVtdHJpb24gR21iSCDigKIgQW10
c2dlcmljaHQgTWFubmhlaW0g4oCiIEhSQiAxMTAgMzAwIOKAoiBHZXNjaMOkZnRzZsO8aHJlcjog
UmFtb25hIE1hdXJlciwgQWNobWVkIEhhZGRvdSDigKIgVW1zYXR6c3RldWVyaWRlbnRpZmlrYXRp
b25zbnVtbWVyOkRFODEzNjk0MjYwIOKAoiBJbXByZXNzdW06IHd3dy5lbXRyaW9uLmRlL2RlL2lt
cHJlc3N1bS5odG1sDQoNCkhJTldFSVM6IFBlcnNvbmVuYmV6b2dlbmUgRGF0ZW4sIGRpZSBTaWUg
cGVyIEUtTWFpbCBhbiB1bnMgw7xiZXJtaXR0ZWxuLCB3ZXJkZW4gYmVpIHVucyBnZXNwZWljaGVy
dCB1bmQgdmVyYXJiZWl0ZXQuIEluZm9ybWF0aW9uZW4genUgdW5zZXJlbiBnZXNldHpsaWNoZW4g
SW5mb3JtYXRpb25zcGZsaWNodGVuLCB6dSB1bnMgdW5kIHVuc2VyZW4gRGllbnN0bGVpc3R1bmdl
biBmaW5kZW4gU2llIGluIHVuc2VyZW4gRGF0ZW5zY2h1dHpoaW53ZWlzZW4uDQpEaWVzZSBFLU1h
aWwga2FubiB2ZXJ0cmF1bGljaGUgdW5kIC8gb2RlciByZWNodGxpY2ggZ2VzY2jDvHR6dGUgSW5m
b3JtYXRpb25lbiBlbnRoYWx0ZW4uIFdlbm4gU2llIG5pY2h0IGRlciByaWNodGlnZSBBZHJlc3Nh
dCBzaW5kLCBvZGVyIGRpZXNlIEUtTWFpbCBpcnJ0w7xtbGljaCBlcmhhbHRlbiBoYWJlbiwgaW5m
b3JtaWVyZW4gU2llIGJpdHRlIGRlbiBBYnNlbmRlciB1bmQgdmVybmljaHRlbiBkaWVzZSBNYWls
LiBEYXMgdW5lcmxhdWJ0ZSBrb3BpZXJlbiwgc293aWUgZGllIHVuYmVmdWd0ZSBXZWl0ZXJnYWJl
IGRpZXNlciBNYWlsIGlzdCBuaWNodCBnZXN0YXR0ZXQuDQo+IC0tLS0tVXJzcHLDvG5nbGljaGUg
TmFjaHJpY2h0LS0tLS0NCj4gVm9uOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+
DQo+IEdlc2VuZGV0OiBEaWVuc3RhZywgMjEuIERlemVtYmVyIDIwMjEgMDE6MDYNCj4gQW46IE11
ZWxsZXIsIFJlaW5ob2xkIDxSZWluaG9sZC5NdWVsbGVyQGVtdHJpb24uZGU+DQo+IENjOiBSb2Ig
SGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyDQo+IDxzLmhhdWVyQHBl
bmd1dHJvbml4LmRlPjsgU2FzY2hhIEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBT
aGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBOWFAgTGludXggVGVhbSA8bGludXgtDQo+
IGlteEBueHAuY29tPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJ
Q0UgVFJFRQ0KPiBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1r
ZXJuZWwgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBCZXRyZWZmOiBSZTog
W1BBVENIIHY0IDIvMl0gYXJtNjQ6IGR0czogaW14OG1tOiBBZGQgc3VwcG9ydCBmb3IgZW10cmlv
bg0KPiBlbUNPTi1NWDhNIE1pbmkNCj4NCj4gSGkgUmVpbmhvbGQsDQo+DQo+IE9uIE1vbiwgRGVj
IDIwLCAyMDIxIGF0IDQ6MjMgQU0gPHJlaW5ob2xkLm11ZWxsZXJAZW10cmlvbi5jb20+IHdyb3Rl
Og0KPg0KPiA+ICsgICAgICAgcGluY3RybF9lY3NwaTE6IGVjc3BpMS1ncnAgew0KPiA+ICsgICAg
ICAgICAgICAgICBmc2wscGlucyA9IDwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDhN
TV9JT01VWENfRUNTUEkxX1NDTEtfRUNTUEkxX1NDTEsgICAgICAgICAgICAweDgyDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgTVg4TU1fSU9NVVhDX0VDU1BJMV9NT1NJX0VDU1BJMV9NT1NJ
ICAgICAgICAgICAgMHg4Mg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIE1YOE1NX0lPTVVY
Q19FQ1NQSTFfTUlTT19FQ1NQSTFfTUlTTyAgICAgICAgICAgIDB4ODINCj4gPiArICAgICAgICAg
ICAgICAgPjsNCj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgcGluY3RybF9lY3Nw
aTFfY3M6IGVjc3BpMS1jcyB7DQo+ID4gKyAgICAgICAgICAgICAgIGZzbCxwaW5zID0gPA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIE1YOE1NX0lPTVVYQ19FQ1NQSTFfU1MwX0dQSU81X0lP
OSAgICAgICAgICAgICAgIDB4NDAwMDANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDhN
TV9JT01VWENfRUNTUEkyX1NTMF9HUElPNV9JTzEzICAgICAgICAgICAgICAweDQwMDAwDQo+DQo+
IFRoaXMgdmVyc2lvbiBsb29rcyBnb29kIHRvIG1lLg0KPg0KPiBPbmUgbml0OiB5b3Ugc2VlbSB0
byB1c2UgYSBzaW5nbGUgU1BJIGNoaXBzZWxlY3QsIGJ1dCB5b3UgYWRkIHR3byBlbnRyaWVzDQo+
IGhlcmUuDQo+DQo+IElzIHRoZSBNWDhNTV9JT01VWENfRUNTUEkyX1NTMF9HUElPNV9JTzEzIG5l
ZWRlZCB0b28/DQpZZXMsIG9mIGNvdXJzZSB0aGUgZW1DT04gcHJvdmlkZXMgYSBjb25uZWN0b3Ig
Y29ubmVjdGluZyB0d28gc2xhdmVzIG9uIHRoZSBzcGkgYnVzLg0KPg0KPiBFaXRoZXIgd2F5Og0K
Pg0KPiBSZXZpZXdlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0K
