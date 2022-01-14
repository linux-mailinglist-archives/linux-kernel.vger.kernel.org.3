Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EFC48E94B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbiANLgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:36:17 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:37638
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234586AbiANLgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:36:16 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(23040:0:AUTH_RELAY)
        (envelope-from <wells.lu@sunplus.com>); Fri, 14 Jan 2022 19:36:31 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 14 Jan 2022 19:36:31 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 14 Jan 2022 19:36:31 +0800
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
Subject: RE: [PATCH v5 2/2] pinctrl: Add driver for Sunplus SP7021
Thread-Topic: [PATCH v5 2/2] pinctrl: Add driver for Sunplus SP7021
Thread-Index: AQHX+JsJQRl6kRXEwk+dQHdfPj/+4axC0feAgAMwBYCAFioXgIAEjh2ggAAegACAARLWMP//9D8AgACSwAD//4aTgIAAiKZw
Date:   Fri, 14 Jan 2022 11:36:31 +0000
Message-ID: <cbfe10d1243f4d6bb37cf936f5926351@sphcmbx02.sunplus.com.tw>
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
 <1640331779-18277-3-git-send-email-wellslutw@gmail.com>
 <CAHp75Vd3iMM+NteJXP_mMAyw5momk3xzp1Y2GX-YJZfFSAwo9A@mail.gmail.com>
 <f87b21407ed44630a86b2661deab4a58@sphcmbx02.sunplus.com.tw>
 <CAHp75VcPB_K6RD8tnMarwGCeaOKcQ_knxvKEW9WNn_4ce41szw@mail.gmail.com>
 <cf53f5dc57e342078ec14a771ba639ca@sphcmbx02.sunplus.com.tw>
 <CAHp75Vf0=Sf8sGtgCo7bMjVFGYDcJOasLqdSHTnQ0YPgSbrr2g@mail.gmail.com>
 <9e15ccc8ee844f1eab320001bc8bc235@sphcmbx02.sunplus.com.tw>
 <CAHp75VfxtGue7bbMm_MU2GWwWo4aZLW2Pj_U9ocCQmWr6wfGMw@mail.gmail.com>
 <b9c1876c9d0f48a3a8d7e091d47fc069@sphcmbx02.sunplus.com.tw>
 <CAHp75VdTm5T=VGgrqfp+3bLAu4chosirJ2uBeoA5MxvV+FMg_Q@mail.gmail.com>
In-Reply-To: <CAHp75VdTm5T=VGgrqfp+3bLAu4chosirJ2uBeoA5MxvV+FMg_Q@mail.gmail.com>
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

