Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E98567920
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiGEVCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiGEVCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:02:22 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034F120F49
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:02:15 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B52652C0538;
        Tue,  5 Jul 2022 21:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1657054932;
        bh=zZajghDGi2xCwhn5CaxJz0V54dwtp9R2dd7rHlJIjLo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DL++UMfL4XjqEtaqe2z3SEEKQ+E9Cd0nr4lVlJKveZoyRjngaMSXxQIN6fihyRBNE
         vqxyGKhOmtZ6LiPjWnjT763ImEqj2FL/7hcL3CABP8o/ENJbHU4ayUQp4p8uFZXSOb
         gWH3jsZrRmRdOs0Ls8L5Qgtf/4bC0z/x2UL3UMWxmieYMWLuQ5KO1BE45ojig7bkAi
         5S9gzcPAcSzGA3QUvgcZb6yV1T1bue/4smbv2Eq9xN7DwiNJExT5jpr8ukxxSkSFRx
         4Ye83glDwsIpWaDQlmCBiEJaP75ms9/lF+yDudLTxRpoH96QfbZM+5X+FpVLlAO62u
         kTBV0jew1Znjw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62c4a6d40001>; Wed, 06 Jul 2022 09:02:12 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.36; Wed, 6 Jul 2022 09:02:12 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.036; Wed, 6 Jul 2022 09:02:12 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Marko <robert.marko@sartura.hr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v10 0/3] arm64: mvebu: Support for Marvell 98DX2530 (and
 variants)
Thread-Topic: [PATCH v10 0/3] arm64: mvebu: Support for Marvell 98DX2530 (and
 variants)
