Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2050548E2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiANCvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:51:44 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:45662
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236108AbiANCvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:51:43 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(23029:0:AUTH_RELAY)
        (envelope-from <wells.lu@sunplus.com>); Fri, 14 Jan 2022 10:51:55 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 14 Jan 2022 10:51:55 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 14 Jan 2022 10:51:55 +0800
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
Thread-Index: AQHX+JsJQRl6kRXEwk+dQHdfPj/+4axC0feAgAMwBYCAFioXgIAEjh2ggAAegACAARLWMA==
Date:   Fri, 14 Jan 2022 02:51:55 +0000
Message-ID: <9e15ccc8ee844f1eab320001bc8bc235@sphcmbx02.sunplus.com.tw>
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
 <1640331779-18277-3-git-send-email-wellslutw@gmail.com>
 <CAHp75Vd3iMM+NteJXP_mMAyw5momk3xzp1Y2GX-YJZfFSAwo9A@mail.gmail.com>
 <f87b21407ed44630a86b2661deab4a58@sphcmbx02.sunplus.com.tw>
 <CAHp75VcPB_K6RD8tnMarwGCeaOKcQ_knxvKEW9WNn_4ce41szw@mail.gmail.com>
 <cf53f5dc57e342078ec14a771ba639ca@sphcmbx02.sunplus.com.tw>
 <CAHp75Vf0=Sf8sGtgCo7bMjVFGYDcJOasLqdSHTnQ0YPgSbrr2g@mail.gmail.com>
In-Reply-To: <CAHp75Vf0=Sf8sGtgCo7bMjVFGYDcJOasLqdSHTnQ0YPgSbrr2g@mail.gmail.com>
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

