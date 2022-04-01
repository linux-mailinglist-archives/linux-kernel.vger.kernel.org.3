Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6434EE8FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbiDAHVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbiDAHU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:20:59 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6DBFB7C3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:19:00 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1166:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 01 Apr 2022 15:16:54 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 1 Apr 2022 15:17:53 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Fri, 1 Apr 2022 15:17:53 +0800
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
Subject: RE: [PATCH v12 7/9] irqchip: Add Sunplus SP7021 interrupt controller
 driver
Thread-Topic: [PATCH v12 7/9] irqchip: Add Sunplus SP7021 interrupt controller
 driver
Thread-Index: AQHYRNqOFHiqRDi4BESy0Jgu755hDKzYsFoAgAH1GCA=
Date:   Fri, 1 Apr 2022 07:17:52 +0000
Message-ID: <49a391f2636d4bb193b80c301ce0832d@cqplus1.com>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <c75df921c121c047d48a34de29cd18cf9a631d01.1648714851.git.qinjian@cqplus1.com>
 <CAK8P3a16M3nv+TQWsC-0Pr5M2vcTttC2WWTzctMBaqdODMFX-A@mail.gmail.com>
In-Reply-To: <CAK8P3a16M3nv+TQWsC-0Pr5M2vcTttC2WWTzctMBaqdODMFX-A@mail.gmail.com>
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

PiANCj4gT24gVGh1LCBNYXIgMzEsIDIwMjIgYXQgMTA6MjkgQU0gUWluIEppYW4gPHFpbmppYW5A
Y3FwbHVzMS5jb20+IHdyb3RlOg0KPiANCj4gPiArI2lmZGVmIENPTkZJR19TTVANCj4gPiArc3Rh
dGljIGludCBzcF9pbnRjX3NldF9hZmZpbml0eShzdHJ1Y3QgaXJxX2RhdGEgKmQsIGNvbnN0IHN0
cnVjdCBjcHVtYXNrICptYXNrLCBib29sIGZvcmNlKQ0KPiA+ICt7DQo+ID4gKyAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gPiArfQ0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1
Y3QgaXJxX2NoaXAgc3BfaW50Y19jaGlwID0gew0KPiA+ICsgICAgICAgLm5hbWUgPSAic3BfaW50
YyIsDQo+ID4gKyAgICAgICAuaXJxX2FjayA9IHNwX2ludGNfYWNrX2lycSwNCj4gPiArICAgICAg
IC5pcnFfbWFzayA9IHNwX2ludGNfbWFza19pcnEsDQo+ID4gKyAgICAgICAuaXJxX3VubWFzayA9
IHNwX2ludGNfdW5tYXNrX2lycSwNCj4gPiArICAgICAgIC5pcnFfc2V0X3R5cGUgPSBzcF9pbnRj
X3NldF90eXBlLA0KPiA+ICsjaWZkZWYgQ09ORklHX1NNUA0KPiA+ICsgICAgICAgLmlycV9zZXRf
YWZmaW5pdHkgPSBzcF9pbnRjX3NldF9hZmZpbml0eSwNCj4gPiArI2VuZGlmDQo+ID4gK307DQo+
IA0KPiBJIGRvbid0IHRoaW5rIHlvdSBuZWVkIHRvIGRlZmluZSBhbiBpcnFfc2V0X2FmZmluaXR5
KCkgY2FsbGJhY2sgYXQgYWxsIGlmIHlvdQ0KPiBqdXN0IHJldHVybiAtRUlOVkFMLCBhbGwgdGhl
IGNhbGxlcnMgc2hvdWxkIGhhdmUgYSBjaGVjayBhbHJlYWR5LiBFdmVuDQo+IGlmIHlvdSBkbyBu
ZWVkIHRoZSBmdW5jdGlvbiwgSSB0aGluayB5b3UgY2FuIHJlbW92ZSB0aGUgI2lmZGVmLCBhcyBs
b25nDQo+IGFzIHRoZSBmdW5jdGlvbiBpdHNlbGYgY2FuIGJlIGJ1aWx0IHRoYXQgd2F5Lg0KPiAN
Cj4gICAgICAgQXJuZA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIEknbGwgcmVtb3ZlIHRo
aXMgZW1wdHkgZnVuY3Rpb24uDQo=
