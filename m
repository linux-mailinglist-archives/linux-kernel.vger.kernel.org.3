Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508884EEA5E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344523AbiDAJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344538AbiDAJ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:27:48 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C15AFFA22B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:25:34 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1193:1:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 01 Apr 2022 17:18:32 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 1 Apr 2022 17:19:31 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Fri, 1 Apr 2022 17:19:31 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v12 4/9] dt-bindings: clock: Add bindings for SP7021 clock
 driver
Thread-Topic: [PATCH v12 4/9] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Index: AQHYRNqEmfEToMF3qkaI4FVvqF6nN6zZafcAgAFYO/A=
Date:   Fri, 1 Apr 2022 09:19:31 +0000
Message-ID: <eae0d1c49fcd4b41b700e8fd86af1b3e@cqplus1.com>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <c535be1e977098993850789faceea1db605df81d.1648714851.git.qinjian@cqplus1.com>
 <84d1e5b6-caa5-cf98-a4b2-2f1ca738b795@linaro.org>
In-Reply-To: <84d1e5b6-caa5-cf98-a4b2-2f1ca738b795@linaro.org>
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

PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3NwLXNwNzAyMS5oIGIv
aW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9zcC1zcDcwMjEuaA0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwLi40NWRhYzZkZTgNCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9zcC1zcDcwMjEuaA0KPiA+IEBA
IC0wLDAgKzEsMTEyIEBADQo+ID4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgKi8NCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChD
KSBTdW5wbHVzIFRlY2hub2xvZ3kgQ28uLCBMdGQuDQo+ID4gKyAqICAgICAgIEFsbCByaWdodHMg
cmVzZXJ2ZWQuDQo+ID4gKyAqLw0KPiA+ICsjaWZuZGVmIF9EVF9CSU5ESU5HU19DTE9DS19TVU5Q
TFVTX1NQNzAyMV9IDQo+ID4gKyNkZWZpbmUgX0RUX0JJTkRJTkdTX0NMT0NLX1NVTlBMVVNfU1A3
MDIxX0gNCj4gPiArDQo+ID4gKyNkZWZpbmUgWFRBTAkJCTI3MDAwMDAwDQo+ID4gKw0KPiA+ICsv
KiBwbGxzICovDQo+ID4gKyNkZWZpbmUgUExMX0EJCQkwDQo+ID4gKyNkZWZpbmUgUExMX0UJCQkx
DQo+ID4gKyNkZWZpbmUgUExMX0VfMlA1CQkyDQo+ID4gKyNkZWZpbmUgUExMX0VfMjUJCTMNCj4g
PiArI2RlZmluZSBQTExfRV8xMTJQNQkJNA0KPiA+ICsjZGVmaW5lIFBMTF9GCQkJNQ0KPiA+ICsj
ZGVmaW5lIFBMTF9UVgkJCTYNCj4gPiArI2RlZmluZSBQTExfVFZfQQkJNw0KPiA+ICsjZGVmaW5l
IFBMTF9TWVMJCQk4DQo+ID4gKw0KPiA+ICsvKiBnYXRlczogbW9fY2xrZW4wIH4gbW9fY2xrZW45
ICovDQo+ID4gKyNkZWZpbmUgQ0xLX1NZU1RFTQkJMHgxMA0KPiA+ICsjZGVmaW5lIENMS19SVEMJ
CQkweDEyDQo+IA0KPiBZQU1MIGxvb2tzIG9rLCBidXQgaGVyZSBjb21tZW50IGZyb20gQXJuZCBh
bHNvIGFwcGxpZXMuIFRoZXNlIHNob3VsZCBiZQ0KPiByZWd1bGFyIGRlY2ltYWwgbnVtYmVycyBp
bmNyZW1lbnRlZCBieSBvbmUuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpZ
ZXMsIHNhbWUgYXMgcmVzZXQgZHJpdmVyLCB0aGVzZSBkZWZpbmVzIGFsc28gbWFwcGluZyB0aGUg
aGFyZHdhcmUuDQpCdXQgZGlmZmVyZW50IGZyb20gcmVzZXQgZHJpdmVyLCBjbGsgZHJpdmVyIGFs
c28gdXNlZCB0aGVzZSBkZWZpbmVzLg0KSWYgSSByZW1vdmVkIHRoaXMgZGVmaW5lcywgSSAgbXVz
dCB3cml0ZSB0aGUgcHJvcGVyIGhhcmR3YXJlIG51bWJlciB0d2ljZSBpbiBkdCAmIGRyaXZlci4N
Ckl0J3MgbWVhbmluZ2xlc3MgJiBoYXJkIHRvIGNoZWNrLg0KDQoNCg0KDQo=
