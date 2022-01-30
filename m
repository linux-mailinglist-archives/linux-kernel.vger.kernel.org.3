Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59C4A3526
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354401AbiA3IUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:20:55 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:43768 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354377AbiA3IUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:20:53 -0500
X-UUID: 32d543e1b7354728a085bcc67f6cef15-20220130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:Subject; bh=5dfX0uT7YajxHZZ5mnr7QgVoobwwPPVsKoXZSANCdOM=;
        b=JnIh5X/PQowhf3y9hYkzTPIaiD4QNRWSpYt4A3+v7KO/XEhHVgNDu42WluVh7GXj4/qLUBn8BRBe8hU15kC5/3cSw2gOLjOcJeeXhbM6bGOsLHHQw7RItKnzwlcH90UVEmSENF+7s2H24SfmGGXv4qju2N+dgw4HP2S2Ben1glw=;
X-UUID: 32d543e1b7354728a085bcc67f6cef15-20220130
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 731501614; Sun, 30 Jan 2022 16:20:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 30 Jan 2022 16:20:46 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 Jan 2022 16:20:46 +0800
Subject: Re: [PATCH 0/2] Add pwrap node for MediaTek MT8192 SoC and mt6359
 node for MediaTek PMIC MT6359
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Hui-Liu Liu <hui.liu@mediatek.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <eddie.huang@mediatek.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hsin-hsiung.wang@mediatek.com>, <sean.wang@mediatek.com>,
        <yuchen.huang@mediatek.com>, <wen.su@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Wens Tsai <wenst@chromium.org>,
        Pablo Sun <pablo.sun@mediatek.com>
References: <20220127063145.13413-1-hui.liu@mediatek.com>
 <aeb9bc06-c6e3-810b-7ec5-6e0038d32c88@mediatek.com>
Message-ID: <88435da5-b3d7-8cdb-908f-aae5d96a98dd@mediatek.com>
Date:   Sun, 30 Jan 2022 16:20:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aeb9bc06-c6e3-810b-7ec5-6e0038d32c88@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI3LzIyIDU6MzYgUE0sIE1hY3BhdWwgTGluIHdyb3RlOg0KPiANCj4gT24gMS8yNy8y
MiAyOjMxIFBNLCBIdWktTGl1IExpdSB3cm90ZToNCj4+IFRoaXMgcGF0aHNldCBhZGQgcHdyYXAg
bm9kZSB0byBTb0MgTVQ4MTkyLCBhbmQgYWRkIFBNSUMgTVQ2MzU5IHJlbGF0ZWQgDQo+PiBub2Rl
cy4NCj4+IE1UNjM1OSBpcyB0aGUgcHJpbWFyeSBQTUlDIGZvciBNVDgxOTIgYW5kIHByb2JhYmx5
IG90aGVyIFNvQ3MuDQo+Pg0KPj4gVGhlIHNlcmllc1sxXSBhbmQgc2VyaWVzWzJdIHNlbmQgYnkg
SHNpbi1Ic2l1bmcgd2lsbCBjb250aW51ZSB0byANCj4+IHVwc3RyZWFtIGluIHRoaXMgcGF0aHNl
dCBhZnRlcndhcmRzLg0KPj4NCj4+IFsxXSANCj4+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8xNjE1NTYzMjg2LTIyMTI2LTYtZ2l0LXNl
bmQtZW1haWwtaHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20vIA0KPj4NCj4+IFsyXSANCj4+
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRj
aC8xNjIyMDExOTI3LTM1OS05LWdpdC1zZW5kLWVtYWlsLWhzaW4taHNpdW5nLndhbmdAbWVkaWF0
ZWsuY29tLyANCj4+DQo+Pg0KPj4gSHVpIExpdSAoMik6DQo+PiDCoMKgIGFybTY0OiBkdHM6IG10
ODE5MjogYWRkIFBXUkFQIG5vZGUNCj4+IMKgwqAgYXJtNjQ6IGR0czogbXQ2MzU5OiBhZGQgUE1J
QyBNVDYzNTkgcmVsYXRlZCBub2Rlcw0KPj4NCj4+IMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ2MzU5LmR0c2nCoMKgwqAgfCAyOTggKysrKysrKysrKysrKysrKysrKysNCj4+IMKg
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLWV2Yi5kdHMgfMKgwqAgMSArDQo+
PiDCoCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpwqDCoMKgIHzCoCAx
MiArDQo+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDMxMSBpbnNlcnRpb25zKCspDQo+PiDCoCBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTkuZHRzaQ0K
Pj4NCj4+IC0tIA0KPj4gMi4yNS4xDQo+Pg0KPj4NCj4gDQo+IFRoaXMgcGF0Y2hzZXQgaXMgYmFz
ZWQgb24gWzFdDQo+IA0KPiBbMV0gYXJtNjQ6IGR0czogQWRkIG1lZGlhdGVrIFNvQyBtdDgxOTUg
YW5kIGV2YWx1YXRpb24gYm9hcmQNCj4gLSANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjIwMTEyMTE0NzI0LjE5NTMtNC10aW5n
aGFuLnNoZW5AbWVkaWF0ZWsuY29tLyANCj4gDQo+IA0KPiBJJ3ZlIHRlc3RlZCB0aGlzIHBhdGNo
IHNldCBidWlsZCBwYXNzIHdpdGggWzFdIGZvciBib3RoIG10ODE5MiBhbmQgDQo+IG10ODE5NSBw
bGF0Zm9ybSBvbiBsaW51eC01LjE3LXJjMS4NCj4gDQo+IFJldmlld2VkLWJ5OiBNYWNwYXVsIExp
biA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gUmVnYXJkcywNCj4gTWFjcGF1bCBM
aW4NCg0KVXBkYXRlZDogVGhpcyBwYXRjaHNldCBwYXNzZXMgYnVpbGQgdGVzdCBiYXNlZCBvbiBu
ZXcgcGF0Y2hzZXQgdjEwIG9mIA0KWzFdLCB3aGVyZSB0aGUgbmV3IHBhdGNoc2V0IGlzIFsyXSBv
biA1LjE3LXJjMS4NCg0KWzJdIHYxMCwgYXJtNjQ6IGR0czogQWRkIG1lZGlhdGVrIFNvQyBtdDgx
OTUgYW5kIGV2YWx1YXRpb24gYm9hcmQNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
YXJtLWtlcm5lbC8yMDIyMDEzMDAyMzIwOS4xNjI3NS0zLXRpbmdoYW4uc2hlbkBtZWRpYXRlay5j
b20vVC8NCg0KUmVnYXJkcywNCk1hY3BhdWwgTGluDQphcm02NDogZHRzOiBBZGQgbWVkaWF0ZWsg
U29DIG10ODE5NSBhbmQgZXZhbHVhdGlvbiBib2FyZA==

