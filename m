Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2457A52409A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349061AbiEKXOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349052AbiEKXO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:14:29 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95415169E34
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:14:27 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D45E22C019F;
        Wed, 11 May 2022 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652310865;
        bh=lhBDBNdC4q4BueoOvAmXJxWRfrkV+88cvt5Lnv+rYXg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Zrt5TISWDS2o6h2Su8jMNx4gYfhgqOiJ6T66Obpwb8PeMseAdu+MEkILvIbHlKUpR
         4FQ2kITToHSyM9e3A9YYSUKci1f5FR/BxvvPi0hzieuUzOD1BGfygjuKEefU6msnNd
         /LJ3gqlxaOHa8z5Z2GFcVRz/61nlQSifwvyQdhxSupQCn/dyKFXC8iN4ySWXkAEqp6
         4rrkCJxhXHxiTzc11GOYR1jxyjKPE3eHEsRtGT+mLODISHes7SWq8shbWcVXJvJgsO
         1eaiPgpwmlRmm8O04rSPjArt3usR32wRlmKG0LIlGPum1Qob/ekCvjlh2hA6ACi0XE
         mmGupO3PpBv+A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627c43510001>; Thu, 12 May 2022 11:14:25 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 12 May 2022 11:14:25 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 12 May 2022 11:14:25 +1200
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
Thread-Index: AQHYZMMYWG5Tfvy6g0WGHR9i+piz6K0ZHxYAgABn74A=
Date:   Wed, 11 May 2022 23:14:25 +0000
Message-ID: <608a7d9d-9238-281a-8770-aa20feb7e6be@alliedtelesis.co.nz>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
 <YnvsInrh03BVh7lN@lunn.ch>
In-Reply-To: <YnvsInrh03BVh7lN@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4377FB2D0F00FA439F61BEFBCD15089B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=tq87R11HY904XGWgxJsA:9 a=QEXdDO2ut3YA:10
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

