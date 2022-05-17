Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C084B529E33
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiEQJjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiEQJj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:39:28 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C4B245066
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:39:17 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(11177:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 17 May 2022 17:30:28 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 17 May 2022 17:30:24 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Tue, 17 May 2022 17:30:24 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [PATCH v15 05/10] clk: Add Sunplus SP7021 clock driver
Thread-Topic: [PATCH v15 05/10] clk: Add Sunplus SP7021 clock driver
Thread-Index: AQHYZcsXCsTwSBsje0a2OPS1GfS78a0h1u8AgADuCPA=
Date:   Tue, 17 May 2022 09:30:24 +0000
Message-ID: <7febed72ae2747abb953a6f44a51102c@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <9a71d17e9c70051db44c5545453ae8320ed8e0f8.1652329411.git.qinjian@cqplus1.com>
 <20220517021755.F1D05C385B8@smtp.kernel.org>
In-Reply-To: <20220517021755.F1D05C385B8@smtp.kernel.org>
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

PiA+ICsgICAgICAgICAgICAgICBuZiA9IGZ2Y28gKiBtX3RhYmxlW21dOw0KPiA+ICsgICAgICAg
ICAgICAgICBuID0gbmYgLyBGXzI3TTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKChuICogRl8y
N00pID09IG5mKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAg
ICAgfQ0KPiA+ICsgICAgICAgbSA9IG1fdGFibGVbbV07DQo+ID4gKw0KPiA+ICsgICAgICAgaWYg
KCFtKSB7DQo+IA0KPiBUaGlzIGNhbiBiZSByZXNvbHZlZCB3aXRoIGEgJ3JldHVybicgZnJvbSBh
IHN1YmZ1bmN0aW9uIG9yIGEgZ290by4NCg0KU29ycnksIENvdWxkIHlvdSBleHBsYWluIG1vcmUg
Y2xlYXI/DQpEaWQgeW91IG1lYW5zIGxpa2U6DQoJSWYgKCFtKSB7DQoJCXJldCA9IC1FSU5WQUw7
DQoJCWdvdG8gZXJyX25vdF9mb3VuZDsNCgl9DQoJLi4uDQoJcmV0dXJuIGZyZXE7DQoNCmVycl9u
b3RfZm91bmQ6DQoJLi4uDQoJcmV0dXJuIHJldDsNCn0NCg0KPiANCj4gPiArICAgICAgICAgICAg
ICAgcHJfZXJyKCIlczogJXMgZnJlcTolbHUgbm90IGZvdW5kIGEgdmFsaWQgc2V0dGluZ1xuIiwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBjbGtfaHdfZ2V0X25hbWUoJmNs
ay0+aHcpLCBmcmVxKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4g
KyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgLyogc2F2ZSBwYXJhbWV0ZXJzICovDQo+ID4g
KyAgICAgICBjbGstPnBbU0VMX0ZSQV0gPSAwOw0KPiA+ICsgICAgICAgY2xrLT5wW0RJVlJdICAg
ID0gcjsNCj4gPiArICAgICAgIGNsay0+cFtESVZOXSAgICA9IG47DQo+ID4gKyAgICAgICBjbGst
PnBbRElWTV0gICAgPSBtOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBmcmVxOw0KPiA+ICt9
DQoNCg0KDQoNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZl9x
dW90aWVudCAgPSBkZiAvIG07DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBk
Zl9yZW1haW5kZXIgPSAoKGRmICUgbSkgKiAxMDAwKSAvIG07DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGZyZXEgPiBkZl9xdW90aWVudCkgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZl9xdW90aWVudCAgPSBmcmVx
IC0gZGZfcXVvdGllbnQgLSAxOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBkZl9yZW1haW5kZXIgPSAxMDAwIC0gZGZfcmVtYWluZGVyOw0KPiANCj4gV2hlcmUg
ZG9lcyAxMDAwIGNvbWUgZnJvbT8NCg0KMTAwMCBpcyBjb21lIGZyb20gImJvcnJvdyAxIiBpbiBs
YXN0IG9wZXJhdGlvbi4NCg0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRm
X3F1b3RpZW50ID0gZGZfcXVvdGllbnQgLSBmcmVxOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfQ0KPiA+ICsNCg0KDQoNCg0KPiA+ICtzdGF0aWMgaW50IHNwX3BsbF9zZXRf
cmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyByYXRlLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgcHJhdGUpDQo+ID4gK3sNCj4gPiArICAg
ICAgIHN0cnVjdCBzcF9wbGwgKmNsayA9IHRvX3NwX3BsbChodyk7DQo+ID4gKyAgICAgICB1bnNp
Z25lZCBsb25nIGZsYWdzOw0KPiA+ICsgICAgICAgdTMyIHJlZzsNCj4gPiArDQo+ID4gKyAgICAg
ICBzcGluX2xvY2tfaXJxc2F2ZShjbGstPmxvY2ssIGZsYWdzKTsNCj4gDQo+IFBsZWFzZSBwdXNo
IHRoZSBsb2NrIGRvd24uIE1heWJlIHRoYXQgbWVhbnMgaGF2aW5nIHR3byBjb25kaXRpb25hbHM/
DQo+IEVpdGhlciB3YXksIGl0IGlzIHRvbyBsYXJnZSBiZWNhdXNlIGl0IGNhbGxzIGludG8gcGxs
YV9zZXRfcmF0ZSgpIGFuZA0KPiBwbGx0dl9zZXRfcmF0ZSgpIHdpdGggdGhlIGxvY2sgaGVsZC4N
Cg0KU29ycnksIEkgZG9uJ3QgdW5kZXJzdGFuZCAicHVzaCB0aGUgbG9jayBkb3duLiBNYXliZSB0
aGF0IG1lYW5zIGhhdmluZyB0d28gY29uZGl0aW9uYWxzPyIgd2hhdCBtZWFucy4NClRoZSBwbGxh
X3NldF9yYXRlKCkgJiBwbGx0dl9zZXRfcmF0ZSgpIGlzIG9ubHkgaW5jbHVkZSBzaW1wbGUgb3Bl
cmF0aW9ucyAmIEhXIHJlZyB3cml0ZXMuDQpJIHRoaW5rIGl0IHNob3VsZCBiZSBjYWxsZWQgd2l0
aCBsb2NrIGhlbGQuDQoNCnN0YXRpYyB2b2lkIHBsbGFfc2V0X3JhdGUoc3RydWN0IHNwX3BsbCAq
Y2xrKQ0Kew0KCWNvbnN0IHUzMiAqcHAgPSBwYVtjbGstPnBbMF1dLnJlZ3M7DQoJaW50IGk7DQoN
Cglmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShwYS0+cmVncyk7IGkrKykNCgkJd3JpdGVsKDB4
ZmZmZjAwMDAgfCBwcFtpXSwgY2xrLT5yZWcgKyAoaSAqIDQpKTsNCn0NCg0Kc3RhdGljIHZvaWQg
cGxsdHZfc2V0X3JhdGUoc3RydWN0IHNwX3BsbCAqY2xrKQ0Kew0KCXUzMiByZWc7DQoNCglyZWcg
ID0gSFdNX0ZJRUxEX1BSRVAoTUFTS19TRUxfRlJBLCBjbGstPnBbU0VMX0ZSQV0pOw0KCXJlZyB8
PSBIV01fRklFTERfUFJFUChNQVNLX1NETV9NT0QsIGNsay0+cFtTRE1fTU9EXSk7DQoJcmVnIHw9
IEhXTV9GSUVMRF9QUkVQKE1BU0tfUEhfU0VMLCBjbGstPnBbUEhfU0VMXSk7DQoJcmVnIHw9IEhX
TV9GSUVMRF9QUkVQKE1BU0tfTkZSQSwgY2xrLT5wW05GUkFdKTsNCgl3cml0ZWwocmVnLCBjbGst
PnJlZyk7DQoNCglyZWcgID0gSFdNX0ZJRUxEX1BSRVAoTUFTS19ESVZSLCBjbGstPnBbRElWUl0p
Ow0KCXdyaXRlbChyZWcsIGNsay0+cmVnICsgNCk7DQoNCglyZWcgID0gSFdNX0ZJRUxEX1BSRVAo
TUFTS19ESVZOLCBjbGstPnBbRElWTl0gLSAxKTsNCglyZWcgfD0gSFdNX0ZJRUxEX1BSRVAoTUFT
S19ESVZNLCBjbGstPnBbRElWTV0gLSAxKTsNCgl3cml0ZWwocmVnLCBjbGstPnJlZyArIDgpOw0K
fQ0KDQoNCg0K
