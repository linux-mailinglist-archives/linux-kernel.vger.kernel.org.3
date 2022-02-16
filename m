Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A3C4B7DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbiBPCqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:46:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiBPCqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:46:16 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A7FBA74;
        Tue, 15 Feb 2022 18:46:04 -0800 (PST)
X-UUID: 11f221bd83bf42e288ace2ff2ff6b487-20220216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=hDrxhPxjQENGAHEi4n1oPYu6PsljPhzDv0c7ynvHbXY=;
        b=Hr5wceSmSREZHLDnvA/oUCSY2KPYMlJHpB3cbGt1YVlkviw/fmLyfWpbUQ3irEYRqhZZq4D6+viuYJurPPlazojLQEu6rP8VCIHbInS1711VfzgFtnKbxotPa+CCL25Cs4ft0hug+3LMiDf1YtPFbEvi1LejLGMt7ja5azjiaAg=;
X-UUID: 11f221bd83bf42e288ace2ff2ff6b487-20220216
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 683217625; Wed, 16 Feb 2022 10:45:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Feb 2022 10:45:58 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 10:45:58 +0800
Subject: Re: [0/4] Add watchdog support for MT8186 SoC
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <runyang.chen@mediatek.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <a680164d-9be2-8f96-abe3-27e93e5c2ad2@mediatek.com>
Date:   Wed, 16 Feb 2022 10:45:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
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

DQoNCk9uIDIvMTYvMjIgOTo0NSBBTSwgUmV4LUJDIENoZW4gd3JvdGU6DQo+IHYxOg0KPiAxLiBB
ZGQgbXQ4MTg2LXJlc2V0cy5oIHRvIGRlZmluZSBkZWZpbml0aW9uIG9mIHJlc2V0IGJpdHMuDQo+
IDIuIEFkZCB3ZHQgY29tcGF0aWJsZSBmb3IgTVQ4MTg2Lg0KPiANCj4gUmV4LUJDIENoZW4gKDIp
Og0KPiAgICBkdC1iaW5kaW5nczogd2F0Y2hkb2c6IEFkZCBjb21wYXRpYmxlIGZvciBNZWRpYVRl
ayBNVDgxODYNCj4gICAgZHQtYmluZGluZ3M6IHJlc2V0OiBtdDgxODY6IGFkZCBEU0kgcmVzZXQg
Yml0IGZvciBNTVNZUw0KPiANCj4gUnVueWFuZyBDaGVuICgyKToNCj4gICAgZHQtYmluZGluZ3M6
IHJlc2V0OiBtdDgxODY6IGFkZCB0b3ByZ3UgcmVzZXQtY29udHJvbGxlciBoZWFkZXIgZmlsZQ0K
PiAgICB3YXRjaGRvZzogbWVkaWF0ZWs6IG10ODE4NjogYWRkIHdkdCBzdXBwb3J0DQo+IA0KPiAg
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL210ay13ZHQudHh0ICB8ICAxICsNCj4g
ICBkcml2ZXJzL3dhdGNoZG9nL210a193ZHQuYyAgICAgICAgICAgICAgICAgICAgfCAgNiArKysr
DQo+ICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC9tdDgxODYtcmVzZXRzLmggICAgIHwgMzYg
KysrKysrKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygr
KQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0L210ODE4
Ni1yZXNldHMuaA0KPiANCg0KV2h5IGRpZCB5b3UgZHJvcCBbUEFUQ0hdIHRhZyBpbiB0aGUgc3Vi
amVjdCBvZiB5b3VyIHBhdGNoIHNlcmllcz8NClBsZWFzZSBrZWVwIGl0IGZvciBkaXN0aW5ndWlz
aGluZyBpdCBmcm9tIFJGQyBhbmQgb3RoZXIgbWVhbmluZ2Z1bCB0YWdzIA0KbmV4dCB0aW1lLg0K
DQpUaGFua3MNCk1hY3BhdWwgTGlu

