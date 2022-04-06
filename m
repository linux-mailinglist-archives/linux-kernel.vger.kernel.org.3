Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA24F6D85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiDFVzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiDFVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:55:11 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBAF220C6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:51:09 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 709DE2C06BA;
        Wed,  6 Apr 2022 21:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1649281866;
        bh=56XxgWYNA5Lr7R6jz0Hxp4nWhzIkidOSOlp3iSis/I0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=S42KHkCugcClpbvXKxE+Q0LmLqmgz567LfNQyex3JCXU08RknzTIfNrlF5+tsRfOI
         iOXN0MaMlHhuaIYWjnvzIElLmW/L7QHoRLWlm9MrSCsA7sLeGToSFZrjNftRE8sfch
         UxbSk99pNfihe0DUss9SAdmd4xIhKlHDWrWfiFHe+gde7WAZxCXmJlf4KoTCcubMun
         d/sZS39w8mqs8KbAo87QAoCrCcYFogyK2HsqLepUzfQQDKSLZYAJgpQuwMKpqf7YID
         veU+nuPP7sGuQwQPVH1giTOaEfKFTm7qgZ8tfsVcOxOHgRfEQRIoKpa7e1tdxKUKF+
         oK96wHg+qL3QQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B624e0b4a0001>; Thu, 07 Apr 2022 09:51:06 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 09:51:06 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 7 Apr 2022 09:51:06 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/4] pinctrl: mvebu: pinctrl driver for 98DX2530 SoC
Thread-Topic: [PATCH v3 2/4] pinctrl: mvebu: pinctrl driver for 98DX2530 SoC
Thread-Index: AQHYSWWOiahKHGl1hkaskFlrlSGHCaziCewAgACa64A=
Date:   Wed, 6 Apr 2022 21:51:05 +0000
Message-ID: <5033e1ed-a4bc-687a-40f5-767e89317ce3@alliedtelesis.co.nz>
References: <20220406032158.1449049-1-chris.packham@alliedtelesis.co.nz>
 <20220406032158.1449049-3-chris.packham@alliedtelesis.co.nz>
 <Yk2JTo91sZHunEpN@lunn.ch>
In-Reply-To: <Yk2JTo91sZHunEpN@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <92F3C1CEA639144B86CA88A86C6FC9DF@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=JcrCUnCV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=z0gMJWrwH1QA:10 a=7zoCwGnkVZnnLB2-y-oA:9 a=QEXdDO2ut3YA:10
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

