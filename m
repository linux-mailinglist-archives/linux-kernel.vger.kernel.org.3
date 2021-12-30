Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9316B481859
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhL3CGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:06:37 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:47122 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232768AbhL3CGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:06:36 -0500
X-UUID: 7c7ca415807944d3bf537f505d520a59-20211230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sPOTvMuDJjvlDzy7nqG24GE8k+hFonDBmuW7nB8SSCA=;
        b=HudQ/kUfDno2Ih1Z6V+bVFQ4AOGSI6DrObbZ3T3M+HkBvBGCNRlWqQasPC3clArbHRlWPZALrcEXwYB6910i5/BY2hmwp+l1dSf6Zv6iELf3SAWB4GSS5R9bzjGvISagU5YMMjViO3zrzqpNvJhUN92fdKzC5NTbHYzGBRjLnlM=;
X-UUID: 7c7ca415807944d3bf537f505d520a59-20211230
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 158729606; Thu, 30 Dec 2021 10:06:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 30 Dec 2021 10:06:31 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Dec 2021 10:06:30 +0800
Message-ID: <75b2773d1d170f42bae0774dbc58d1458cb25502.camel@mediatek.com>
Subject: Re: [PATCH v2 3/5] phy: mediatek: add helpers to update bits of
 registers
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Thu, 30 Dec 2021 10:06:31 +0800
In-Reply-To: <047803b9-d09f-d4f8-a674-317cc19dd055@collabora.com>
References: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
         <20211218082802.5256-3-chunfeng.yun@mediatek.com>
         <047803b9-d09f-d4f8-a674-317cc19dd055@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTEyLTI0IGF0IDExOjEwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTgvMTIvMjEgMDk6MjgsIENodW5mZW5nIFl1biBoYSBzY3JpdHRv
Og0KPiA+IEFkZCB0aHJlZSBoZWxwZXJzIG10a19waHlfY2xlYXIvc2V0L3VwZGF0ZV9iaXRzKCkg
Zm9yIHJlZ2lzdGVycw0KPiA+IG9wZXJhdGlvbg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENo
dW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2Mjog
bmV3IHBhdGNoLCBhZGQgcmVnaXN0ZXIgYWNjZXNzIGhlbHBlcnMsDQo+ID4gICAgICBBZGQgdXBk
YXRlbCgpIG1hY3JvIHN1Z2dlc3RlZCBieSBWaW5vZCwgaGVyZSBhZGQgbW9yZSBvbmVzDQo+ID4g
aW5zdGVhZC4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstaW8u
aCB8IDM4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWlvLmgNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1pby5oDQo+ID4gYi9kcml2ZXJzL3BoeS9tZWRpYXRl
ay9waHktbXRrLWlvLmgNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAw
MDAwMDAwMC4uNTAwZmNkYWIxNjVkDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZl
cnMvcGh5L21lZGlhdGVrL3BoeS1tdGstaW8uaA0KPiA+IEBAIC0wLDAgKzEsMzggQEANCj4gPiAr
LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gPiArLyoNCj4gPiArICog
Q29weXJpZ2h0IChDKSAyMDIxIE1lZGlhVGVrIEluYy4NCj4gPiArICoNCj4gPiArICogQXV0aG9y
OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gKyAqLw0KPiA+
ICsNCj4gPiArI2lmbmRlZiBfX1BIWV9NVEtfSF9fDQo+ID4gKyNkZWZpbmUgX19QSFlfTVRLX0hf
Xw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW5saW5lIHZvaWQgbXRrX3BoeV9jbGVhcl9iaXRzKHZvaWQgX19pb21lbSAqcmVnLCB1MzIgYml0
cykNCj4gPiArew0KPiA+ICsJdTMyIHRtcCA9IHJlYWRsKHJlZyk7DQo+ID4gKw0KPiA+ICsJdG1w
ICY9IH5iaXRzOw0KPiA+ICsJd3JpdGVsKHRtcCwgcmVnKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGlubGluZSB2b2lkIG10a19waHlfc2V0X2JpdHModm9pZCBfX2lvbWVtICpyZWcsIHUz
MiBiaXRzKQ0KPiA+ICt7DQo+ID4gKwl1MzIgdG1wID0gcmVhZGwocmVnKTsNCj4gPiArDQo+ID4g
Kwl0bXAgfD0gYml0czsNCj4gPiArCXdyaXRlbCh0bXAsIHJlZyk7DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBtdGtfcGh5X3VwZGF0ZV9iaXRzKHZvaWQgX19pb21lbSAq
cmVnLCB1MzINCj4gPiBtYXNrLCB1MzIgdmFsKQ0KPiA+ICt7DQo+ID4gKwl1MzIgdG1wID0gcmVh
ZGwocmVnKTsNCj4gPiArDQo+ID4gKwl0bXAgJj0gfm1hc2s7DQo+ID4gKwl0bXAgfD0gdmFsICYg
bWFzazsNCj4gPiArCXdyaXRlbCh0bXAsIHJlZyk7DQo+ID4gK30NCj4gPiArDQo+ID4gKyNlbmRp
Zg0KPiA+IA0KPiANCj4gVGhlc2UgaGVscGVycyBhcmUgYWxtb3N0IGV4YWN0bHkgZHVwbGljYXRp
bmcgd2hhdA0KPiByZWdtYXBfdXBkYXRlX2JpdHMoKSBpcyBkb2luZy4NCj4gSSBhcHByZWNpYXRl
IHRoZSBlZmZvcnQgdG8gc3RvcCBvcGVuLWNvZGluZyB0aGUgc2FtZSBzZXF1ZW5jZXMgb3Zlcg0K
PiBhbmQgb3ZlciBieQ0KPiBhZGRpbmcgc3VjaCBoZWxwZXIgZnVuY3Rpb25zLCANCkkgYWdyZWUg
d2l0aCB5b3UuDQo+IGJ1dCBJIHRoaW5rIHRoYXQgdGhlIHByb3BlciB3YXkgb2YgZG9pbmcgd2hh
dCB5b3UNCj4gYXJlIHByb3Bvc2luZyBpcyBub3QgdG8gYWRkIGN1c3RvbSBmdW5jdGlvbnMgYnV0
IHJhdGhlciByZXVzZSB3aGF0DQo+IHRoZSBMaW51eCBBUElzDQo+IGdpdmUgeW91Lg0KSSBhbHNv
IGxpa2UgdG8gdXNlIGNvbW1vbiBBUElzIEFTQVAsIGJ1dCBub3QgZm91bmQgc3VpdGFibGUgb25l
cy4NClRoaXMgbWF5IGJlIGEgcHJvYmxlbSwgSSBmb3VuZCB0aGF0IHNvbWUgc2ltaWxhciBjdXN0
b20gaGVscHMgYWxyZWFkeQ0KYWRkZWQgdW5kZXIgcGh5IGZvbGQuDQoNCj4gDQo+IFdoYXQgYWJv
dXQgZG9pbmcgYSBjb252ZXJzaW9uIHRvIHVzZSByZWdtYXAgb24gdGhpcyBkcml2ZXI/DQpObywg
d2UgZG9uJ3QgdXNlIHJlZ21hcCBoZXJlLCB0aGVzZSByZWdpc3RlcnMgYXJlIG1vbm9wb2xpemVk
IGJ5IHQtcGh5LCANCml0J3Mgbm90IHN5c2Nvbi4NCg0KDQo=

