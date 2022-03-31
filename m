Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4394EE25E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbiCaULy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiCaULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:11:52 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F615878F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:10:01 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 508742C083D;
        Thu, 31 Mar 2022 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648757399;
        bh=utd02a39MmCn6qH4iX7GZxU1nY5TtqGsKh1ad7CyZX0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=nMRpTMP6Jx9ms1Rcr+A01DgLNAcuffRwg9jQ6ijDwaiB2Vo4tlRBWVDjM7gM51Bnc
         2jqIsc+GRs67oqMpOwOb/M/zo10Q7FYQxqYlCBqiBSPcKEgFYS+iU3X9abGmd/wE13
         BKK7xHpAH3vrStp9Jf86DWgRHAJ1EnTZ/w/0IV1hFg7Izm93c+jYYsJBY25DLpHZWz
         sKZBKdQNkBqK5reUQ5BFfOoUZNS6TtmM0OZaONT2iZVWIOYK4rv0u2Kkqp8limbFnI
         ZZWlaECNIwIm17YP1OFWhPpq+ncuNAgwA/21z7auCENXTD/rH2xqv8Mu5Qy94Jjpkv
         0WdruDW6pC5gA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62460a970001>; Fri, 01 Apr 2022 09:09:59 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 1 Apr 2022 09:09:59 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 1 Apr 2022 09:09:59 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "huziji@marvell.com" <huziji@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Thread-Topic: [PATCH v4 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Thread-Index: AQHYQwBQxHzoaq5k202Ou7T2PLN3cqzVZnGAgAAXboCAAG7SgIABO5GAgAHuZgA=
Date:   Thu, 31 Mar 2022 20:09:58 +0000
Message-ID: <8d24fdee-1538-68bf-f4b8-1e07d3ba5b75@alliedtelesis.co.nz>
References: <20220329000231.3544810-1-chris.packham@alliedtelesis.co.nz>
 <20220329000231.3544810-3-chris.packham@alliedtelesis.co.nz>
 <1648554629.870840.350362.nullmailer@robh.at.kernel.org>
 <d4c477b3-0cf2-e495-6a54-5fcd0301cc14@kernel.org>
 <6e118704-3c63-929e-ebf0-9a78fbed5daa@alliedtelesis.co.nz>
 <YkRr22lQHKCZa5A2@robh.at.kernel.org>
In-Reply-To: <YkRr22lQHKCZa5A2@robh.at.kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0630ACFD8453E448A56EA08445E6D350@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=JcrCUnCV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=z0gMJWrwH1QA:10 a=VwQbUJbxAAAA:8 a=UkoVw5r5gxAZN7hNCIAA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
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

SGkgUm9iLA0KDQpPbiAzMS8wMy8yMiAwMzo0MCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFR1
ZSwgTWFyIDI5LCAyMDIyIGF0IDA3OjUwOjU5UE0gKzAwMDAsIENocmlzIFBhY2toYW0gd3JvdGU6
DQo+PiBPbiAzMC8wMy8yMiAwMjoxNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBP
biAyOS8wMy8yMDIyIDEzOjUwLCBSb2IgSGVycmluZyB3cm90ZToNCj4+Pj4gT24gVHVlLCAyOSBN
YXIgMjAyMiAxMzowMjozMSArMTMwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+Pj4+IENvbnZl
cnQgdGhlIG1hcnZlbGwseGVub24tc2RoY2kgYmluZGluZyB0byBKU09OIHNjaGVtYS4gQ3VycmVu
dGx5IHRoZQ0KPj4+Pj4gaW4tdHJlZSBkdHMgZmlsZXMgZG9uJ3QgdmFsaWRhdGUgYmVjYXVzZSB0
aGV5IHVzZSBzZGhjaUAgaW5zdGVhZCBvZiBtbWNADQo+Pj4+PiBhcyByZXF1aXJlZCBieSB0aGUg
Z2VuZXJpYyBtbWMtY29udHJvbGxlciBzY2hlbWEuDQo+Pj4+Pg0KPj4+Pj4gVGhlIGNvbXBhdGli
bGUgIm1hcnZlbGwsc2RoY2kteGVub24iIHdhcyBub3QgZG9jdW1lbnRlZCBpbiB0aGUgb2xkDQo+
Pj4+PiBiaW5kaW5nIGJ1dCBpdCBhY2NvbXBhbmllcyB0aGUgb2YgIm1hcnZlbGwsYXJtYWRhLTM3
MDAtc2RoY2kiIGluIHRoZQ0KPj4+Pj4gYXJtYWRhLTM3eHggU29DIGR0c2kgc28gdGhpcyBjb21i
aW5hdGlvbiBpcyBhZGRlZCB0byB0aGUgbmV3IGJpbmRpbmcNCj4+Pj4+IGRvY3VtZW50Lg0KPj4+
Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxs
aWVkdGVsZXNpcy5jby5uej4NCj4+Pj4+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+Pj4+PiAtLS0NCj4+Pj4+DQo+Pj4+PiBOb3RlczoNCj4+Pj4+
ICAgICAgIENoYW5nZXMgaW4gdjQ6DQo+Pj4+PiAgICAgICAtIEFkZCByZXZpZXcgZnJvbSBLcnp5
c3p0b2YNCj4+Pj4+ICAgICAgIC0gU3F1YXNoIGluIGFkZGl0aW9uIG9mIG1hcnZlbGwsc2RoY2kt
eGVub24gd2l0aCBhbiBleHBsYW5hdGlvbiBpbiB0aGUNCj4+Pj4+ICAgICAgICAgY29tbWl0IG1l
c3NhZ2UNCj4+Pj4+ICAgICAgIENoYW5nZXMgaW4gdjM6DQo+Pj4+PiAgICAgICAtIERvbid0IGFj
Y2VwdCBhcDgwNyB3aXRob3V0IGFwODA2DQo+Pj4+PiAgICAgICAtIEFkZCByZWY6IHN0cmluZyBm
b3IgcGFkLXR5cGUNCj4+Pj4+ICAgICAgIENoYW5nZXMgaW4gdjI6DQo+Pj4+PiAgICAgICAtIFVw
ZGF0ZSBNQUlOVEFJTkVSUyBlbnRyeQ0KPj4+Pj4gICAgICAgLSBJbmNvcnBvcmF0ZSBmZWVkYmFj
ayBmcm9tIEtyenlzenRvZg0KPj4+Pj4NCj4+Pj4+ICAgIC4uLi9iaW5kaW5ncy9tbWMvbWFydmVs
bCx4ZW5vbi1zZGhjaS50eHQgICAgICB8IDE3MyAtLS0tLS0tLS0tLQ0KPj4+Pj4gICAgLi4uL2Jp
bmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnlhbWwgICAgIHwgMjc1ICsrKysrKysrKysr
KysrKysrKw0KPj4+Pj4gICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAyICstDQo+Pj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDI3NiBpbnNlcnRpb25z
KCspLCAxNzQgZGVsZXRpb25zKC0pDQo+Pj4+PiAgICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnR4dA0K
Pj4+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tbWMvbWFydmVsbCx4ZW5vbi1zZGhjaS55YW1sDQo+Pj4+Pg0KPj4+PiBNeSBib3QgZm91
bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0tbSBkdF9iaW5kaW5nX2No
ZWNrJw0KPj4+PiBvbiB5b3VyIHBhdGNoIChEVF9DSEVDS0VSX0ZMQUdTIGlzIG5ldyBpbiB2NS4x
Myk6DQo+Pj4+DQo+Pj4+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4+Pj4NCj4+Pj4gZHRz
Y2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4+Pj4gL2J1aWxkcy9yb2JoZXJyaW5nL2xpbnV4
LWR0LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21hcnZlbGws
eGVub24tc2RoY2kuZXhhbXBsZS5kdC55YW1sOiBtbWNAYWEwMDAwOiBjb21wYXRpYmxlOiAnb25l
T2YnIGNvbmRpdGlvbmFsIGZhaWxlZCwgb25lIG11c3QgYmUgZml4ZWQ6DQo+Pj4+IAlbJ21hcnZl
bGwsYXJtYWRhLTM3MDAtc2RoY2knXSBpcyB0b28gc2hvcnQNCj4+Pj4gCSdtYXJ2ZWxsLGFybWFk
YS0zNzAwLXNkaGNpJyBpcyBub3Qgb25lIG9mIFsnbWFydmVsbCxhcm1hZGEtY3AxMTAtc2RoY2kn
LCAnbWFydmVsbCxhcm1hZGEtYXA4MDYtc2RoY2knXQ0KPj4+PiAJJ21hcnZlbGwsYXJtYWRhLWFw
ODA3LXNkaGNpJyB3YXMgZXhwZWN0ZWQNCj4+Pj4gCUZyb20gc2NoZW1hOiAvYnVpbGRzL3JvYmhl
cnJpbmcvbGludXgtZHQtcmV2aWV3L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvbWFydmVsbCx4ZW5vbi1zZGhjaS55YW1sDQo+Pj4+IC9idWlsZHMvcm9iaGVycmluZy9saW51
eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tYXJ2ZWxs
LHhlbm9uLXNkaGNpLmV4YW1wbGUuZHQueWFtbDogbW1jQGFiMDAwMDogY29tcGF0aWJsZTogJ29u
ZU9mJyBjb25kaXRpb25hbCBmYWlsZWQsIG9uZSBtdXN0IGJlIGZpeGVkOg0KPj4+PiAJWydtYXJ2
ZWxsLGFybWFkYS0zNzAwLXNkaGNpJ10gaXMgdG9vIHNob3J0DQo+Pj4+IAknbWFydmVsbCxhcm1h
ZGEtMzcwMC1zZGhjaScgaXMgbm90IG9uZSBvZiBbJ21hcnZlbGwsYXJtYWRhLWNwMTEwLXNkaGNp
JywgJ21hcnZlbGwsYXJtYWRhLWFwODA2LXNkaGNpJ10NCj4+Pj4gCSdtYXJ2ZWxsLGFybWFkYS1h
cDgwNy1zZGhjaScgd2FzIGV4cGVjdGVkDQo+Pj4+IAlGcm9tIHNjaGVtYTogL2J1aWxkcy9yb2Jo
ZXJyaW5nL2xpbnV4LWR0LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bW1jL21hcnZlbGwseGVub24tc2RoY2kueWFtbA0KPj4+Pg0KPj4+PiBkb2MgcmVmZXJlbmNlIGVy
cm9ycyAobWFrZSByZWZjaGVja2RvY3MpOg0KPj4+IENocmlzLCB5b3VyIG93biBkdCBiaW5kaW5n
IGRvZXMgbm90IHBhc3MgaXQncyBjaGVjayAoZXhhbXBsZSkuLi4NCj4+Pg0KPj4+IEFmdGVyIHVw
ZGF0aW5nIHRoZSBjb21wYXRpYmxlcywgeW91IG5lZWQgdG8gY2hlY2sgdGhlIGV4YW1wbGUuIFRo
ZQ0KPj4+IGV4YW1wbGVzIGFyZSBhbnl3YXkgZHVwbGljYXRpbmcgY29tbW9uIHN0dWZmLCBzbyBo
YWxmIG9mIHRoZW0gY291bGQgYmUNCj4+PiByZW1vdmVkLg0KPj4gWWVhaCBzaWxseSBtZS4gSSBz
dGFydGVkIHRha2luZyBzaG9ydCBjdXRzIHRvIHJ1biBkdF9iaW5kaW5nX2NoZWNrDQo+PiBkdGJz
X2NoZWNrIGFzIG9uZSBjb21tYW5kIGJ1dCB0aGVuIHRoZSBkdF9iaW5kaW5nc19jaGVjayBvdXRw
dXQgc2Nyb2xsZWQNCj4+IG9mZiB0aGUgdG9wIG9mIG15IHRlcm1pbmFsLg0KPj4NCj4+IEFzIGZv
ciB0aGUgZXhhbXBsZXMgdGhlbXNlbHZlcyBJIHdhbnQgdG8gbGVhdmUgd2hhdCdzIHRoZXJlIGFz
IGEgZmFpcmx5DQo+PiBkaXJlY3QgdHJhbnNsYXRpb24gb2YgdGhlIG9sZCBiaW5kaW5nLiBJZiB3
ZSBjb25zaWRlciB0aGVtIHVubmVjZXNzYXJ5DQo+PiByZW1vdmluZyB0aGVtIGNhbiBiZSBkb25l
IGFzIGEgZm9sbG93LXVwLg0KPiBUaGUgZXhhbXBsZXMgY2Fubm90IGhhdmUgd2FybmluZ3MvZXJy
b3JzLg0KSSB3YXMgcmVmZXJyaW5nIHRvIHRoZSBjb21tZW50IG9mIHJlbW92aW5nIGV4YW1wbGVz
LiBUaGUgdjUgb2YgdGhpcyANCnNlcmllcyBhZGRyZXNzZWQgdGhlIGVycm9yIGluIHRoZSBleGFt
cGxlLg0KPiBSb2I=
