Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00AC4691C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbhLFIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbhLFIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:51:46 -0500
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E7AC061746;
        Mon,  6 Dec 2021 00:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1638780421;
        bh=6jaTMmXBmF19GHLv0vFZrDBi7PSUD+mgYaqX54w4rb0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GY6918A+EwWGHoV9yNwZTvsyGKv9imDsRd+g+ZdSTceu1bWugp5w3MnLd5Ba7TEXf
         lzzNt9OWQgPmhrKvas2CbYEvRLoO4CXpb/lq4pdCpFRhlV83Nz/Ipt4Ed2AQaCUzlN
         uWg15R5PMK6/o64IZmN1StWgBDQqZlt9xuT/MoR8FhU6XiqZFW9haGC5spG4pyeKKV
         sfQXURx9z6SvQZbzQcp4q8cwP8qXCdKIqDorkgMeTB4nyg2+owmoixcJ1Eep2c10xN
         GEnkq1ps8gTE7x+SyeEiKLiwh9xYAd1Ocfw22FHwTfU7+V3WIkeVuMwgDdcZmArui2
         e9gfRZx4NRY0Q==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Andrej Picej <andrej.picej@norik.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 2/5] mfd: da9061: make register CONFIG_I writable
Thread-Topic: [PATCH v5 2/5] mfd: da9061: make register CONFIG_I writable
Thread-Index: AQHX6m0s9RmOs0WHvUmZX0opZ+OZf6wlIxdg
Date:   Mon, 6 Dec 2021 08:46:52 +0000
Message-ID: <9d9032c5e1da4a0f83b0d8eba9156d4c@dh-electronics.com>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <20211206064732.280375-2-andrej.picej@norik.com>
In-Reply-To: <20211206064732.280375-2-andrej.picej@norik.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5kcmVqIFBpY2VqDQpTZW50OiBNb25kYXksIERlY2VtYmVyIDYsIDIwMjEgNzo0NyBB
TQ0KPiANCj4gTWFrZSB0aGUgY29uZmlnIHJlZ2lzdGVyIENPTkZJR19JIHdyaXRhYmxlIHRvIGNo
YW5nZSB0aGUgd2F0Y2hkb2cgbW9kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlaiBQaWNl
aiA8YW5kcmVqLnBpY2VqQG5vcmlrLmNvbT4NCj4gLS0tDQo+IENobmFnZXMgaW4gdjU6DQo+ICAt
IG5ldyBwYXRjaCwgbWFrZSBDT05GSUdfSSB3cml0YWJsZSBhbHNvIGZvciBkYTkwNjEgdmVyc2lv
bg0KPiAtLS0NCj4gIGRyaXZlcnMvbWZkL2RhOTA2Mi1jb3JlLmMgfCAxICsNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2Rh
OTA2Mi1jb3JlLmMgYi9kcml2ZXJzL21mZC9kYTkwNjItY29yZS5jDQo+IGluZGV4IDcwNDFiYTUz
ZWZiNC4uMjBlNWNlMmEyMzU0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21mZC9kYTkwNjItY29y
ZS5jDQo+ICsrKyBiL2RyaXZlcnMvbWZkL2RhOTA2Mi1jb3JlLmMNCj4gQEAgLTQ1Myw2ICs0NTMs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9yYW5nZQ0KPiBkYTkwNjFfYWFfd3JpdGVh
YmxlX3Jhbmdlc1tdID0gew0KPiAgICAgICAgIHJlZ21hcF9yZWdfcmFuZ2UoREE5MDYyQUFfVkJV
Q0sxX0IsIERBOTA2MkFBX1ZCVUNLNF9CKSwNCj4gICAgICAgICByZWdtYXBfcmVnX3JhbmdlKERB
OTA2MkFBX1ZCVUNLM19CLCBEQTkwNjJBQV9WQlVDSzNfQiksDQo+ICAgICAgICAgcmVnbWFwX3Jl
Z19yYW5nZShEQTkwNjJBQV9WTERPMV9CLCBEQTkwNjJBQV9WTERPNF9CKSwNCj4gKyAgICAgICBy
ZWdtYXBfcmVnX3JhbmdlKERBOTA2MkFBX0NPTkZJR19JLCBEQTkwNjJBQV9DT05GSUdfSSksDQo+
ICAgICAgICAgcmVnbWFwX3JlZ19yYW5nZShEQTkwNjJBQV9HUF9JRF8wLCBEQTkwNjJBQV9HUF9J
RF8xOSksDQo+ICB9Ow0KDQpUZXN0ZWQgaXQgb24gbXkgREE5MDYxOg0KLSBJZiBJIGRvbid0IGFk
ZCBhbnl0aGluZyB0byBteSBkZXZpY2UgdHJlZSwgdGhlIHN5c3RlbSBmcmVlemVzLg0KLSBXaXRo
ICJkbGcsd2R0LXNkID0gPDE+OyIgaW4gbXkgZGV2aWNldHJlZSB0aGUgc3lzdGVtIHJlc3RhcnRz
Lg0KVGh1cyBpdCB3b3JrcyBvbiBteSBzeXN0ZW0hDQoNClRlc3RlZC1ieTogQ2hyaXN0b3BoIE5p
ZWRlcm1haWVyIDxjbmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tPg0KDQoNClRoYW5rcyBh
bmQgcmVnYXJkcw0KQ2hyaXN0b3BoDQo=
