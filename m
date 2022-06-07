Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16754244F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442532AbiFHAzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575962AbiFGX15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:27:57 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8C16FEEF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:40:44 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E33C52C0272;
        Tue,  7 Jun 2022 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1654638039;
        bh=96oErJ8zD+XXujfdEyvt2Gd4Gbhvl7gCYR2TkJ8IyDg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RQf8h6Tc/GrJ2q9Iv3ba0UlUfoifRG8FJICikRGM6N6yUhDWadFssyJbYHZ8HDG5m
         q+McxnKj7QAkE7/gp0Pcy+/LMO2Xszj7mTf3SbNQMqfj4jA0CwACIUbJygyIpy5+n3
         Vkc3IU01UGWOkc8nPrgTD9VdfUThjzmtbWFzOHTrWNXAXWuPc9oJv2wKJ5O8sURxif
         4gStptPLBO5JhRhbx+rEAFW+I3F4duC3fkYM1RXzv1RkFzW7EHMkroBONatU/CM9ME
         pTGNUr1CvRcEXOMI8U8CGhRcGXje9edelLDK/YViDsyiG1wYjtfW9FYwHTNbHc9PlQ
         89+9/qmZJC/hA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B629fc5d70001>; Wed, 08 Jun 2022 09:40:39 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.36; Wed, 8 Jun 2022 09:40:39 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.036; Wed, 8 Jun 2022 09:40:39 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v8 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYaLPUD+oibO1AYUujXl5i0rei+a1DLsAAgAAFAYCAAKAigA==
Date:   Tue, 7 Jun 2022 21:40:39 +0000
Message-ID: <1e968eb4-e0c3-1fe0-c7d6-3a967654cbf9@alliedtelesis.co.nz>
References: <20220515233047.531979-3-chris.packham@alliedtelesis.co.nz>
 <20220607114936.GA18404@plvision.eu> <Yp8/g0m0xWiRmOq9@lunn.ch>
In-Reply-To: <Yp8/g0m0xWiRmOq9@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <04066A73B1004044921AF650C55085E1@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=G+Ni7Os5 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=nKnlM8vPjNwglxpXPE8A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA4LzA2LzIyIDAwOjA3LCBBbmRyZXcgTHVubiB3cm90ZToNCj4gT24gVHVlLCBKdW4gMDcs
IDIwMjIgYXQgMDI6NDk6MzZQTSArMDMwMCwgVmFkeW0gS29jaGFuIHdyb3RlOg0KPj4gSGkgQWxs
LA0KPj4NCj4+PiBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUgICAgICAgICAg
fCAgIDEgKw0KPj4+IC4uLi9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS05OGR4MjV4eC5kdHNpICAg
ICB8IDI5NyArKysrKysrKysrKysrKysrKysNCj4+PiAuLi4vYm9vdC9kdHMvbWFydmVsbC9hcm1h
ZGEtOThkeDM1eHgtcmQuZHRzICAgfCAxMDEgKysrKysrDQo+Pj4gLi4uL2Jvb3QvZHRzL21hcnZl
bGwvYXJtYWRhLTk4ZHgzNXh4LmR0c2kgICAgIHwgIDEzICsNCj4+IFRoZXJlIGlzIGEgcHJvcG9z
YWwgZnJvbSB0aGUgTWFydmVsbCB0byByZXBsYWNlICJhcm1hZGEtIiBwcmVmaXggdG8gImFjNS0i
IGluIERUUyBuYW1pbmcgYXMgdGhlcmUNCj4+IGlzIG5vIG11Y2ggY29tbW9uIHdpdGggQXJtYWRh
IFNvQydzLg0KPiBPLksuIFdlIGNhbiBkbyB0aGlzLiBCdXQgaSBob3BlIGl0IGlzIG5vdCBNYXJ2
ZWxsIGJlaW5nIGxhenkuDQo+DQo+IEkgY2FuIGFsc28gc2VlIGFuIGFkdmFudGFnZSBvZiB1c2lu
ZyBhcm1hZGEtLCBzaW5jZSBpdCBtYWtlcyBpdCBjbGVhcg0KPiB3ZSBhcmUgdGFsa2luZyBhYm91
dCBtYWlubGluZSBkZXZpY2UgdHJlZSBmaWxlcywgbm90IE1hcnZlbGwgdmVuZG9yDQo+IGRldmlj
ZSB0cmVlIGZpbGVzLiBJdCBpcyBub3QgZ2l2ZW4gdGhleSB3aWxsIGJlIGNvbXBhdGlibGUuDQoN
CldlJ2xsIHN0aWxsIGhhdmUgdGhlIDk4ZHgyNXh4IHN1ZmZpeGVzIHNvIGl0IHNob3VsZCBzdGls
bCBiZSBkaXN0aW5jdCANCmZyb20gdGhlIE1hcnZlbGwgU0RLIG9uZXMuIEFsc28gaG9wZWZ1bGx5
IG9uY2UgdGhpcyBsYW5kcyB1cHN0cmVhbSBpdCANCndpbGwgZW5jb3VyYWdlIE1hcnZlbGwgdG8g
dXBkYXRlIHRoZWlyIFNESyB0byBhIG5ld2VyIGtlcm5lbC4NCg==
