Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFEE49AE32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450816AbiAYIhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:37:12 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1447388AbiAYIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:32:51 -0500
X-UUID: d34c4a2663774fe6a7673d1c569dbd36-20220125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=4z9ZeJmBG14zGimszg3w76h2+5n57fel86i0W4yHyUg=;
        b=JFj/Loop5+x0yWVEqPpRwZzVrp+KOd+HVeVYMCsY5egVjMV1enxDNGNYQJrPr/5+JyckueMRZ+4fpa5kSIJ/tWORPICoXAu6KBheFcCyBmtELgFB9KAiStKP/3A5Z2tVSaHMRYloX/s/1s4w9KfCK2Uz6aurOm8h8rD8vK+Ma0A=;
X-UUID: d34c4a2663774fe6a7673d1c569dbd36-20220125
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 826994321; Tue, 25 Jan 2022 16:32:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 25 Jan 2022 16:32:38 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 16:32:38 +0800
Subject: Re: Re: [PATCH v8 8/8] arm64: dts: mt6359: add PMIC MT6359 related
 nodes
To:     Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hui.liu@mediatek.com>, <sen.chu@mediatek.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fei Shao <fshao@chromium.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Yuchen Huang <yuchen.huang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Wen Su <wen.su@mediatek.com>, Wens Tsai <wenst@chromium.org>,
        Rex-BC Chen <Rex-BC.Chen@mediatek.com>
References: <1622011927-359-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1622011927-359-9-git-send-email-hsin-hsiung.wang@mediatek.com>
 <a8de7273-7253-0601-4b8d-5bcab85539f0@gmail.com>
 <1623852422.4262.3.camel@mtksdaap41>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <2a7c0936-55a5-8448-3ffa-2a854f5a57ee@mediatek.com>
Date:   Tue, 25 Jan 2022 16:32:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1623852422.4262.3.camel@mtksdaap41>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA2LzE2LzIxIDEwOjA3IFBNLCBIc2luLWhzaXVuZyBXYW5nIHdyb3RlOg0KPiBIaSwNCj4g
DQo+IE9uIEZyaSwgMjAyMS0wNi0xMSBhdCAxNjowOSArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3
cm90ZToNCj4+DQo+PiBPbiAyNi8wNS8yMDIxIDA4OjUyLCBIc2luLUhzaXVuZyBXYW5nIHdyb3Rl
Og0KPj4+IEZyb206IFdlbiBTdSA8d2VuLnN1QG1lZGlhdGVrLmNvbT4NCj4+Pg0KPj4+IGFkZCBQ
TUlDIE1UNjM1OSByZWxhdGVkIG5vZGVzIHdoaWNoIGlzIGZvciBNVDY3NzkgcGxhdGZvcm0NCj4+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFdlbiBTdSA8d2VuLnN1QG1lZGlhdGVrLmNvbT4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVr
LmNvbT4NCj4+PiAtLS0NCj4+PiBjaGFuZ2VzIHNpbmNlIHY3Og0KPj4+IC0gbm8gY2hhbmdlLg0K
Pj4+IC0tLQ0KPj4+ICAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTkuZHRzaSAg
ICB8IDI5OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gICBhcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL210ODE5Mi1ldmIuZHRzIHwgICAxICsNCj4+PiAgIDIgZmlsZXMgY2hh
bmdlZCwgMjk5IGluc2VydGlvbnMoKykNCj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NjM1OS5kdHNpDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTkuZHRzaSBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ2MzU5LmR0c2kNCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+
IGluZGV4IDAwMDAwMDAuLjE4YzBkNTMNCj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTkuZHRzaQ0KPj4+IEBAIC0wLDAgKzEsMjk4
IEBADQo+Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+Pg0KPj4gQW55
IHNwZWNpZmljIHJlYXNvbiBmb3Igbm90IHNldHRpbmcgaXQgIlNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMCsgT1INCj4+IE1JVCkiID8NCj4+IAkNCj4+IE90aGVyIHRoZW4gdGhhdCwg
bG9va3MgZ29vZC4NCj4+DQo+PiBNYXR0aGlhcw0KPj4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJl
dmlldywgdGhlcmUgaXMgbm8gc3BlY2lhbCByZWFzb24gZm9yIHRoZSB3cml0aW5nLg0KPiBJIHdp
bGwgdXBkYXRlIGl0IGluIHRoZSBuZXh0IHBhdGNoLg0KPiANCltUaGUgY29udGVudCBvZiB0aGUg
cGF0Y2ggaGFzIGJlZW4gZGVsZXRlZC4uLl0NCg0KQWNjb3JkaW5nIHRvIHRoZSByZXZpZXdpbmcg
bm90ZSBvZiBQTUlDIHdyYXAsIFVSTDoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1tZWRpYXRlay9jb3Zlci8xNjE1NTYzMjg2LTIyMTI2LTEtZ2l0LXNlbmQtZW1h
aWwtaHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20NCg0KRGVhciBIdWkgYW5kIFNlbiwNCmNv
dWxkIHlvdSBoZWxwIHVwZGF0ZSBhbmQgdXBzdHJlYW0gdGhlIG10NjM1OS5kdHNpIGFuZCBtdDgx
OTItZXZiLmR0cyANCndpdGggdGhlIG5lY2Vzc2FyeSBmaXhlcz8NCg0KVGhhbmtzIQ0KTWFjcGF1
bCBMaW4=

