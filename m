Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342CB48E8AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiANK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:56:05 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:34630
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240580AbiANK4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:56:03 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(23023:0:AUTH_RELAY)
        (envelope-from <wells.lu@sunplus.com>); Fri, 14 Jan 2022 18:56:16 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 14 Jan 2022 18:56:11 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 14 Jan 2022 18:56:11 +0800
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
Thread-Index: AQHX+JsJQRl6kRXEwk+dQHdfPj/+4axC0feAgAMwBYCAFioXgIAEjh2ggAAegACAARLWMP//9D8AgACSwAA=
Date:   Fri, 14 Jan 2022 10:56:10 +0000
Message-ID: <b9c1876c9d0f48a3a8d7e091d47fc069@sphcmbx02.sunplus.com.tw>
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
 <1640331779-18277-3-git-send-email-wellslutw@gmail.com>
 <CAHp75Vd3iMM+NteJXP_mMAyw5momk3xzp1Y2GX-YJZfFSAwo9A@mail.gmail.com>
 <f87b21407ed44630a86b2661deab4a58@sphcmbx02.sunplus.com.tw>
 <CAHp75VcPB_K6RD8tnMarwGCeaOKcQ_knxvKEW9WNn_4ce41szw@mail.gmail.com>
 <cf53f5dc57e342078ec14a771ba639ca@sphcmbx02.sunplus.com.tw>
 <CAHp75Vf0=Sf8sGtgCo7bMjVFGYDcJOasLqdSHTnQ0YPgSbrr2g@mail.gmail.com>
 <9e15ccc8ee844f1eab320001bc8bc235@sphcmbx02.sunplus.com.tw>
 <CAHp75VfxtGue7bbMm_MU2GWwWo4aZLW2Pj_U9ocCQmWr6wfGMw@mail.gmail.com>
In-Reply-To: <CAHp75VfxtGue7bbMm_MU2GWwWo4aZLW2Pj_U9ocCQmWr6wfGMw@mail.gmail.com>
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