DQpPbiAxMi8wNS8yMiAwNTowMiwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDEx
LCAyMDIyIGF0IDExOjEwOjAwQU0gKzEyMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBEZXNj
cmliZSB0aGUgY29tcGF0aWJsZSBwcm9wZXJ0aWVzIGZvciB0aGUgTWFydmVsbCBBbGxleWNhdDUv
NVggc3dpdGNoZXMNCj4+IHdpdGggaW50ZWdyYXRlZCBDUFVzLg0KPj4NCj4+IEFsbGV5Y2F0NToN
Cj4+ICogOThEWDI1Mzg6IDI0eDFHICsgMngxMEcgKyAyeDEwRyBTdGFjaw0KPj4gKiA5OERYMjUz
NTogMjR4MUcgKyA0eDFHIFN0YWNrDQo+PiAqIDk4RFgyNTMyOiA4eDFHICsgMngxMEcgKyAyeDFH
IFN0YWNrDQo+PiAqIDk4RFgyNTMxOiA4eDFHICsgNHgxRyBTdGFjaw0KPj4gKiA5OERYMjUyODog
MjR4MUcgKyAyeDEwRyArIDJ4MTBHIFN0YWNrDQo+PiAqIDk4RFgyNTI1OiAyNHgxRyArIDR4MUcg
U3RhY2sNCj4+ICogOThEWDI1MjI6IDh4MUcgKyAyeDEwRyArIDJ4MUcgU3RhY2sNCj4+ICogOThE
WDI1MjE6IDh4MUcgKyA0eDFHIFN0YWNrDQo+PiAqIDk4RFgyNTE4OiAyNHgxRyArIDJ4MTBHICsg
MngxMEcgU3RhY2sNCj4+ICogOThEWDI1MTU6IDI0eDFHICsgNHgxRyBTdGFjaw0KPj4gKiA5OERY
MjUxMjogOHgxRyArIDJ4MTBHICsgMngxRyBTdGFjaw0KPj4gKiA5OERYMjUxMTogOHgxRyArIDR4
MUcgU3RhY2sNCj4+DQo+PiBBbGxleWNhdDVYOg0KPj4gKiA5OERYMzUwMDogMjR4MUcgKyA2eDI1
Rw0KPj4gKiA5OERYMzUwMTogMTZ4MUcgKyA2eDEwRw0KPj4gKiA5OERYMzUxMDogNDh4MUcgKyA2
eDI1Rw0KPj4gKiA5OERYMzUyMDogMjR4Mi41RyArIDZ4MjVHDQo+PiAqIDk4RFgzNTMwOiA0OHgy
LjVHICsgNngyNUcNCj4+ICogOThEWDM1NDA6IDEyeDVHLzZ4MTBHICsgNngyNUcNCj4+ICogOThE
WDM1NTA6IDI0eDVHLzEyeDEwRyArIDZ4MjVHDQo+IEhpIENocmlzDQo+DQo+IFdoZW4gbG9va2lu
ZyBhdCB0aGlzIGxpc3QsIGlzIGl0IGp1c3QgdGhlIHN3aXRjaCB3aGljaCBjaGFuZ2VzLCBhbmQN
Cj4gZXZlcnl0aGluZyBlbHNlIGluIHRoZSBwYWNrYWdlIHN0YXlzIHRoZSBzYW1lPw0KDQpDUFUg
d2lzZSBJJ3ZlIGJlZW4gdG9sZCBldmVyeXRoaW5nIGlzIGlkZW50aWNhbC4gVGhlIGRpZmZlcmVu
Y2VzIGFyZSBhbGwgDQppbiB0aGUgc3dpdGNoIHNpZGUuDQoNCj4gSSdtIHRoaW5raW5nIGJhY2sg
dG8gcGxhaW4gS2lya3dvb2QuIFRoZXJlIHdlcmUgMyBLaXJrd29vZCBTb0NzLiBXZQ0KPiBoYWQg
a2lya3dvb2QuZHRzaSB3aGljaCBkZXNjcmliZWQgZXZlcnl0aGluZyBjb21tb24gdG8gYWxsIHRo
cmVlDQo+IFNvQ3MuIEFuZCB0aGVuIGtpcmt3b29kLTYxOTIuZHRzaSwga2lya3dvb2QtNjI4MS5k
dHNpLA0KPiBraXJrd29vZC02MjgyLmR0c2kgd2hpY2ggZXh0ZW5kZWQgdGhhdCBiYXNlIHdpdGgg
d2hhdGV2ZXIgYWRkaXRpb25hbA0KPiB0aGluZ3MgZWFjaCBTb0MgaGFkLg0KPg0KPiBJJ20gd29u
ZGVyaW5nIGlmIHNvbWV0aGluZyBzaW1pbGFyIGlzIG5lZWRlZCBoZXJlPw0KPg0KPiBhcm1hZGEt
OThEWDI1eHguZHRzaSB3aGljaCBkZXNjcmliZXMgZXZlcnl0aGluZyBjb21tb24gdG8gQWxsZXlj
YXQ1Lg0KPg0KPiBhcm1hZGEtOThEWDM1eHguZHRzaSB3aGljaCBkZXNjcmliZXMgZXZlcnl0aGlu
ZyBjb21tb24gdG8gQWxsZXljYXQ1WCwNCj4gbWF5YmUgbWFraW5nIHVzZSBvZiBhcm1hZGEtOThE
WDI1eHguZHRzaT8uDQoNClJpZ2h0IG5vdyB0aGVyZSB3b3VsZCBiZSBubyBkaWZmZXJlbmNlIGJl
dHdlZW4gMjV4eCBhbmQgMzV4eCBidXQgcGVyaGFwcyANCmhhdmluZyBhcm1hZGEtOThEWDM1eHgu
ZHRzaSBqdXN0ICNpbmNsdWRlIGFybWFkYS05OERYMjV4eC5kdHNpIHdvdWxkIA0KbWFrZSB0aGUg
Ym9hcmRzIGFibGUgdG8gcHVsbCBpbiBzb21ldGhpbmcgdGhhdCBtb3JlIG5hdHVyYWxseSBmaXRz
IHRoZSANCmFjdHVhbCBjaGlwIHRoYXQgaXMgdXNlZC4NCg0KPiBhcm1hZGEtOThEWDI1MzguZHRz
aSB3aGljaCBleHRlbmRzIGFybWFkYS05OERYMjV4eC5kdHNpDQoNClRoZXJlIHdvdWxkbid0IGJl
IGFueXRoaW5nIHRvIGFkZCBpbiA5OERYMjUzOCAoYXQgbGVhc3Qgbm90IHVudGlsIHdlIA0KaGF2
ZSBhIHByb3BlciBzd2l0Y2hkZXYgZHJpdmVyKS4NCg0KPiBBbmQgdGhlbiBhIGJvYXJkIGZpbGUg
d2hpY2ggaW5jbHVkZXMgYXJtYWRhLTk4RFgyNTM4LmR0c2kgYW5kIGFkZCB0aGUNCj4gYm9hcmQg
c3BlY2lmaWMgYml0cz8NCj4NCj4gSSd2ZSBubyBpZGVhIGhvdyB0aGVzZSBkaWZmZXJlbnQgZGV2
aWNlcyBkaWZmZXIsIHNvIGkgZG9uJ3Qga25vdyB3aGF0DQo+IHRoZSBjb3JyZWN0IGhpZXJhcmNo
eSBzaG91bGQgYmUuDQoNCklmIHlvdSBwdXQgYXNpZGUgdGhlIHN3aXRjaCBzdHVmZiB0aGV5IGRv
bid0IGRpZmZlciBhdCBhbGwuIFdoaWNoIGlzIGEgDQpiaXQgZGlmZmVyZW50IHRvIHRoZSA5OGR4
MzIzNi85OGR4MzMzNi85OGR4NDI1MSBzdXBwb3J0IEkgYWRkZWQgYSBmZXcgDQp5ZWFycyBhZ28g
d2hlcmUgdGhlcmUgd2VyZSBkaWZmZXJlbmNlcyB3LnIudCBudW1iZXIgb2YgQ1BVIGNvcmVzIGFu
ZCB0aGUgDQpvZGQgcGVyaXBoZXJhbC4NCg0KTXkgbWFpbiBnb2FsIGhhcyBiZWVuIHRvIGdldCB0
aGUgQ1BVIHNpZGUgc3R1ZmYgbGFuZGVkIGZpcnN0LiBJbiB3aGF0IA0KSSd2ZSBzdWJtaXR0ZWQg
c28gZmFyIEkgaGF2ZW4ndCB0cmllZCB0byBpbmNvcnBvcmF0ZSB0aGUgc3dpdGNoIHJlZ2lzdGVy
IA0Kc3BhY2UsIHRoYXQncyB3aGVyZSB5b3UgbWlnaHQgc2VlIHNvbWUgZGlmZmVyZW5jZSBsaWtl
ICdjb21wYXRpYmxlID0gDQoibWFydmVsbCxwcmVzdGVyYS05OGR4MjUzOCIsICJtYXJ2ZWxsLHBy
ZXN0ZXJhIjsnLg0KDQoNCg==
