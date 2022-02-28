Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41F64C63A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiB1HIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiB1HIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:08:01 -0500
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD303673D8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:07:14 -0800 (PST)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26026:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Mon, 28 Feb 2022 15:05:16 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 28 Feb 2022 15:05:37 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Mon, 28 Feb 2022 15:05:37 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v9 02/10] dt-bindings: arm: sunplus: Add bindings for
 Sunplus SP7021 SoC boards
Thread-Topic: [PATCH v9 02/10] dt-bindings: arm: sunplus: Add bindings for
 Sunplus SP7021 SoC boards
Thread-Index: AQHYJtRL7BpgMun7wkSEmTd5rYSoP6ydrKQAgAFsZ7D//5U0gIAJ5rig
Date:   Mon, 28 Feb 2022 07:05:36 +0000
Message-ID: <66b2710bc7c048a284fa3b6270ba7bc8@cqplus1.com>
References: <cover.1645413746.git.qinjian@cqplus1.com>
 <87cc20bb3ef747c4da89f9e60c0847532bb0a679.1645413746.git.qinjian@cqplus1.com>
 <141c1b3e-b116-a0eb-78ad-dd9263880e9d@kernel.org>
 <fd66d0c1f8d5410ca676dd523bcde61b@cqplus1.com>
 <8ce8a3db-0f42-0b30-6688-01c1ea905425@kernel.org>
In-Reply-To: <8ce8a3db-0f42-0b30-6688-01c1ea905425@kernel.org>
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

DQo+ID4+IFRoaXMgYmluZGluZyBsb29rcyBpbmNvbXBsZXRlLg0KPiA+DQo+ID4gU3VucGx1cyBT
UDcwMjEgaXMgYW4gQVJNIENvcnRleCBBNyBiYXNlZCBTb0MuDQo+ID4gVGhlIHBhdGNoIGlzIGZv
ciBTUDcwMjEgU29DIGFuZCBTUDcwMjEgYmFzZWQgYm9hcmRzLg0KPiA+IFNvcnJ5LCBJIGRvbid0
IHVuZGVyc3RhbmQgeW91ciBxdWVzdGlvbnMuDQo+ID4gQ291bGQgeW91IGV4cGxhaW4gbW9yZT8N
Cj4gDQo+IFlvdSBoYXZlIHRoZXJlIG9ubHkgb25lIGNvbXBhdGlibGUgYnV0IGlmIEkgd291bGQg
ZXhwZWN0IGF0IGxlYXN0IHR3by4NCj4gT25lIGZvciBTb0MgYW5kIG9uZSBmb3IgYm9hcmQuIFNv
bWV0aGluZyBsaWtlIHRoaXM6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vcmRhLnlhbWwNCj4gYnV0IGluIHlvdXIgY2FzZSBlbnVtIHdvdWxkIGhhdmUgb25seSBvbmUg
ZW50cnkuDQoNCkN1cnJlbnRseSwgd2Ugb25seSBzdXBwb3J0IG9uZSBib2FyZC4gTWF5YmUgd2ls
bCBzdXBwb3J0IG1vcmUgYm9hcmRzIGluIGZ1dHVyZS4NCg==
