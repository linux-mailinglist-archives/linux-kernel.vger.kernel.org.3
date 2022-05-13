Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0E525A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376723AbiEMDYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376671AbiEMDYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:24:46 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F288B201C06
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:24:21 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7688:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 13 May 2022 11:22:23 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Fri, 13 May 2022 11:22:20 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Fri, 13 May 2022 11:22:20 +0800
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
Subject: RE: [PATCH v15 04/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Topic: [PATCH v15 04/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Index: AQHYZcsP5QfLdHxDWUuwmqTXvmezs60ag04AgACLAGD//30wAIABmWAA
Date:   Fri, 13 May 2022 03:22:20 +0000
Message-ID: <d4671a918be043b991e4ab050239b326@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <b5ca5d417be079a2a40a6e79ac1b246b6359a49e.1652329411.git.qinjian@cqplus1.com>
 <e9a39eb6-d8e2-bac6-27e2-f63ef8519917@linaro.org>
 <8a9fa13f66ce4ef9a8f8c9200e1fac5f@cqplus1.com>
 <c385961d-7290-bad6-a1d7-be9738a1d842@linaro.org>
In-Reply-To: <c385961d-7290-bad6-a1d7-be9738a1d842@linaro.org>
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

PiBPbiAxMi8wNS8yMDIyIDEyOjQ1LCBxaW5qaWFuW+img+WBpV0gd3JvdGU6DQo+ID4+PiArDQo+
ID4+PiArZXhhbXBsZXM6DQo+ID4+PiArICAtIHwNCj4gPj4+ICsNCj4gPj4NCj4gPj4gU2FtZSBh
cyBpbiB2MTQuIFBsZWFzZSBnbyB0aHJvdWdoIHRoZSBjb21tZW50cyB0aG9yb3VnaGx5IHNvIHJl
dmlld2Vycw0KPiA+PiB3aWxsIG5vdCB3YXN0ZSB0aW1lIHJlcGVhdGluZyB0aGUgc2FtZSB0d2lj
ZS4NCj4gPj4NCj4gPg0KPiA+IFNvcnJ5LCBJIGRvbuKAmXQgdW5kZXJzdGFuZCB5b3VyIG1lYW5p
bmcuDQo+ID4gQ291bGQgeW91IGV4cGxhaW4gbW9yZSwgdGhhbmtzLg0KPiANCj4gSSBjb21tZW50
ZWQgaW4geW91ciB2MTQuIFBsZWFzZSBhcHBseSB0aGUgY29tbWVudCBvciBrZWVwIGRpc2N1c3Np
b24NCj4gcnVubmluZy4gRG9uJ3QgaWdub3JlIG15IGNvbW1lbnQuDQo+IA0KDQpTb3JyeSwgSSBt
aXNzZWQgeW91ciBjb21tZW50OiAiTm8gbmVlZCBmb3IgYmxhbmsgbGluZSIuDQpJJ2xsIGZpeCBp
dCBsYXRlci4NCg==
