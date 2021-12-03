Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4D466F42
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhLCBxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:53:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46636 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229678AbhLCBxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:53:34 -0500
X-UUID: 961fbc40fc0044feae65e29ead907f67-20211203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=U8O6yZXk1USP9a3ivghloEgtx5u1o7Sb0yAqTaln6E0=;
        b=LXCZxpgvnJNaixibysFu6THwLAjpiQDuMaOu82bZHmCJnAK7sVz3xqv0oqO6GTzpzIZH/IfdViNKKhRSS67GViVX5+zm1B+ekaF/LaqJsxEmjyd4HT0xSv2IAUu+4J7ykDh6aAqH0p7vISoasIF2U+WA+MV7e6Qa51viR+osql0=;
X-UUID: 961fbc40fc0044feae65e29ead907f67-20211203
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1071865208; Fri, 03 Dec 2021 09:50:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Dec 2021 09:50:05 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Dec 2021 09:50:04 +0800
Message-ID: <e4be43859ea07a8382f927905c32f047dda77584.camel@mediatek.com>
Subject: Re: [PATCH v11, 04/19] media: mtk-vcodec: export decoder pm
 functions
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 3 Dec 2021 09:50:04 +0800
In-Reply-To: <2fa4e19f-d57c-6264-4284-8387c4182d1f@collabora.com>
References: <20211129034201.5767-1-yunfei.dong@mediatek.com>
         <20211129034201.5767-5-yunfei.dong@mediatek.com>
         <2fa4e19f-d57c-6264-4284-8387c4182d1f@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuamFtaW4sDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLg0KT24gVHVlLCAyMDIx
