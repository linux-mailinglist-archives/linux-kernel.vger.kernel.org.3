Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB349C44D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbiAZH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:28:30 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55770 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229681AbiAZH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:28:28 -0500
X-UUID: 590d66e196f64f838d2bc3aff3643759-20220126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:Subject; bh=VRCQaBSeocZxql6szDpUIy9PLmXd1DQ8Nb4b6y5f3YQ=;
        b=da31axrEXKcGuaESjKgVGoqvPOwWgH6ygPtWYj3rsV/4BXT0OmqFcg7Xdph61kpWJrNxhtgk4kjQjDojNzUSg86kXvD28kvqzldImlAHVABrJ4whOUcreSloBanO8uONx+HHhcNJvxahzOwmwcR0e8W/MS3nzUlFQJ5737501FA=;
X-UUID: 590d66e196f64f838d2bc3aff3643759-20220126
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1959618733; Wed, 26 Jan 2022 15:28:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 26 Jan 2022 15:28:22 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 15:28:22 +0800
Subject: Re: [PATCH v8 8/8] arm64: dts: mt6359: add PMIC MT6359 related nodes
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
Message-ID: <2b49b965-5cb9-251d-787d-5206df698775@mediatek.com>
Date:   Wed, 26 Jan 2022 15:28:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2a7c0936-55a5-8448-3ffa-2a854f5a57ee@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNS8yMiA0OjMyIFBNLCBNYWNwYXVsIExpbiB3cm90ZToNCj4gDQo+IE9uIDYvMTYvMjEg
MTA6MDcgUE0sIEhzaW4taHNpdW5nIFdhbmcgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBPbiBGcmks
IDIwMjEtMDYtMTEgYXQgMTY6MDkgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+Pj4N
Cj4+PiBPbiAyNi8wNS8yMDIxIDA4OjUyLCBIc2luLUhzaXVuZyBXYW5nIHdyb3RlOg0KPj4+PiBG
cm9tOiBXZW4gU3UgPHdlbi5zdUBtZWRpYXRlay5jb20+DQo+Pj4+DQo+Pj4+IGFkZCBQTUlDIE1U
NjM1OSByZWxhdGVkIG5vZGVzIHdoaWNoIGlzIGZvciBNVDY3NzkgcGxhdGZvcm0NCj4+Pj4NCj4+
Pj4gU2lnbmVkLW9mZi1ieTogV2VuIFN1IDx3ZW4uc3VAbWVkaWF0ZWsuY29tPg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVrLmNv
bT4NCj4+Pj4gLS0tDQo+Pj4+IGNoYW5nZXMgc2luY2Ugdjc6DQo+Pj4+IC0gbm8gY2hhbmdlLg0K
Pj4+PiAtLS0NCj4+Pj4gwqAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTkuZHRz
acKgwqDCoCB8IDI5OCANCj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiDC
oCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi1ldmIuZHRzIHzCoMKgIDEgKw0K
Pj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI5OSBpbnNlcnRpb25zKCspDQo+Pj4+IMKgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NjM1OS5kdHNpDQo+
Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NjM1
OS5kdHNpIA0KPj4+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5LmR0c2kN
Cj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4gaW5kZXggMDAwMDAwMC4uMThjMGQ1Mw0K
Pj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ2MzU5LmR0c2kNCj4+Pj4gQEAgLTAsMCArMSwyOTggQEANCj4+Pj4gKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+Pj4NCj4+PiBBbnkgc3BlY2lmaWMgcmVhc29uIGZv
ciBub3Qgc2V0dGluZyBpdCAiU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IA0KPj4+IChHUEwtMi4w
KyBPUg0KPj4+IE1JVCkiID8NCj4+Pg0KPj4+IE90aGVyIHRoZW4gdGhhdCwgbG9va3MgZ29vZC4N
Cj4+Pg0KPj4+IE1hdHRoaWFzDQo+Pj4NCj4+DQo+PiBUaGFua3MgZm9yIHRoZSByZXZpZXcsIHRo
ZXJlIGlzIG5vIHNwZWNpYWwgcmVhc29uIGZvciB0aGUgd3JpdGluZy4NCj4+IEkgd2lsbCB1cGRh
dGUgaXQgaW4gdGhlIG5leHQgcGF0Y2guDQo+Pg0KPiBbVGhlIGNvbnRlbnQgb2YgdGhlIHBhdGNo
IGhhcyBiZWVuIGRlbGV0ZWQuLi5dDQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIHJldmlld2luZyBu
b3RlIG9mIFBNSUMgd3JhcCwgVVJMOg0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvbGludXgtbWVkaWF0ZWsvY292ZXIvMTYxNTU2MzI4Ni0yMjEyNi0xLWdpdC1zZW5kLWVt
YWlsLWhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tIA0KPiANCj4gDQo+IERlYXIgSHVpIGFu
ZCBTZW4sDQo+IGNvdWxkIHlvdSBoZWxwIHVwZGF0ZSBhbmQgdXBzdHJlYW0gdGhlIG10NjM1OS5k
dHNpIGFuZCBtdDgxOTItZXZiLmR0cyANCj4gd2l0aCB0aGUgbmVjZXNzYXJ5IGZpeGVzPw0KPiAN
Cj4gVGhhbmtzIQ0KPiBNYWNwYXVsIExpbg0KDQpEZWFyIEh1aSwNCg0KSSd2ZSBmb3VuZCBwYXRj
aCB2OCB3aWxsIGNhdXNlIGJ1aWxkIGZhaWwgYmVjYXVzZSBwd3JhcCBub2RlIGhhc24ndCBiZWVu
IA0KbWVyZ2VkIGFjY29yZGluZyB0byBbMV0gYW5kIFsyXSAobXQ4MTkyKS4gSG93ZXZlciwgdGhl
IHB3cmFwIG5vZGUgZm9yIA0KbXQ4MTk1IGlzIGFscmVhZHkgaW4gWzNdIG10ODE5NS5kdHNpLiBU
aGUgbXQ4MTk1IGJvYXJkcyB1c2luZyBtdDYzNTkgDQp3aWxsIG5lZWQgbXQ2MzU5LmR0c2kgZm9y
IGVuYWJsaW5nIG1vcmUgcGVyaXBoZXJhbHMuDQoNCkkgdGhpbmsgdG8gc3BsaXQgdGhlIG10ODE5
MiBwYXJ0IGludG8gdGhlIG90aGVyIHBhdGNoIGluIG5leHQgdmVyc2lvbiANCmNvdWxkIHJlZHVj
ZSB0aGUgZGVwZW5kZW5jaWVzIGJldHdlZW4gbXQ2MzU5LmR0c2kgYW5kIG10ODE5Mi5kdHNpIGF0
IA0KdGhpcyBzdGFnZS4gSGVuY2Ugd2UgZG9uJ3QgbmVlZCB0byB3YWl0IHB3cmFwIG5vZGUgYmUg
bWVyZ2VkIGluIG10ODE5Mi5kdHNpLg0KDQpbMV0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMTYxNTU2MzI4Ni0yMjEyNi02LWdpdC1zZW5kLWVtYWlsLWhzaW4taHNpdW5nLndhbmdAbWVk
aWF0ZWsuY29tLw0KWzJdIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2UzMzA1M2NmLWYz
MzctZDdmNi1mYmY2LTkzZDM4NWY3ZTY4M0BnbWFpbC5jb20vDQpbM10gDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMjAxMTIxMTQ3MjQuMTk1My00LXRpbmdoYW4uc2hlbkBtZWRpYXRl
ay5jb20vDQoNCkFmdGVyIHRoYXQsIHlvdSBjYW4gaGF2ZSBteSBSZXZpZXdlZC1ieSB0YWcgaW4g
bmV4dCB2ZXJzaW9uLg0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1l
ZGlhdGVrLmNvbT4NCg0KVGhhbmtzIDopDQpNYWNwYXVsIExpbg==

