Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D74A3530
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354334AbiA3InN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:43:13 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:35240 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242883AbiA3InM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:43:12 -0500
X-UUID: 5e902a898edd4733a531eee7ad86c6a6-20220130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:Subject; bh=cGAQsykx4WSO0q8gY9BPXQgA6PjADBiTAnKJOMXK7DE=;
        b=fmXijuxtQRoHk/an2FnSey7LxEd9UReN0dD+YzXChvPPXPxeFAzok/zSteSan1Zfog1q1hxvD919+UeWzHX0mENTpChkk6yFFYJT+MHLqnxH23gJoKC8wUpX/rkr9Or8Vth2Z/u44hghIuS71gYXyaj5tnPodkaaAOHhLZbcb8o=;
X-UUID: 5e902a898edd4733a531eee7ad86c6a6-20220130
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 526882817; Sun, 30 Jan 2022 16:43:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 30 Jan 2022 16:43:08 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 Jan 2022 16:43:07 +0800
Subject: Re: Re: [PATCH v8 8/8] arm64: dts: mt6359: add PMIC MT6359 related
 nodes
From:   Macpaul Lin <macpaul.lin@mediatek.com>
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
        Rex-BC Chen <Rex-BC.Chen@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <1622011927-359-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1622011927-359-9-git-send-email-hsin-hsiung.wang@mediatek.com>
 <a8de7273-7253-0601-4b8d-5bcab85539f0@gmail.com>
 <1623852422.4262.3.camel@mtksdaap41>
 <2a7c0936-55a5-8448-3ffa-2a854f5a57ee@mediatek.com>
 <2b49b965-5cb9-251d-787d-5206df698775@mediatek.com>
