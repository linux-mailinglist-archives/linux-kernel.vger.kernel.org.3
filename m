Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC24C80D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiCACOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiCACO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:14:28 -0500
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07C91220C4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:13:36 -0800 (PST)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26034:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 01 Mar 2022 10:12:05 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 1 Mar 2022 10:12:25 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Tue, 1 Mar 2022 10:12:25 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
Subject: RE: [PATCH v9 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Topic: [PATCH v9 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Index: AQHYJtROb4p9p9dJDEiPbzM3WmTlw6ygfv2AgAgL80D//6oxgIABn9iw
Date:   Tue, 1 Mar 2022 02:12:25 +0000
Message-ID: <9250c1b0918f49b1b2592027a7ac9a61@cqplus1.com>
References: <cover.1645413746.git.qinjian@cqplus1.com>
 <2089471296584b527f1e08f51f5216d1e733741f.1645413746.git.qinjian@cqplus1.com>
 <498e89dd-c438-68dc-69b5-8de82045ffbd@canonical.com>
 <97cf98c598a04b77bb6de6e91fcdcc0b@cqplus1.com>
 <39ce4a12-ff56-e0cf-b0b2-2a3545a9cb7f@canonical.com>
In-Reply-To: <39ce4a12-ff56-e0cf-b0b2-2a3545a9cb7f@canonical.com>
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

PiA+Pj4gK2V4YW1wbGVzOg0KPiA+Pj4gKyAgLSB8DQo+ID4+PiArICAgIGNsa2M6IGNsb2NrLWNv
bnRyb2xsZXJAOWMwMDAwMDAgew0KPiA+Pj4gKyAgICAgIGNvbXBhdGlibGUgPSAic3VucGx1cyxz
cDcwMjEtY2xrYyI7DQo+ID4+PiArICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+Pj4gKyAg
ICAgIHJlZyA9IDwweDljMDAwMDAwIDB4MjgwPjsNCj4gPj4+ICsgICAgICBjbG9ja3MgPSA8JmV4
dGNsaz4sIDwmY2xrYyBQTExfU1lTPjsNCj4gPj4NCj4gPj4gRXhjZXB0IHRoZSB3YXJuaW5nIHBv
aW50ZWQgb3V0IGJ5IFJvYidzIGJvdCwgaXQgbG9va3MgbGlrZSB5b3UgZmVlZCB0aGlzDQo+ID4+
IGNsb2NrLWNvbnRyb2xsZXIgd2l0aCBhIGNsb2NrIGZyb20gaXRzZWxmLiBJcyB0aGVyZSBhIHBv
aW50IHRvIGV4cHJlc3MNCj4gPj4gaXQgaW4gRFRTIGF0IGFsbD8NCj4gPg0KPiA+IFllcywgcGxs
c3lzIGlzIGFuIGludGVybmFsIGNsb2NrLCBidXQgaXQgYWxzbyBhcyBhIHBhcmVudCBjbG9jayBm
b3Igc29tZSBvdGhlcg0KPiA+IGNsb2NrcyBpbiB0aGlzIGNsb2NrLWNvbnRyb2xsZXIuDQo+IA0K
PiBXaGF0IGlzIHRoZSBwb2ludCB0byBleHByZXNzIGl0IGluIERUUz8gVXN1YWxseSBzdWNoIGlu
dGVybmFsDQo+IHBhcmVudC1jaGlsZCByZWxhdGlvbiBpcyBkZXNjcmliZWQgaW4gdGhlIGRyaXZl
ci4NCj4gDQo+IEFuZCBob3cgZG9lcyBpdCBldmVuIHdvcms/IEhvdyBjYW4geW91IGdldCBhIGNs
b2NrIGZyb20gYSBkZXZpY2UgYmVmb3JlDQo+IHlvdSByZWdpc3RlcmVkIHRoYXQgZGV2aWNlPw0K
DQpUaGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24uDQpJJ2xsIHJlbW92ZSB0aGUgaW50ZXJuYWwg
Y2xvY2sgcGFyZW50IGZvcm0gRFRTLg0K
