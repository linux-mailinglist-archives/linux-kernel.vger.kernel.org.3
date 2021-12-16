Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9318476E85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhLPKIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:08:15 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:34932 "EHLO test.cqplus1.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233509AbhLPKIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:08:13 -0500
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(4800:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 16 Dec 2021 18:06:36 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 18:06:28 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Thu, 16 Dec 2021 18:06:28 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v6 08/10] irqchip: Add Sunplus SP7021 interrupt controller
 driver
Thread-Topic: [PATCH v6 08/10] irqchip: Add Sunplus SP7021 interrupt
 controller driver
Thread-Index: AQHX8kzEkLzYBdbKnUiMsYSthxYJfqw0SZIAgACaTVA=
Date:   Thu, 16 Dec 2021 10:06:27 +0000
Message-ID: <e150f340a98b49a2b6958bc0f0530214@cqplus1.com>
References: <cover.1639560427.git.qinjian@cqplus1.com>
        <677ce3dd9b4650521968d6cb50999608b5136ddd.1639560427.git.qinjian@cqplus1.com>
 <87tuf9vso3.wl-maz@kernel.org>
In-Reply-To: <87tuf9vso3.wl-maz@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
RGVjZW1iZXIgMTYsIDIwMjEgNDo1MiBQTQ0KPiBUbzogcWluamlhblvopoPlgaVdIDxxaW5qaWFu
QGNxcGx1czEuY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtdHVycXVldHRlQGJheWxp
YnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgdGdseEBsaW51dHJvbml4LmRlOyBwLnphYmVsQHBl
bmd1dHJvbml4LmRlOw0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IGJyb29uaWVAa2VybmVsLm9y
ZzsgYXJuZEBhcm5kYi5kZTsgc3RlZmFuLndhaHJlbkBpMnNlLmNvbTsgbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgV2Vs
bHMgTHUg5ZGC6Iqz6aiwIDx3ZWxscy5sdUBzdW5wbHVzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NiAwOC8xMF0gaXJxY2hpcDogQWRkIFN1bnBsdXMgU1A3MDIxIGludGVycnVwdCBjb250
cm9sbGVyIGRyaXZlcg0KPiANCj4gT24gVGh1LCAxNiBEZWMgMjAyMSAwNzowODoxMCArMDAwMCwN
Cj4gUWluIEppYW4gPHFpbmppYW5AY3FwbHVzMS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIGlu
dGVycnVwdCBjb250cm9sbGVyIGRyaXZlciBmb3IgU3VucGx1cyBTUDcwMjEgU29DLg0KPiA+DQo+
ID4gVGhpcyBpcyB0aGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgaW4gUC1jaGlwIHdoaWNoIGNvbGxl
Y3RzIGFsbCBpbnRlcnJ1cHQNCj4gPiBzb3VyY2VzIGluIFAtY2hpcCBhbmQgcm91dGVzIHRoZW0g
dG8gcGFyZW50IGludGVycnVwdCBjb250cm9sbGVyIGluIEMtY2hpcC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFFpbiBKaWFuIDxxaW5qaWFuQGNxcGx1czEuY29tPg0KPiA+IC0tLQ0KPiA+IEZp
eCB0aGUgY29tbWVudHMgZnJvbSBNYXJjLg0KPiANCj4gTm8sIHlvdSBkaWRuJ3QuDQo+IA0KPiA+
ICt2b2lkIHNwX2ludGNfc2V0X2V4dCh1MzIgaHdpcnEsIGludCBleHRfbnVtKQ0KPiA+ICt7DQo+
ID4gKwlzcF9pbnRjX2Fzc2lnbl9iaXQoaHdpcnEsIFJFR19JTlRSX1BSSU9SSVRZLCAhZXh0X251
bSk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoc3BfaW50Y19zZXRfZXh0KTsNCj4g
DQo+IEkgYWxyZWFkeSBjb21tZW50ZWQgb24gdGhpcy4gSW4gY2FzZSBpdCB3YXNuJ3QgY2xlYXIs
IHRoaXMgaXMgYSBzdHJvbmcNCj4gTkFLIHRvIHJhbmRvbSBsb3ctbGV2ZWwgaGFja3MgbGlrZSB0
aGlzLg0KPiANCg0KWWVzLCBJIGp1c3QgZm9yZ290IGRlbGV0ZSB0aGlzLg0KU29ycnkgZm9yIG15
IG1pc3Rha2UsIEknbGwgZml4IGl0IG9uIG5leHQgY29tbWl0Lg0K
