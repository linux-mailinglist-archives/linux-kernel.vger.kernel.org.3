Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A84873D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbiAGICB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:02:01 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:58670 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345196AbiAGICA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:02:00 -0500
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24938:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 07 Jan 2022 15:55:16 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 15:55:18 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Fri, 7 Jan 2022 15:55:18 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
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
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v7 06/10] clk: Add Sunplus SP7021 clock driver
Thread-Topic: [PATCH v7 06/10] clk: Add Sunplus SP7021 clock driver
Thread-Index: AQHX9wMzddZ4i1EhDk6U/miEAgqwiKxUuIQAgAKMxIA=
Date:   Fri, 7 Jan 2022 07:55:18 +0000
Message-ID: <51a2cbddc978400086271fc735493566@cqplus1.com>
References: <cover.1640154492.git.qinjian@cqplus1.com>
 <7f8302e2c1d02141dd69d2524eaa857d6494fdc7.1640154492.git.qinjian@cqplus1.com>
 <20220106004249.90484C36AEB@smtp.kernel.org>
In-Reply-To: <20220106004249.90484C36AEB@smtp.kernel.org>
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

PiA+ICsNCj4gPiArQ0xLX09GX0RFQ0xBUkVfRFJJVkVSKHNwX2Nsa2MsICJzdW5wbHVzLHNwNzAy
MS1jbGtjIiwgc3BfY2xrX3NldHVwKTsNCj4gDQo+IFdoeSBDTEtfT0ZfREVDTEFSRV9EUklWRVI/
IFRoZXJlIHNob3VsZCBiZSBhIGNvbW1lbnQgYnV0IGJldHRlciB3b3VsZCBiZQ0KPiB0byBtYWtl
IGEgcGxhdGZvcm0gZHJpdmVyIGluc3RlYWQuIElmIHRoZSBwbGF0Zm9ybSBkcml2ZXIgY2FuJ3Qg
YmUgdXNlZCwNCj4gd2UgbmVlZCB0byBrbm93IHdoYXQgb3RoZXIgZGV2aWNlIGRyaXZlciBpcyBw
cm9iaW5nIGJhc2VkIG9uIHRoaXMgY2xrYw0KPiBjb21wYXRpYmxlIHN0cmluZy4NCg0KRGVhciBT
dGVwaGVuLA0KDQpTb3JyeSwgSSBkb24ndCB1bmRlcnN0YW5kIHlvdXIgY29tbWVudC4NCkRpZCB5
b3UgbWVhbiwgbGlrZSBiZWxvdzoNCg0Kc3RhdGljIGludCBzcDcwMjFfY2xrX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQp7DQoJLi4uLi4uDQoJc3BfY2xrX2RhdGEtPm51bSA9
IENMS19NQVg7DQoJcmV0dXJuIGRldm1fb2ZfY2xrX2FkZF9od19wcm92aWRlcihkZXYsIG9mX2Ns
a19od19vbmVjZWxsX2dldCwgc3BfY2xrX2RhdGEpOw0KfQ0KDQpzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBzcDcwMjFfY2xrX2R0X2lkc1tdID0gew0KCXsgLmNvbXBhdGlibGUgPSAi
c3VucGx1cyxzcDcwMjEtY2xrYyIsIH0sDQoJeyB9DQp9Ow0KTU9EVUxFX0RFVklDRV9UQUJMRShv
Ziwgc3A3MDIxX2Nsa19kdF9pZHMpOw0KDQpzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBz
cDcwMjFfY2xrX2RyaXZlciA9IHsNCgkucHJvYmUgID0gc3A3MDIxX2Nsa19wcm9iZSwNCgkuZHJp
dmVyID0gew0KCQkubmFtZSA9ICJzcDcwMjEtY2xrIiwNCgkJLm9mX21hdGNoX3RhYmxlID0gc3A3
MDIxX2Nsa19kdF9pZHMsDQoJfSwNCn07DQpidWlsdGluX3BsYXRmb3JtX2RyaXZlcihzcDcwMjFf
Y2xrX2RyaXZlcik7DQoNCg0KQnV0LCBJdCdzIGRvZXNuJ3Qgd29yay4gDQpNb3N0IG90aGVyIGNs
ayBkcml2ZXJzIHVzZWQgQ0xLX09GX0RFQ0xBUkVfRFJJVkVSIG9yIENMS19PRl9ERUNMQVJFLg0K
SSBqdXN0IHRha2UgdGhlc2UgYXMgdGhlIHJlZmVyZW5jZSBhbmQgaXQncyB3b3JraW5nLg0K
