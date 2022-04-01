Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7034EE9C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbiDAIat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDAIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:30:46 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81634EA5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 01:28:35 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1188:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 01 Apr 2022 16:23:46 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 1 Apr 2022 16:24:45 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Fri, 1 Apr 2022 16:24:45 +0800
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
Subject: RE: [PATCH v12 2/9] dt-bindings: reset: Add bindings for SP7021 reset
 driver
Thread-Topic: [PATCH v12 2/9] dt-bindings: reset: Add bindings for SP7021
 reset driver
Thread-Index: AQHYRNqIUjsRZ57Im0G1ASM2miSM7KzYqzEAgAIN1IA=
Date:   Fri, 1 Apr 2022 08:24:45 +0000
Message-ID: <7a344146331847ce88d26716fc3b6380@cqplus1.com>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <6abf8de01fa2f24e13e9b78b3dc3b206ea551c9c.1648714851.git.qinjian@cqplus1.com>
 <CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com>
In-Reply-To: <CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com>
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
Y3FwbHVzMS5jb20+IHdyb3RlOg0KPiANCj4gPiArLyogbW9fcmVzZXQwIH4gbW9fcmVzZXQ5ICov
DQo+ID4gKyNkZWZpbmUgUlNUX1NZU1RFTSAgICAgICAgICAgICAweDAwDQo+ID4gKyNkZWZpbmUg
UlNUX1JUQyAgICAgICAgICAgICAgICAgICAgICAgIDB4MDINCj4gPiArI2RlZmluZSBSU1RfSU9D
VEwgICAgICAgICAgICAgIDB4MDMNCj4gPiArI2RlZmluZSBSU1RfSU9QICAgICAgICAgICAgICAg
ICAgICAgICAgMHgwNA0KPiA+ICsjZGVmaW5lIFJTVF9PVFBSWCAgICAgICAgICAgICAgMHgwNQ0K
PiA+ICsjZGVmaW5lIFJTVF9OT0MgICAgICAgICAgICAgICAgICAgICAgICAweDA2DQo+ID4gKyNk
ZWZpbmUgUlNUX0JSICAgICAgICAgICAgICAgICAweDA3DQo+ID4gKyNkZWZpbmUgUlNUX1JCVVNf
TDAwICAgICAgICAgICAweDA4DQo+ID4gKyNkZWZpbmUgUlNUX1NQSUZMICAgICAgICAgICAgICAw
eDA5DQo+ID4gKyNkZWZpbmUgUlNUX1NEQ1RSTDAgICAgICAgICAgICAweDBhDQo+ID4gKyNkZWZp
bmUgUlNUX1BFUkkwICAgICAgICAgICAgICAweDBiDQo+ID4gKyNkZWZpbmUgUlNUX0E5MjYgICAg
ICAgICAgICAgICAweDBkDQo+ID4gKyNkZWZpbmUgUlNUX1VNQ1RMMiAgICAgICAgICAgICAweDBl
DQo+ID4gKyNkZWZpbmUgUlNUX1BFUkkxICAgICAgICAgICAgICAweDBmDQo+ID4gKw0KPiA+ICsj
ZGVmaW5lIFJTVF9ERFJfUEhZMCAgICAgICAgICAgMHgxMA0KPiA+ICsjZGVmaW5lIFJTVF9BQ0hJ
UCAgICAgICAgICAgICAgMHgxMg0KPiA+ICsjZGVmaW5lIFJTVF9TVEMwICAgICAgICAgICAgICAg
MHgxNA0KPiA+ICsjZGVmaW5lIFJTVF9TVENfQVYwICAgICAgICAgICAgMHgxNQ0KPiA+ICsjZGVm
aW5lIFJTVF9TVENfQVYxICAgICAgICAgICAgMHgxNg0KPiA+ICsjZGVmaW5lIFJTVF9TVENfQVYy
ICAgICAgICAgICAgMHgxNw0KPiANCj4gVGhlIGxpc3QgbG9va3MgbGlrZSB0aGVzZSBkZWZpbml0
aW9ucyBqdXN0IG1hdGNoIHRoZSBoYXJkd2FyZSwgd2hpY2ggbWVhbnMgeW91DQo+IGRvbid0IGhh
dmUgdG8gZGVmaW5lIHRoZW0gYXMgYSBiaW5kaW5nIGF0IGFsbCwganVzdCB1c2UgdGhlIGhhcmR3
YXJlIG51bWJlcnMNCj4gZGlyZWN0bHkgaW4gdGhlIGR0LCBhcyB5b3UgZG8gZm9yIGludGVycnVw
dHMgb3IgZ3BpbyBudW1iZXJzLg0KPiANCj4gSWYgdGhlIGhhcmR3YXJlIGRvZXMgbm90IGhhdmUg
YSBzYW5lIHdheSBvZiBtYXBwaW5nIHJlc2V0IGxpbmVzIHRvIGEgcGFydGljdWxhcg0KPiBoYXJk
d2FyZSBudW1iZXIsIHRoZW4geW91IG1heSBoYXZlIHRvIGRlZmluZSBhIGJpbmRpbmcsIGJ1dCBp
biB0aGF0IGNhc2UganVzdA0KPiB1c2UgY29uc2VjdXRpdmUgaW50ZWdlciBudW1iZXJzLCBub3Qg
aGV4YWRlY2ltYWwgbnVtYmVycy4NCj4gDQo+ICAgICAgICBBcm5kDQoNCllvdSBhcmUgcmlnaHQs
IHRoZXNlIGRlZmluaXRpb25zIGRvZXMgbWF0Y2ggdGhlIGhhcmR3YXJlLCBJbiByZXNldC1zdW5w
bHVzLmM6DQpzdGF0aWMgaW50IHNwX3Jlc2V0X3N0YXR1cyhzdHJ1Y3QgcmVzZXRfY29udHJvbGxl
cl9kZXYgKnJjZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBp
ZCkNCnsNCiAgICAgICAgc3RydWN0IHNwX3Jlc2V0ICpyZXNldCA9IHRvX3NwX3Jlc2V0KHJjZGV2
KTsNCiAgICAgICAgaW50IGluZGV4ID0gaWQgLyBCSVRTX1BFUl9IV01fUkVHOw0KICAgICAgICBp
bnQgc2hpZnQgPSBpZCAlIEJJVFNfUEVSX0hXTV9SRUc7DQogICAgICAgIHUzMiByZWc7DQoNCiAg
ICAgICAgcmVnID0gcmVhZGwocmVzZXQtPmJhc2UgKyAoaW5kZXggKiA0KSk7DQoNCiAgICAgICAg
cmV0dXJuICEhKHJlZyAmIEJJVChzaGlmdCkpOw0KfQ0KdGhlICdpZCcgIGlzIHRoZXNlIHZhbHVl
IHBhc3NlZCBmcm9tIGR0Lg0KDQpJJ2xsIHJlbW92ZSB0aGlzIGZpbGUgJiB1cGRhdGUgZHQsIHRo
YW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0K
