Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAAD49D90B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiA0DOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:14:07 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52342 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229997AbiA0DOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:14:05 -0500
X-UUID: 29a9983c1c37452a9feea7eb02f38e62-20220127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=O7ExxcYQ34pCqU+aHSIMXMERAIswBAj9fMKKhUp0H54=;
        b=IRPJXRhkni8LQiaUhtSlkHuEfJtgS/h1pzO0QFk4us9+wKnIF174MfDEUX+mLTS9d2k4wbdSJDdmOGU5dtkPoZ78COQwHOu95Dw45CbcY4AIs40nLcCG3PkMITtX0D1w4Me0sOSgWrkZk79VBVZrDMHAnTfBeVNS1OFUo8Q0m7w=;
X-UUID: 29a9983c1c37452a9feea7eb02f38e62-20220127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1804577149; Thu, 27 Jan 2022 11:14:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 27 Jan 2022 11:13:59 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Jan 2022 11:13:59 +0800
Subject: Re: [PATCH v1, 4/8] media: mtk-vcodec: Adds compatible for mt8195
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
 <20220127025544.10854-5-yunfei.dong@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <44215372-ff16-6f58-f4be-4df3f506a460@mediatek.com>
Date:   Thu, 27 Jan 2022 11:13:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220127025544.10854-5-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI3LzIyIDEwOjU1IEFNLCBZdW5mZWkgRG9uZyB3cm90ZToNCj4gQWRkcyBjb21wYXRp
YmxlIGZvciBtdDgxOTUgcGxhdGZvcm0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdW5mZWkgRG9u
ZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19kZWNfZHJ2LmMgfCA0ICsrKysNCj4gICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZGVjX2Rydi5jIGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZGVjX2Rydi5jDQo+IGluZGV4IDJk
MjFkMDAxMGM5Yy4uOTM4YmYxNGU0ZThjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19kZWNfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZGVjX2Rydi5jDQo+IEBAIC00Njgs
NiArNDY4LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a192Y29kZWNf
bWF0Y2hbXSA9IHsNCj4gICAJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4Ni12Y29kZWMt
ZGVjIiwNCj4gICAJCS5kYXRhID0gJm10a192ZGVjX3NpbmdsZV9jb3JlX3BkYXRhLA0KPiAgIAl9
LA0KPiArCXsNCj4gKwkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXZjb2RlYy1kZWMi
LA0KPiArCQkuZGF0YSA9ICZtdGtfbGF0X3NpZ19jb3JlX3BkYXRhLA0KPiArCX0sDQo+ICAgCXt9
LA0KPiAgIH07DQo+ICAgDQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwu
bGluQG1lZGlhdGVrLmNvbT4NCg0KUmVnYXJkcywNCk1hY3BhdWwgTGlu

