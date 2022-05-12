Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD50B5241BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiELAzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbiELAy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:54:56 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9A66FAA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:54:55 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2D00F2C019F;
        Thu, 12 May 2022 00:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652316893;
        bh=gFSZc598exmtpiVgaujcTl6mTLXkLYGY2+CfsNXLzfQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=sYHUUzIYyK9gcNWDmHGlcW5VcoLxf6TAgbC2BrYs6zh3CzYMxiOkJrnNU+TPOaeP2
         CnXUfbWKL466zVOVvLfYKoX8h0Z4EQpwyL2TUtfn+1MBThtD3SsfRdrM96bLvPd/I+
         1aOBusGm4mOOwxWngcCKCURCE2ji1JcHnXCyVNS+dixwuAt1gKRRiQZ9C+YotvzLxE
         Xxf6X/sI918Xwx9ZFKs8/Nuoks0M7zRM7HZZeCuMv5qJtfEnuxmdMGb563DiHXfnSn
         QA9OJlmcMZThzMtuqEoj3mpr36XDaRDQu3X+Gk/G33Nbl9G4tMuHu8q7J7WLP1FkvZ
         6MSwvQHwGXzEg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627c5add0001>; Thu, 12 May 2022 12:54:53 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 12 May 2022 12:54:52 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 12 May 2022 12:54:52 +1200
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Thread-Topic: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Thread-Index: AQHYZMMYWG5Tfvy6g0WGHR9i+piz6K0ZHxYAgABn74CAABRpAIAAAzQAgAAB4QCAAAKRgA==
Date:   Thu, 12 May 2022 00:54:52 +0000
Message-ID: <429ac287-04bd-af78-2deb-06426af53ea4@alliedtelesis.co.nz>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
 <YnvsInrh03BVh7lN@lunn.ch>
 <608a7d9d-9238-281a-8770-aa20feb7e6be@alliedtelesis.co.nz>
 <YnxUcB2e+Y9gtwI7@lunn.ch>
 <d9663aa1-e574-f12f-a330-79d984af107e@alliedtelesis.co.nz>
 <YnxYtE9dGn6BwF/8@lunn.ch>
In-Reply-To: <YnxYtE9dGn6BwF/8@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A034A62B5E2C2469FA952FB2E54CCF6@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=5W-Hl1EMTqXFlRFXWI8A:9 a=QEXdDO2ut3YA:10
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

DQpPbiAxMi8wNS8yMiAxMjo0NSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+PiBZZXMgdGhlcmUgYXJl
IHJlZ2lzdGVycyB0aGF0IHlvdSBjYW4gcmVhZCB0byBpZGVudGlmeSB0aGUgc3BlY2lmaWMgY2hp
cC4NCj4+DQo+PiBJdCBzdGlsbCBtaWdodCBiZSB1c2VmdWwgdG8gaGF2ZSBhIGV4cGVjdGVkIHZz
IGFjdHVhbCBjaGVjayBhcyB0aG9zZSBJRA0KPj4gdmFsdWVzIGFyZSBkZXRlcm1pbmVkIGJ5IHBp
biBzdHJhcHBpbmcgcmVzaXN0b3JzLg0KPiBUaGF0IGkgZG9uJ3QgZ2V0PyBDYW4gaSB0dXJuIGEN
Cj4NCj4gKiA5OERYMjUzODogMjR4MUcgKyAyeDEwRyArIDJ4MTBHIFN0YWNrDQo+DQo+IGludG8g
YQ0KPg0KPiAqIDk4RFgyNTM1OiAyNHgxRyArIDR4MUcgU3RhY2sNCj4NCj4gYnkgc3RyYXBwaW5n
IGl0cyBwaW4gZGlmZmVyZW50bHk/DQoNCkknbSBub3Qgc3VyZSBpdCdkIGFjdHVhbGx5IHdvcmsg
cHJvcGVybHkgYnV0IHllcyB0aGVyZSBhcmUgZXh0ZXJuYWwgDQpQVS9QRCByZXNpc3RvcnMgdGhh
dCBpZiB5b3UgZml0dGVkIGRpZmZlcmVudGx5IHdvdWxkIGF0IGxlYXN0IG1ha2UgdGhlIA0KSUQg
c2F5IHRoYXQgYSA5OERYMjUzOCBpcyBhIDk4RFgyNTM1LiBUaGUgSFcgZG9jcyBoYXZlIHRoZXNl
IGFzIA0KInJlc2VydmVkIiBwaW5zIHRoYXQgbXVzdCBiZSBwdWxsZWQgdXAvZG93biBkZXBlbmRp
bmcgb24gdGhlIHNwZWNpZmljIHBhcnQuDQoNCkluIHJlYWxpdHkgSSBzdXNwZWN0IHRoYXQgdGhl
IGRpZmZlcmVudCBzZXJkZXMgYXJyYW5nZW1lbnRzIGFyZSBiYXNlZCBvbiANCndoYXQgbGV2ZWwg
b2Ygc2NyZWVuaW5nIHRoZSBzaWxpY29uIHBhc3NlZCAoc2ltaWxhciB0byBob3cgc29tZSBTb0Mg
DQpzcGVlZCBncmFkZXMgYXJlIGRpc3Rpbmd1aXNoZWQpLiBTbyB5b3UgbWlnaHQgYmUgYWJsZSB0
byBnbyBkb3duIChpLmUuIA0KMjUzOCAtPiAyNTM1KSBidXQgcHJvYmFibHkgbm90IHVwIChpLmUg
MjUzNSAtPiAyNTM4KS4NCg0KPg0KPj4gSXQgY291bGQgYWxzbyBiZSB1c2VkDQo+PiB0byB2YWxp
ZGF0ZSB0aGUgZHRzIChlLmcuIHBvcnQgMjAgd291bGQgYmUgaW52YWxpZCBvbiBhIDk4RFgzNTAx
KS4gQnV0DQo+PiB0aG9zZSBhcmUgY29uc2lkZXJhdGlvbnMgZm9yIGZ1cnRoZXIgZG93biB0aGUg
dHJhY2suDQo+IFllcywgdGhhdCB3b3VsZCBiZSB1cCB0byB0aGUgc3dpdGNoZGV2IGRyaXZlciB0
byB2YWxpZGF0ZSB0aGUgRFQgYmFzZWQNCj4gb24gdGhlIElEIHJlZ2lzdGVyLg0KPg0KPiAgICAg
QW5kcmV3
