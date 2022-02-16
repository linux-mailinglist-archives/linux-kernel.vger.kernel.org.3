Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D354B7DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbiBPCpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:45:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiBPCpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:45:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A73FBA73;
        Tue, 15 Feb 2022 18:44:52 -0800 (PST)
X-UUID: b070c4003ec8456184ba0c4c303423d6-20220216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=Pzq1ASA1hc2sgu0ItXffmb7MYGAO/ElkjWHHNwr99Yw=;
        b=R5wKSy6A4oAJ+50cSviOAmsKXFEwwMXEVcO74JZppaSEgcC6XzQHn4xJpDZSn+vtkKgLveuuD0TdvjEYRSVdDf1iuLSUJqjNCr9un3Dun04JWnm/BOdiyNuiL7nqYT4n4ff5c62xl+PyxQ8dD0ZX6QdD1yqXkRCMNTFArGg6Vnk=;
X-UUID: b070c4003ec8456184ba0c4c303423d6-20220216
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 713896900; Wed, 16 Feb 2022 10:44:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 16 Feb 2022 10:44:47 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 10:44:47 +0800
Subject: Re: [v2 0/2] Mediatek MT8186 power domain support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220215104917.5726-1-chun-jie.chen@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <75e57cf8-0704-1a6c-5c0b-860c7fb4e947@mediatek.com>
Date:   Wed, 16 Feb 2022 10:44:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220215104917.5726-1-chun-jie.chen@mediatek.com>
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

DQoNCk9uIDIvMTUvMjIgNjo0OSBQTSwgQ2h1bi1KaWUgQ2hlbiB3cm90ZToNCj4gVGhpcyBwYXRj
aCBzZXJpZXMgYWRkcyBwb3dlciBkb21haW4gc3VwcG9ydCBmb3IgTVQ4MTg2DQo+IGFuZCBkZXBl
bmRzIG9uIFsxXSBiYXNlZCBvbiA1LjE3LXJjMS4NCj4gDQo+IGNoYW5nZSBzaW5jZSB2MToNCj4g
LSBjaGFuZ2UgdG8gZHVhbCBsaWNlbnNlIGluIGR0LWJpbmRpbmcNCj4gDQo+IFsxXSBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz02MDk3OTlfXzshIUNUUk5LQTl3TWcwQVJidyEz
Q0pBQzAtVklxQXltckNjQVJza29hNlhJMElkcUg5Ynh6UHRDR0V1X29LUmVtMGwwSUVPZXRZOFNj
YkdnOUNMWkNjJA0KPiANCj4gQ2h1bi1KaWUgQ2hlbiAoMik6DQo+ICAgIGR0LWJpbmRpbmdzOiBw
b3dlcjogQWRkIE1UODE4NiBwb3dlciBkb21haW5zDQo+ICAgIHNvYzogbWVkaWF0ZWs6IHBtLWRv
bWFpbnM6IEFkZCBzdXBwb3J0IGZvciBtdDgxODYNCj4gDQo+ICAgLi4uL3Bvd2VyL21lZGlhdGVr
LHBvd2VyLWNvbnRyb2xsZXIueWFtbCAgICAgIHwgICAxICsNCj4gICBkcml2ZXJzL3NvYy9tZWRp
YXRlay9tdDgxODYtcG0tZG9tYWlucy5oICAgICAgfCAzNDQgKysrKysrKysrKysrKysrKysrDQo+
ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuYyAgICAgICAgIHwgICA1ICsN
Cj4gICBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4Ni1wb3dlci5oICAgICAgfCAgMzIg
KysNCj4gICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oICAgICAgICAgfCAg
NDggKysrDQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCA0MzAgaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxODYtcG0tZG9tYWlucy5oDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTg2LXBv
d2VyLmgNCj4gDQo+IC0tDQo+IDIuMTguMA0KDQpXaHkgZGlkIHlvdSBkcm9wIFtQQVRDSF0gdGFn
IGluIHRoZSBzdWJqZWN0IG9mIHlvdXIgcGF0Y2ggc2VyaWVzPw0KUGxlYXNlIGtlZXAgaXQgZm9y
IGRpc3Rpbmd1aXNoaW5nIGl0IGZyb20gUkZDIGFuZCBvdGhlciBtZWFuaW5nZnVsIHRhZ3MgDQpu
ZXh0IHRpbWUuDQoNClRoYW5rcw0KTWFjcGF1bCBMaW4=

