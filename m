Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD32481130
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbhL2JMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:12:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57018 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234861AbhL2JMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:12:20 -0500
X-UUID: 120c0e50eefc457bbb88f7d0572f9a88-20211229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IYlNhXTVg7RykrRTJ4Pn1wcnduyAqMsSQtTQ4GeTyeg=;
        b=pHnK3QWr9rtEsX73rEBk80fcBTuzQcmoceD+5jxBto9ZdvarJilRRZpT7en2UmV4M10owvjocB6lPInh+as3PZU8lScV7PIq7ckkDcbqvUsCa2dLRXVaPu3shmHWvEVXRONcsz/gwF94Qd03CMQx9FReIMcvXYbIYDuOVJMPRC0=;
X-UUID: 120c0e50eefc457bbb88f7d0572f9a88-20211229
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1210317601; Wed, 29 Dec 2021 17:12:17 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Dec 2021 17:12:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 29 Dec
 2021 17:12:13 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Dec 2021 17:12:12 +0800
Message-ID: <36b3e42bf80da14782712de5f8c672191dd58073.camel@mediatek.com>
Subject: Re: [PATCH v1 3/3] mmc: mediatek: add support for SDIO eint irq
From:   Axe Yang <axe.yang@mediatek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 29 Dec 2021 17:12:12 +0800
In-Reply-To: <CAHp75VcVx4Yf69TEoSy8GL-he9ZAW+yvoH8-DXAotQ3Mwx7n2A@mail.gmail.com>
References: <20211227083641.12538-1-axe.yang@mediatek.com>
         <20211227083641.12538-4-axe.yang@mediatek.com>
         <CAHp75VcVx4Yf69TEoSy8GL-he9ZAW+yvoH8-DXAotQ3Mwx7n2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTEyLTI3IGF0IDE5OjI3ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIE1vbiwgRGVjIDI3LCAyMDIxIGF0IDY6NDYgUE0gQXhlIFlhbmcgPGF4ZS55YW5nQG1l
ZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAgICAgICBpZiAobW1j
LT5jYXJkICYmICFtbWMtPmNhcmQtPmNjY3IuZW5hYmxlX2FzeW5jX2ludCkgew0KPiA+ICsgICAg
ICAgICAgICAgICBpZiAoZW5iKQ0KPiANCj4gU3BlbGwgaXQgZnVsbHksIGkuZS4gZW5hYmxlLg0K
DQpXaWxsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+IA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHBtX3J1bnRpbWVfZ2V0X25vcmVzdW1lKGhvc3QtPmRldik7DQo+ID4gKyAg
ICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwbV9ydW50aW1l
X3B1dF9ub2lkbGUoaG9zdC0+ZGV2KTsNCj4gPiArICAgICAgIH0NCj4gDQo+IC4uLg0KPiANCj4g
PiArICAgICAgIGludCByZXQgPSAwOw0KPiANCj4gUmVkdW5kYW50IGFzc2lnbm1lbnQsIHNlZSBi
ZWxvdy4NCg0KV2lsbCBmaXggaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiAuLi4NCj4gDQo+
ID4gKyAgICAgICBkZXNjID0gZGV2bV9ncGlvZF9nZXRfaW5kZXgoaG9zdC0+ZGV2LCAiZWludCIs
IDAsDQo+ID4gR1BJT0RfSU4pOw0KPiANCj4gV2h5IF9pbmRleCB2YXJpYW50PyBCeSBkZWZhdWx0
IGRldm1fZ3Bpb2RfZ2V0KCkgdXNlcyAwIGZvciBpbmRleC4NCg0KV2lsbCBmaXggaXQgaW4gbmV4
dCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICsgICAgICAgaWYgKElTX0VSUihkZXNjKSkNCj4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoZGVzYyk7DQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAg
ICAgICBpcnEgPSBncGlvZF90b19pcnEoZGVzYyk7DQo+IA0KPiByZXQgPSAuLi4NCj4gaWYgKHJl
dCA8IDApDQo+ICAgLi4uaGFuZGxlIGVycm9yLi4uDQoNCldpbGwgZml4IGl0IGluIG5leHQgdmVy
c2lvbi4NCg0KPiANCj4gPiArICAgICAgIGlmIChpcnEgPj0gMCkgew0KPiANCj4gKGZvciB0aGUg
cmVjb3JkLCAwIGlzIG5ldmVyIHJldHVybmVkIGJ5IGdwaW9kX3RvX2lycSgpIGFjY29yZGluZyB0
bw0KPiBhbGwgaXRzIHZlcnNpb25zKS4NCg0KV2lsbCBmaXggaXQgaW4gbmV4dCB2ZXJzaW9uLg0K
DQo+IA0KPiA+ICsgICAgICAgICAgICAgICBpcnFfc2V0X3N0YXR1c19mbGFncyhpcnEsIElSUV9O
T0FVVE9FTik7DQo+IA0KPiBVc2UgY29ycmVzcG9uZGluZyBmbGFnOg0KPiANCmh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvaW5jbHVkZS9saW51eC9pbnRlcnJ1
cHQuaCNMODMNCg0KSSB0aGluayBJUlFfTk9BVVRPRU4gaXMgdGhlIGNvcnJlY3QgcGFyYW1ldGVy
IEkgc2hvdWxkIHVzZToNCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpLmNvbS9saW51eC9sYXRlc3Qv
c291cmNlL2luY2x1ZGUvbGludXgvaXJxLmgjTDgwMA0KDQpJUlFGX1hYWCBkZWZpbmVkIGluIGlu
dGVycnVwdC5oIGlzIG9ubHkgZm9yIHh4eF9yZXF1ZXN0X3h4eF9pcnEoKS4NCkNhbiB5b3UgY29u
ZmlybSB0aGF0Pw0KDQo+IA0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBkZXZtX3JlcXVlc3Rf
dGhyZWFkZWRfaXJxKGhvc3QtPmRldiwgaXJxLA0KPiA+IE5VTEwsIG1zZGNfc2Rpb19laW50X2ly
cSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJ
UlFGX1RSSUdHRVJfTE9XIHwNCj4gPiBJUlFGX09ORVNIT1QsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInNkaW8tZWludCIsIGhvc3QpOw0KPiA+
ICsgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gaXJxOw0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGhvc3QtPmVpbnRfaXJxID0gaXJxOw0KPiANCj4g
SXMgaXQgb2theSBpZiB5b3UgYXNzaWduIGdhcmJhZ2UgaGVyZSBpbiBjYXNlIG9mIGVycm9yPw0K
DQpXaWxsIHJlZmluZSB0aGlzIHBhcnQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICsgICAg
ICAgcmV0dXJuIHJldDsNCj4gDQo+IC4uLg0KPiANCj4gPiArICAgICAgIGhvc3QtPnBpbnNfZWlu
dCA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGhvc3QtPnBpbmN0cmwsDQo+ID4gInN0YXRlX2VpbnQi
KTsNCj4gPiArICAgICAgIGlmIChJU19FUlIoaG9zdC0+cGluc19laW50KSkgew0KPiA+ICsgICAg
ICAgICAgICAgICBkZXZfZGJnKCZwZGV2LT5kZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsIGVpbnQh
XG4iKTsNCj4gPiArICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgIGhvc3QtPnBp
bnNfZGF0MSA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGhvc3QtDQo+ID4gPnBpbmN0cmwsICJzdGF0
ZV9kYXQxIik7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChJU19FUlIoaG9zdC0+cGluc19kYXQx
KSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoaG9zdC0+cGlu
c19kYXQxKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYs
ICJDYW5ub3QgZmluZCBwaW5jdHJsDQo+ID4gZGF0MSFcbiIpOw0KPiANCj4gcmV0ID0gZGV2X2Vy
cl9wcm9iZSguLi4pOyA/DQoNCldpbGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4NCg0KPiANCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGhvc3RfZnJlZTsNCj4gPiArICAgICAgICAg
ICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiANCj4gLi4uDQo+IA0KPiA+ICsgICAgICAgaWYgKCFJ
U19FUlIoaG9zdC0+cGluc19laW50KSkgew0KPiANCj4gSSdtIHdvbmRlcmluZyBpZiB5b3UgY2Fu
IHVzZSBhIHBhdHRlcm4gImVycm9yIGNoZWNrIGZpcnN0Ij8NCg0KVGhlIGludGVudGlvbiBvZiB0
aGlzIGxpbmUgaXMgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgY3VycmVudCBtbWMgZGV2aWNlDQppcyBh
IFNESU8gY2FyZCB3aGljaCBzdXBwb3J0cyBlaW50LCBub3QgZm9yIGVycm9yIGNoZWNrLiBCdXQs
IHNpbmNlIGl0DQptYXkgYnJpbmcgYW1iaWd1aXR5LCBJIHdpbGwgaW1wbGVtZW50IGl0IGluIGFu
b3RoZXIgd2F5LiBUaGFua3MgZm9yDQp5b3VyIGFkdmljZS4NCg0KLi4uDQoNCi0tDQpSZWdhcmRz
LA0KQXhlIFlhbmcNCg0K

