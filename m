Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197034B8490
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiBPJi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:38:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiBPJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:38:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F98E44AE;
        Wed, 16 Feb 2022 01:38:40 -0800 (PST)
X-UUID: abd4d364babd48a0942d93fefd5053ce-20220216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=KXmXiao3N/LP6EYmXpUlj7b1IEb9SBtcb1jEDOaHX2o=;
        b=ik6B1RLvtWETkn3Disuxr0/CgmPU13YEJoZGYkA0gpG7EB3Ub8IwBJMYKXHZrKyobZbEe/sTnTJEBhLSI/aqV23Y/Hd/+CNEFD04aFujwxrBE3gH28dPnumcezRQbIjuE0lhojClVJPZujjrkEJcu5azKV/0bh6fCz1YTQoX6lo=;
X-UUID: abd4d364babd48a0942d93fefd5053ce-20220216
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2005764580; Wed, 16 Feb 2022 17:38:36 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Feb 2022 17:38:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Feb
 2022 17:38:34 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 17:38:34 +0800
Subject: Re: [PATCH v2 3/4] arm64: dts: mediatek: mt8195: add efuse node and
 cells
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
 <20220128062902.26273-3-chunfeng.yun@mediatek.com>
 <YgY3qvAy5lW1tEdG@kroah.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <6e26f483-f4b6-0d0f-7cca-cfa19a39b10a@mediatek.com>
Date:   Wed, 16 Feb 2022 17:38:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YgY3qvAy5lW1tEdG@kroah.com>
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

DQoNCk9uIDIvMTEvMjIgNjoxNyBQTSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiBPbiBG
cmksIEphbiAyOCwgMjAyMiBhdCAwMjoyOTowMVBNICswODAwLCBDaHVuZmVuZyBZdW4gd3JvdGU6
DQo+PiBBZGQgZWZ1c2Ugbm9kZSBhbmQgY2VsbHMgdXNlZCBieSB0LXBoeSB0byBmaXggdGhlIGJp
dCBzaGlmdCBpc3N1ZQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZl
bmcueXVuQG1lZGlhdGVrLmNvbT4NCj4+IC0tLQ0KPj4gdjI6IHVzZSBodyBhdXRvIGxvYWQgZm9y
IHUycGh5IHdoaWNoIGhhcyBubyB0aGlzIGlzc3VlDQo+Pg0KPj4gTm90ZToNCj4+DQo+PiAgIGRl
cGVuZCBvbiB0aGUgcmV2aWV3aW5nIHBhdGNoOg0KPj4NCj4+IFt2OSwzLzNdIGFybTY0OiBkdHM6
IEFkZCBtZWRpYXRlayBTb0MgbXQ4MTk1IGFuZCBldmFsdWF0aW9uIGJvYXJkDQo+PiBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8x
MjcxMTI5Nl9fOyEhQ1RSTktBOXdNZzBBUmJ3ITBKZzhrTE40a0J3MExjYmlBSDFIWVRxMnVRNVZ3
aUQtQ0U4eW9GQkQ3b0FwbjhZTlNkbVZwd1NkWTFxMkM3THZZNmMkDQo+IA0KPiBBcyBJIGRvbid0
IGhhdmUgdGhhdCBpbiBteSB0cmVlLCBJIGNhbiBvbmx5IHRha2UgdGhlIGZpcnN0IDIgcGF0Y2hl
cw0KPiBoZXJlIG5vdywgdGhhbmtzLg0KPiANCj4gZ3JlZyBrLWgNCj4gDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4LW1lZGlhdGVrIG1h
aWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrX187ISFDVFJOS0E5d01nMEFSYnchMEpnOGtMTjRrQncw
TGNiaUFIMUhZVHEydVE1VndpRC1DRTh5b0ZCRDdvQXBuOFlOU2RtVnB3U2RZMXEyWk1EWG1HNCQN
Cj4gDQoNCkp1c3QgYSBnZW50bGUgcmVtaW5kZXIgdGhhdCB0aGVyZSBpcyBuZXcgdjEwIHZlcnNp
b24NCg0KWzFdIFtQQVRDSCB2MTAgMy8zXSBhcm02NDogZHRzOiBBZGQgbWVkaWF0ZWsgU29DIG10
ODE5NSBhbmQgZXZhbHVhdGlvbiANCmJvYXJkDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjIwMTMwMDIzMjA5LjE2Mjc1LTQtdGluZ2hhbi5zaGVuQG1lZGlhdGVrLmNvbS9ULyNtYWU3
ZmNlNjBhZTU0MDJlN2E1ZDA0NGZiMjdjZTA3ZDlmMGRiMDNjZQ0KDQpDb21lIGFsb25nIHdpdGgg
dGhpcyBwYXRjaCBzZXQgaXMgc3RpbGwgdW5kZXIgcmV2aWV3aW5nLg0KWzJdIFtQQVRDSCB2MTAg
MC8zXSBBZGQgYmFzaWMgU29DIHN1cHBvcnQgZm9yIG1lZGlhdGVrIG10ODE5NQ0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDEzMDAyMzIwOS4xNjI3NS00LXRpbmdoYW4uc2hlbkBt
ZWRpYXRlay5jb20vVC8NCg0KV2hpbGUgdGhlIHYxMCBbUEFUQ0ggMi8zXSBpbmNsdWRlZCBpbiB2
MTAgcGF0Y2hzZXQgWzJdIGlzIHJlcXVpcmVkIGZvciANCnRoaXMgcmV2aWV3IGZlZWRiYWNrLg0K
WzNdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIyLzEvMjkvNDAxDQoNClRoYW5rcyENCk1hY3Bh
dWwgTGlu