LTExLTMwIGF0IDE0OjM0ICswMTAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4gTGUgMjkv
MTEvMjAyMSDDoCAwNDo0MSwgWXVuZmVpIERvbmcgYSDDqWNyaXQgOg0KPiA+IFJlZ2lzdGVyIGVh
Y2ggaGFyZHdhcmUgYXMgcGxhdGZvcm0gZGV2aWNlLCBuZWVkIHRvIGNhbGwgcG0NCj4gPiBmdW5j
dGlvbnMNCj4gPiB0byBvcGVuL2Nsb3NlIHBvd2VyIGFuZCBjbG9jayBmcm9tIG1vZHVsZSBtdGst
dmNvZGVjLWRlYywgZXhwb3J0DQo+ID4gdGhlc2UNCj4gPiBmdW5jdGlvbnMuDQo+IA0KPiBUaGUg
Y29tbWl0IG1lc3NhZ2UgY29uZnVzZSBtZSwgbWF5YmUgc29tZXRoaW5nIGxpa2U6DQo+ICJXaGVu
IG10ayB2Y29kZWMgZGVjb2RlciBpcyBidWlsZCBhcyBhIG1vZHVsZSB3ZSBuZWVkIHRvIGV4cG9y
dA0KPiBtdGstdmNvZGVjLWRlYyBwbSBmdW5jdGlvbnMgdG8gbWFrZSB0aGVtIHZpc2libGUgYnkg
dGhlIG90aGVyDQo+IGNvbXBvbmVudHMiDQo+IA0KRml4IGluIHBhdGNoIHYxMg0KPiBXaXRoIHRo
YXQ6DQo+IFJldmlld2VkLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRA
Y29sbGFib3JhLmNvbT4NCj4gDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2Rl
Y19kZWNfcG0uYyB8IDYgKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZj
b2RlYy9tdGtfdmNvZGVjX2RlY19wbS5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210
ay12Y29kZWMvbXRrX3Zjb2RlY19kZWNfcG0uYw0KPiA+IGluZGV4IDIwYmQxNTdhODU1Yy4uMjIx
Y2Y2MGU5ZmJmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZj
b2RlYy9tdGtfdmNvZGVjX2RlY19wbS5jDQo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9tdGstdmNvZGVjL210a192Y29kZWNfZGVjX3BtLmMNCj4gPiBAQCAtNzcsMTIgKzc3LDE0IEBA
IGludCBtdGtfdmNvZGVjX2luaXRfZGVjX3BtKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAq
cGRldiwNCj4gPiAgIAlwdXRfZGV2aWNlKHBtLT5sYXJidmRlYyk7DQo+ID4gICAJcmV0dXJuIHJl
dDsNCj4gPiAgIH0NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwobXRrX3Zjb2RlY19pbml0X2RlY19w
bSk7DQo+ID4gICANCj4gPiAgIHZvaWQgbXRrX3Zjb2RlY19yZWxlYXNlX2RlY19wbShzdHJ1Y3Qg
bXRrX3Zjb2RlY19wbSAqcG0pDQo+ID4gICB7DQo+ID4gICAJcG1fcnVudGltZV9kaXNhYmxlKHBt
LT5kZXYpOw0KPiA+ICAgCXB1dF9kZXZpY2UocG0tPmxhcmJ2ZGVjKTsNCj4gPiAgIH0NCj4gPiAr
RVhQT1JUX1NZTUJPTF9HUEwobXRrX3Zjb2RlY19yZWxlYXNlX2RlY19wbSk7DQo+ID4gICANCj4g
PiAgIGludCBtdGtfdmNvZGVjX2RlY19wd19vbihzdHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG0pDQo+
ID4gICB7DQo+ID4gQEAgLTk0LDYgKzk2LDcgQEAgaW50IG10a192Y29kZWNfZGVjX3B3X29uKHN0
cnVjdCBtdGtfdmNvZGVjX3BtDQo+ID4gKnBtKQ0KPiA+ICAgDQo+ID4gICAJcmV0dXJuIHJldDsN
Cj4gPiAgIH0NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwobXRrX3Zjb2RlY19kZWNfcHdfb24pOw0K
PiA+ICAgDQo+ID4gICB2b2lkIG10a192Y29kZWNfZGVjX3B3X29mZihzdHJ1Y3QgbXRrX3Zjb2Rl
Y19wbSAqcG0pDQo+ID4gICB7DQo+ID4gQEAgLTEwMyw2ICsxMDYsNyBAQCB2b2lkIG10a192Y29k
ZWNfZGVjX3B3X29mZihzdHJ1Y3QgbXRrX3Zjb2RlY19wbQ0KPiA+ICpwbSkNCj4gPiAgIAlpZiAo
cmV0KQ0KPiA+ICAgCQltdGtfdjRsMl9lcnIoInBtX3J1bnRpbWVfcHV0X3N5bmMgZmFpbCAlZCIs
IHJldCk7DQo+ID4gICB9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKG10a192Y29kZWNfZGVjX3B3
X29mZik7DQo+ID4gICANCj4gPiAgIHZvaWQgbXRrX3Zjb2RlY19kZWNfY2xvY2tfb24oc3RydWN0
IG10a192Y29kZWNfcG0gKnBtKQ0KPiA+ICAgew0KPiA+IEBAIC0xMjksNiArMTMzLDcgQEAgdm9p
ZCBtdGtfdmNvZGVjX2RlY19jbG9ja19vbihzdHJ1Y3QNCj4gPiBtdGtfdmNvZGVjX3BtICpwbSkN
Cj4gPiAgIAlmb3IgKGkgLT0gMTsgaSA+PSAwOyBpLS0pDQo+ID4gICAJCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShkZWNfY2xrLT5jbGtfaW5mb1tpXS52Y29kZWNfY2xrKTsNCj4gPiAgIH0NCj4gPiAr
RVhQT1JUX1NZTUJPTF9HUEwobXRrX3Zjb2RlY19kZWNfY2xvY2tfb24pOw0KPiA+ICAgDQo+ID4g
ICB2b2lkIG10a192Y29kZWNfZGVjX2Nsb2NrX29mZihzdHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG0p
DQo+ID4gICB7DQo+ID4gQEAgLTEzOSwzICsxNDQsNCBAQCB2b2lkIG10a192Y29kZWNfZGVjX2Ns
b2NrX29mZihzdHJ1Y3QNCj4gPiBtdGtfdmNvZGVjX3BtICpwbSkNCj4gPiAgIAlmb3IgKGkgPSBk
ZWNfY2xrLT5jbGtfbnVtIC0gMTsgaSA+PSAwOyBpLS0pDQo+ID4gICAJCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShkZWNfY2xrLT5jbGtfaW5mb1tpXS52Y29kZWNfY2xrKTsNCj4gPiAgIH0NCj4gPiAr
RVhQT1JUX1NZTUJPTF9HUEwobXRrX3Zjb2RlY19kZWNfY2xvY2tfb2ZmKTsNCg==

