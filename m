Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0532A52419F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349719AbiELAjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiELAjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:39:05 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D223166C89
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:38:59 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 69AEE2C0184;
        Thu, 12 May 2022 00:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652315937;
        bh=44qKdZ5IbRae6ZHizTaAjO+S5j+7XqQaA6XQHAP1Nc4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mqVvTL0u0g6RUHW9033wC7aNznZsTNbXmNcJY6kL9g+n8r6wW+39ow0xHHeRZGYFi
         3j0rwbW7l+GYiLPagOVXXFcCsprLPkCrT08S5wqGB2JWtKfXSX5H8jsMQpV8u6oMQv
         THAWIitckqjOShibtmn2Ci7OMNWkf21oVcVCgp8KDGEdLwpUMnisvl7WHOQJWLZKpQ
         KwMql6ACep6zTIOdIRoQsnOMv362F+ShmKoSWkWQV5ZiWc51CS0kbgohJ3bUg18yXo
         mjlW54UTj3pIGgZCkIjEdtqv25IGt78QjgI7dZbfzi1SMD8NnAyQcpa+MslJBo02L9
         pROG9doOTu61w==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627c57210001>; Thu, 12 May 2022 12:38:57 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 12 May 2022 12:38:57 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 12 May 2022 12:38:57 +1200
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
Thread-Index: AQHYZMMYWG5Tfvy6g0WGHR9i+piz6K0ZHxYAgABn74CAABRpAIAAAzQA
Date:   Thu, 12 May 2022 00:38:56 +0000
Message-ID: <d9663aa1-e574-f12f-a330-79d984af107e@alliedtelesis.co.nz>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
 <YnvsInrh03BVh7lN@lunn.ch>
 <608a7d9d-9238-281a-8770-aa20feb7e6be@alliedtelesis.co.nz>
 <YnxUcB2e+Y9gtwI7@lunn.ch>
