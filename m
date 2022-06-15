Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D254C040
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbiFODkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFODkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:40:02 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 262674D9D3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:39:42 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(28649:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 15 Jun 2022 11:31:54 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 15 Jun 2022 11:31:50 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Wed, 15 Jun 2022 11:31:50 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v18 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board
 device tree
Thread-Topic: [PATCH v18 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board
 device tree
Thread-Index: AQHYf8r27MMUrQucmUWH+5A1oaj77q1OMQ+AgAGftCA=
Date:   Wed, 15 Jun 2022 03:31:50 +0000
Message-ID: <f19b479d70704784ae5fb00ca610fda3@cqplus1.com>
References: <cover.1655194858.git.qinjian@cqplus1.com>
 <0574ed0ad1e9ec4c12645fe2d2dde8f701d285e5.1655194858.git.qinjian@cqplus1.com>
 <CAK8P3a0XgDS-iJEfOrTjTRGODosxj0gc748PAH_hc534DkyswQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0XgDS-iJEfOrTjTRGODosxj0gc748PAH_hc534DkyswQ@mail.gmail.com>
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

PiANCj4gSSdsbCB3YWl0IGZvciBhIGZpbmFsIEFjayBmcm9tIEtyenlzenRvZiBiZWZvcmUgYXBw
bHlpbmcgdGhpcy4NCj4gDQo+IA0KPiBBIGZldyBtb3JlIGRldGFpbHMgSSBub3RpY2VkOg0KPiAN
Cj4gDQo+ID4gKy8gew0KPiA+ICsgICAgICAgY29tcGF0aWJsZSA9ICJzdW5wbHVzLHNwNzAyMSI7
DQo+ID4gKyAgICAgICBtb2RlbCA9ICJTdW5wbHVzIFNQNzAyMSI7DQo+ID4gKw0KPiA+ICsgICAg
ICAgYWxpYXNlcyB7DQo+ID4gKyAgICAgICAgICAgICAgIHNlcmlhbDAgPSAmdWFydDA7DQo+ID4g
KyAgICAgICAgICAgICAgIHNlcmlhbDEgPSAmdWFydDE7DQo+ID4gKyAgICAgICAgICAgICAgIHNl
cmlhbDIgPSAmdWFydDI7DQo+ID4gKyAgICAgICAgICAgICAgIHNlcmlhbDMgPSAmdWFydDM7DQo+
ID4gKyAgICAgICAgICAgICAgIHNlcmlhbDQgPSAmdWFydDQ7DQo+ID4gKyAgICAgICB9Ow0KPiAN
Cj4gU29tZSBvZiB0aGVzZSBhcmUgZGlzYWJsZWQsIHByZXN1bWFibHkgYmVjYXVzZSB0aGV5IGFy
ZSBub3QNCj4gYWN0dWFsbHkgY29ubmVjdGVkIG9uIGFsbCBib2FyZHMuIEJldHRlciBtb3ZlIHRo
ZSBhbGlhc2VzIHRvIHRoZSAuZHRzIGZpbGUNCj4gYW5kIG9ubHkgbGlzdCB0aGUgcG9ydHMgdGhh
dCBhcmUgaW4gZmFjdCB1c2VkLCB1c2luZyB0aGUgbnVtYmVyaW5nIHRoYXQNCj4gbWF0Y2hlcyB0
aGUgbGFiZWxzIG9uIHRoZSBib2FyZCwgbm90IHRoZSBudW1iZXJzIGluc2lkZSBvZiB0aGUgU29D
DQo+IA0KPiA+ICsNCj4gPiArICAgICAgIHNvYyB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+ID4gKyAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArICAg
ICAgICAgICAgICAgcmFuZ2VzOw0KPiA+ICsgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50
ID0gPCZpbnRjPjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGludGM6IGludGVycnVwdC1j
b250cm9sbGVyQDljMDAwNzgwIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gInN1bnBsdXMsc3A3MDIxLWludGMiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJlZyA9IDwweDljMDAwNzgwIDB4ODA+LCA8MHg5YzAwMGE4MCAweDgwPjsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAgICAgICAgICB9
Ow0KPiANCj4gQWxsIGNoaWxkIG5vZGVzIGJlbG93IC9zb2MgaGF2ZSByZWdpc3RlcnMgaW4gdGhl
IDB4OWMwMDAwMDAgcmFuZ2UuIEkgd291bGQNCj4gc3VnZ2VzdCB5b3UgdXNlIGEgbWF0Y2hpbmcg
J3JhbmdlcycgcHJvcGVydHkgdG8gdHJhbnNsYXRlIHRoZXNlIGludG8gYQ0KPiB6ZXJvLWJhc2Vk
DQo+IGFkZHJlc3MgbGlrZQ0KPiANCj4gL3NvYyB7DQo+ICAgICAgICByYW5nZXMgPSA8MCAweDlj
MDAwMDAwIDB4MTAwMDA+Ow0KPiANCj4gICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXJANzgwIHsN
Cj4gICAgICAgICAgICAgIHJlZyA9IDwweDc4MCAweDgwPiwgPDB4YTgwIDB4ODA+Ow0KPiAgICAg
ICAgICAgICAgLi4uDQo+ICAgICAgIH07DQo+IH07DQo+IA0KPiA+ICsgICAgICAgICAgICAgICBj
bGtjOiBjbG9jay1jb250cm9sbGVyQDljMDAwMDA0IHsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gInN1bnBsdXMsc3A3MDIxLWNsa2MiOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHJlZyA9IDwweDljMDAwMDA0IDB4Mjg+LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDwweDljMDAwMjAwIDB4NDQ+LA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDwweDljMDAwMjY4IDB4MDQ+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGNsb2NrcyA9IDwmZXh0Y2xrPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAjY2xv
Y2stY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgICAgICByc3RjOiByZXNldEA5YzAwMDA1NCB7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJzdW5wbHVzLHNwNzAyMS1yZXNldCI7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmVnID0gPDB4OWMwMDAwNTQgMHgyOD47DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICB9Ow0K
PiANCj4gDQo+IE1heWJlIHNvcnQgdGhlIG5vZGVzIGJ5IGFkZHJlc3MsIG9yIHBvc3NpYmx5IGJ5
IG5hbWUuDQo+IA0KPiAgICAgICAgQXJuZA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIEkn
bGwgZml4IHRoZXNlIGluIG5leHQgcGF0Y2guDQoNCg==
