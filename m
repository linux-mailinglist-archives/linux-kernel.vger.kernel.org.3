Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4EA481868
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhL3COE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:14:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41614 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231612AbhL3COC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:14:02 -0500
X-UUID: cfc0a5edf5ac4842a1d131375155a352-20211230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=x6GiD9JJ4B1knkLkeZo2l7UgESkmJYdMXsAzklAKuuQ=;
        b=Qg4F1qYwMCtyrkbGjOSO86EVcnkGnAg8MaoALcUdT9dEGiZJ+uBoVtWdKevLnZ1gqkYPTAiHN+vtmBCXD0OwOsDYNUhLkgFOdELjZLmoaGR9r2oLZhQfBRrUxjRzwJ83XVSc0x+tCwquZqD7ZJ2CrtIOb1q28ZoY9Zfh94GXIsw=;
X-UUID: cfc0a5edf5ac4842a1d131375155a352-20211230
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 861019317; Thu, 30 Dec 2021 10:13:58 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Dec 2021 10:13:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 30 Dec
 2021 10:13:57 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Dec 2021 10:13:56 +0800
Message-ID: <e7e25a6bce17a4f488e49dfc6d17aa77f0603645.camel@mediatek.com>
Subject: Re: [PATCH v2 2/5] phy: phy-mtk-tphy: add support efuse setting
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
Date:   Thu, 30 Dec 2021 10:13:56 +0800
In-Reply-To: <bc841baa-e025-b0b8-8dbd-f438fd6981f7@collabora.com>
References: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
         <20211218082802.5256-2-chunfeng.yun@mediatek.com>
         <bc841baa-e025-b0b8-8dbd-f438fd6981f7@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTEyLTI0IGF0IDExOjAzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTgvMTIvMjEgMDk6MjcsIENodW5mZW5nIFl1biBoYSBzY3JpdHRv