In-Reply-To: <YnxUcB2e+Y9gtwI7@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B23BDB1AA2629468C6B7A20622F89AE@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=9s5BO7W635n2Z5SboxQA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wNS8yMiAxMjoyNywgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDEx
LCAyMDIyIGF0IDExOjE0OjI1UE0gKzAwMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBPbiAx
Mi8wNS8yMiAwNTowMiwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4gT24gV2VkLCBNYXkgMTEsIDIw
MjIgYXQgMTE6MTA6MDBBTSArMTIwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+Pj4gRGVzY3Jp
YmUgdGhlIGNvbXBhdGlibGUgcHJvcGVydGllcyBmb3IgdGhlIE1hcnZlbGwgQWxsZXljYXQ1LzVY
IHN3aXRjaGVzDQo+Pj4+IHdpdGggaW50ZWdyYXRlZCBDUFVzLg0KPj4+Pg0KPj4+PiBBbGxleWNh
dDU6DQo+Pj4+ICogOThEWDI1Mzg6IDI0eDFHICsgMngxMEcgKyAyeDEwRyBTdGFjaw0KPj4+PiAq
IDk4RFgyNTM1OiAyNHgxRyArIDR4MUcgU3RhY2sNCj4+Pj4gKiA5OERYMjUzMjogOHgxRyArIDJ4
MTBHICsgMngxRyBTdGFjaw0KPj4+PiAqIDk4RFgyNTMxOiA4eDFHICsgNHgxRyBTdGFjaw0KPj4+
PiAqIDk4RFgyNTI4OiAyNHgxRyArIDJ4MTBHICsgMngxMEcgU3RhY2sNCj4+Pj4gKiA5OERYMjUy
NTogMjR4MUcgKyA0eDFHIFN0YWNrDQo+Pj4+ICogOThEWDI1MjI6IDh4MUcgKyAyeDEwRyArIDJ4
MUcgU3RhY2sNCj4+Pj4gKiA5OERYMjUyMTogOHgxRyArIDR4MUcgU3RhY2sNCj4+Pj4gKiA5OERY
MjUxODogMjR4MUcgKyAyeDEwRyArIDJ4MTBHIFN0YWNrDQo+Pj4+ICogOThEWDI1MTU6IDI0eDFH
ICsgNHgxRyBTdGFjaw0KPj4+PiAqIDk4RFgyNTEyOiA4eDFHICsgMngxMEcgKyAyeDFHIFN0YWNr
DQo+Pj4+ICogOThEWDI1MTE6IDh4MUcgKyA0eDFHIFN0YWNrDQo+Pj4+DQo+Pj4+IEFsbGV5Y2F0
NVg6DQo+Pj4+ICogOThEWDM1MDA6IDI0eDFHICsgNngyNUcNCj4+Pj4gKiA5OERYMzUwMTogMTZ4
MUcgKyA2eDEwRw0KPj4+PiAqIDk4RFgzNTEwOiA0OHgxRyArIDZ4MjVHDQo+Pj4+ICogOThEWDM1
MjA6IDI0eDIuNUcgKyA2eDI1Rw0KPj4+PiAqIDk4RFgzNTMwOiA0OHgyLjVHICsgNngyNUcNCj4+
Pj4gKiA5OERYMzU0MDogMTJ4NUcvNngxMEcgKyA2eDI1Rw0KPj4+PiAqIDk4RFgzNTUwOiAyNHg1
Ry8xMngxMEcgKyA2eDI1Rw0KPj4+IEhpIENocmlzDQo+Pj4NCj4+PiBXaGVuIGxvb2tpbmcgYXQg
dGhpcyBsaXN0LCBpcyBpdCBqdXN0IHRoZSBzd2l0Y2ggd2hpY2ggY2hhbmdlcywgYW5kDQo+Pj4g
ZXZlcnl0aGluZyBlbHNlIGluIHRoZSBwYWNrYWdlIHN0YXlzIHRoZSBzYW1lPw0KPj4gQ1BVIHdp
c2UgSSd2ZSBiZWVuIHRvbGQgZXZlcnl0aGluZyBpcyBpZGVudGljYWwuIFRoZSBkaWZmZXJlbmNl
cyBhcmUgYWxsDQo+PiBpbiB0aGUgc3dpdGNoIHNpZGUuDQo+IE8uSy4gVGhhdCBoZWxwcyBhIGxv
dCB3aXRoIHRoaXMgZGVzY3JpcHRpb24uDQo+DQo+Pj4gYXJtYWRhLTk4RFgyNTM4LmR0c2kgd2hp
Y2ggZXh0ZW5kcyBhcm1hZGEtOThEWDI1eHguZHRzaQ0KPj4gVGhlcmUgd291bGRuJ3QgYmUgYW55
dGhpbmcgdG8gYWRkIGluIDk4RFgyNTM4IChhdCBsZWFzdCBub3QgdW50aWwgd2UNCj4+IGhhdmUg
YSBwcm9wZXIgc3dpdGNoZGV2IGRyaXZlcikuDQo+IERvZXMgdGhlIHN3aXRjaC9Tb0MgaGF2ZSBJ
RCByZWdpc3RlcnM/IEZvciBtdjg4ZTZ4eHgsIHRoZSBzd2l0Y2ggaXMNCj4gaWRlbnRpZmllZCBi
eSBpdHMgSUQgcmVnaXN0ZXJzLCBzbyB3ZSBkb24ndCBoYXZlIHN3aXRjaCBzcGVjaWZpYw0KPiBj
b21wYXRpYmxlIHZhbHVlIGluIERULiBIb3BlZnVsbHkgaXQgaXMgdGhlIHNhbWUgaGVyZS4gQWxs
IHdlIG5lZWQgdG8NCj4gc2F5IGlzIHRoYXQgdGhlcmUgaXMgYSBzd2l0Y2ggaW4gdGhlIG1haW4g
LmR0c2kgZmlsZSwgYW5kIHRoZSAuZHRzDQo+IGZpbGUgd291bGQgdGhlbiBpbmRpY2F0ZSB3aGlj
aCBwb3J0cyBhcmUgYWN0dWFsbHkgdXNlZC4NCg0KWWVzIHRoZXJlIGFyZSByZWdpc3RlcnMgdGhh
dCB5b3UgY2FuIHJlYWQgdG8gaWRlbnRpZnkgdGhlIHNwZWNpZmljIGNoaXAuDQoNCkl0IHN0aWxs
IG1pZ2h0IGJlIHVzZWZ1bCB0byBoYXZlIGEgZXhwZWN0ZWQgdnMgYWN0dWFsIGNoZWNrIGFzIHRo
b3NlIElEIA0KdmFsdWVzIGFyZSBkZXRlcm1pbmVkIGJ5IHBpbiBzdHJhcHBpbmcgcmVzaXN0b3Jz
LiBJdCBjb3VsZCBhbHNvIGJlIHVzZWQgDQp0byB2YWxpZGF0ZSB0aGUgZHRzIChlLmcuIHBvcnQg
MjAgd291bGQgYmUgaW52YWxpZCBvbiBhIDk4RFgzNTAxKS4gQnV0IA0KdGhvc2UgYXJlIGNvbnNp
ZGVyYXRpb25zIGZvciBmdXJ0aGVyIGRvd24gdGhlIHRyYWNrLg0KDQo+ICAgICBBbmRyZXc=
