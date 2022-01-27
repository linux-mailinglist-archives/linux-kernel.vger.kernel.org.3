Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E9E49DDFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiA0JcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:32:09 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:43912 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229861AbiA0JcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:32:07 -0500
X-UUID: 6a179c00dcc447f1b8a7e23db931ab64-20220127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=lCw7xxlThueL7C/oHzrF0dm+seOD7h4+6Gc3SeDLnuo=;
        b=D0/jHsiy1/KJNp7FoOiyw93FIL8kWlGZoDWEuY2bVaJ3jA3yeG+qzd8CI5QziyhCLLvGzKF0Mp8fC34tlDQVxg7vl13cFCN+/utsgthxu4Ob8F+8tEARLJe3joeWg9uy8pXDimHlmOCRNQHIOaIz9DsmaX/hzEJ/F20YUkwTqXM=;
X-UUID: 6a179c00dcc447f1b8a7e23db931ab64-20220127
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 51152178; Thu, 27 Jan 2022 17:32:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 27 Jan 2022 17:32:00 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Jan 2022 17:32:00 +0800
Subject: Re: [PATCH 1/2] arm64: dts: mt8192: add PWRAP node
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
        Wens Tsai <wenst@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Rex-BC Chen <Rex-BC.Chen@mediatek.com>
References: <20220127063145.13413-1-hui.liu@mediatek.com>
 <20220127063145.13413-2-hui.liu@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <8725f9cb-9c40-2d51-0a7b-96aaf80f7bdf@mediatek.com>
Date:   Thu, 27 Jan 2022 17:32:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220127063145.13413-2-hui.liu@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNy8yMiAyOjMxIFBNLCBIdWktTGl1IExpdSB3cm90ZToNCj4gRnJvbTogSHVpIExpdSA8
aHVpLmxpdUBtZWRpYXRlay5jb20+DQo+IA0KPiBBZGQgcHdyYXAgbm9kZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEh1aSBMaXUgPGh1aS5saXVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gICBhcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpIHwgMTIgKysrKysrKysrKysrDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpIGIvYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KPiBpbmRleCA1M2Q3OTBjMzM1ZjkuLjllZjMzZGJm
N2E3MyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIu
ZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQo+
IEBAIC0zMTYsNiArMzE2LDE4IEBAIHN5c3RpbWVyOiB0aW1lckAxMDAxNzAwMCB7DQo+ICAgCQkJ
Y2xvY2stbmFtZXMgPSAiY2xrMTNtIjsNCj4gICAJCX07DQo+ICAgDQo+ICsJCXB3cmFwOiBwd3Jh
cEAxMDAyNjAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njg3My1wd3JhcCI7
DQo+ICsJCQlyZWcgPSA8MCAweDEwMDI2MDAwIDAgMHgxMDAwPjsNCj4gKwkJCXJlZy1uYW1lcyA9
ICJwd3JhcCI7DQo+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjIwIElSUV9UWVBFX0xFVkVM
X0hJR0ggMD47DQo+ICsJCQljbG9ja3MgPSA8JmluZnJhY2ZnIENMS19JTkZSQV9QTUlDX0FQPiwN
Cj4gKwkJCQkgPCZpbmZyYWNmZyBDTEtfSU5GUkFfUE1JQ19UTVI+Ow0KPiArCQkJY2xvY2stbmFt
ZXMgPSAic3BpIiwgIndyYXAiOw0KPiArCQkJYXNzaWduZWQtY2xvY2tzID0gPCZ0b3Bja2dlbiBD
TEtfVE9QX1BXUkFQX1VMUE9TQ19TRUw+Ow0KPiArCQkJYXNzaWduZWQtY2xvY2stcGFyZW50cyA9
IDwmdG9wY2tnZW4gQ0xLX1RPUF9PU0NfRDEwPjsNCj4gKwkJfTsNCj4gKw0KPiAgIAkJc2NwX2Fk
c3A6IGNsb2NrLWNvbnRyb2xsZXJAMTA3MjAwMDAgew0KPiAgIAkJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTkyLXNjcF9hZHNwIjsNCj4gICAJCQlyZWcgPSA8MCAweDEwNzIwMDAwIDAgMHgx
MDAwPjsNCj4gDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0
ZWsuY29tPg0KDQpSZWdhcmRzLA0KTWFjcGF1bCBMaW4=

