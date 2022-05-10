Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F65522694
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiEJWA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiEJWAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:00:53 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39891CB3F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:00:51 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CE7B82C0538;
        Tue, 10 May 2022 22:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652220047;
        bh=phHLbe8Oyxwe+Av7s89xoak9cOF7wZxvdY/6IMgP9DA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PS5DIVqv8v+6gDDcRLM58PSLzue4awydqpSqSBzuaUwLjInKRKRtrs+cvmeg+QJ5k
         uX+h8n8xCQKH8E+yLcb1DwxCXTdfpYEtFQiXyFc2jw1zab4h2a4pljEXd0UYoICcPY
         Kzbsw5191D9BdYGY1Z78BOIruXGQJp1ORL41wgb+YYa6f6X/lQKeXy5PyTloOlmmeb
         xwJxUvCtEcrzv5tIvtALwMoIwpZ8fxpy18Vyde/RQOTnuRjBhKWZ5sOse2mL6PWgk5
         Y2B+eswshaD4QM0DsD3AlNAjrf1Xo96OxPKX7st0ehUl/DA2m4/sFX0cXCqntPDy2M
         9GTgcrlrKwqmA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627ae08f0001>; Wed, 11 May 2022 10:00:47 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May 2022 10:00:47 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Wed, 11 May 2022 10:00:47 +1200
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
Thread-Index: AQHYX3HqbCVddS0CWEWMkXLyqck2rq0POn2AgAittYCAAAKMAA==
Date:   Tue, 10 May 2022 22:00:46 +0000
Message-ID: <71e28c27-d876-9177-3251-92d0063c4dd6@alliedtelesis.co.nz>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220504044624.951841-2-chris.packham@alliedtelesis.co.nz>
 <dcc80690-c159-99f8-4686-536b9e87eb69@linaro.org>
 <8f6272ce-0d25-3a1e-f71e-66444a94a2d4@alliedtelesis.co.nz>
In-Reply-To: <8f6272ce-0d25-3a1e-f71e-66444a94a2d4@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F1A20137601FA4CAF6598F4E522340D@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7GXNjH+ c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=UhUHEfIMftsWJk1-XO0A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMS8wNS8yMiAwOTo1MSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4NCj4gT24gNS8wNS8y
MiAyMToxOSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiArLyB7DQo+Pj4gK8KgwqDC
oCBtb2RlbCA9ICJNYXJ2ZWxsIEFDNSBTb0MiOw0KPj4+ICvCoMKgwqAgY29tcGF0aWJsZSA9ICJt
YXJ2ZWxsLGFjNSI7DQo+PiBNaXNzaW5nIGJvYXJkIGJpbmRpbmdzIHBhdGNoLg0KPj4NCj4gV2hl
cmUgZG8gdGhlc2UgdXN1YWxseSBlbmQgdXA/IEkgY2FuJ3Qgc2VlIGFueSBvZiB0aGUgb3RoZXIg
TWFydmVsbCANCj4gYm9hcmRzIGhhdmluZyBiaW5kaW5ncyAod2hpY2ggbWlnaHQgYmUgd2h5IHlv
dSdyZSB0ZWxsaW5nIG1lIG5vdCB0byANCj4gYWRkIG5ldyBib2FyZHMvU29DcyB3aXRob3V0IGl0
KS7CoCBUaGVyZSdzIG9uZSBlbnRyeSBpbiANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2JvYXJkIGJ1dCB0aGF0IHNlZW1zIG1vcmUgcmVsYXRlZCB0byANCj4gc29tZSBib2Fy
ZCBzcGVjaWZpYyBtaXNjIGRldmljZXMuDQpBaCBJIGp1c3QgZm91bmQgDQpEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwuIEkgY2Fu
IA0KcHV0IHNvbWV0aGluZyBuZXh0IHRvIHRoYXQu
