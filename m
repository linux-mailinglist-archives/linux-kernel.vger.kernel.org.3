Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA64BF205
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiBVGUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:20:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiBVGUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:20:19 -0500
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5535590CF9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:19:46 -0800 (PST)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26021:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 22 Feb 2022 14:15:00 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 14:15:18 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Tue, 22 Feb 2022 14:15:18 +0800
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
Thread-Index: AQHYJtRL7BpgMun7wkSEmTd5rYSoP6ydrKQAgAFsZ7A=
Date:   Tue, 22 Feb 2022 06:15:18 +0000
Message-ID: <fd66d0c1f8d5410ca676dd523bcde61b@cqplus1.com>
References: <cover.1645413746.git.qinjian@cqplus1.com>
 <87cc20bb3ef747c4da89f9e60c0847532bb0a679.1645413746.git.qinjian@cqplus1.com>
 <141c1b3e-b116-a0eb-78ad-dd9263880e9d@kernel.org>
In-Reply-To: <141c1b3e-b116-a0eb-78ad-dd9263880e9d@kernel.org>
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

PiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICAkbm9kZW5hbWU6DQo+ID4gKyAgICBjb25z
dDogJy8nDQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIG9uZU9mOg0KPiA+ICsgICAgICAt
IGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogc3VucGx1cyxzcDcwMjEtYWNoaXANCj4g
PiArDQo+IA0KPiBZb3UgZGlkIG5vdCBwdWJsaXNoIERUUyBzbyBiaWdnZXIgcGljdHVyZSBhbmQg
Y29udGV4dCBhcmUgbWlzc2luZyBoZXJlLg0KPiBJcyBpdCBhIFNvQyBjb21wYXRpYmxlPyBBIGJv
YXJkIGNvbXBhdGlibGU/IFdoeSBvbmx5IG9uZT8gQWdhaW5zdCB3aGF0DQo+IGRvZXMgaXQgdmFs
aWRhdGU/DQo+IA0KPiBUaGlzIGJpbmRpbmcgbG9va3MgaW5jb21wbGV0ZS4NCg0KU3VucGx1cyBT
UDcwMjEgaXMgYW4gQVJNIENvcnRleCBBNyBiYXNlZCBTb0MuDQpUaGUgcGF0Y2ggaXMgZm9yIFNQ
NzAyMSBTb0MgYW5kIFNQNzAyMSBiYXNlZCBib2FyZHMuDQpTb3JyeSwgSSBkb24ndCB1bmRlcnN0
YW5kIHlvdXIgcXVlc3Rpb25zLg0KQ291bGQgeW91IGV4cGxhaW4gbW9yZT8NCiANCg==
