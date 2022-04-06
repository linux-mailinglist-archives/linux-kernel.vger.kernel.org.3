Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6254F6E88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiDFXbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiDFXbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:31:10 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B8AE08A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:29:10 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1117D2C049B;
        Wed,  6 Apr 2022 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1649287747;
        bh=NrO2io1fNu1Dq8zpirtPjO6hL23Fu+tHPwckAyQiG08=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iGRDeniEgJUECQLt1v2BwyW3LpdMib6/Gv8bkjBdMC5vCcwl+5XhHjT6KX+FzaFpl
         Gm17x/GQRPwcojWHAu3fptRbZK9Q6bPo67MY/OI94/J3c4/kFvJCMd4ADIwZpk30Iw
         qCt+qhAjcEaLARKiQ5imvUN0IS6UQ7PNSC5IitjRg54l6MW1AogorlV4xvJG2Wbqxc
         UK/fFvyQprod7N0457VBe3HEFwrDH1phijCuC1DYhDNHCbt63+08bwZEGko4nYbVGl
         kz4AMPGfyxrVOYa8oC8rqUI0NCL9N6pn6q0OfeTyxTYoSvZJIfHiyBjmyK1goed8I5
         RpziR8zTtrGQA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B624e22420001>; Thu, 07 Apr 2022 11:29:07 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 11:29:07 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 7 Apr 2022 11:29:07 +1200
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
Subject: Re: [PATCH v3 3/4] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v3 3/4] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYSWWOuxqfse0Zo02heMaoBUB4aazivr6AgAABfgA=
Date:   Wed, 6 Apr 2022 23:29:06 +0000
Message-ID: <645fbdd4-99d1-90e3-04f1-a88be135c1d7@alliedtelesis.co.nz>
References: <20220406032158.1449049-1-chris.packham@alliedtelesis.co.nz>
 <20220406032158.1449049-4-chris.packham@alliedtelesis.co.nz>
 <Yk4g/ShFxNsCM8JR@lunn.ch>
In-Reply-To: <Yk4g/ShFxNsCM8JR@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <33ADC5EBA68A9240BCB38A53C866EA86@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=JcrCUnCV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=z0gMJWrwH1QA:10 a=Cj5Alfpt04uwt4QH35QA:9 a=QEXdDO2ut3YA:10
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

DQpPbiA3LzA0LzIyIDExOjIzLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gT24gV2VkLCBBcHIgMDYs
IDIwMjIgYXQgMDM6MjE6NTdQTSArMTIwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IFRoZSA5
OERYMjUzMCBTb0MgaXMgdGhlIENvbnRyb2wgYW5kIE1hbmFnZW1lbnQgQ1BVIGludGVncmF0ZWQg
aW50bw0KPj4gdGhlIE1hcnZlbGwgOThEWDI1eHggYW5kIDk4RFgzNXh4IHNlcmllcyBvZiBzd2l0
Y2ggY2hpcCAoaW50ZXJuYWxseQ0KPj4gcmVmZXJyZWQgdG8gYXMgQWxsZXlDYXQ1IGFuZCBBbGxl
eUNhdDVYKS4NCj4+DQo+PiBUaGVzZSBmaWxlcyBoYXZlIGJlZW4gdGFrZW4gZnJvbSB0aGUgTWFy
dmVsbCBTREsgYW5kIGxpZ2h0bHkgY2xlYW5lZA0KPj4gdXAgd2l0aCB0aGUgTGljZW5zZSBhbmQg
Y29weXJpZ2h0IHJldGFpbmVkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0g
PGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+ICsmZXRoMCB7DQo+PiArCXN0
YXR1cyA9ICJva2F5IjsNCj4+ICsJcGh5ID0gPCZwaHkwPjsNCj4gVGhpcyBpcyBPLkssIGJ1dCBt
b3N0IERUIGZpbGVzIG5vdyB1c2UgcGh5LWhhbmRsZSwgbm90IHBoeS4NCkknbGwgdXBkYXRlIHRv
IHBoeS1oYW5kbGUgZm9yIHY0DQo+DQo+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+DQo+ICAgICAgQW5kcmV3