Og0KPiA+IER1ZSB0byBzb21lIFNvQ3MgaGF2ZSBhIGJpdCBzaGlmdCBpc3N1ZSB0aGF0IHdpbGwg
ZHJvcCBhIGJpdCBmb3INCj4gPiB1c2IzDQo+ID4gcGh5IG9yIHBjaWUgcGh5LCBmaXggaXQgYnkg
YWRkaW5nIHNvZnR3YXJlIGVmdXNlIHJlYWRpbmcgYW5kDQo+ID4gc2V0dGluZywNCj4gPiBidXQg
b25seSBzdXBwb3J0IGl0IG9wdGlvbmFsbHkgZm9yIHZlcnNpb24gMi8zLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiB2MjogY2hhbmdlcyBzdWdnZXN0ZWQgYnkgVmlub2QNCj4gPiAgICAgIDEuIGZp
eCB0eXBvIG9mIHZlcnNpb24gaW4gY29tbWl0IG1lc3NhZ2UNCj4gPiAgICAgIDIuIHVzZSBkZXZf
ZGJnKCkgaW5zdGVhZCBvZiBkZXZfaW5mbygpDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3BoeS9t
ZWRpYXRlay9waHktbXRrLXRwaHkuYyB8IDE2Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNjIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiAN
Cj4gSGVsbG8gQ2h1bmZlbmcsIHRoYW5rcyBmb3IgdGhlIHBhdGNoIQ0KPiBIb3dldmVyLCB0aGVy
ZSBhcmUgYSBmZXcgdGhpbmdzIHRvIGltcHJvdmUuLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQo+ID4gYi9kcml2ZXJzL3BoeS9tZWRp
YXRlay9waHktbXRrLXRwaHkuYw0KPiA+IGluZGV4IGNkY2VmODY1ZmU5ZS4uOThhOTQyYzYwN2E2
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQo+
ID4gKysrIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCj4gPiBAQCAtMTIs
NiArMTIsNyBAQA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICAgI2luY2x1
ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L252bWVtLWNvbnN1bWVyLmg+DQo+ID4gICAjaW5jbHVkZSA8
bGludXgvb2ZfYWRkcmVzcy5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0K
PiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BoeS9waHkuaD4NCj4gPiBAQCAtNDEsNiArNDIsOSBAQA0K
PiA+ICAgI2RlZmluZSBTU1VTQl9TSUZTTFZfVjJfVTNQSFlECQkweDIwMA0KPiA+ICAgI2RlZmlu
ZSBTU1VTQl9TSUZTTFZfVjJfVTNQSFlBCQkweDQwMA0KPiA+ICAgDQo+ID4gKyNkZWZpbmUgVTNQ
X01JU0NfUkVHMQkJMHgwNA0KPiA+ICsjZGVmaW5lIE1SMV9FRlVTRV9BVVRPX0xPQURfRElTCQlC
SVQoNikNCj4gPiArDQo+ID4gICAjZGVmaW5lIFUzUF9VU0JQSFlBQ1IwCQkweDAwMA0KPiA+ICAg
I2RlZmluZSBQQTBfUkdfVTJQTExfRk9SQ0VfT04JCUJJVCgxNSkNCj4gPiAgICNkZWZpbmUgUEEw
X1VTQjIwX1BMTF9QUkVESVYJCUdFTk1BU0soNywgNikNCj4gPiBAQCAtMTMzLDYgKzEzNyw4IEBA
DQo+ID4gICAjZGVmaW5lIFAzQ19SR19TV1JTVF9VM19QSFlEX0ZPUkNFX0VOCUJJVCgyNCkNCj4g
PiAgIA0KPiA+ICAgI2RlZmluZSBVM1BfVTNfUEhZQV9SRUcwCTB4MDAwDQo+ID4gKyNkZWZpbmUg
UDNBX1JHX0lFWFRfSU5UUgkJR0VOTUFTSygxNSwgMTApDQo+ID4gKyNkZWZpbmUgUDNBX1JHX0lF
WFRfSU5UUl9WQUwoeCkJCSgoMHgzZiAmICh4KSkgPDwgMTApDQo+ID4gICAjZGVmaW5lIFAzQV9S
R19DTEtEUlZfT0ZGCQlHRU5NQVNLKDMsIDIpDQo+ID4gICAjZGVmaW5lIFAzQV9SR19DTEtEUlZf
T0ZGX1ZBTCh4KQkoKDB4MyAmICh4KSkgPDwgMikNCj4gPiAgIA0KPiA+IEBAIC0xODcsNiArMTkz
LDE5IEBADQo+ID4gICAjZGVmaW5lIFAzRF9SR19GV0FLRV9USAkJR0VOTUFTSygyMSwgMTYpDQo+
ID4gICAjZGVmaW5lIFAzRF9SR19GV0FLRV9USF9WQUwoeCkJKCgweDNmICYgKHgpKSA8PCAxNikN
Cj4gPiAgIA0KPiA+ICsjZGVmaW5lIFUzUF9VM19QSFlEX0lNUENBTDAJCTB4MDEwDQo+ID4gKyNk
ZWZpbmUgUDNEX1JHX0ZPUkNFX1RYX0lNUEVMCQlCSVQoMzEpDQo+ID4gKyNkZWZpbmUgUDNEX1JH
X1RYX0lNUEVMCQkJR0VOTUFTSygyOCwgMjQpDQo+ID4gKyNkZWZpbmUgUDNEX1JHX1RYX0lNUEVM
X1ZBTCh4KQkJKCgweDFmICYgKHgpKSA8PCAyNCkNCj4gPiArDQo+ID4gKyNkZWZpbmUgVTNQX1Uz
X1BIWURfSU1QQ0FMMQkJMHgwMTQNCj4gPiArI2RlZmluZSBQM0RfUkdfRk9SQ0VfUlhfSU1QRUwJ
CUJJVCgzMSkNCj4gPiArI2RlZmluZSBQM0RfUkdfUlhfSU1QRUwJCQlHRU5NQVNLKDI4LCAyNCkN
Cj4gPiArI2RlZmluZSBQM0RfUkdfUlhfSU1QRUxfVkFMKHgpCQkoKDB4MWYgJiAoeCkpIDw8IDI0
KQ0KPiA+ICsNCj4gPiArI2RlZmluZSBVM1BfVTNfUEhZRF9SU1YJCQkweDA1NA0KPiA+ICsjZGVm
aW5lIFAzRF9SR19FRlVTRV9BVVRPX0xPQURfRElTCUJJVCgxMikNCj4gPiArDQo+ID4gICAjZGVm
aW5lIFUzUF9VM19QSFlEX0NEUjEJCTB4MDVjDQo+ID4gICAjZGVmaW5lIFAzRF9SR19DRFJfQklS
X0xURDEJCUdFTk1BU0soMjgsIDI0KQ0KPiA+ICAgI2RlZmluZSBQM0RfUkdfQ0RSX0JJUl9MVEQx
X1ZBTCh4KQkoKDB4MWYgJiAoeCkpIDw8IDI0KQ0KPiA+IEBAIC0zMDcsNiArMzI2LDExIEBAIHN0
cnVjdCBtdGtfcGh5X3BkYXRhIHsNCj4gPiAgIAkgKiA0OE0gUExMLCBmaXggaXQgYnkgc3dpdGNo
aW5nIFBMTCB0byAyNk0gZnJvbSBkZWZhdWx0IDQ4TQ0KPiA+ICAgCSAqLw0KPiA+ICAgCWJvb2wg
c3dfcGxsXzQ4bV90b18yNm07DQo+ID4gKwkvKg0KPiA+ICsJICogU29tZSBTb0NzIChlLmcuIG10
ODE5NSkgZHJvcCBhIGJpdCB3aGVuIHVzZSBhdXRvIGxvYWQgZWZ1c2UsDQo+ID4gKwkgKiBzdXBw
b3J0IHN3IHdheSwgYWxzbyBzdXBwb3J0IGl0IGZvciB2Mi92MyBvcHRpb25hbGx5Lg0KPiA+ICsJ
ICovDQo+ID4gKwlib29sIHN3X2VmdXNlX3N1cHBvcnRlZDsNCj4gPiAgIAllbnVtIG10a19waHlf
dmVyc2lvbiB2ZXJzaW9uOw0KPiA+ICAgfTsNCj4gPiAgIA0KPiA+IEBAIC0zMzYsNiArMzYwLDEw
IEBAIHN0cnVjdCBtdGtfcGh5X2luc3RhbmNlIHsNCj4gPiAgIAlzdHJ1Y3QgcmVnbWFwICp0eXBl
X3N3Ow0KPiA+ICAgCXUzMiB0eXBlX3N3X3JlZzsNCj4gPiAgIAl1MzIgdHlwZV9zd19pbmRleDsN
Cj4gPiArCXUzMiBlZnVzZV9zd19lbjsNCj4gPiArCXUzMiBlZnVzZV9pbnRyOw0KPiA+ICsJdTMy
IGVmdXNlX3R4X2ltcDsNCj4gPiArCXUzMiBlZnVzZV9yeF9pbXA7DQo+ID4gICAJaW50IGV5ZV9z
cmM7DQo+ID4gICAJaW50IGV5ZV92cnQ7DQo+ID4gICAJaW50IGV5ZV90ZXJtOw0KPiA+IEBAIC0x
MDQwLDYgKzEwNjgsMTMwIEBAIHN0YXRpYyBpbnQgcGh5X3R5cGVfc2V0KHN0cnVjdA0KPiA+IG10
a19waHlfaW5zdGFuY2UgKmluc3RhbmNlKQ0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+
ICAgDQo+ID4gK3N0YXRpYyBpbnQgcGh5X2VmdXNlX2dldChzdHJ1Y3QgbXRrX3RwaHkgKnRwaHks
IHN0cnVjdA0KPiA+IG10a19waHlfaW5zdGFuY2UgKmluc3RhbmNlKQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmaW5zdGFuY2UtPnBoeS0+ZGV2Ow0KPiA+ICsJaW50IHJldCA9
IDA7DQo+ID4gKw0KPiA+ICsJLyogdHBoeSB2MSBkb2Vzbid0IHN1cHBvcnQgc3cgZWZ1c2UsIHNr
aXAgaXQgKi8NCj4gPiArCWlmICghdHBoeS0+cGRhdGEtPnN3X2VmdXNlX3N1cHBvcnRlZCkgew0K
PiA+ICsJCWluc3RhbmNlLT5lZnVzZV9zd19lbiA9IDA7DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+IA0KPiA+IFsuLi5dDQo+ID4gDQo+ID4gKw0KPiA+ICsJCWRldl9kYmco
ZGV2LCAidTMgZWZ1c2UgLSBpbnRyICV4LCByeF9pbXAgJXgsIHR4X2ltcA0KPiA+ICV4XG4iLA0K
PiA+ICsJCQlpbnN0YW5jZS0+ZWZ1c2VfaW50ciwgaW5zdGFuY2UtDQo+ID4gPmVmdXNlX3J4X2lt
cCxpbnN0YW5jZS0+ZWZ1c2VfdHhfaW1wKTsNCj4gPiArCQlicmVhazsNCj4gPiArCWRlZmF1bHQ6
DQo+ID4gKwkJZGV2X2VycihkZXYsICJubyBzdyBlZnVzZSBmb3IgdHlwZSAlZFxuIiwgaW5zdGFu
Y2UtDQo+ID4gPnR5cGUpOw0KPiA+ICsJCXJldCA9IC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcGh5X2Vm
dXNlX3NldChzdHJ1Y3QgbXRrX3BoeV9pbnN0YW5jZSAqaW5zdGFuY2UpDQo+IA0KPiBUaGUgbmFt
ZSBmb3IgdGhpcyBmdW5jdGlvbiBpcyBhIGJpdCBtaXNsZWFkaW5nIGFuZCBvbmUgbWF5IHRoaW5r
IHRoYXQNCj4gdGhpcw0KPiBpcyB3cml0aW5nIGVmdXNlcyAoYWthIGJsb3dpbmcgYSBmdXNlIGFy
cmF5KSwgDQpUaGUgaGFyZHdhcmUgZWZ1c2VzIG9uIE1lZGlhVGVrIHBsYXRmb3JtIG9ubHkgc3Vw
cG9ydCBSZWFkLU9ubHkuDQoNCj4gd2hpY2ggZG9lc24ndCBsb29rIGxpa2UgYmVpbmcNCj4gdGhl
IGNhc2UgYXQgYWxsLg0KPiANCj4gV2hhdCBhYm91dCBjaGFuZ2luZyBpdCB0byBwaHlfc2V0X3N3
X2VmdXNlX3BhcmFtcygpLCBvciBzb21ldGhpbmcNCj4gc2ltaWxhcj8NCkl0IHNlZW1zIGJldHRl
ciwgSSdsbCBwcmVwYXJlIGEgbmV3IHBhdGNoLg0KPiANCj4gDQo+IFRoYW5rIHlvdSwNCj4gLSBB
bmdlbG8NCg==

