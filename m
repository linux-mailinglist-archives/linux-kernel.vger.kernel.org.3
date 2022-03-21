Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BEB4E1E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 01:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbiCUAN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 20:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343854AbiCUANx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 20:13:53 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7141D71A01
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:12:28 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 056162C05F3;
        Mon, 21 Mar 2022 00:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647821545;
        bh=A1XDGzxnAPnhWdHJEVIaz098g7kZ8jMAFOh3mQ6xx9g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CsrXBQprPgYWpzjsWWg+htuQBOLaar1yNwSp2oD37Ud5Ic+SUV+SGIlBKzNR7M97L
         4NGL+Y+jgvuo37aFOdnL81htuyxFGJsFOjMERXKBraYwdvb2x2zupS4YGbPY3T69Em
         qvr0DN/UVXN8JK7+Py0VfaIhmVrE/ERgG2fX34e2bNL5qXu2bGcumtsSLHXNOJX0Sd
         5fHipZN3JmqdLzdmdYuAw4Z7OLezMUjP4eNkCVbmBTfAYIY4nfDLKAr6WtLKZXEFjY
         ZvfblfCziZjIncNhDl8xzNC9XtxGDfK/PDldry2EYcZkXTq7clv7LVU4NdvxAlJu32
         PsEiM5weodrEA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6237c2e80001>; Mon, 21 Mar 2022 13:12:24 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 21 Mar 2022 13:12:24 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Mon, 21 Mar 2022 13:12:24 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "huziji@marvell.com" <huziji@marvell.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: mmc: xenon: Convert to JSON schema
Thread-Topic: [PATCH] dt-bindings: mmc: xenon: Convert to JSON schema
Thread-Index: AQHYOnk50rTlUpEP/EiwBNSfY0h6HKzEV64AgAPKHoA=
Date:   Mon, 21 Mar 2022 00:12:24 +0000
Message-ID: <fd8cb680-5ae0-6b47-3f35-a497c51a47b9@alliedtelesis.co.nz>
References: <20220318033521.1432767-1-chris.packham@alliedtelesis.co.nz>
 <91b6660d-c22b-0679-4cb9-6ebba9066545@kernel.org>
In-Reply-To: <91b6660d-c22b-0679-4cb9-6ebba9066545@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B303CDD4947E94088B318403BF5FDE3@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=AefNodu_EPYWPp4RkKgA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KGFkZGluZyBzb21lIEFSTSBwZW9wbGUsIHJlc2VuZGluZyBob3BlZnVsbHkgd2l0aG91dCB0aGUg
aHRtbCkNCg0KT24gMTkvMDMvMjIgMDM6MjAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+
PiArICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsc2RoY2kteGVub24NCj4gVGhpcyBkaWQgbm90
IGV4aXN0IGJlZm9yZS4gU2VwYXJhdGUgcGF0Y2hlcyBwbGVhc2UgZm9yIGFkZGl0aW9ucyAod2l0
aA0KPiBleHBsYW5hdGlvbiB3aHkpLiBNYXliZSBzb21lIERUUyBsaXN0cyB0aGlzLCBidXQgdGhl
biBpdCBzaG91bGQgYmUNCj4gaW5kaXZpZHVhbGx5IGp1ZGdlZCB3aGV0aGVyIHRoZSBEVFMgaXMg
Y29ycmVjdC4NCj4NCk9uIHRoaXMgc3BlY2lmaWNhbGx5LiBJIHdhcyBhbGwgcmVhZHkgdG8gYWRk
IGFuIGFkZGl0aW9uYWwgcGF0Y2ggdG8gDQpkb2N1bWVudCB0aGlzIGJ1dCB0aGVuIEkgbm90aWNl
ZCBub3RoaW5nIGFjdHVhbGx5IHVzZXMgdGhlIA0KIm1hcnZlbGwsc2RoY2kteGVub24iIGNvbXBh
dGlibGUgYW5kIGl0IGFwcGVhcnMgbm90aGluZyBldmVyIGRpZC4gSSB0aGVuIA0KZmlndXJlZCBJ
J2QgZGVsZXRlIHRoZSB1bnVzZWQgY29tcGF0aWJsZSBzdHJpbmcgZnJvbSBhcm1hZGEtMzd4eC5k
dHNpIA0KYnV0IHRoZW4gSSByZW1lbWJlcmVkIHRoYXQgc29tZXRpbWVzIHdlIGFkZCBjb21wYXRp
YmxlIHN0cmluZ3MgdG8gaGF2ZSANCnRoZW0gImp1c3QgaW4gY2FzZSIgd2UgbmVlZCB0aGVtIGZv
ciBzb21lIFNvQyBzcGVjaWZpYyB3b3JrYXJvdW5kLg0KDQpTbyB0aGVyZSdzIGEgZmV3IHRoaW5n
cyBJIGNhbiBkbw0KDQowLiBOb3RoaW5nIChlYXN5KSBhbHRob3VnaCB0aGUgYmluZGluZyBJIGp1
c3Qgc3VibWl0dGVkIHdpbGwgY29tcGxhaW4gDQphYm91dCB0aGUgdW5leHBlY3RlZCB2YWx1ZQ0K
MS4gRG9jdW1lbnQgIm1hcnZlbGwsc2RoY2kteGVub24iIGFzIGEgdmFsaWQgY29tcGF0aWJsZQ0K
MS5hLiBBZGQgIm1hcnZlbGwsc2RoY2kteGVub24iIHRvIHRoZSBzZGhjaS14ZW5vbi5jIGRyaXZl
cg0KMi4gUmVtb3ZlICJtYXJ2ZWxsLHNkaGNpLXhlbm9uIiBmcm9tIGFybWFkYS0zN3h4LmR0c2kN
Cg==
