Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC5952267B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiEJVvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiEJVvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:51:43 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C16E517E3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:51:42 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 400D72C046F;
        Tue, 10 May 2022 21:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652219500;
        bh=cBvSinLe5Zk/AJFgIIikXUlgXVxVp2m/UQR/YawRuxU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bFMk8dFNrZPEJbRJWgXCFnCcN86CNGz36beJqOowRTPNZNDBI8vUJrOiTH/aY7J6X
         0VL5LWKP7bGZCnyxvfmzpvEvf3ohgXLy3dRFtLwLvG1BBrTeMfD2I2TqJZWg6J+b1R
         MfTpoVsAGFu9obQmossG7TGxlpoj4J2jtDTWbgJ4l5ele8uaxM0u0pMHtWwIelgXxd
         bpIsFuOalkDz1g8+yvzQSOfSoOQWsBGtg9jkJ61qfw180203u1IKWsQsX4qURnFm4I
         4kVsrKcwQGYMgJP6Pt6H0mEcTs5UAIcJgh3by4EqTUBD0vePOOM0am7ZuliMdItDnk
         G/Zm/PdtxUEzg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627ade6c0001>; Wed, 11 May 2022 09:51:40 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May 2022 09:51:39 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Wed, 11 May 2022 09:51:39 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYX3HqbCVddS0CWEWMkXLyqck2rq0POn2AgAittYA=
Date:   Tue, 10 May 2022 21:51:39 +0000
Message-ID: <8f6272ce-0d25-3a1e-f71e-66444a94a2d4@alliedtelesis.co.nz>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220504044624.951841-2-chris.packham@alliedtelesis.co.nz>
 <dcc80690-c159-99f8-4686-536b9e87eb69@linaro.org>
In-Reply-To: <dcc80690-c159-99f8-4686-536b9e87eb69@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F219E25187B3064EA53D5932D5CA8077@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7GXNjH+ c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=Zpg9Uwi24b-cIoSFnZQA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA1LzA1LzIyIDIxOjE5LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4gKy8gew0K
Pj4gKwltb2RlbCA9ICJNYXJ2ZWxsIEFDNSBTb0MiOw0KPj4gKwljb21wYXRpYmxlID0gIm1hcnZl
bGwsYWM1IjsNCj4gTWlzc2luZyBib2FyZCBiaW5kaW5ncyBwYXRjaC4NCj4NCldoZXJlIGRvIHRo
ZXNlIHVzdWFsbHkgZW5kIHVwPyBJIGNhbid0IHNlZSBhbnkgb2YgdGhlIG90aGVyIE1hcnZlbGwg
DQpib2FyZHMgaGF2aW5nIGJpbmRpbmdzICh3aGljaCBtaWdodCBiZSB3aHkgeW91J3JlIHRlbGxp
bmcgbWUgbm90IHRvIGFkZCANCm5ldyBib2FyZHMvU29DcyB3aXRob3V0IGl0KS7CoCBUaGVyZSdz
IG9uZSBlbnRyeSBpbiANCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ib2FyZCBi
dXQgdGhhdCBzZWVtcyBtb3JlIHJlbGF0ZWQgdG8gDQpzb21lIGJvYXJkIHNwZWNpZmljIG1pc2Mg
ZGV2aWNlcy4=
