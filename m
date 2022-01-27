Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94AF49D907
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiA0DNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:13:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54116 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229997AbiA0DNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:13:24 -0500
X-UUID: 6a6c34f1b16f40a083c0d8dbe5b42166-20220127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=+2WxQpFVI5qw1dkZNg30PRf7aBP8hnEBwwYTFu2nm70=;
        b=DlY5F6L8/jLJ/PYMsdqOwOsDOQcbFXFdy4Go35hIrxKm2plA/l2cBg82xW2/QaJYYKd2t5oledqgsH432VLC6WSJv5iPJG63BLCJYqU3ra48QIpj+gmOLRQRXSomEGEuxyMEnjE00/mlpoPMsx1lgMr2uyPwnloHvUhbZfhKJ2I=;
X-UUID: 6a6c34f1b16f40a083c0d8dbe5b42166-20220127
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1078697365; Thu, 27 Jan 2022 11:13:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 27 Jan 2022 11:13:20 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Jan 2022 11:13:19 +0800
Subject: Re: [PATCH v1, 3/8] dt-bindings: media: mtk-vcodec: Adds decoder
 dt-bindings for mt8195
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Macross Chen <macross.chen@mediatek.com>
References: <20220127025544.10854-1-yunfei.dong@mediatek.com>
 <20220127025544.10854-4-yunfei.dong@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <6d82d43c-8cf9-49cc-9a23-1d4af29ece81@mediatek.com>
Date:   Thu, 27 Jan 2022 11:13:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220127025544.10854-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNy8yMiAxMDo1NSBBTSwgWXVuZmVpIERvbmcgd3JvdGU6DQo+IEFkZHMgZGVjb2RlciBk
dC1iaW5kaW5ncyBmb3IgbXQ4MTk1Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVuZmVpIERvbmcg
PHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICAgLi4uL2JpbmRpbmdzL21lZGlh
L21lZGlhdGVrLHZjb2RlYy1zdWJkZXYtZGVjb2Rlci55YW1sICAgICAgICAgICB8IDEgKw0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtc3ViZGV2
LWRlY29kZXIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9t
ZWRpYXRlayx2Y29kZWMtc3ViZGV2LWRlY29kZXIueWFtbA0KPiBpbmRleCBhM2M4OTIzMzhhYzAu
LmEyZjJkYjI5ZGFlZCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy1zdWJkZXYtZGVjb2Rlci55YW1sDQo+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMt
c3ViZGV2LWRlY29kZXIueWFtbA0KPiBAQCAtNTAsNiArNTAsNyBAQCBwcm9wZXJ0aWVzOg0KPiAg
ICAgICBlbnVtOg0KPiAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXZjb2RlYy1kZWMNCj4gICAg
ICAgICAtIG1lZGlhdGVrLG10ODE4Ni12Y29kZWMtZGVjDQo+ICsgICAgICAtIG1lZGlhdGVrLG10
ODE5NS12Y29kZWMtZGVjDQo+ICAgDQo+ICAgICByZWc6DQo+ICAgICAgIG1heEl0ZW1zOiAxDQo+
IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4N
Cg0KUmVnYXJkcywNCk1hY3BhdWwgTGlu

