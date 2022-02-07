Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933F24AB43C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiBGFut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350094AbiBGDSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:18:12 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 19:18:04 PST
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D21C061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 19:18:04 -0800 (PST)
X-UUID: 5a4ab4f1b2964d9e9448fd94ad2d7066-20220207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=YZZvR0t4dJmK+tzaa2+xl8XMxoD2nvg+7x/q6w/YaC0=;
        b=fGSeHeV+NLZFKcpxYupzDcTsSu8bO0DC6EfTY2NiFElqw4ihy8cke9nJhFwnrmheaivOuo+8NCh+f9rabijaPUtFwtMd4i8YrnfDJ3jApEC4Fr1pgek4b+Ur4bYyaqVm4h1nYs/qT5MrvCl4cnlhCCSgRkL+eLytm696F83BBgU=;
X-UUID: 5a4ab4f1b2964d9e9448fd94ad2d7066-20220207
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1598545706; Mon, 07 Feb 2022 11:12:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Feb 2022 11:12:58 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Feb 2022 11:12:58 +0800
Subject: Re: [PATCH] memory: mtk-smi: Enable sleep ctrl safety function for
 MT8195
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <yong.wu@mediatek.com>
CC:     <krzysztof.kozlowski@canonical.com>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220204125543.1189151-1-angelogioacchino.delregno@collabora.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <6c360daa-151b-5bb3-5c93-17f90cb693a6@mediatek.com>
Date:   Mon, 7 Feb 2022 11:12:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220204125543.1189151-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi80LzIyIDg6NTUgUE0sIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBF
bmFibGUgdGhlIHNsZWVwIGN0cmwgZnVuY3Rpb24gdG8gd2FpdCB1bnRpbCBhbGwgdGhlIHF1ZXVl
ZCBjb21tYW5kcw0KPiBhcmUgZXhlY3V0ZWQgYmVmb3JlIHN1c3BlbmRpbmcgdGhlIExBUkJzLCBs
aWtlIGRvbmUgZm9yIE1UODE4Ni4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hp
bm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyB8IDMgKystDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiBp
bmRleCBjMjJhY2QzZGRkMTAuLjg2YTNkMzRmNDE4ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9t
ZW1vcnkvbXRrLXNtaS5jDQo+ICsrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiBAQCAt
MzUxLDcgKzM1MSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NtaV9sYXJiX2dlbiBtdGtf
c21pX2xhcmJfbXQ4MTkyID0gew0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3Nt
aV9sYXJiX2dlbiBtdGtfc21pX2xhcmJfbXQ4MTk1ID0gew0KPiAgIAkuY29uZmlnX3BvcnQgICAg
ICAgICAgICAgICAgPSBtdGtfc21pX2xhcmJfY29uZmlnX3BvcnRfZ2VuMl9nZW5lcmFsLA0KPiAt
CS5mbGFnc19nZW5lcmFsCSAgICAgICAgICAgID0gTVRLX1NNSV9GTEFHX1RIUlRfVVBEQVRFIHwg
TVRLX1NNSV9GTEFHX1NXX0ZMQUcsDQo+ICsJLmZsYWdzX2dlbmVyYWwJICAgICAgICAgICAgPSBN
VEtfU01JX0ZMQUdfVEhSVF9VUERBVEUgfCBNVEtfU01JX0ZMQUdfU1dfRkxBRyB8DQo+ICsJCQkJ
ICAgICAgTVRLX1NNSV9GTEFHX1NMRUVQX0NUTCwNCj4gICAJLm9zdGQJCSAgICAgICAgICAgID0g
bXRrX3NtaV9sYXJiX210ODE5NV9vc3RkLA0KPiAgIH07DQo+ICAgDQo+IA0KDQpSZXZpZXdlZC1i
eTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KUmVnYXJkcywNCk1h
Y3BhdWwgTGlu

