Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECD74E4AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiCWB7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiCWB7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:59:42 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0A5E167EB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:58:05 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7830:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 23 Mar 2022 09:54:05 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Mar 2022 09:54:35 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Wed, 23 Mar 2022 09:54:35 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v11 2/9] dt-bindings: reset: Add bindings for SP7021 reset
 driver
Thread-Topic: [PATCH v11 2/9] dt-bindings: reset: Add bindings for SP7021
 reset driver
Thread-Index: AQHYPbVznEjGDkREfkyqc2C0ll94iqzKt7sAgAF7uwA=
Date:   Wed, 23 Mar 2022 01:54:35 +0000
Message-ID: <678d1f84d9d240b9983f9d3b82db17d4@cqplus1.com>
References: <cover.1647928315.git.qinjian@cqplus1.com>
 <55db801055793f43678e902395913330ecb8fbbf.1647928316.git.qinjian@cqplus1.com>
 <a7194fbf-8423-9b49-1443-68dd33e23783@kernel.org>
In-Reply-To: <a7194fbf-8423-9b49-1443-68dd33e23783@kernel.org>
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

PiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIHJzdGM6IHJlc2V0QDljMDAwMDU0
IHsNCj4gPiArICAgICAgY29tcGF0aWJsZSA9ICJzdW5wbHVzLHNwNzAyMS1yZXNldCI7DQo+ID4g
KyAgICAgICNyZXNldC1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgcmVnID0gPDB4OWMwMDAwNTQg
MHgyOD47DQo+IA0KPiBJIGFza2VkIHlvdSB0byBwdXQgdGhlIHJlZyBhZnRlciBjb21wYXRpYmxl
IGluIGFsbCBEVFMgY29kZSBhbmQNCj4gZXhhbXBsZXMuIElmIHlvdSBkbyBub3QgYWdyZWUgd2l0
aCBhIGNvbW1lbnQsIHBsZWFzZSByZXNwb25kLiBJZ25vcmluZw0KPiBpdCBpcyBub3QgY29vcGVy
YXRpdmUuDQo+IA0KDQpZb3VyICByZXBseTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2Qz
YWMzZTJmLTcxZmQtYjJiNC03YzdlLWJiNDNjNjgxZDE0ZUBjYW5vbmljYWwuY29tLw0KPiA+ICsg
IC0gfA0KPiA+ICsNCj4gPiArICAgIGNsa2M6IGNsb2NrLWNvbnRyb2xsZXJAOWMwMDAwMDAgew0K
PiA+ICsgICAgICBjb21wYXRpYmxlID0gInN1bnBsdXMsc3A3MDIxLWNsa2MiOw0KPiA+ICsgICAg
ICAjY2xvY2stY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgIHJlZyA9IDwweDljMDAwMDAwIDB4Mjgw
PjsNCj4NCj4gSW4gRFRTIGNvZGUsIHBsZWFzZSBwdXQgcmVnIGFmdGVyIGNvbXBhdGlibGUuIElu
IGFsbCB5b3VyIGV4YW1wbGVzIGFuZA0KPiBEVFMgcGF0Y2hlcy4NCj4NCj4NCj4gUmV2aWV3ZWQt
Ynk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNv
bT4NCg0KSSBzZWUgeW91ciByZXZpZXctdGFnLiBTbywgSSBtaXN1bmRlcnN0YW5kIHlvdXIgY29t
bWVudHMuDQpEaWQgeW91IG1lYW5zICdyZWcnIG11c3QgZGlyZWN0bHkgYWZ0ZXIgdGhlICdjb21w
YXRpYmxlJywgbGlrZSB0aGlzPw0KICAgIGNsa2M6IGNsb2NrLWNvbnRyb2xsZXJAOWMwMDAwMDAg
ew0KICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KICAgICAgY29tcGF0aWJsZSA9ICJzdW5wbHVz
LHNwNzAyMS1jbGtjIjsNCiAgICAgIHJlZyA9IDwweDljMDAwMDAwIDB4MjgwPjsNCg==
