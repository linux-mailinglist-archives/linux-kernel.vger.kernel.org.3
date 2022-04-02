Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A574EFE02
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 04:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiDBCqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 22:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiDBCqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 22:46:34 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE8C3EB85
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 19:44:19 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1159:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Sat, 02 Apr 2022 10:42:24 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Sat, 2 Apr 2022 10:43:23 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Sat, 2 Apr 2022 10:43:22 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Rob Herring <robh@kernel.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH v12 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Thread-Topic: [PATCH v12 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Thread-Index: AQHYRNqIBkj2YEKP8ka+VOn6WZsX66zZcIoAgADkMACAAH4sAIABGb5A
Date:   Sat, 2 Apr 2022 02:43:22 +0000
Message-ID: <2b5ed89d562543ac84351d8c1aee1635@cqplus1.com>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <ff5bfd5611ab0defe0c98f98edbbf655e33cd16d.1648714851.git.qinjian@cqplus1.com>
 <YkYSyHVGsXkGs0uf@robh.at.kernel.org>
 <3373b11528214394baae71198df3adff@cqplus1.com>
 <Ykc8Cv/TbYlr9GxV@robh.at.kernel.org>
In-Reply-To: <Ykc8Cv/TbYlr9GxV@robh.at.kernel.org>
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

PiANCj4gT24gRnJpLCBBcHIgMDEsIDIwMjIgYXQgMDI6Mjk6NThBTSArMDAwMCwgcWluamlhblvo
poPlgaVdIHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFRodSwgMzEgTWFyIDIwMjIgMTY6Mjk6NTMg
KzA4MDAsIFFpbiBKaWFuIHdyb3RlOg0KPiA+ID4gPiBBZGQgZG9jdW1lbnRhdGlvbiB0byBkZXNj
cmliZSBTdW5wbHVzIFNQNzAyMSBpbnRlcnJ1cHQgY29udHJvbGxlciBiaW5kaW5ncy4NCj4gPiA+
ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUWluIEppYW4gPHFpbmppYW5AY3FwbHVzMS5jb20+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBNb3ZlICdyZWcnIGFmdGVyICdjb21wYXRpYmxlJw0KPiA+
ID4gPiAtLS0NCj4gPiA+ID4gIC4uLi9zdW5wbHVzLHNwNzAyMS1pbnRjLnlhbWwgICAgICAgICAg
ICAgICAgICB8IDYyICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4gPiA+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9zdW5w
bHVzLHNwNzAyMS1pbnRjLnlhbWwNCj4gPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gUGxlYXNl
IGFkZCBBY2tlZC1ieS9SZXZpZXdlZC1ieSB0YWdzIHdoZW4gcG9zdGluZyBuZXcgdmVyc2lvbnMu
IEhvd2V2ZXIsDQo+ID4gPiB0aGVyZSdzIG5vIG5lZWQgdG8gcmVwb3N0IHBhdGNoZXMgKm9ubHkq
IHRvIGFkZCB0aGUgdGFncy4gVGhlIHVwc3RyZWFtDQo+ID4gPiBtYWludGFpbmVyIHdpbGwgZG8g
dGhhdCBmb3IgYWNrcyByZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiA+ID4N
Cj4gPiA+IElmIGEgdGFnIHdhcyBub3QgYWRkZWQgb24gcHVycG9zZSwgcGxlYXNlIHN0YXRlIHdo
eSBhbmQgd2hhdCBjaGFuZ2VkLg0KPiA+DQo+ID4gQ2hhbmdlczogTW92ZSAncmVnJyBhZnRlciAn
Y29tcGF0aWJsZScNCj4gPiBJIGRpZCBhIG1vZGlmaWNhdGlvbiBiYXNlZCBvbiBjb21tZW50cyBm
cm9tIGtyenlzenRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNvbSBbMV0NCj4gPg0KPiA+IFsxXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNmRiZWRhMTgtYTExYy02MDlkLTdhOGYtYmYyZTZm
MjdhZWE3QGtlcm5lbC5vcmcvDQo+IA0KPiBBIHRyaXZpYWwgY2hhbmdlIGxpa2UgdGhhdCBjYW4g
a2VlcCBhIHRhZyBlc3BlY2lhbGx5IGlmIGl0IGNhbWUgYWZ0ZXINCj4gdGhlIGNvbW1lbnQgKG5v
dCBzdXJlIGhlcmUpLg0KPiANCj4gUm9iDQoNCkknbGwgYWRkIGJhY2sgdGhlIHRhZyBuZXh0IHZl
cnNpb24sIHRoYW5rcy4NCg==