PiA+ID4gPiA+ID4gKyAgICAgICBib29sICJTdW5wbHVzIFNQNzAyMSBQaW5NdXggYW5kIEdQSU8g
ZHJpdmVyIg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2h5IGJvb2wgYW5kIG5vdCB0cmlzdGF0ZT8N
Cj4gPiA+ID4NCj4gPiA+ID4gUGluY3RybCBkcml2ZXIgaXMgc2VsZWN0ZWQgYnkgbWFueSBkcml2
ZXJzIGluIFNQNzAyMSBwbGF0Zm9ybS4NCj4gPiA+ID4gV2UgbmV2ZXIgYnVpbGQgaXQgYXMgYSBt
b2R1bGUsIGJ1dCBidWlsZC1pbiB0byBrZXJuZWwuDQo+ID4gPiA+IFNvIHdlIHVzZSAiYm9vbCIu
DQo+ID4gPiA+DQo+ID4gPiA+IFNob3VsZCB3ZSBzZXQgaXQgdG8gdHJpc3RhdGU/DQo+ID4gPg0K
PiA+ID4gWW91IHN0aWxsIGhhdmVuJ3QgYW5zd2VyZWQgIndoeSIsIHNvIEkgY2FuJ3QgdGVsbCB5
b3UuDQo+ID4NCj4gPiBJIGFtIHB1enpsZWQgYmVjYXVzZSBJIHRoaW5rIEkgaGF2ZSBhbnN3ZXJl
ZCAid2h5Ii4NCj4gDQo+IE5vcGUuIDotKQ0KPiANCj4gPiBCZWNhdXNlIFBpbmN0cmwgZHJpdmVy
IGlzIG5lY2Vzc2FyeSBmb3IgYWxsIFNQNzAyMS1iYXNlZCBwbGF0Zm9ybXMuDQo+IA0KPiAiV2h5
PyIgV2h5IGlzIGl0IG5lY2Vzc2FyeSAodG8gYmUgYnVpbHQtaW4pPw0KDQpQaW5jdHJsIGlzIG5l
Y2Vzc2FyeSB0byBiZSBidWlsdC1pbiBiZWNhdXNlIGRyaXZlcnMgb2YgYm9vdC1kZXZpY2UsIA0K
bGlrZSBlTU1DLCBTRCBjYXJkLCBOQU5EIGZsYXNoLCBhbmQgTk9SIGZsYXNoIGRyaXZlcnMsIG5l
ZWQgaXQuDQoNClNQNzAyMSBzdXBwb3J0cyBib290aW5nIGZyb20gZU1NQywgU0QgY2FyZCwgTkFO
RCBmbGFzaCBhbmQgTk9SIGZsYXNoIA0KZGV2aWNlcy4gVGhlaXIgZHJpdmVycyBuZWVkIFBpbmN0
cmwgZHJpdmVyIHByb2JlcyBpbiBhZHZhbmNlLg0KDQoNCj4gLi4uDQo+IA0KPiA+ID4gPiA+ID4g
KyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0NCj4gPiA+ID4gPiA+ICsgb2Zfbm9kZV9n
ZXQocGRldi0+ZGV2Lm9mX25vZGUpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2hhdCdzIHRoZSBy
b2xlIG9mIG9mX25vZGVfZ2V0KCk/DQo+ID4gPiA+DQo+ID4gPiA+IEknbGwgcmVtb3ZlIHRoZSB1
bnVzZWQgY29kZXMuDQo+ID4gPiA+IEkgdGhpbmsgaXQgd2FzIHVzZWQgdG8gY2hlY2sgaWYgT0Yg
bm9kZSBleGlzdHMuDQo+ID4gPg0KPiA+ID4gQW5kIGlmIGl0IGRvZXNuJ3QsIHdoYXQgaXMgdGhl
IGRpZmZlcmVuY2U/DQo+ID4gPg0KPiA+ID4gWW91IGFyZSB0aGUgYXV0aG9yIG9mIHRoaXMgY29k
ZSwgcGxlYXNlIGJlIHByZXBhcmVkIHRvIGV4cGxhaW4gZXZlcnkgbGluZSBpbiBpdC4NCj4gPg0K
PiA+IEZyb20ga2VybmVsLWRvYyBjb21tZW50LCBvZl9ub2RlX2dldCgpIGluY3JlbWVudHMgcmVm
Y291bnQgb2YgYSBub2RlLg0KPiA+IEkgdGhpbmsgYXMgYSBwbGF0Zm9ybSBkcml2ZXIsIHdlIGRv
bid0IG5lZWQgdG8gY2hlY2sgaWYgdGhlIG5vZGUgZXhpc3RzIG9yIG5vdC4NCj4gPiBJZiBub3Qg
ZXhpc3QsIHBsYXRmb3JtIGRyaXZlciB3aWxsIG5vdCBiZSBwcm9iZWQuDQo+IA0KPiBSaWdodCEN
Cj4gDQo+IC4uLg0KPiANCj4gPiA+ID4gPiBXaHkgaXMgdGhpcyBpbiB0aGUgaGVhZGVyPw0KPiA+
ID4gPg0KPiA+ID4gPiBEbyB5b3UgbWVhbiBJIG5lZWQgdG8gbW92ZSB0aGlzICJzdHJ1Y3Qgc3Bw
Y3RsX2dwaW9fY2hpcCB7IC4uLiB9Ig0KPiA+ID4gPiBkZWNsYXJhdGlvbiB0byBjIGZpbGUgYmVj
YXVzZSBpdCBpcyBvbmx5IHVzZWQgYnkgdGhlIGMgZmlsZT8NCj4gPiA+DQo+ID4gPiBZZXMuDQo+
ID4NCj4gPiBCdXQgInN0cnVjdCBzcHBjdGxfZ3Bpb19jaGlwIiBpcyBub3Qgb25seSB1c2VkIGlu
IGMgZmlsZSwgYnV0IGFsc28NCj4gPiB1c2VkIGluIHRoZSBzYW1lIGhlYWRlciBmaWxlIGp1c3Qg
YmVuZWF0aCBpdC4gUmVmZXIgdG8gY29kZSBiZWxvdzoNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHNu
aXBwZXQuIEl0IGFjdHVhbGx5IHNob3dzIHRoZSBvcHBvc2l0ZS4gTm8sIGJlbG93IGlzIHRoZSB1
c2VyIG9mIHRoZQ0KPiBfcG9pbnRlcl8gdG8gdGhlIHN0cnVjdCBvZiB0aGF0IHR5cGUuIFlvdSBt
YXkgZWFzaWx5IHVzZSB0aGUgIm9wYXF1ZSBwb2ludGVyIiBhcHByb2FjaC4NCj4gSS5vLncuIG15
IGNvbW1lbnQgc3RheXMuDQo+IA0KPiA+IHN0cnVjdCBzcHBjdGxfZ3Bpb19jaGlwIHsNCj4gPiAg
ICAgICAgIDoNCj4gPiAgICAgICAgIDoNCj4gPiB9Ow0KPiA+DQo+ID4gc3RydWN0IHNwcGN0bF9w
ZGF0YSB7DQo+ID4gICAgICAgICA6DQo+ID4gICAgICAgICA6DQo+ID4gICAgICAgICBzdHJ1Y3Qg
c3BwY3RsX2dwaW9fY2hpcCAqc3BwX2djaGlwOw0KPiA+ICAgICAgICAgOg0KPiA+ICAgICAgICAg
Og0KPiA+IH07DQoNCkkgc2VlIQ0KSSdsbCBtb3ZlIHN0cnVjdCBzcHBjdGxfZ3Bpb19jaGlwIHsu
Li59IHRvIGMgZmlsZSBuZXh0IHBhdGNoLg0KDQoNCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMs
DQo+IEFuZHkgU2hldmNoZW5rbw0KDQpUaGFua3MsDQpXZWxscyBMdQ0K
