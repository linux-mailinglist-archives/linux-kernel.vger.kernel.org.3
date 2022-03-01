Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCCA4C80C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiCACLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiCACLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:11:04 -0500
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56F8F65CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:10:18 -0800 (PST)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26039:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 01 Mar 2022 10:08:16 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 1 Mar 2022 10:08:37 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Tue, 1 Mar 2022 10:08:37 +0800
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
Thread-Index: AQHYJtRL7BpgMun7wkSEmTd5rYSoP6ydrKQAgAFsZ7D//5U0gIAJ5rig//+U8YCAAanw0A==
Date:   Tue, 1 Mar 2022 02:08:37 +0000
Message-ID: <3d7decc2cf9c4df4ae7f22d0ca671f34@cqplus1.com>
References: <cover.1645413746.git.qinjian@cqplus1.com>
 <87cc20bb3ef747c4da89f9e60c0847532bb0a679.1645413746.git.qinjian@cqplus1.com>
 <141c1b3e-b116-a0eb-78ad-dd9263880e9d@kernel.org>
 <fd66d0c1f8d5410ca676dd523bcde61b@cqplus1.com>
 <8ce8a3db-0f42-0b30-6688-01c1ea905425@kernel.org>
 <66b2710bc7c048a284fa3b6270ba7bc8@cqplus1.com>
 <d6031c8e-5a70-9561-f44e-0573594da34d@kernel.org>
In-Reply-To: <d6031c8e-5a70-9561-f44e-0573594da34d@kernel.org>
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

PiA+Pj4+IFRoaXMgYmluZGluZyBsb29rcyBpbmNvbXBsZXRlLg0KPiA+Pj4NCj4gPj4+IFN1bnBs
dXMgU1A3MDIxIGlzIGFuIEFSTSBDb3J0ZXggQTcgYmFzZWQgU29DLg0KPiA+Pj4gVGhlIHBhdGNo
IGlzIGZvciBTUDcwMjEgU29DIGFuZCBTUDcwMjEgYmFzZWQgYm9hcmRzLg0KPiA+Pj4gU29ycnks
IEkgZG9uJ3QgdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9ucy4NCj4gPj4+IENvdWxkIHlvdSBleHBs
YWluIG1vcmU/DQo+ID4+DQo+ID4+IFlvdSBoYXZlIHRoZXJlIG9ubHkgb25lIGNvbXBhdGlibGUg
YnV0IGlmIEkgd291bGQgZXhwZWN0IGF0IGxlYXN0IHR3by4NCj4gPj4gT25lIGZvciBTb0MgYW5k
IG9uZSBmb3IgYm9hcmQuIFNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcmRhLnlhbWwNCj4gPj4gYnV0IGluIHlvdXIgY2FzZSBl
bnVtIHdvdWxkIGhhdmUgb25seSBvbmUgZW50cnkuDQo+ID4NCj4gPiBDdXJyZW50bHksIHdlIG9u
bHkgc3VwcG9ydCBvbmUgYm9hcmQuIE1heWJlIHdpbGwgc3VwcG9ydCBtb3JlIGJvYXJkcyBpbiBm
dXR1cmUuDQo+IA0KPiBUaGlzIGlzIG5vdCB0aGUgYW5zd2VyIGZvciBteSBxdWVzdGlvbnMuIEkg
c2FpZCBJIGV4cGVjdCB0d28gY29tcGF0aWJsZXM6DQo+IDEuIE9uZSBmb3IgU29DLA0KPiAyLiBP
bmUgZm9yIGJvYXJkLg0KPiANCj4gQW5kIHlvdSByZXNwb25kICJ3ZSBoYXZlIG9ubHkgb25lIGJv
YXJkIi4NCj4gDQo+IFdoZXJlIGlzIHRoZSBTb0MgY29tcGF0aWJsZT8NCj4gDQoNCkdvdCBpdCwg
dGhhbmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uLg0KDQpJJ2xsIGFkZCB0aGUgU29DIGNvbXBhdGli
bGUoc3VucGx1cyxzcDcwMjEpIGluIG5leHQgcGF0Y2guDQoNCiAgY29tcGF0aWJsZToNCiAgICBp
dGVtczoNCiAgICAgIC0gZW51bToNCiAgICAgICAgICAtIHN1bnBsdXMsc3A3MDIxLWFjaGlwDQog
ICAgICAtIGNvbnN0OiBzdW5wbHVzLHNwNzAyMQ0K
