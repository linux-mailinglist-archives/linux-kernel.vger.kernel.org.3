Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C026A54C046
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbiFODqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiFODqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:46:44 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EA354F9E2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:46:34 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(28626:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 15 Jun 2022 11:43:27 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 15 Jun 2022 11:43:22 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Wed, 15 Jun 2022 11:43:22 +0800
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
Subject: RE: [PATCH v18 05/10] clk: Add Sunplus SP7021 clock driver
Thread-Topic: [PATCH v18 05/10] clk: Add Sunplus SP7021 clock driver
Thread-Index: AQHYf8r5uo30wfgQ7kKLEgfDFgKMD61OMbmAgAGfqOA=
Date:   Wed, 15 Jun 2022 03:43:22 +0000
Message-ID: <7846c32b2c134fca9ad723c026e345f5@cqplus1.com>
References: <cover.1655194858.git.qinjian@cqplus1.com>
 <42ed93cf0e5cfeaffdf50d63da558a3f1f6c1021.1655194858.git.qinjian@cqplus1.com>
 <CAK8P3a0p3M2Z7aaB3tGJSud3Tr+E7BtwQka6j5HS3VooV7L8XQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0p3M2Z7aaB3tGJSud3Tr+E7BtwQka6j5HS3VooV7L8XQ@mail.gmail.com>
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

PiANCj4gT24gVHVlLCBKdW4gMTQsIDIwMjIgYXQgMTA6MzEgQU0gUWluIEppYW4gPHFpbmppYW5A
Y3FwbHVzMS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIGNsb2NrIGRyaXZlciBmb3IgU3VucGx1
cyBTUDcwMjEgU29DLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUWluIEppYW4gPHFpbmppYW5A
Y3FwbHVzMS5jb20+DQo+ID4gLS0tDQo+ID4gRml4IHRoZSBjb21tZW50cyBmcm9tIFN0ZXBoZW4g
Qm95ZC4NCj4gDQo+IERvIHlvdSBtZWFuIHlvdSBzdGlsbCBuZWVkIHRvIGFkZHJlc3MgdGhlIGNv
bW1lbnRzIGZyb20gU3RlcGhlbiwgb3INCj4gdGhhdCB5b3UgaGF2ZQ0KPiBkb25lIHRoaXMgYWxy
ZWFkeT8NCj4gDQo+IEkgY2FuJ3QgYXBwbHkgdGhlIHNlcmllcyBpZiB0aGVyZSBhcmUgcGF0Y2hl
cyBpbiBpdCB0aGF0IHN0aWxsIG5lZWQgdG8NCj4gYmUgZml4ZWQgb3INCj4gZmluaXNoIHJldmll
dywgc28gSSBob3BlIHRoaXMgaXMgb25seSB3YWl0aW5nIGZvciBhIGZpbmFsIEFjay4NCj4gDQo+
ICAgICAgICAgQXJuZA0KDQpZZXMsIEkgZml4ZWQgY29tbWVudHMgZnJvbSBTdGVwaGVuJ3MgbGFz
dCByZXZpZXcuDQpBbmQgSSBnb3Qgc29tZSBuZXcgY29tbWVudHMgZnJvbSBoaW0sIHdoaWNoIGlz
IG5vdCBsaXN0ZWQgQCBsa21sIHN0cmFuZ2VseS4NClNlZSBteSByZXBseSBbMV0NCg0KWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvYWFmOTY0OTFmMWE5NGI1Njk0MDAzNzk3ODUzYWE3
MzJAY3FwbHVzMS5jb20vVC8jbTVmMjg2ZmM3NzQ3Mjc5NGU1YWZhY2E1ZDFhODI1MjUxMzY5NWU2
YmINCg0KDQo=
