Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE44E4A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiCWBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiCWBpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:45:10 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8409729815
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:43:33 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7834:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 23 Mar 2022 09:41:20 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Mar 2022 09:41:50 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Wed, 23 Mar 2022 09:41:50 +0800
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
Thread-Index: AQHYPbV20XoTM/apKU2VdtNWQYp2n6zKqyIAgAGFk2A=
Date:   Wed, 23 Mar 2022 01:41:50 +0000
Message-ID: <d79dd7655c964f88a58d8bf403da39be@cqplus1.com>
References: <cover.1647928315.git.qinjian@cqplus1.com>
 <8372ee2fcf361a3af7233450c4403178052ceee2.1647928316.git.qinjian@cqplus1.com>
 <CAK8P3a1H2xM1PdDwKPWHD0fqZ0q_o-KZTLvSXdm9jjqTWcX-hA@mail.gmail.com>
In-Reply-To: <CAK8P3a1H2xM1PdDwKPWHD0fqZ0q_o-KZTLvSXdm9jjqTWcX-hA@mail.gmail.com>
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

PiBPbiBUdWUsIE1hciAyMiwgMjAyMiBhdCA3OjE3IEFNIFFpbiBKaWFuIDxxaW5qaWFuQGNxcGx1
czEuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBnZW5lcmljIFN1bnBsdXMgU1A3MDIxIGJhc2Vk
IGJvYXJkIGRlZmNvbmZpZw0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogUWluIEppYW4gPHFpbmppYW5AY3FwbHVz
MS5jb20+DQo+IA0KPiBJIGRvbid0IHRoaW5rIEkgZXZlciByZXBsaWVkIHdpdGggJ1Jldmlld2Vk
LWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPicNCj4gdG8gdGhpcyBwYXRjaC4gV2hp
bGUgSSBkaWQgcmV2aWV3IGl0IGluIHZlcnNpb24gNSwgeW91IG5ldmVyIHNlZW0gdG8gaGF2ZQ0K
PiByZXBsaWVkIHRvIG15IHF1ZXN0aW9ucyB0aGVyZS4NCj4gDQo+IEl0IHdhcyBhIHdoaWxlIGFn
byB0aG91Z2gsIHNvIEkgZG9uJ3QgcmVtZW1iZXIgdGhlIGRldGFpbHMsIGlmIHdlIGRpZA0KPiBj
b25jbHVkZSB0aGUgcmV2aWV3LCBjYW4geW91IGxpbmsgdG8gdGhlIGxvcmUua2VybmVsLm9yZyB0
aHJlYWQgaW4NCj4gdGhlIG5leHQgdmVyc2lvbj8gUGxlYXNlIGFsc28gY2hlY2sgdGhlIG90aGVy
IHBhdGNoZXMgb24gd2hpY2gNCj4geW91IGFkZGVkIGEgJ1Jldmlld2VkLWJ5JyB0YWcgZnJvbSBz
b21lb25lIHRvIGVuc3VyZSB0aGF0IHRoZXkNCj4gYWN0dWFsbHkgcHJvdmlkZWQgdGhhdCB0YWcs
IHJhdGhlciB0aGFuIGp1c3QgcHJvdmlkaW5nIHJldmlldyBjb21tZW50cy4NCj4gDQo+ICAgICAg
ICBBcm5kDQoNCg0KSW4gcGF0Y2ggNiwgSSBmaXhlZCBhbGwgeW91ciBjb21tZW50cy4NCg0KSSBn
b3QgYSByZXBseSBmcm9tIHlvdTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBSzhQM2Ex
RG9oOEdZOWlGWnN2bWQ2d0FTSG9QcXlSK3JvWHgwRzVYaWRubUhOa0dhQUBtYWlsLmdtYWlsLmNv
bS8NCj4gVGhpcyBsb29rcyBhbGwgZ29vZCB0byBtZSBub3csIGl0IGp1c3QgbmVlZHMgYSByZXZp
ZXcgZm9yIHRoZSBjbGssDQo+IHJlc2V0ICBhbmQgaXJxY2hpcCBkcml2ZXJzLiAuLi4NCg0KSWYg
dGhlc2Ugbm90IG1lYW5zIHlvdSByZXZpZXdlZCwgSSdsbCByZW1vdmUgeW91ciByZXZpZXctdGFn
Lg0KDQoNCg==
