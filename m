Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3A51D37C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389535AbiEFIkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbiEFIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:40:14 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C2CB24BCA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:36:10 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24042:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 06 May 2022 16:34:24 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Fri, 6 May 2022 16:34:17 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Fri, 6 May 2022 16:34:17 +0800
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
Subject: RE: [PATCH v14 0/9] Add Sunplus SP7021 SoC Support
Thread-Topic: [PATCH v14 0/9] Add Sunplus SP7021 SoC Support
Thread-Index: AQHYYPmpoyLFCwENCkOMTsBsGD1pya0Q7muAgACVJHA=
Date:   Fri, 6 May 2022 08:34:17 +0000
Message-ID: <23e22e4e8b9e4d7ab02caaa1c3f7b599@cqplus1.com>
References: <cover.1651805790.git.qinjian@cqplus1.com>
 <CAK8P3a0W4wpVwDmCXDkm_u9W=JozrnCnxW7zK3h2XD8f_ODy6w@mail.gmail.com>
In-Reply-To: <CAK8P3a0W4wpVwDmCXDkm_u9W=JozrnCnxW7zK3h2XD8f_ODy6w@mail.gmail.com>
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

PiANCj4gT24gRnJpLCBNYXkgNiwgMjAyMiBhdCA1OjIzIEFNIFFpbiBKaWFuIDxxaW5qaWFuQGNx
cGx1czEuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZCBTdW5wbHVz
IFNQNzAyMSBTb0Mgc3VwcG9ydC4NCj4gPg0KPiA+IFN1bnBsdXMgU1A3MDIxIGlzIGFuIEFSTSBD
b3J0ZXggQTcgKDQgY29yZXMpIGJhc2VkIFNvQy4gSXQgaW50ZWdyYXRlcyBtYW55DQo+ID4gcGVy
aXBoZXJhbHMgKGV4OiBVQVJULCBJMkMsIFNQSSwgU0RJTywgZU1NQywgVVNCLCBTRCBjYXJkIGFu
ZCBldGMuKSBpbnRvIGENCj4gPiBzaW5nbGUgY2hpcC4gSXQgaXMgZGVzaWduZWQgZm9yIGluZHVz
dHJpYWwgY29udHJvbC4NCj4gPg0KPiA+IFNQNzAyMSBjb25zaXN0cyBvZiB0d28gY2hpcHMgKGRp
ZXMpIGluIGEgcGFja2FnZS4gT25lIGlzIGNhbGxlZCBDLWNoaXANCj4gPiAoY29tcHV0aW5nIGNo
aXApLiBJdCBpcyBhIDQtY29yZSBBUk0gQ29ydGV4IEE3IENQVS4gSXQgYWRvcHRzIGhpZ2gtbGV2
ZWwNCj4gPiBwcm9jZXNzICgyMiBubSkgZm9yIGhpZ2ggcGVyZm9ybWFuY2UgY29tcHV0aW5nLiBU
aGUgb3RoZXIgaXMgY2FsbGVkIFAtDQo+ID4gY2hpcCAocGVyaXBoZXJhbCBjaGlwKS4gSXQgaGFz
IG1hbnkgcGVyaXBoZXJhbHMgYW5kIGFuIEFSTSBBOTI2IGFkZGVkDQo+ID4gZXNwZWNpYWxseSBm
b3IgcmVhbC10aW1lIGNvbnRyb2wuIFAtY2hpcCBpcyBtYWRlIGZvciBjdXN0b21lcnMuIEl0IGFk
b3B0cw0KPiA+IGxvdy1sZXZlbCBwcm9jZXNzIChleDogMC4xMSB1bSkgdG8gcmVkdWNlIGNvc3Qu
DQo+IA0KPiBKdXN0IGFuIHVwZGF0ZSBmcm9tIG15IHNpZGUgYWJvdXQgbWVyZ2luZyB0aGUgcGxh
dGZvcm0gY29kZTogdGhlDQo+IHN1Ym1pc3Npb24gbG9va3MgbW9zdGx5IHNlbnNpYmxlIHRvIG1l
LCBidXQgYXMgbG9uZyBhcyB0aGUgY2xrIGFuZCBpcnFjaGlwDQo+IGRyaXZlcnMgaGF2ZSBub3Qg
ZmluaXNoZWQgdGhlIHJldmlldywgSSBjYW5ub3QgdGFrZSB0aGlzIHRocm91Z2ggdGhlIHNvYw0K
PiB0cmVlLiBXZSBjb3VsZCBjb25zaWRlciBtZXJnaW5nIHRoZSBwbGF0Zm9ybSBjb2RlIHdpdGhv
dXQgdGhvc2UgdHdvDQo+IGRyaXZlcnMsIGJ1dCB0aGF0IHNlZW1zIHBvaW50bGVzcyBiZWNhdXNl
IGl0IHdpbGwgbm90IGJvb3QuDQo+IA0KDQpUaGUgcmV2aWV3ZXJzIG5vIHJlcGx5LCBJIGRvbuKA
mXQga25vdyB3aHkuDQoNCj4gV2hhdCBpcyB0aGUgcmVhc29uIHlvdSBkb24ndCBpbmNsdWRlIGEg
LmR0c2kgZmlsZSBpbiB0aGlzIHNlcmllcz8gVXN1YWxseQ0KPiB0aGVyZSBzaG91bGQgYmUgYXQg
bGVhc3Qgb25lIGJvYXJkIGFuZCB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIFNvQyBpdHNlbGYuDQo+
IEFnYWluLCB3aXRob3V0IHRob3NlIEknbSBub3Qgc3VyZSBpdCdzIHdvcnRoIG1lcmdpbmcuDQo+
IA0KDQpTb3JyeSwgSSdsbCBhZGQgdGhlIGR0cyBmaWxlIGluIG5leHQgcGF0Y2guDQoNCj4gRm9y
IHRoZSB0aW1pbmcsIHdlIGFyZSBnZXR0aW5nIGNsb3NlIHRvIHRoZSA1LjE5IG1lcmdlIHdpbmRv
dyB0aGF0DQo+IHN0YXJ0cyBvbmNlIHY1LjE4IGlzIG91dCwgYW5kIEkgZG9uJ3QgZXhwZWN0IHRo
YXQgYWxsIHRoZSBhYm92ZSB3aWxsDQo+IGJlIHJlc29sdmVkIGluIHRpbWUsIHNvIGl0IGxvb2tz
IHdlIHdpbGwgaGF2ZSB0byBkZWZlciBpdCBieSBvbmUgbW9yZQ0KPiByZWxlYXNlIHRvIDUuMjAu
DQo+IA0KPiAgICAgICAgICAgQXJuZA0K