Message-ID: <cf93c715-97c6-7fff-e24e-e9b418b9fb60@mediatek.com>
Date:   Sun, 30 Jan 2022 16:43:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2b49b965-5cb9-251d-787d-5206df698775@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI2LzIyIDM6MjggUE0sIE1hY3BhdWwgTGluIHdyb3RlOg0KPiBPbiAxLzI1LzIyIDQ6
MzIgUE0sIE1hY3BhdWwgTGluIHdyb3RlOg0KPj4NCj4+IE9uIDYvMTYvMjEgMTA6MDcgUE0sIEhz
aW4taHNpdW5nIFdhbmcgd3JvdGU6DQo+Pj4gSGksDQo+Pj4NCj4+PiBPbiBGcmksIDIwMjEtMDYt
MTEgYXQgMTY6MDkgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+Pj4+DQo+Pj4+IE9u
IDI2LzA1LzIwMjEgMDg6NTIsIEhzaW4tSHNpdW5nIFdhbmcgd3JvdGU6DQo+Pj4+PiBGcm9tOiBX
ZW4gU3UgPHdlbi5zdUBtZWRpYXRlay5jb20+DQo+Pj4+Pg0KPj4+Pj4gYWRkIFBNSUMgTVQ2MzU5
IHJlbGF0ZWQgbm9kZXMgd2hpY2ggaXMgZm9yIE1UNjc3OSBwbGF0Zm9ybQ0KPj4+Pj4NCj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFdlbiBTdSA8d2VuLnN1QG1lZGlhdGVrLmNvbT4NCj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEhzaW4tSHNpdW5nIFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29t
Pg0KPj4+Pj4gLS0tDQo+Pj4+PiBjaGFuZ2VzIHNpbmNlIHY3Og0KPj4+Pj4gLSBubyBjaGFuZ2Uu
DQo+Pj4+PiAtLS0NCj4+Pj4+IMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5
LmR0c2nCoMKgwqAgfCAyOTggDQo+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
Pj4+PiDCoCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi1ldmIuZHRzIHzCoMKg
IDEgKw0KPj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyOTkgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4g
wqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5
LmR0c2kNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRp
YXRlay9tdDYzNTkuZHRzaSANCj4+Pj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDYzNTkuZHRzaQ0KPj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4+IGluZGV4IDAwMDAw
MDAuLjE4YzBkNTMNCj4+Pj4+IC0tLSAvZGV2L251bGwNCj4+Pj4+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5LmR0c2kNCj4+Pj4+IEBAIC0wLDAgKzEsMjk4IEBADQo+
Pj4+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+Pj4NCj4+Pj4gQW55
IHNwZWNpZmljIHJlYXNvbiBmb3Igbm90IHNldHRpbmcgaXQgIlNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiANCj4+Pj4gKEdQTC0yLjArIE9SDQo+Pj4+IE1JVCkiID8NCj4+Pj4NCj4+Pj4gT3RoZXIg
dGhlbiB0aGF0LCBsb29rcyBnb29kLg0KPj4+Pg0KPj4+PiBNYXR0aGlhcw0KPj4+Pg0KPj4+DQo+
Pj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3LCB0aGVyZSBpcyBubyBzcGVjaWFsIHJlYXNvbiBmb3Ig
dGhlIHdyaXRpbmcuDQo+Pj4gSSB3aWxsIHVwZGF0ZSBpdCBpbiB0aGUgbmV4dCBwYXRjaC4NCj4+
Pg0KPj4gW1RoZSBjb250ZW50IG9mIHRoZSBwYXRjaCBoYXMgYmVlbiBkZWxldGVkLi4uXQ0KPj4N
Cj4+IEFjY29yZGluZyB0byB0aGUgcmV2aWV3aW5nIG5vdGUgb2YgUE1JQyB3cmFwLCBVUkw6DQo+
PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvY292
ZXIvMTYxNTU2MzI4Ni0yMjEyNi0xLWdpdC1zZW5kLWVtYWlsLWhzaW4taHNpdW5nLndhbmdAbWVk
aWF0ZWsuY29tIA0KPj4NCj4+DQo+PiBEZWFyIEh1aSBhbmQgU2VuLA0KPj4gY291bGQgeW91IGhl
bHAgdXBkYXRlIGFuZCB1cHN0cmVhbSB0aGUgbXQ2MzU5LmR0c2kgYW5kIG10ODE5Mi1ldmIuZHRz
IA0KPj4gd2l0aCB0aGUgbmVjZXNzYXJ5IGZpeGVzPw0KPj4NCj4+IFRoYW5rcyENCj4+IE1hY3Bh
dWwgTGluDQo+IA0KPiBEZWFyIEh1aSwNCj4gDQo+IEkndmUgZm91bmQgcGF0Y2ggdjggd2lsbCBj
YXVzZSBidWlsZCBmYWlsIGJlY2F1c2UgcHdyYXAgbm9kZSBoYXNuJ3QgYmVlbiANCj4gbWVyZ2Vk
IGFjY29yZGluZyB0byBbMV0gYW5kIFsyXSAobXQ4MTkyKS4gSG93ZXZlciwgdGhlIHB3cmFwIG5v
ZGUgZm9yIA0KPiBtdDgxOTUgaXMgYWxyZWFkeSBpbiBbM10gbXQ4MTk1LmR0c2kuIFRoZSBtdDgx
OTUgYm9hcmRzIHVzaW5nIG10NjM1OSANCj4gd2lsbCBuZWVkIG10NjM1OS5kdHNpIGZvciBlbmFi
bGluZyBtb3JlIHBlcmlwaGVyYWxzLg0KPiANCj4gSSB0aGluayB0byBzcGxpdCB0aGUgbXQ4MTky
IHBhcnQgaW50byB0aGUgb3RoZXIgcGF0Y2ggaW4gbmV4dCB2ZXJzaW9uIA0KPiBjb3VsZCByZWR1
Y2UgdGhlIGRlcGVuZGVuY2llcyBiZXR3ZWVuIG10NjM1OS5kdHNpIGFuZCBtdDgxOTIuZHRzaSBh
dCANCj4gdGhpcyBzdGFnZS4gSGVuY2Ugd2UgZG9uJ3QgbmVlZCB0byB3YWl0IHB3cmFwIG5vZGUg
YmUgbWVyZ2VkIGluIA0KPiBtdDgxOTIuZHRzaS4NCj4gDQo+IFsxXSANCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzE2MTU1NjMyODYtMjIxMjYtNi1naXQtc2VuZC1lbWFpbC1oc2luLWhz
aXVuZy53YW5nQG1lZGlhdGVrLmNvbS8gDQo+IA0KPiBbMl0gDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9lMzMwNTNjZi1mMzM3LWQ3ZjYtZmJmNi05M2QzODVmN2U2ODNAZ21haWwuY29t
Lw0KPiBbM10gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDExMjExNDcyNC4x
OTUzLTQtdGluZ2hhbi5zaGVuQG1lZGlhdGVrLmNvbS8gDQo+IA0KPiANCj4gQWZ0ZXIgdGhhdCwg
eW91IGNhbiBoYXZlIG15IFJldmlld2VkLWJ5IHRhZyBpbiBuZXh0IHZlcnNpb24uDQo+IA0KPiBS
ZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+
IFRoYW5rcyA6KQ0KPiBNYWNwYXVsIExpbg0KDQpKdXN0IGEgcmVtaW5kOg0KVGhlIHVwZGF0ZWQg
dmVyc2lvbiBvZiB0aGlzIHBhdGNoIFs0XSAiYXJtNjQ6IGR0czogbXQ2MzU5OiBhZGQgUE1JQyAN
Ck1UNjM1OSByZWxhdGVkIG5vZGVzIiBoYXMgYmVlbiB1cGRhdGUgYW5kIHJlc2VuZCBhcyBhIG5l
dyBwYXRjaHNldCBbNV0uDQoNClRoZSBuZXcgcGF0Y2hzZXQgWzVdIHBhc3NlZCBidWlsdCB0ZXN0
IHdpdGggdGhlIHY5IGFuZCB2MTAncyBkZXBlbmRlbnQgDQpwYXRjaCBbNl0uDQpXaGVyZSB0aGUg
cHJldmlvdXMgdXBkYXRlZCBub3RlIG9mIGJ1aWxkIHRlc3QgcmVzdWx0IGlzIGhlcmUgWzddLg0K
DQpbNF0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE2MjIwMTE5MjctMzU5LTktZ2l0
LXNlbmQtZW1haWwtaHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20vDQpbNV0gaHR0cHM6Ly93
d3cuc3Bpbmljcy5uZXQvbGlzdHMvZGV2aWNldHJlZS9tc2c0NzIxMTkuaHRtbA0KWzZdIA0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwMTMwMDIzMjA5LjE2Mjc1LTEtdGluZ2hhbi5z
aGVuQG1lZGlhdGVrLmNvbS8NCls3XSBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9kZXZp
Y2V0cmVlL21zZzQ3MjE0OS5odG1sDQoNClRoYW5rcw0KTWFjcGF1bCBMaW4=

