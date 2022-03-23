Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB84E4E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbiCWIsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiCWIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:48:36 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63ACD6E8CA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:46:59 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7823:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 23 Mar 2022 16:45:30 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Mar 2022 16:45:58 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Wed, 23 Mar 2022 16:45:58 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Russell King - ARM Linux" <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v11 9/9] ARM: sp7021_defconfig: Add Sunplus SP7021
 defconfig
Thread-Topic: [PATCH v11 9/9] ARM: sp7021_defconfig: Add Sunplus SP7021
 defconfig
Thread-Index: AQHYPbV20XoTM/apKU2VdtNWQYp2n6zKqyIAgAGFk2D//+uUgIAAjMMg
Date:   Wed, 23 Mar 2022 08:45:58 +0000
Message-ID: <c0af7c88c19f4fe9a9288f371482c302@cqplus1.com>
References: <cover.1647928315.git.qinjian@cqplus1.com>
 <8372ee2fcf361a3af7233450c4403178052ceee2.1647928316.git.qinjian@cqplus1.com>
 <CAK8P3a1H2xM1PdDwKPWHD0fqZ0q_o-KZTLvSXdm9jjqTWcX-hA@mail.gmail.com>
 <d79dd7655c964f88a58d8bf403da39be@cqplus1.com>
 <CAK8P3a10rsxpzd4eJbSJmRUDEMbOO+=6+=6Eu-7EY86+xw8V6g@mail.gmail.com>
In-Reply-To: <CAK8P3a10rsxpzd4eJbSJmRUDEMbOO+=6+=6Eu-7EY86+xw8V6g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEluIHBhdGNoIDYsIEkgZml4ZWQgYWxsIHlvdXIgY29tbWVudHMuDQo+ID4NCj4gPiBJIGdv
dCBhIHJlcGx5IGZyb20geW91Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FLOFAz
YTFEb2g4R1k5aUZac3ZtZDZ3QVNIb1BxeVIrcm9YeDBHNVhpZG5tSE5rR2FBQG1haWwuZ21haWwu
Y29tLw0KPiA+ID4gVGhpcyBsb29rcyBhbGwgZ29vZCB0byBtZSBub3csIGl0IGp1c3QgbmVlZHMg
YSByZXZpZXcgZm9yIHRoZSBjbGssDQo+ID4gPiByZXNldCAgYW5kIGlycWNoaXAgZHJpdmVycy4g
Li4uDQo+ID4NCj4gPiBJZiB0aGVzZSBub3QgbWVhbnMgeW91IHJldmlld2VkLCBJJ2xsIHJlbW92
ZSB5b3VyIHJldmlldy10YWcuDQo+IA0KPiBZb3UgY2FuIG9ubHkgYWRkIFJldmlld2VkLWJ5IHRh
Z3MgdGhhdCBoYXZlIGJlZW4gZXhwbGljaXRseSBnaXZlbiwNCj4gc2VlIHRoZSBkb2N1bWVudGF0
aW9uIGF0IFsxXSBmb3IgZGV0YWlscy4gV2hhdCBJIHdyb3RlIHdhcyBhIGxlc3MNCj4gZm9ybWFs
IGFja25vd2xlZGdlbWVudCB0aGF0IGRvZXMgbm90IGhhdmUgdGhlIHNwZWNpZmljIG1lYW5pbmcu
DQo+IA0KPiAgICAgICBBcm5kDQo+IA0KPiBbMV0gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2Mv
aHRtbC9sYXRlc3QvdHJhbnNsYXRpb25zL3poX1RXL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVz
Lmh0bWwjdXNpbmctcmVwb3J0ZWQtYnktdGVzdGVkLWJ5LQ0KPiByZXZpZXdlZC1ieS1zdWdnZXN0
ZWQtYnktYW5kLWZpeGVzDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cywgSSdsbCByZW1vdmUg
eW91ciB0YWdzIGxhdGVyLg0K
