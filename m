Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B54EFE44
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 05:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbiDBDrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 23:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiDBDrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:47:17 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB99B118609
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 20:45:03 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1163:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Sat, 02 Apr 2022 11:36:23 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Sat, 2 Apr 2022 11:37:22 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Sat, 2 Apr 2022 11:37:22 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Subject: RE: [PATCH v12 5/9] clk: Add Sunplus SP7021 clock driver
Thread-Topic: [PATCH v12 5/9] clk: Add Sunplus SP7021 clock driver
Thread-Index: AQHYRNqOjCd6CVvOR0G759g8P20c0KzYsc4AgAIYlbD//4b8AIABqeEg
Date:   Sat, 2 Apr 2022 03:37:22 +0000
Message-ID: <1af581687f424316b8759c65997694db@cqplus1.com>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <fe4f4c3b0c768d1cd66fb648d74fa302e86787c0.1648714851.git.qinjian@cqplus1.com>
 <CAK8P3a0OGM4aiaE2Nfc=7XGkGwAbnB99-j3PhVUmuA1z2FWeKg@mail.gmail.com>
 <2fa0ce6048f6449d883e2454ceea9540@cqplus1.com>
 <CAK8P3a002iHquY4J59omBwxyZjCFFiymqbWKu9GXs-7RVy292g@mail.gmail.com>
In-Reply-To: <CAK8P3a002iHquY4J59omBwxyZjCFFiymqbWKu9GXs-7RVy292g@mail.gmail.com>
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

PiANCj4gPiA+ID4gKyAgICAgICAvKiBUaGlzIG1lbW9yeSByZWdpb24gaW5jbHVkZSBtdWx0aSBI
VyByZWdzIGluIGRpc2NvbnRpbnVvdXMgb3JkZXIuDQo+ID4gPiA+ICsgICAgICAgICogY2xrIGRy
aXZlciB1c2VkIHNvbWUgZGlzY29udGludW91cyBhcmVhcyBpbiB0aGUgbWVtb3J5IHJlZ2lvbi4N
Cj4gPiA+ID4gKyAgICAgICAgKiBVc2luZyBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2Uo
KSB3b3VsZCBjb25mbGljdGVkIHdpdGggb3RoZXIgZHJpdmVycy4NCj4gPiA+ID4gKyAgICAgICAg
Ki8NCj4gPiA+ID4gKyAgICAgICByZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9S
RVNPVVJDRV9NRU0sIDApOw0KPiA+ID4gPiArICAgICAgIHNwX2Nsa19iYXNlID0gZGV2bV9pb3Jl
bWFwKGRldiwgcmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsNCj4gPiA+ID4gKyAgICAg
ICBpZiAoIXNwX2Nsa19iYXNlKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTlhJ
TzsNCj4gPiA+DQo+ID4gPiBDYW4geW91IGV4cGxhaW4gdGhpcyBjb21tZW50IGluIG1vcmUgZGV0
YWlsPyBHZW5lcmFsbHksIHRoZSAncmVnJyBwcm9wZXJ0aWVzDQo+ID4gPiBvZiBkcml2ZXJzIHNo
b3VsZCBub3Qgb3ZlcmxhcCwgc28gaXQgaXMgc3VwcG9zZWQgdG8gYmUgc2FmZSB0byBjYWxsDQo+
ID4gPiBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKSBoZXJlLg0KPiA+ID4NCj4gPiA+
IFdlIGRpc2N1c3NlZCB0aGlzIGluIHRoZSBjb250ZXh0IG9mIHRoZSBpb3AgZHJpdmVyIHRoYXQg
ZGlkIGhhdmUgb3ZlcmxhcHBpbmcNCj4gPiA+IHJlZ2lzdGVycyB3aXRoIHRoaXMgZHJpdmVyLCBh
bmQgdGhhdCB3YXMgaW5jb3JyZWN0LiBBcmUgdGhlcmUgYW55IG90aGVyIGRyaXZlcnMNCj4gPiA+
IHRoYXQgY29uZmxpY3Qgd2l0aCB0aGUgY2xrIGRyaXZlcj8NCj4gPg0KPiA+IEkgbWVhbnMsIEkg
bXVzdCBzcGxpdCB1cCB0aGUgb3JpZ2luIHJlZyByZWdpb24gaW50byA0IHNtYWxsIHBpZWNlcywN
Cj4gPiBhbmQgY2FsbCBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKSA0IHRpbWVzLg0K
PiA+IERpZCBJIHNob3VsZCBmb2xsb3cgdGhpcyB3YXk/DQo+IA0KPiBJdCBkZXBlbmRzLiBXaGF0
IGFyZSB0aG9zZSBvdGhlciByZWdpc3RlcnMsIGFuZCB3aGF0IGRyaXZlcnMgdXNlIHRoZW0/DQo+
IA0KPiAgICAgICAgIEFybmQNCg0KSW5jbHVkZSBSZXNldCAvIFBpbk11eCAvIFVTQkMgLyBVUEhZ
IHJlZ3MsIHdoaWNoIHVzZWQgYnkgcmVsYXRlZCBkcml2ZXJzLg0K
