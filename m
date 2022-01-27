Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1549DE27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiA0JgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:36:13 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:50866 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229699AbiA0JgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:36:12 -0500
X-UUID: 18b85e8565714eccacd26e804009fa9f-20220127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=4Mdu4dP44jYB1UdM0uaD1oyQ+nWAaTLV7TqoxKckcQk=;
        b=ACGCQ4Be8G0Q/VeDv/kuchX5oH1XthHNztfwSc2oxiX8bMOhaFG+EgvuCqMsV33dYuw6+f9bB2HyEhakJhqYDPodqJnS27rAAaAXRvBARv/eM7uRzH3UtbJNMJ5Oy6x2zTsb4eVoeHj1wDXUcxRTVZZwfLK6qEgHU7yNLyN1n04=;
X-UUID: 18b85e8565714eccacd26e804009fa9f-20220127
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 988202731; Thu, 27 Jan 2022 17:36:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 27 Jan 2022 17:36:08 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Jan 2022 17:36:08 +0800
Subject: Re: [PATCH 0/2] Add pwrap node for MediaTek MT8192 SoC and mt6359
 node for MediaTek PMIC MT6359
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
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <aeb9bc06-c6e3-810b-7ec5-6e0038d32c88@mediatek.com>
Date:   Thu, 27 Jan 2022 17:36:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220127063145.13413-1-hui.liu@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI3LzIyIDI6MzEgUE0sIEh1aS1MaXUgTGl1IHdyb3RlOg0KPiBUaGlzIHBhdGhzZXQg
YWRkIHB3cmFwIG5vZGUgdG8gU29DIE1UODE5MiwgYW5kIGFkZCBQTUlDIE1UNjM1OSByZWxhdGVk
IG5vZGVzLg0KPiBNVDYzNTkgaXMgdGhlIHByaW1hcnkgUE1JQyBmb3IgTVQ4MTkyIGFuZCBwcm9i
YWJseSBvdGhlciBTb0NzLg0KPiANCj4gVGhlIHNlcmllc1sxXSBhbmQgc2VyaWVzWzJdIHNlbmQg
YnkgSHNpbi1Ic2l1bmcgd2lsbCBjb250aW51ZSB0byB1cHN0cmVhbSBpbiB0aGlzIHBhdGhzZXQg
YWZ0ZXJ3YXJkcy4NCj4gDQo+IFsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2pl
Y3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMTYxNTU2MzI4Ni0yMjEyNi02LWdpdC1zZW5kLWVtYWls
LWhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tLw0KPiBbMl0gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzE2MjIwMTE5MjctMzU5LTkt
Z2l0LXNlbmQtZW1haWwtaHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20vDQo+IA0KPiBIdWkg
TGl1ICgyKToNCj4gICAgYXJtNjQ6IGR0czogbXQ4MTkyOiBhZGQgUFdSQVAgbm9kZQ0KPiAgICBh
cm02NDogZHRzOiBtdDYzNTk6IGFkZCBQTUlDIE1UNjM1OSByZWxhdGVkIG5vZGVzDQo+IA0KPiAg
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5LmR0c2kgICAgfCAyOTggKysrKysr
KysrKysrKysrKysrKysNCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi1l
dmIuZHRzIHwgICAxICsNCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5k
dHNpICAgIHwgIDEyICsNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMxMSBpbnNlcnRpb25zKCspDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5
LmR0c2kNCj4gDQo+IC0tDQo+IDIuMjUuMQ0KPiANCj4gDQoNClRoaXMgcGF0Y2hzZXQgaXMgYmFz
ZWQgb24gWzFdDQoNClsxXSBhcm02NDogZHRzOiBBZGQgbWVkaWF0ZWsgU29DIG10ODE5NSBhbmQg
ZXZhbHVhdGlvbiBib2FyZA0KLSANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIyMDExMjExNDcyNC4xOTUzLTQtdGluZ2hhbi5zaGVu
QG1lZGlhdGVrLmNvbS8NCg0KSSd2ZSB0ZXN0ZWQgdGhpcyBwYXRjaCBzZXQgYnVpbGQgcGFzcyB3
aXRoIFsxXSBmb3IgYm90aCBtdDgxOTIgYW5kIA0KbXQ4MTk1IHBsYXRmb3JtIG9uIGxpbnV4LTUu
MTctcmMxLg0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVr
LmNvbT4NCg0KUmVnYXJkcywNCk1hY3BhdWwgTGlu