SGkgQW5kcmV3LA0KDQpPbiA3LzA0LzIyIDAwOjM2LCBBbmRyZXcgTHVubiB3cm90ZToNCj4gT24g
V2VkLCBBcHIgMDYsIDIwMjIgYXQgMDM6MjE6NTZQTSArMTIwMCwgQ2hyaXMgUGFja2hhbSB3cm90
ZToNCj4+IFRoaXMgcGluY3RybCBkcml2ZXIgc3VwcG9ydHMgdGhlIDk4RFgyNXh4IGFuZCA5OERY
MzV4eCBmYW1pbHkgb2YgY2hpcHMNCj4+IGZyb20gTWFydmVsbC4gSXQgaXMgYmFzZWQgb24gdGhl
IE1hcnZlbGwgU0RLIHdpdGggYWRkaXRpb25zIGZvciB2YXJpb3VzDQo+PiAobm9uLWdwaW8pIHBp
biBjb25maWd1cmF0aW9ucyBiYXNlZCBvbiB0aGUgZGF0YXNoZWV0Lg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4N
Cj4+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+PiAtLS0NCj4+
DQo+PiBOb3RlczoNCj4+ICAgICAgQ2hhbmdlcyBpbiB2MzoNCj4+ICAgICAgLSBVc2UgbW1pbyBp
bnN0ZWFkIG9mIHN5c2Nvbg0KPiBIaSBDaHJpcw0KPg0KPiBzeXNjb24gaXMgdXNlZCB3aGVuIHRo
ZSByZWdpc3RlciBzcGFjZSBpcyBzaGFyZWQgd2l0aCBvdGhlcg0KPiBkZXZpY2VzLiBJcyB0aGF0
IG5vdCB0aGUgY2FzZSBoZXJlPyBZb3UgY2FuIHNoYXJlIG1taW8gc3BhY2VzLCBidXQgeW91DQo+
IGhhdmUgdG8gdXNlIHRoZSBjb3JyZWN0IGNhbGwgdG8gcmVzZXJ2ZSBpdCwgc28gdGhhdCB0aGUg
c3lzdGVtIGtub3dzDQo+IGl0IGlzIHRvIGJlIHNoYXJlZC4gT3IgYXJlIGFsbCB0aGUgcGluY3Rs
IHJlZ2lzdGVycyBjb250aWd1b3VzIGFuZCB5b3UNCj4gYXJlIG9ubHkgcmVzZXJ2ZSBqdXN0IHRo
ZSByZWdpc3RlcnMgeW91IG5lZWQsIGxlYXZpbmcgb3RoZXIgZHJpdmVycw0KPiBmZWUgdG8gdGFr
ZSB3aGF0IHRoZXkgbmVlZD8NCj4NCj4gSSdtIGp1c3QgdHJ5aW5nIHRvIGVuc3VyZSB5b3UgYXJl
IG5vdCBnb2luZyB0byBoYXZlIHRyb3VibGUgbGF0ZXIgd2hlbg0KPiB5b3UgYWRkIG90aGVyIGRy
aXZlcnMuDQoNClRoZSBwaW5jdHJsIHJlZ2lzdGVycyB0aGF0IGFyZSB1c2VkIGFyZSBhbGwgY29u
dGluZ3VvdXMgKDB4ODAwMjAxMDAgLS0gDQoweDgwMDIwMTFjKSAuIFRoZXJlIGlzIGEgYmxvY2sg
Y2FsbGVkIHRoZSAiQ25NIFJGVSIgd2hpY2ggaXMgbmVhciB0aGUgDQpwaW5jdHJsIHJlZ2lzdGVy
cyAoYnV0IGEgZGlmZmVyZW50IHNlY3Rpb24gaW4gdGhlIGRhdGFzaGVldCkgd2hpY2ggaGFzIA0K
c29tZSBwZXJpcGhlcmFsIGNvbnRyb2xzLiBUaGVyZSBpcyBhbHNvIHNvbWUgb2RkIHJlZ2lzdGVy
cyAoZU1NQyBQSFkgYW5kIA0KUkZVIGludGVycnVwdHMpIGluIHRoZSBNUFAgc2VjdGlvbiBvZiB0
aGUgZG9jdW1lbnQgYnV0IG91dHNpZGUgdGhlIHJhbmdlIA0KdGhhdCB0aGlzIGRyaXZlciB1c2Vz
LiBJIGNhbid0IHRlbGwgaWYgdGhpcyBpcyBzaW1pbGFyIHRvIHRoZSBSRlUgYmxvY2sgDQpvbiB0
aGUgZGlzY3JldGUgQXJtYWRhIDY0IFNvQ3MsIHRoZSBpbnRlZ3JhdGVkIFNvQy9Td2l0Y2ggY2hp
cHMgdGVuZCB0byANCmJlIGEgYml0IG9mIGEgZnJhbmtlbnN0aWVucyBtb25zdGVyIG9mIElQIGJs
b2Nrcy4NCg0KSSByZWFsbHkgd2lzaCBJIGNvdWxkIGp1c3Qgc2hhcmUgdGhlIGRhdGFzaGVldCBi
dXQgeW91IGtub3cgaG93IGhhcmR3YXJlIA0KdmVuZG9ycyBsaWtlIHRoZWlyIE5EQXMuDQoNCj4N
Cj4gICAgICBBbmRyZXc=
