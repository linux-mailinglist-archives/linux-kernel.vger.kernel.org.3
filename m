Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28B9525C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377924AbiEMHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377910AbiEMHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:51:04 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A77136401
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:50:41 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7682:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 13 May 2022 15:44:27 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Fri, 13 May 2022 15:44:24 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Fri, 13 May 2022 15:44:24 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v15 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board
 device tree
Thread-Topic: [PATCH v15 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board
 device tree
Thread-Index: AQHYZcsUOdNmnhD0gkKqn75ry15Nq60ahDUAgAHng+A=
Date:   Fri, 13 May 2022 07:44:24 +0000
Message-ID: <3a01fe9aa860407694ee77133459a9ab@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <daeccdfb9655e549656af0af955a4697871e3ab0.1652329411.git.qinjian@cqplus1.com>
 <32c80a79-abd5-3fd2-cbb4-e2ae93c539da@linaro.org>
In-Reply-To: <32c80a79-abd5-3fd2-cbb4-e2ae93c539da@linaro.org>
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

PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdW5wbHVzLXNwNzAyMS1hY2hpcC5k
dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3VucGx1cy1zcDcwMjEtYWNoaXAuZHRzaQ0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwLi4xNTYwYzk1ZDkNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3VucGx1cy1zcDcwMjEt
YWNoaXAuZHRzaQ0KPiA+IEBAIC0wLDAgKzEsODUgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogRGV2aWNlIFRyZWUgU291cmNlIGZv
ciBTdW5wbHVzIFNQNzAyMQ0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjEgU3Vu
cGx1cyBUZWNobm9sb2d5IENvLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlICJzdW5w
bHVzLXNwNzAyMS5kdHNpIg0KPiA+ICsNCj4gPiArLyB7DQo+ID4gKwljb21wYXRpYmxlID0gInN1
bnBsdXMsc3A3MDIxLWFjaGlwIjsNCj4gDQo+IFRoaXMgZG9lcyBub3QgbWF0Y2ggeW91ciBiaW5k
aW5ncy4NCj4gDQoNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9zdW5wbHVzLXNwNzAyMS1k
ZW1vLXYzLmR0cw0KPiA+IEBAIC0wLDAgKzEsMjcgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogRGV2aWNlIFRyZWUgU291cmNlIGZv
ciBTdW5wbHVzIFNQNzAyMSBEZW1vIFYzIFNCQyBib2FyZA0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5
cmlnaHQgKEMpIFN1bnBsdXMgVGVjaG5vbG9neSBDby4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsv
ZHRzLXYxLzsNCj4gPiArDQo+ID4gKyNpbmNsdWRlICJzdW5wbHVzLXNwNzAyMS1hY2hpcC5kdHNp
Ig0KPiA+ICsNCj4gPiArLyB7DQo+ID4gKwljb21wYXRpYmxlID0gInN1bnBsdXMsc3A3MDIxLWRl
bW8tdjMiOw0KPiANCj4gVGhpcyBkb2VzIG5vdCBtYXRjaCB5b3VyIGJpbmRpbmdzLg0KPiANCj4g
UGxlYXNlIHJ1biBtYWtlIGR0YnNfY2hlY2suDQoNCkkgZGlkIHBhc3NlZCB0aGUgbWFrZSBkdGJz
X2NoZWNrLg0KY29tcGF0aWJsZSBzdHJpbmc6ICJzdW5wbHVzLHNwNzAyMSIsICJzdW5wbHVzLHNw
NzAyMS1hY2hpcCIsICJzdW5wbHVzLHNwNzAyMS1kZW1vLXYzIg0KYWxsIGRlZmluZWQgQCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3N1bnBsdXMsc3A3MDIxLnlhbWwgWzFd
DQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzYxMDdhNjgwMDhmMmQ3MWQyYzc4
NjhkNGQ5NGNiNjZjNWI1ZmMxMzQuMTY1MjMyOTQxMS5naXQucWluamlhbkBjcXBsdXMxLmNvbS8N
CiANCg0K
