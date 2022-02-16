Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98DB4B84BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiBPJrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:47:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiBPJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:47:40 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D76B1AB4;
        Wed, 16 Feb 2022 01:47:27 -0800 (PST)
X-UUID: 43e5992bb4ca47e8a2d9ed72ddfbe55c-20220216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=RX4zJ5sBZgDNyte8klxClMm6QaG0WtU72JE8EwaTSR8=;
        b=ETk/k5E6a591GWaXD5QAmg0VRHSI6P9wAocjJcMVb/hjfCb6uC+4/4BlfGfvWZuSWzMuF6IkJy2O076UOt3KujqoIx7JuCVxWe8/gA8mPRHuyIKjhTitprHZI+c7K2uHCnDBYvKAUTHrkWOxQOe9L/k0/Qu16tWK+LfNR7VNscc=;
X-UUID: 43e5992bb4ca47e8a2d9ed72ddfbe55c-20220216
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 856271510; Wed, 16 Feb 2022 17:47:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 16 Feb 2022 17:47:23 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 17:47:22 +0800
Subject: Re: [v2,0/4] Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml
 format
To:     <xinlei.lee@mediatek.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <jitao.shi@mediatek.com>
CC:     <allen-kh.cheng@mediatek.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <7d54ecb2-bb7a-ab3d-9e29-fa2541ec549d@mediatek.com>
Date:   Wed, 16 Feb 2022 17:47:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMTYvMjIgNTozMiBQTSwgeGlubGVpLmxlZUBtZWRpYXRlay5jb20gd3JvdGU6DQo+
IEZyb206IFhpbmxlaSBMZWUgPHhpbmxlaS5sZWVAbWVkaWF0ZWsuY29ycC1wYXJ0bmVyLmdvb2ds
ZS5jb20+DQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAxLiBGaXhlZCBmb3JtYXR0aW5nIGlz
c3VlcyBtZW50aW9uZWQgaW4gdGhlIHYxLg0KPiAyLiBEZWxldGUgcHdtLW10ay1kaXNwLnR4dC4N
Cj4gMy4gQWRkIG10a19wd20gZHRfbWFpbnRhaW5lcnMuDQo+IDQuIEFkZCAiI3B3bS1jZWxscyIg
JiBwb3dlci1kb21haW5zIHByb3BlcnRpZXMuDQo+IDUuIE1ha2UgZHRfY2hlY2tpbmcgc3VjY2Vz
c2Z1bC4NCj4gDQo+IFhpbmxlaSBMZWUgKDQpOg0KPiAgICBkdC1iaW5kaW5nczogcHdtOiBDb252
ZXJ0IHB3bS1tdGstZGlzcC50eHQgdG8gbWVkaWF0ZWsscHdtLWRpc3AueWFtbA0KPiAgICAgIGZv
cm1hdA0KPiAgICBkdC1iaW5kaW5nczogcHdtOiBBZGQgY29tcGF0aWJsZSBmb3IgTWVkaWFUZWsg
TVQ4MTkyDQo+ICAgIGR0LWJpbmRpbmdzOiBwd206IEFkZCBjb21wYXRpYmxlIGZvciBNZWRpYVRl
ayBNVDgxOTUNCj4gICAgZHQtYmluZGluZ3M6IHB3bTogQWRkIGNvbXBhdGlibGUgZm9yIE1lZGlh
VGVrIE1UODE4Ng0KPiANCj4gICAuLi4vYmluZGluZ3MvcHdtL21lZGlhdGVrLHB3bS1kaXNwLnlh
bWwgICAgICAgfCA3NCArKysrKysrKysrKysrKysrKysrDQo+ICAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcHdtL3B3bS1tdGstZGlzcC50eHQgIHwgNDQgLS0tLS0tLS0tLS0NCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKyksIDQ0IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBt
b2RlIDEwMDc1NSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL21lZGlhdGVr
LHB3bS1kaXNwLnlhbWwNCj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3B3bS9wd20tbXRrLWRpc3AudHh0DQo+IA0KDQpXaHkgZGlkIHlvdSBk
cm9wIFtQQVRDSF0gdGFnIGluIHRoZSBzdWJqZWN0IG9mIHlvdXIgcGF0Y2ggc2VyaWVzPw0KUGxl
YXNlIGtlZXAgaXQgZm9yIGRpc3Rpbmd1aXNoaW5nIGl0IGZyb20gUkZDL1JFU0VORCBhbmQgb3Ro
ZXIgDQptZWFuaW5nZnVsIHRhZ3MgbmV4dCB0aW1lLg0KDQpUaGFua3MNCk1hY3BhdWwgTGlu