PiAuLi4NCj4gDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBib29sICJTdW5wbHVzIFNQNzAyMSBQ
aW5NdXggYW5kIEdQSU8gZHJpdmVyIg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBXaHkg
Ym9vbCBhbmQgbm90IHRyaXN0YXRlPw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFBpbmN0cmwg
ZHJpdmVyIGlzIHNlbGVjdGVkIGJ5IG1hbnkgZHJpdmVycyBpbiBTUDcwMjEgcGxhdGZvcm0uDQo+
ID4gPiA+ID4gPiBXZSBuZXZlciBidWlsZCBpdCBhcyBhIG1vZHVsZSwgYnV0IGJ1aWxkLWluIHRv
IGtlcm5lbC4NCj4gPiA+ID4gPiA+IFNvIHdlIHVzZSAiYm9vbCIuDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gU2hvdWxkIHdlIHNldCBpdCB0byB0cmlzdGF0ZT8NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFlvdSBzdGlsbCBoYXZlbid0IGFuc3dlcmVkICJ3aHkiLCBzbyBJIGNhbid0IHRlbGwgeW91
Lg0KPiA+ID4gPg0KPiA+ID4gPiBJIGFtIHB1enpsZWQgYmVjYXVzZSBJIHRoaW5rIEkgaGF2ZSBh
bnN3ZXJlZCAid2h5Ii4NCj4gPiA+DQo+ID4gPiBOb3BlLiA6LSkNCj4gPiA+DQo+ID4gPiA+IEJl
Y2F1c2UgUGluY3RybCBkcml2ZXIgaXMgbmVjZXNzYXJ5IGZvciBhbGwgU1A3MDIxLWJhc2VkIHBs
YXRmb3Jtcy4NCj4gPiA+DQo+ID4gPiAiV2h5PyIgV2h5IGlzIGl0IG5lY2Vzc2FyeSAodG8gYmUg
YnVpbHQtaW4pPw0KPiA+DQo+ID4gUGluY3RybCBpcyBuZWNlc3NhcnkgdG8gYmUgYnVpbHQtaW4g
YmVjYXVzZSBkcml2ZXJzIG9mIGJvb3QtZGV2aWNlLA0KPiA+IGxpa2UgZU1NQywgU0QgY2FyZCwg
TkFORCBmbGFzaCwgYW5kIE5PUiBmbGFzaCBkcml2ZXJzLCBuZWVkIGl0Lg0KPiA+DQo+ID4gU1A3
MDIxIHN1cHBvcnRzIGJvb3RpbmcgZnJvbSBlTU1DLCBTRCBjYXJkLCBOQU5EIGZsYXNoIGFuZCBO
T1IgZmxhc2gNCj4gPiBkZXZpY2VzLiBUaGVpciBkcml2ZXJzIG5lZWQgUGluY3RybCBkcml2ZXIg
cHJvYmVzIGluIGFkdmFuY2UuDQo+IA0KPiBPbiB4ODYgcGxhdGZvcm1zLCBmb3IgZXhhbXBsZSwg
Ym9vdGluZyBmcm9tIGVNTUMgYW5kIFNEIGNhcmQgZG9lcyBub3QgcmVxdWlyZSBhIHBpbg0KPiBj
b250cm9sIGRyaXZlciB0byBiZSBidWlsdC1pbi4gV2h5IGlzIHRoaXMgcmVxdWlyZW1lbnQgZm9y
IFNQIHBsYXRmb3Jtcz8NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNo
ZXZjaGVua28NCg0KQmVjYXVzZSBhbGwgcGlucyBvZiBib290LWRldmljZSBtdWx0aXBsZXggd2l0
aCBHUElPIHBpbnMuDQoNClNQNzAyMSBwbGF0Zm9ybXMgc3VwcG9ydCBtdWx0aSBib290IGRldmlj
ZXMsIGluY2x1ZGluZyBlTU1DLCBTRCBjYXJkLA0KU1BJLU5PUiBmbGFzaCwgU1BJLU5BTkQgZmxh
c2guIEVhY2ggYm9vdCBkZXZpY2UgaGFzIGNvbnRyb2wtYml0KHMpIA0KdG8gZW5hYmxlIGl0Lg0K
DQpGb3IgZXhhbXBsZSAjMSwgaWYgY29udHJvbC1iaXRzIG9mIFNQSS1OT1IgZmxhc2ggaXMgc2V0
IDEsDQpHUElPIDgzLCA4NCwgODYsIDg3IGFyZSBjb25uZWN0ZWQgdG8gU1BJLU5PUiBmbGFzaC4N
CklmIGNvbnRyb2wtYml0cyBvZiBTUEktTk9SIGZsYXNoIGlzIHNldCAyLA0KR1BJTyA3NiwgNzgs
IDc5LCA4MSBhcmUgY29ubmVjdGVkIHRvIFNQSS1OT1IgZmxhc2guDQpJZiBjb250cm9sLWJpdHMg
b2YgU1BJLU5PUiBmbGFzaCBpcyBzZXQgMCwgbm8gcGluIGlzIA0KY29ubmVjdGVkIFNQSS1OT1Ig
Zmxhc2guDQoNCkZvciBleGFtcGxlICMyLCBpZiBjb250cm9sLWJpdHMgb2YgZU1NQyBkZXZpY2Ug
aXMgc2V0IDEsDQpHUElPIDcyLCA3MywgNzQsIDc1LCA3NiwgNzcsIDc4LCA3OSwgODAsIDgxIGFy
ZSBjb25uZWN0ZWQgdG8NCmVNTUMgZGV2aWNlLg0KSWYgY29udHJvbC1iaXRzIG9mIGVNTUMgZGV2
aWNlIGlzIHNldCAwLCBubyBwaW4gaXMgY29ubmVjdGVkIA0KZU1NQyBkZXZpY2UuDQoNCkZvciBl
eGFtcGxlICMzLCBpZiBjb250cm9sLWJpdHMgb2YgU0RDYXJkIGRldmljZSBpcyBzZXQgMSwNCkdQ
SU8gNjUsIDY2LCA2NywgNjgsIDY5LCA3MCBhcmUgY29ubmVjdGVkIHRvIFNEIENhcmQgZGV2aWNl
Lg0KSWYgY29udHJvbC1iaXRzIG9mIFNEQ2FyZCBkZXZpY2UgaXMgc2V0IDAsIG5vIHBpbiBpcyBj
b25uZWN0ZWQgDQpTRENhcmQgZGV2aWNlLg0KDQpOb3RlIHRoYXQgYWxsIHBpbnMgbXVsdGlwbGV4
IHdpdGggR1BJTyBwaW5zLg0KDQpOb3JtYWxseSwgb25seSBhIGJvb3QtZGV2aWNlIGlzIGVuYWJs
ZWQuIEFsbCBvdGhlciBHUElPIHBpbnMNCmFyZSByZWxlYXNlZCBmb3IgcGVyaXBoZXJhbHMgKGNv
bnRyb2xsZWQgYnkgZnVsbHktcGlubXV4DQpPciBncm91cCBwaW5tdXgpIG9yIElPIHByb2Nlc3Nv
cg0KDQpQaW5jdHJsIGRyaXZlciBpcyByZXNwb25zaWJsZSBmb3Igc2V0dXAgdGhlIHBpbnMuDQpJ
ZiBQaW5jdHJsIGZhaWxzIHRvIHByb2JlLCBib290LWRldmljZSBhbHNvIGZhaWxzIHRvIHByb2Jl
Lg0KDQoNCkJlc3QgcmVnYXJkcywNCldlbGxzIEx1DQo=
