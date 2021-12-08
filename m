Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254B246CE4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbhLHHZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:25:05 -0500
Received: from [113.204.237.245] ([113.204.237.245]:47082 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240199AbhLHHZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:25:04 -0500
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by cqmailgates with MailGates ESMTP Server V5.0(21501:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 08 Dec 2021 15:16:01 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 15:15:58 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Wed, 8 Dec 2021 15:15:58 +0800
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
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v5 08/10] irqchip: Add Sunplus SP7021 interrupt controller
 driver
Thread-Topic: [PATCH v5 08/10] irqchip: Add Sunplus SP7021 interrupt
 controller driver
Thread-Index: AQHX6BmQ/JspEgyikE+suUmdAKG1nqwmO/YAgAHtkbA=
Date:   Wed, 8 Dec 2021 07:15:57 +0000
Message-ID: <39f9b853af7c44cb94421354744512a8@cqplus1.com>
References: <cover.1638515726.git.qinjian@cqplus1.com>
        <e88ea4cf28ba69a41f6d1b4dd4128b82a6095c29.1638515726.git.qinjian@cqplus1.com>
 <87r1ao23fp.wl-maz@kernel.org>
In-Reply-To: <87r1ao23fp.wl-maz@kernel.org>
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

PiA+ICt2b2lkIHNwX2ludGNfc2V0X2V4dCh1MzIgaHdpcnEsIGludCBleHRfbnVtKQ0KPiA+ICt7
DQo+ID4gKwlzcF9pbnRjX2Fzc2lnbl9iaXQoaHdpcnEsIFJFR19JTlRSX1BSSU9SSVRZLCAhZXh0
X251bSk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoc3BfaW50Y19zZXRfZXh0KTsN
Cj4gDQo+IE5vIHdheS4gV2UgZG9uJ3QgZXhwb3J0IHJhbmRvbSBzeW1ib2xzIHdpdGhvdXQgYSBn
b29kIGp1c3RpZmljYXRpb24sDQo+IGFuZCB5b3UgZGlkbid0IGdpdmUgYW55Lg0KPiANCg0KVGhp
cyBmdW5jdGlvbiBjYWxsZWQgYnkgU1A3MDIxIGRpc3BsYXkgZHJpdmVyIHRvIGRlY2lkZSBESVNQ
TEFZX0lSUQ0Kcm91dGluZyB0byB3aGljaCBwYXJlbnQgaXJxIChFWFRfSU5UMCBvciBFWFRfSU5U
MSkuDQoNCkluIHByZXZpb3VzIHBhdGNoZXMsIHdoaWNoIGRlZmluZWQgaW4gRFQsIHBhcnNlZCAm
IHByb2Nlc3NlZCBAIHNwX2ludGNfeGxhdGVfb2YoKQ0KRnJvbSB5b3VyIGNvbW1lbnQsIHRoaXMg
aXMgYSBTVyBkZWNpc2lvbi4gU28gSSByZW1vdmVkIGl0IGZyb20gRFQgJiBpbnRjIGRyaXZlciwg
b25seSANCmV4cG9ydCB0aGlzIGZ1bmN0aW9uIHRvIGFjY2VzcyB0aGUgcmVsYXRlZCBpbnRjIHJl
Zy4NCg0K