Thread-Index: AQHYkKLpF7FCI/dgpUqn3R0QNHwVaK1veoyA
Date:   Tue, 5 Jul 2022 21:02:11 +0000
Message-ID: <aec639fc-1ffd-6a12-d87e-1cc3e8739218@alliedtelesis.co.nz>
References: <20220705190934.6168-1-vadym.kochan@plvision.eu>
In-Reply-To: <20220705190934.6168-1-vadym.kochan@plvision.eu>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ACE2B8F4F4F944F84E5CADDB8F995D9@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=KJck82No c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=RgO8CyIxsXoA:10 a=YWKnTcS2clTo5x2NLqgA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA2LzA3LzIyIDA3OjA5LCBWYWR5bSBLb2NoYW4gd3JvdGU6DQo+IFRoaXMgc2VyaWVzIGFk
ZHMgc3VwcG9ydCBmb3IgdGhlIE1hcnZlbGwgOThEWDI1MzAgU29DIHdoaWNoIGlzIHRoZSBDb250
cm9sIGFuZA0KPiBNYW5hZ2VtZW50IENQVSBpbnRlZ3JhdGVkIGludG8gdGhlIEFsbGV5Q2F0NS9B
bGxleUNhdDVYIHNlcmllcyBvZiBNYXJ2ZWxsDQo+IHN3aXRjaGVzLg0KPg0KPiBUaGUgQ1BVIGNv
cmUgaXMgYW4gQVJNIENvcnRleC1BNTUgd2l0aCBuZW9uLCBzaW1kIGFuZCBjcnlwdG8gZXh0ZW5z
aW9ucy4NCj4NCj4gVGhpcyBpcyBmYWlybHkgc2ltaWxhciB0byB0aGUgQXJtYWRhLTM3MDAgU29D
IHNvIG1vc3Qgb2YgdGhlIHJlcXVpcmVkDQo+IHBlcmlwaGVyYWxzIGFyZSBhbHJlYWR5IHN1cHBv
cnRlZC4gVGhpcyBzZXJpZXMgYWRkcyBhIGRldmljZXRyZWUgYW5kIHBpbmN0cmwNCj4gZHJpdmVy
IGZvciB0aGUgU29DIGFuZCB0aGUgUkQtQUM1WC0zMkcxNkhWRzZITEcgcmVmZXJlbmNlIGJvYXJk
Lg0KPg0KPiBUaGUgcGluY3RybCBjaGFuZ2VzIGZyb20gdjQgaGF2ZSBiZWVuIHBpY2tlZCB1cCBh
bmQgYXJlIGluIGxpbnV4LW5leHQgc28gSQ0KPiBoYXZlbid0IGluY2x1ZGVkIHRoZW0gaW4gdGhp
cyByb3VuZC4gVGhhdCBsZWF2ZXMganVzdCB0aGUgZHRzIGZpbGVzIGFuZCBhIG1pbm9yDQo+IEtj
b25maWcgdXBkYXRlIGZvciBhcm02NC4NCg0KTG9va3MgZ29vZCB0byBtZS4NCg0KSSBkb24ndCBr
bm93IGlmIGl0J3MgdGhlIGRvbmUgcHJhY3RpY2UgZm9yIGEgc2VyaWVzIEkgc3RhcnRlZCBidXQg
SSd2ZSANCmp1c3QgdGFrZW4gdGhlc2UgZm9yIGEgc3BpbiBvbiBteSBib2FyZCBzbw0KDQpUZXN0
ZWQtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4N
Cg0KPg0KPiBDaGFuZ2VzOg0KPg0KPiB2MTA6DQo+ICAgICAgICAxKSBVc2UgZGlmZmVyZW50IGNu
bSBjbG9jayBmb3IgQUM1IGFuZCBBQzVYIERUU0lzDQo+DQo+ICAgICAgICAyKSBSZW5hbWUgZGV2
aWNlLXRyZWUgeWFtbCBiaW5kaW5nIHRvIG1hdGNoIHRoZSAkaWQNCj4NCj4gdjkgKHByb3Bvc2Vk
IGJ5IE1hcnZlbGwpOg0KPiAgICAgSXQgd2FzIGRpc2N1c3NlZCB3aXRoIENocmlzIHRoYXQgTWFy
dmVsbCB3aWxsIGFkZCBzb21lIGNoYW5nZXM6DQo+ICAgICAgICAxKSBSZW5hbWUgImFybWFkYS0i
IHByZWZpeCBpbiBkdHMoaSkgZmlsZSBuYW1lcyB0byBhYzUsIGJlY2F1c2UNCj4gICAgICAgICAg
IEFybWFkYSBoYXMgbm90IG11Y2ggY29tbW9uIHdpdGggQUM1IFNvQy4NCj4NCj4gICAgICAgIDIp
IEFkZCBjbG9jayBmaXhlczoNCj4gICAgICAgICAgIGEpIHJlbmFtZSBjb3JlX2Nsb2NrIHRvIGNu
bV9jbG9jaw0KPg0KPiAgICAgICAgICAgYikgcmVtb3ZlIGF4aV9jbG9jaw0KPg0KPiAgICAgICAg
ICAgYykgY2hhbmdlIGNubV9jbG9jayB0byAzMjVNSFoNCj4NCj4gICAgICAgICAgIGQpIHVzZSBj
bm1fY2xvY2sgZm9yIHRoZSBVQVJUDQo+DQo+IENocmlzIFBhY2toYW0gKDMpOg0KPiAgICBkdC1i
aW5kaW5nczogbWFydmVsbDogRG9jdW1lbnQgdGhlIEFDNS9BQzVYIGNvbXBhdGlibGVzDQo+ICAg
IGFybTY0OiBkdHM6IG1hcnZlbGw6IEFkZCBBcm1hZGEgOThEWDI1MzAgU29DIGFuZCBSRC1BQzVY
IGJvYXJkDQo+ICAgIGFybTY0OiBtYXJ2ZWxsOiBlbmFibGUgdGhlIDk4RFgyNTMwIHBpbmN0cmwg
ZHJpdmVyDQo+DQo+ICAgLi4uL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL21hcnZlbGwsYWM1LnlhbWwg
ICAgIHwgIDMyICsrDQo+ICAgYXJjaC9hcm02NC9LY29uZmlnLnBsYXRmb3JtcyAgICAgICAgICAg
ICAgICAgIHwgICAyICsNCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUg
ICAgICAgICAgfCAgIDEgKw0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hYzUtOThk
eDI1eHguZHRzaSB8IDI5MSArKysrKysrKysrKysrKysrKysNCj4gICAuLi4vYm9vdC9kdHMvbWFy
dmVsbC9hYzUtOThkeDM1eHgtcmQuZHRzICAgICAgfCAxMDEgKysrKysrDQo+ICAgYXJjaC9hcm02
NC9ib290L2R0cy9tYXJ2ZWxsL2FjNS05OGR4MzV4eC5kdHNpIHwgIDE3ICsNCj4gICA2IGZpbGVz
IGNoYW5nZWQsIDQ0NCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9tYXJ2ZWxsLGFjNS55YW1s
DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hYzUt
OThkeDI1eHguZHRzaQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRz
L21hcnZlbGwvYWM1LTk4ZHgzNXh4LXJkLmR0cw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYWM1LTk4ZHgzNXh4LmR0c2kNCj4=
