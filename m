Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B82346D045
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhLHJpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:45:23 -0500
Received: from [106.84.20.49] ([106.84.20.49]:7597 "EHLO test.cqplus1.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229498AbhLHJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:45:22 -0500
X-Greylist: delayed 632 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2021 04:45:22 EST
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.27.96.203
        by cqmailgates with MailGates ESMTP Server V5.0(21478:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 08 Dec 2021 17:28:45 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 17:28:42 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Wed, 8 Dec 2021 17:28:42 +0800
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
Thread-Index: AQHX6BmQ/JspEgyikE+suUmdAKG1nqwmO/YAgAHtkbD//484gIAAn6dA
Date:   Wed, 8 Dec 2021 09:28:42 +0000
Message-ID: <8fa00c3b55874e90b5baae1f84010997@cqplus1.com>
References: <cover.1638515726.git.qinjian@cqplus1.com>
 <e88ea4cf28ba69a41f6d1b4dd4128b82a6095c29.1638515726.git.qinjian@cqplus1.com>
 <87r1ao23fp.wl-maz@kernel.org> <39f9b853af7c44cb94421354744512a8@cqplus1.com>
 <ce867937861df454823eb703bfd29256@kernel.org>
In-Reply-To: <ce867937861df454823eb703bfd29256@kernel.org>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIFp5bmdpZXIgPG1hekBr
ZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDgsIDIwMjEgMzo0NSBQTQ0K
PiBUbzogcWluamlhblvopoPlgaVdIDxxaW5qaWFuQGNxcGx1czEuY29tPg0KPiBDYzogcm9iaCtk
dEBrZXJuZWwub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsg
dGdseEBsaW51dHJvbml4LmRlOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOw0KPiBsaW51eEBhcm1s
aW51eC5vcmcudWs7IGJyb29uaWVAa2VybmVsLm9yZzsgYXJuZEBhcm5kYi5kZTsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5v
cmc7IFdlbGxzIEx1IOWRguiKs+mosCA8d2VsbHMubHVAc3VucGx1cy5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjUgMDgvMTBdIGlycWNoaXA6IEFkZCBTdW5wbHVzIFNQNzAyMSBpbnRlcnJ1
cHQgY29udHJvbGxlciBkcml2ZXINCj4gDQo+IE9uIDIwMjEtMTItMDggMDc6MTUsIHFpbmppYW5b
6KaD5YGlXSB3cm90ZToNCj4gPj4gPiArdm9pZCBzcF9pbnRjX3NldF9leHQodTMyIGh3aXJxLCBp
bnQgZXh0X251bSkNCj4gPj4gPiArew0KPiA+PiA+ICsJc3BfaW50Y19hc3NpZ25fYml0KGh3aXJx
LCBSRUdfSU5UUl9QUklPUklUWSwgIWV4dF9udW0pOw0KPiA+PiA+ICt9DQo+ID4+ID4gK0VYUE9S
VF9TWU1CT0xfR1BMKHNwX2ludGNfc2V0X2V4dCk7DQo+ID4+DQo+ID4+IE5vIHdheS4gV2UgZG9u
J3QgZXhwb3J0IHJhbmRvbSBzeW1ib2xzIHdpdGhvdXQgYSBnb29kIGp1c3RpZmljYXRpb24sDQo+
ID4+IGFuZCB5b3UgZGlkbid0IGdpdmUgYW55Lg0KPiA+Pg0KPiA+DQo+ID4gVGhpcyBmdW5jdGlv
biBjYWxsZWQgYnkgU1A3MDIxIGRpc3BsYXkgZHJpdmVyIHRvIGRlY2lkZSBESVNQTEFZX0lSUQ0K
PiA+IHJvdXRpbmcgdG8gd2hpY2ggcGFyZW50IGlycSAoRVhUX0lOVDAgb3IgRVhUX0lOVDEpLg0K
PiANCj4gQmFzZWQgb24gd2hhdD8gSG93IGNhbiBhIGRpc3BsYXkgZHJpdmVyIGRlY2lkZSB3aGlj
aCBwYXJlbnQgaXMNCj4gYXBwcm9wcmlhdGU/IFdoYXQgaW1wcm92ZW1lbnQgZG9lcyB0aGlzIGJy
aW5nPw0KDQpJbiBkZWZhdWx0LCBhbGwgSVJRIHJvdXRpbmcgdG8gRVhUX0lOVDAsIHdoaWNoIHBy
b2Nlc3NlZCBieSBDUFUwDQpTb21lIGRldmljZSdzIElSUSBuZWVkIGxvdyBsYXRlbmN5LCBsaWtl
IGRpc3BsYXksIHNvIHJvdXRpbmcgRElTUExBWV9JUlEgdG8gRVhUX0lOVDEsDQp3aGljaCBwcm9j
ZXNzZWQgYnkgQ1BVMSAoc2V0IC9wcm9jL2lycS88RVhUX0lOVDE+L3NtcF9hZmZpbml0eV9saXN0
KQ0K