PiAuLi4NCj4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgYm9vbCAiU3VucGx1cyBTUDcw
MjEgUGluTXV4IGFuZCBHUElPIGRyaXZlciINCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4gPiBXaHkgYm9vbCBhbmQgbm90IHRyaXN0YXRlPw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gUGluY3RybCBkcml2ZXIgaXMgc2VsZWN0ZWQgYnkgbWFueSBkcml2ZXJzIGlu
IFNQNzAyMSBwbGF0Zm9ybS4NCj4gPiA+ID4gPiA+ID4gPiBXZSBuZXZlciBidWlsZCBpdCBhcyBh
IG1vZHVsZSwgYnV0IGJ1aWxkLWluIHRvIGtlcm5lbC4NCj4gPiA+ID4gPiA+ID4gPiBTbyB3ZSB1
c2UgImJvb2wiLg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gU2hvdWxkIHdlIHNl
dCBpdCB0byB0cmlzdGF0ZT8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gWW91IHN0aWxs
IGhhdmVuJ3QgYW5zd2VyZWQgIndoeSIsIHNvIEkgY2FuJ3QgdGVsbCB5b3UuDQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gSSBhbSBwdXp6bGVkIGJlY2F1c2UgSSB0aGluayBJIGhhdmUgYW5zd2Vy
ZWQgIndoeSIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBOb3BlLiA6LSkNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gQmVjYXVzZSBQaW5jdHJsIGRyaXZlciBpcyBuZWNlc3NhcnkgZm9yIGFsbCBTUDcw
MjEtYmFzZWQgcGxhdGZvcm1zLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIldoeT8iIFdoeSBpcyBp
dCBuZWNlc3NhcnkgKHRvIGJlIGJ1aWx0LWluKT8NCj4gPiA+ID4NCj4gPiA+ID4gUGluY3RybCBp
cyBuZWNlc3NhcnkgdG8gYmUgYnVpbHQtaW4gYmVjYXVzZSBkcml2ZXJzIG9mDQo+ID4gPiA+IGJv
b3QtZGV2aWNlLCBsaWtlIGVNTUMsIFNEIGNhcmQsIE5BTkQgZmxhc2gsIGFuZCBOT1IgZmxhc2gg
ZHJpdmVycywgbmVlZCBpdC4NCj4gPiA+ID4NCj4gPiA+ID4gU1A3MDIxIHN1cHBvcnRzIGJvb3Rp
bmcgZnJvbSBlTU1DLCBTRCBjYXJkLCBOQU5EIGZsYXNoIGFuZCBOT1INCj4gPiA+ID4gZmxhc2gg
ZGV2aWNlcy4gVGhlaXIgZHJpdmVycyBuZWVkIFBpbmN0cmwgZHJpdmVyIHByb2JlcyBpbiBhZHZh
bmNlLg0KPiA+ID4NCj4gPiA+IE9uIHg4NiBwbGF0Zm9ybXMsIGZvciBleGFtcGxlLCBib290aW5n
IGZyb20gZU1NQyBhbmQgU0QgY2FyZCBkb2VzDQo+ID4gPiBub3QgcmVxdWlyZSBhIHBpbiBjb250
cm9sIGRyaXZlciB0byBiZSBidWlsdC1pbi4gV2h5IGlzIHRoaXMgcmVxdWlyZW1lbnQgZm9yIFNQ
DQo+IHBsYXRmb3Jtcz8NCj4gDQo+ID4gQmVjYXVzZSBhbGwgcGlucyBvZiBib290LWRldmljZSBt
dWx0aXBsZXggd2l0aCBHUElPIHBpbnMuDQo+ID4NCj4gPiBTUDcwMjEgcGxhdGZvcm1zIHN1cHBv
cnQgbXVsdGkgYm9vdCBkZXZpY2VzLCBpbmNsdWRpbmcgZU1NQywgU0QgY2FyZCwNCj4gPiBTUEkt
Tk9SIGZsYXNoLCBTUEktTkFORCBmbGFzaC4gRWFjaCBib290IGRldmljZSBoYXMgY29udHJvbC1i
aXQocykgdG8NCj4gPiBlbmFibGUgaXQuDQo+ID4NCj4gPiBGb3IgZXhhbXBsZSAjMSwgaWYgY29u
dHJvbC1iaXRzIG9mIFNQSS1OT1IgZmxhc2ggaXMgc2V0IDEsIEdQSU8gODMsDQo+ID4gODQsIDg2
LCA4NyBhcmUgY29ubmVjdGVkIHRvIFNQSS1OT1IgZmxhc2guDQo+ID4gSWYgY29udHJvbC1iaXRz
IG9mIFNQSS1OT1IgZmxhc2ggaXMgc2V0IDIsIEdQSU8gNzYsIDc4LCA3OSwgODEgYXJlDQo+ID4g
Y29ubmVjdGVkIHRvIFNQSS1OT1IgZmxhc2guDQo+ID4gSWYgY29udHJvbC1iaXRzIG9mIFNQSS1O
T1IgZmxhc2ggaXMgc2V0IDAsIG5vIHBpbiBpcyBjb25uZWN0ZWQgU1BJLU5PUg0KPiA+IGZsYXNo
Lg0KPiA+DQo+ID4gRm9yIGV4YW1wbGUgIzIsIGlmIGNvbnRyb2wtYml0cyBvZiBlTU1DIGRldmlj
ZSBpcyBzZXQgMSwgR1BJTyA3MiwgNzMsDQo+ID4gNzQsIDc1LCA3NiwgNzcsIDc4LCA3OSwgODAs
IDgxIGFyZSBjb25uZWN0ZWQgdG8gZU1NQyBkZXZpY2UuDQo+ID4gSWYgY29udHJvbC1iaXRzIG9m
IGVNTUMgZGV2aWNlIGlzIHNldCAwLCBubyBwaW4gaXMgY29ubmVjdGVkIGVNTUMNCj4gPiBkZXZp
Y2UuDQo+ID4NCj4gPiBGb3IgZXhhbXBsZSAjMywgaWYgY29udHJvbC1iaXRzIG9mIFNEQ2FyZCBk
ZXZpY2UgaXMgc2V0IDEsIEdQSU8gNjUsDQo+ID4gNjYsIDY3LCA2OCwgNjksIDcwIGFyZSBjb25u
ZWN0ZWQgdG8gU0QgQ2FyZCBkZXZpY2UuDQo+ID4gSWYgY29udHJvbC1iaXRzIG9mIFNEQ2FyZCBk
ZXZpY2UgaXMgc2V0IDAsIG5vIHBpbiBpcyBjb25uZWN0ZWQgU0RDYXJkDQo+ID4gZGV2aWNlLg0K
PiA+DQo+ID4gTm90ZSB0aGF0IGFsbCBwaW5zIG11bHRpcGxleCB3aXRoIEdQSU8gcGlucy4NCj4g
Pg0KPiA+IE5vcm1hbGx5LCBvbmx5IGEgYm9vdC1kZXZpY2UgaXMgZW5hYmxlZC4gQWxsIG90aGVy
IEdQSU8gcGlucyBhcmUNCj4gPiByZWxlYXNlZCBmb3IgcGVyaXBoZXJhbHMgKGNvbnRyb2xsZWQg
YnkgZnVsbHktcGlubXV4IE9yIGdyb3VwIHBpbm11eCkNCj4gPiBvciBJTyBwcm9jZXNzb3INCj4g
DQo+IFRoYW5rcyBmb3IgdGhpcyBkZXRhaWxlZCBwaWN0dXJlIG9mIHRoZSBIVyBjb25maWd1cmF0
aW9uLg0KPiANCj4gPiBQaW5jdHJsIGRyaXZlciBpcyByZXNwb25zaWJsZSBmb3Igc2V0dXAgdGhl
IHBpbnMuDQo+ID4gSWYgUGluY3RybCBmYWlscyB0byBwcm9iZSwgYm9vdC1kZXZpY2UgYWxzbyBm
YWlscyB0byBwcm9iZS4NCj4gDQo+IEJ1dCBoYXZlIHlvdSB0cmllZCB0byBjb21waWxlIGl0IGFz
IGEgbW9kdWxlIGFuZCBzdXBwbHkgaXQgaW4gdGhlIGluaXRyYW1mcz8NCj4gDQo+IFdoYXQga2Vy
bmVsIGRvZXMgaW4gdGhpcyBjYXNlIGl0IHRha2VzIGFkZHJlc3Mgb2YgaW5pdHJhbWZzIGZyb20g
bWVtb3J5IChJIGJlbGlldmUNCj4geW91IGhhdmUgYm9vdGxvYWRlciB0aGF0IGNhcGFibGUgdG8g
c2V0dXAga2VybmVsLCBpbml0cmFtZnMsIGNvbW1hbmQgbGluZSwgYW5kIGRldmljZQ0KPiB0cmVl
IGJsb2IgYW5kIHBhc3MgdGhlIGNvbnRyb2wgdG8gdGhlIGtlcm5lbCkgYXQgc29tZSBwb2ludCwg
bW91bnRzIGl0IGFuZCBwcm9iZXMgdGhlDQo+IG1vZHVsZXMgdGhhdCBhcmUgcmVxdWlyZWQgdG8g
Z2V0IHlvdXIgYm9vdCBkZXZpY2UgcmVhZHkuDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJk
cywNCj4gQW5keSBTaGV2Y2hlbmtvDQoNClllcywgSSdsbCBtb2RpZnkgS2NvbmZpZyBhbmQgTWFr
ZWZpbGUgdG8gc3VwcG9ydCAiY29tcGlsZSBhcyBtb2R1bGUiLg0KDQpBY3R1YWxseSwgU1A3MDIx
IHBsYXRmb3JtcyBhbHNvIHN1cHBvcnQgYm9vdGluZyBmcm9tIHRmdHAgYW5kIG5mcyBzZXJ2ZXIu
DQpJbiB0aGVzZSB0d28gY2FzZXMsIG5vIGJvb3QgZGV2aWNlIGlzIGVuYWJsZWQgaW4gTGludXgg
a2VybmVsIChidXQgDQpib290IGRldmljZSBpcyBlbmFibGVkIGluIFUtQm9vdCkuIFBpbmN0cmwg
ZHJpdmVyIGNhbiBiZSBhIG1vZHVsZS4NCg0KDQpUaGFua3MsDQpXZWxscyBMdQ0K
