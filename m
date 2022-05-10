Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6A520C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiEJEU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiEJEUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:20:01 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23051D5033
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:14:34 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 574222C0781;
        Tue, 10 May 2022 04:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652156072;
        bh=beR9evBBDHwCGXTYqGuejgNhP+joqfGIzTwytCv6kNQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=famXQywzQqBz8alJ9cQNnaZlJTV2te65K6LfE63ekYrKNo2FvNVNCtWhupkraAsod
         wNHxSbJK7jxwA0Ku7zXurqwg/xodK6y/WlJb8TnNLXY8i/cX1m1m5wbfSe6g9azJf9
         ws39wHNXjDVlC9HSW9nLZZAaj6tC9qYoEYczHTIY41hoy7Hbn+Ay77qP6V6tDIk2pv
         r1u6Nuh70SFQ1hHLvK6aYNIFJsDKSzUc5U3+0GfprmPOr9QmYx3YIwJMkpr/UoafHo
         p465vw0dTEI8VE86bGLdF9GUVtEB2X3fyOZb+T0gyxv1oi2atwcIDupZW2tJEcJOSH
         /DsNNY4qlOfGA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6279e6a80001>; Tue, 10 May 2022 16:14:32 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 10 May 2022 16:14:31 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Tue, 10 May 2022 16:14:31 +1200
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
Thread-Index: AQHYX3HqbCVddS0CWEWMkXLyqck2rq0POn2AgAeGWYA=
Date:   Tue, 10 May 2022 04:14:31 +0000
Message-ID: <6770d320-b998-0c9d-3824-0d429834b289@alliedtelesis.co.nz>
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
Content-ID: <FF4C3F1620A2824CB79752A08CC827C1@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7GXNjH+ c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=KV0xaAgqlUJaG30mGBAA:9 a=QEXdDO2ut3YA:10
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

KHJlc2VuZCB3aXRob3V0IHRoZSBodG1sKQ0KDQoNCk9uIDUvMDUvMjIgMjE6MTksIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+PiArCWNvcmVfY2xvY2s6IGNvcmVfY2xvY2sgew0KPiBObyB1
bmRlcnNjb3JlcyBpbiBub2RlIG5hbWVzLg0KPg0KPiBBbGwgdGhlc2UgY2xvY2tzIGRvIG5vdCBs
b29rIGxpa2UgcmVhbCBjbG9ja3MuIFdoZXJlIGFyZSB0aGV5IGlmIG91dHNpZGUNCj4gb2YgU29D
PyBUaGVzZSBzaG91bGQgYmUgZmVkIGZyb20gY2xvY2sgY29udHJvbGxlcnMsIHNob3VsZG4ndCB0
aGV5PyBJZg0KPiB0aGV5IGFyZSBwcm92aWRlZCBieSBib2FyZHMsIGRvbid0IHB1dCB0aGVtIGlu
dG8gU29DLi4uDQo+DQo+PiArCQljb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4+ICsJCSNj
bG9jay1jZWxscyA9IDwwPjsNCj4+ICsJCWNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDAwMDA+Ow0K
Pj4gKwl9Ow0KPj4gKw0KPj4gKwlheGlfY2xvY2s6IGF4aV9jbG9jayB7DQo+PiArCQljb21wYXRp
YmxlID0gImZpeGVkLWNsb2NrIjsNCj4+ICsJCSNjbG9jay1jZWxscyA9IDwwPjsNCj4+ICsJCWNs
b2NrLWZyZXF1ZW5jeSA9IDwzMjUwMDAwMDA+Ow0KPj4gKwl9Ow0KPj4gKw0KPj4gKwlzcGlfY2xv
Y2s6IHNwaV9jbG9jayB7DQo+PiArCQljb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4+ICsJ
CSNjbG9jay1jZWxscyA9IDwwPjsNCj4+ICsJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyMDAwMDAwMDA+
Ow0KPj4gKwl9Ow0KDQpCYXNlZCBvbiB0aGUgaW5mb3JtYXRpb24gSSBoYXZlICh3aGljaCBpc24n
dCBtdWNoKSB0aGVyZSBpcyBhIHJlZl9jbGsgDQppbnB1dCB0aGF0IGlzIGNvbm5lY3RlZCB0byBh
IDI1TUh6IG9zY2lsbGF0b3IgYW5kIHRoZW4gSSdtIGFzc3VtaW5nIA0KdGhlc2UgYXJlIGFsbCBn
ZW5lcmF0ZWQgZnJvbSB0aGF0IHdpdGggdmFyaW91cyBkaXZpZGVycy4gMjVNSHogaXMgdGhlIA0K
b25seSBkb2N1bWVudGVkIG9wdGlvbi4NCg0KVGhlcmUgZG9lc24ndCBhcHBlYXIgdG8gYmUgYW55
IGRvY3VtZW50ZWQgcmVnaXN0ZXIgd2hlcmUgSSBjYW4gcmVhZCBvdXQgDQp0aGUgZGl2aWRlciBy
YXRpb3MuIEl0IG1pZ2h0IGJlIG5pY2UgSSBjb3VsZCBoYXZlIHRoZSBmaXhlZCBvc2Mgbm9kZSBh
bmQgDQpoYXZlIHRoZXNlIDMgY2xvY2tzIGRlcml2ZWQgd2l0aCBmaXhlZCBkaXZpc29ycyBidXQg
SSBkb24ndCBzZWUgYW55IHdoYXQgDQpvZiBhY2hpZXZpbmcgdGhhdC4NCg0K
