Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FF7525F48
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379163AbiEMJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347873AbiEMJzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:55:21 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9F0515FE06
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:54:55 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7678:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 13 May 2022 17:47:40 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Fri, 13 May 2022 17:47:38 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Fri, 13 May 2022 17:47:38 +0800
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
Thread-Index: AQHYZcsUOdNmnhD0gkKqn75ry15Nq60ahDUAgAHng+D//4R3gIAAnWgA
Date:   Fri, 13 May 2022 09:47:38 +0000
Message-ID: <878e3edf42434620b31cf7f8bf97209f@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <daeccdfb9655e549656af0af955a4697871e3ab0.1652329411.git.qinjian@cqplus1.com>
 <32c80a79-abd5-3fd2-cbb4-e2ae93c539da@linaro.org>
 <3a01fe9aa860407694ee77133459a9ab@cqplus1.com>
 <85c40d22-afaa-0f7b-01bd-6de9e592079f@linaro.org>
In-Reply-To: <85c40d22-afaa-0f7b-01bd-6de9e592079f@linaro.org>
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

PiA+DQo+ID4gSSBkaWQgcGFzc2VkIHRoZSBtYWtlIGR0YnNfY2hlY2suDQo+ID4gY29tcGF0aWJs
ZSBzdHJpbmc6ICJzdW5wbHVzLHNwNzAyMSIsICJzdW5wbHVzLHNwNzAyMS1hY2hpcCIsICJzdW5w
bHVzLHNwNzAyMS1kZW1vLXYzIg0KPiA+IGFsbCBkZWZpbmVkIEAgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9zdW5wbHVzLHNwNzAyMS55YW1sIFsxXQ0KPiANCj4gSG93IHRo
aXMgY2FuIHBhc3MgdGhlIGNoZWNrIGlmIGl0IGlzIGVudGlyZWx5IGRpZmZlcmVudCBjb21wYXRp
YmxlIGFuZA0KPiBkb2VzIG5vdCBtYXRjaCBzY2hlbWE/IFRoZSBjb2RlIGlzIG5vdCBjb3JyZWN0
LiBJZiB5b3UgdGVzdCB5b3VyIERUUw0KPiB3aXRoIGR0YnNfY2hlY2sgeW91IHdpbGwgc2VlOg0K
PiANCj4gCXN1bnBsdXMtc3A3MDIxLWRlbW8tdjMuZHRiOiAvOiBjb21wYXRpYmxlOiBbJ3N1bnBs
dXMsc3A3MDIxLWRlbW8tdjMnXQ0KPiBpcyB0b28gc2hvcnQNCj4gDQo+IA0KPiBBZGRpdGlvbmFs
bHk6DQo+IDEuIFlvdXIgRFRCcyBkbyBub3QgY29tcGlsZSwgbWlzc2luZyBNYWtlZmlsZSBlbnRy
eS4NCj4gDQoNCkdvdCBpdCwgSSBjb21waWxlZCB0aGUgZHRiIHdpdGggY29tbWFuZDogbWFrZSBz
dW5wbHVzLXNwNzAyMS1kZW1vLXYzLmR0Yg0KQWZ0ZXIgSSBhZGQgaXQgdG8gYXJjaC9hcm0vYm9v
dC9kdHMvTWFrZWZpbGUsDQptYWtlIGR0YnNfY2hlY2sgZ290IHRoZSBlcnJvci4NClRoYW5rcyBm
b3IgeW91ciBwYXRpZW50IGd1aWRhbmNlLg0KDQo=
