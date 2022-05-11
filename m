Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB37524135
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349484AbiEKXt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349476AbiEKXt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:49:28 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E8BCE83
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:49:23 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AA16C2C019F;
        Wed, 11 May 2022 23:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652312961;
        bh=5oOkVRtUAA65pYcC1RRf/J7mW/3UA4pOKZcT+ZG6SNk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=0gW3zQxVvcoDhYe7bqDP9W31CLPjpgzwPCHcsVfIa1VnEyNx9+j0U+9eLmbT37bxh
         luCsLwMk2ytJQh+bsoI23DzpGR+KU7f4IWx4wURKcRPgsKlUOGBdCm2seB3tlJVo7u
         opUcLlhAIhkKFNNVXdYU4kt4aB0/jAlQa6NAZ7vGoNvZTmGjHUyj+6QtDSs8osk4ad
         2ILMMgJE5Jqf3R1iIJkDkyG3B8u+szz7fV8wqr4BXv8a1p71qjCQYG/Yp/TVTl8ALK
         UEl/+qa6yKfIB7YUzpVwps3zx8GGXBX947NlCdQjDkm5B1qWLwjlMdaxJnFh3GHD2z
         FvrXUnLrZoM1A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627c4b810001>; Thu, 12 May 2022 11:49:21 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 12 May 2022 11:49:21 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 12 May 2022 11:49:21 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        Vadym Kochan <vadym.kochan@plvision.eu>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v6 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYZMMYMz1sTzZOAUq8a13JJQhu+q0ZGHAAgAB4VgA=
Date:   Wed, 11 May 2022 23:49:21 +0000
Message-ID: <48c5ce46-906b-3aaa-afcc-8d0eafbd098c@alliedtelesis.co.nz>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-3-chris.packham@alliedtelesis.co.nz>
 <1372f51c-0158-dbe3-a0bf-aeeb83f4fec3@linaro.org>
In-Reply-To: <1372f51c-0158-dbe3-a0bf-aeeb83f4fec3@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A7B69A47838BF43B75CFA19BD4C517D@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EPW-fjKtu9av83L7MeYA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
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

DQpPbiAxMi8wNS8yMiAwNDozOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTEv
MDUvMjAyMiAwMToxMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IFRoZSA5OERYMjUzMCBTb0Mg
aXMgdGhlIENvbnRyb2wgYW5kIE1hbmFnZW1lbnQgQ1BVIGludGVncmF0ZWQgaW50bw0KPj4gdGhl
IE1hcnZlbGwgOThEWDI1eHggYW5kIDk4RFgzNXh4IHNlcmllcyBvZiBzd2l0Y2ggY2hpcCAoaW50
ZXJuYWxseQ0KPj4gcmVmZXJyZWQgdG8gYXMgQWxsZXlDYXQ1IGFuZCBBbGxleUNhdDVYKS4NCj4+
DQo+PiBUaGVzZSBmaWxlcyBoYXZlIGJlZW4gdGFrZW4gZnJvbSB0aGUgTWFydmVsbCBTREsgYW5k
IGxpZ2h0bHkgY2xlYW5lZA0KPj4gdXAgd2l0aCB0aGUgTGljZW5zZSBhbmQgY29weXJpZ2h0IHJl
dGFpbmVkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2to
YW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5k
cmV3QGx1bm4uY2g+DQo+PiAtLS0NCj4+DQo+PiBOb3RlczoNCj4+ICAgICAgVGhlIE1hcnZlbGwg
U0RLIGhhcyBhIG51bWJlciBvZiBuZXcgY29tcGF0aWJsZSBzdHJpbmdzLiBJJ3ZlIGJyb3VnaHQN
Cj4+ICAgICAgdGhyb3VnaCBzb21lIG9mIHRoZSBkcml2ZXJzIG9yIHdoZXJlIHBvc3NpYmxlIHVz
ZWQgYW4gaW4tdHJlZQ0KPj4gICAgICBhbHRlcm5hdGl2ZSAoZS5nLiB0aGVyZSBpcyBTREsgY29k
ZSBmb3IgYSBhYzUtZ3BpbyBidXQgdHdvIGluc3RhbmNlcyBvZg0KPj4gICAgICB0aGUgZXhpc3Rp
bmcgbWFydmVsbCxvcmlvbi1ncGlvIHNlZW1zIHRvIGNvdmVyIHdoYXQgaXMgbmVlZGVkIGlmIHlv
dSB1c2UNCj4+ICAgICAgYW4gYXBwcm9wcmlhdGUgYmluZGluZykuIEkgZXhwZWN0IHRoYXQgdGhl
cmUgd2lsbCBhIG5ldyBzZXJpZXMgb2YNCj4+ICAgICAgcGF0Y2hlcyB3aGVuIEkgZ2V0IHNvbWUg
ZGlmZmVyZW50IGhhcmR3YXJlIChvciBhZGRpdGlvbnMgdG8gdGhpcyBzZXJpZXMNCj4+ICAgICAg
ZGVwZW5kaW5nIG9uIGlmL3doZW4gaXQgbGFuZHMpLg0KPj4gICAgICANCj4+ICAgICAgQ2hhbmdl
cyBpbiB2NjoNCj4+ICAgICAgLSBNb3ZlIENQVSBub2RlcyBhYm92ZSB0aGUgU29DIChLcnp5c3p0
b2YpDQo+PiAgICAgIC0gTWlub3IgZm9ybWF0dGluZyBjbGVhbiB1cHMgKEtyenlzenRvZikNCj4+
ICAgICAgLSBSdW4gdGhyb3VnaCBgbWFrZSBkdGJzX2NoZWNrYA0KPj4gICAgICAtIE1vdmUgZ2lj
IG5vZGVzIGluc2lkZSBTb0MNCj4+ICAgICAgLSBHcm91cCBjbG9ja3MgdW5kZXIgYSBjbG9jayBu
b2RlDQo+PiAgICAgIENoYW5nZXMgaW4gdjU6DQo+PiAgICAgIC0gYWRkICN7YWRkcmVzcyxzaXpl
fS1jZWxscyBwcm9wZXJ0eSB0byBpMmMgbm9kZXMNCj4+ICAgICAgLSBtYWtlIGkyYyBub2RlcyBk
aXNhYmxlZCBpbiB0aGUgU29DIGFuZCBlbmFibGUgdGhlbSBpbiB0aGUgYm9hcmQNCj4+ICAgICAg
LSBhZGQgaW50ZXJydXB0IGNvbnRyb2xsZXIgYXR0cmlidXRlcyB0byBncGlvIG5vZGVzDQo+PiAg
ICAgIC0gTW92ZSBmaXhlZC1jbG9jayBub2RlcyB1cCBhIGxldmVsIGFuZCByZW1vdmUgdW5uZWNl
c3NhcnkgQDANCj4+ICAgICAgQ2hhbmdlcyBpbiB2NDoNCj4+ICAgICAgLSB1c2UgJ3BoeS1oYW5k
bGUnIGluc3RlYWQgb2YgJ3BoeScNCj4+ICAgICAgLSBtb3ZlIHN0YXR1cz0ib2theSIgb24gdXNi
IG5vZGVzIHRvIGJvYXJkIGR0cw0KPj4gICAgICAtIEFkZCByZXZpZXcgZnJvbSBBbmRyZXcNCj4+
ICAgICAgQ2hhbmdlcyBpbiB2MzoNCj4+ICAgICAgLSBNb3ZlIG1lbW9yeSBub2RlIHRvIGJvYXJk
DQo+PiAgICAgIC0gVXNlIHNpbmdsZSBkaWdpdCByZWcgdmFsdWUgZm9yIHBoeSBhZGRyZXNzDQo+
PiAgICAgIC0gUmVtb3ZlIE1NQyBub2RlIChkcml2ZXIgbmVlZHMgd29yaykNCj4+ICAgICAgLSBS
ZW1vdmUgc3lzY29uICYgc2ltcGxlLW1mZCBmb3IgcGluY3RybA0KPj4gICAgICBDaGFuZ2VzIGlu
IHYyOg0KPj4gICAgICAtIE1ha2UgcGluY3RybCBhIGNoaWxkIG5vZGUgb2YgYSBzeXNjb24gbm9k
ZQ0KPj4gICAgICAtIFVzZSBtYXJ2ZWxsLGFybWFkYS04ay1ncGlvIGluc3RlYWQgb2Ygb3Jpb24t
Z3Bpbw0KPj4gICAgICAtIFJlbW92ZSBuYW5kIHBlcmlwaGVyYWwuIFRoZSBNYXJ2ZWxsIFNESyBk
b2VzIGhhdmUgc29tZSBjaGFuZ2VzIGZvciB0aGUNCj4+ICAgICAgICBhYzUtbmFuZC1jb250cm9s
bGVyIGJ1dCBJIGN1cnJlbnRseSBsYWNrIGhhcmR3YXJlIHdpdGggTkFORCBmaXR0ZWQgc28NCj4+
ICAgICAgICBJIGNhbid0IHRlc3QgaXQgcmlnaHQgbm93LiBJJ3ZlIHRoZXJlZm9yZSBjaG9zZW4g
dG8gb21pdCB0aGUgbm9kZSBhbmQNCj4+ICAgICAgICBub3QgYXR0ZW1wdGVkIHRvIGJyaW5nIGlu
IHRoZSBkcml2ZXIgb3IgYmluZGluZy4NCj4+ICAgICAgLSBSZW1vdmUgcGNpZSBwZXJpcGhlcmFs
LiBBZ2FpbiB0aGVyZSBhcmUgY2hhbmdlcyBpbiB0aGUgU0RLIGFuZCBJIGhhdmUNCj4+ICAgICAg
ICBubyB3YXkgb2YgdGVzdGluZyB0aGVtLg0KPj4gICAgICAtIFJlbW92ZSBwcmVzdGVyYSBub2Rl
Lg0KPj4gICAgICAtIFJlbW92ZSAibWFydmVsbCxhYzUtZWhjaSIgY29tcGF0aWJsZSBmcm9tIFVT
QiBub2RlIGFzDQo+PiAgICAgICAgIm1hcnZlbGwsb3Jpb24tZWhjaSIgaXMgc3VmZmljaWVudA0K
Pj4gICAgICAtIFJlbW92ZSB3YXRjaGRvZyBub2RlLiBUaGVyZSBpcyBhIGJ1Z2d5IGRyaXZlciBm
b3IgdGhlIGFjNSB3YXRjaGRvZyBpbg0KPj4gICAgICAgIHRoZSBTREsgYnV0IGl0IG5lZWRzIHNv
bWUgd29yayBzbyBJJ3ZlIGRyb3BwZWQgdGhlIG5vZGUgZm9yIG5vdy4NCj4+DQo+PiAgIGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWFydmVsbC9NYWtlZmlsZSAgICAgICAgICB8ICAgMSArDQo+PiAgIC4u
Li9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS05OGR4MjUzMC5kdHNpICAgICB8IDMxMyArKysrKysr
KysrKysrKysrKysNCj4+ICAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL3JkLWFjNXguZHRz
ICAgICAgIHwgIDkwICsrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgNDA0IGluc2VydGlvbnMo
KykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9h
cm1hZGEtOThkeDI1MzAuZHRzaQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9i
b290L2R0cy9tYXJ2ZWxsL3JkLWFjNXguZHRzDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWFydmVsbC9NYWtlZmlsZSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9NYWtlZmlsZQ0KPj4gaW5kZXggMWM3OTRjZGNiOGU2Li4zOTA1ZGVlNTU4YjQgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUNCj4+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9NYWtlZmlsZQ0KPj4gQEAgLTI0LDMgKzI0LDQgQEAg
ZHRiLSQoQ09ORklHX0FSQ0hfTVZFQlUpICs9IGNuOTEzMi1kYi5kdGINCj4+ICAgZHRiLSQoQ09O
RklHX0FSQ0hfTVZFQlUpICs9IGNuOTEzMi1kYi1CLmR0Yg0KPj4gICBkdGItJChDT05GSUdfQVJD
SF9NVkVCVSkgKz0gY245MTMwLWNyYi1BLmR0Yg0KPj4gICBkdGItJChDT05GSUdfQVJDSF9NVkVC
VSkgKz0gY245MTMwLWNyYi1CLmR0Yg0KPj4gK2R0Yi0kKENPTkZJR19BUkNIX01WRUJVKSArPSBy
ZC1hYzV4LmR0Yg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9h
cm1hZGEtOThkeDI1MzAuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEt
OThkeDI1MzAuZHRzaQ0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAw
MDAwMC4uNzI0ZTcyMmI0MjY1DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTk4ZHgyNTMwLmR0c2kNCj4+IEBAIC0wLDAgKzEsMzEz
IEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wKyBPUiBNSVQpDQo+
PiArLyoNCj4+ICsgKiBEZXZpY2UgVHJlZSBGb3IgQUM1Lg0KPj4gKyAqDQo+PiArICogQ29weXJp
Z2h0IChDKSAyMDIxIE1hcnZlbGwNCj4+ICsgKg0KPj4gKyAqLw0KPj4gKw0KPj4gKy9kdHMtdjEv
Ow0KPj4gKw0KPj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4+ICsjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPj4gKw0K
Pj4gKy8gew0KPj4gKwltb2RlbCA9ICJNYXJ2ZWxsIEFDNSBTb0MiOw0KPj4gKwljb21wYXRpYmxl
ID0gIm1hcnZlbGwsYWM1IjsNCj4+ICsJaW50ZXJydXB0LXBhcmVudCA9IDwmZ2ljPjsNCj4+ICsJ
I2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+PiArCSNzaXplLWNlbGxzID0gPDI+Ow0KPj4gKw0KPj4g
KwlhbGlhc2VzIHsNCj4+ICsJCXNlcmlhbDAgPSAmdWFydDA7DQo+PiArCQlzcGlmbGFzaDAgPSAm
c3BpZmxhc2gwOw0KPiBUaGVzZSBzaG91bGQgYmUgaW4gYm9hcmQgRFRTLCBub3QgU29DLg0KPg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yb2NrY2hpcC9DQUs4UDNhMjVpWWtzdWJD
blFiMS1lNXlqPWNyRXNLMzdSQjlIbjRaR1pNd2NWVnJHN2dAbWFpbC5nbWFpbC5jb20vDQoNClRo
YW5rcyBmb3IgdGhlIHJlZmVyZW5jZS4gV2lsbCBtb3ZlLg0KDQo+DQo+PiArCQlncGlvMCA9ICZn
cGlvMDsNCj4+ICsJCWdwaW8xID0gJmdwaW8xOw0KPj4gKwkJZXRoZXJuZXQwID0gJmV0aDA7DQo+
PiArCQlldGhlcm5ldDEgPSAmZXRoMTsNCj4gKC4uLikNCj4NCj4+ICsNCj4+ICsJY2xvY2tzIHsN
Cj4+ICsJCWNvcmVfY2xvY2s6IGNvcmUtY2xvY2sgew0KPj4gKwkJCWNvbXBhdGlibGUgPSAiZml4
ZWQtY2xvY2siOw0KPj4gKwkJCSNjbG9jay1jZWxscyA9IDwwPjsNCj4+ICsJCQljbG9jay1mcmVx
dWVuY3kgPSA8NDAwMDAwMDAwPjsNCj4+ICsJCX07DQo+PiArDQo+PiArCQlheGlfY2xvY2s6IGF4
aS1jbG9jayB7DQo+PiArCQkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+PiArCQkJI2Ns
b2NrLWNlbGxzID0gPDA+Ow0KPj4gKwkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwzMjUwMDAwMDA+Ow0K
Pj4gKwkJfTsNCj4+ICsNCj4+ICsJCXNwaV9jbG9jazogc3BpLWNsb2NrIHsNCj4+ICsJCQljb21w
YXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4+ICsJCQkjY2xvY2stY2VsbHMgPSA8MD47DQo+PiAr
CQkJY2xvY2stZnJlcXVlbmN5ID0gPDIwMDAwMDAwMD47DQo+PiArCQl9Ow0KPiBNeSBxdWVzdGlv
bnMgYWJvdXQgdGhlc2UgY2xvY2tzIGFyZSBzdGlsbCB1bmFuc3dlcmVkLiBXaHkgZG8geW91IGRl
ZmluZQ0KPiBmaXhlZC1jbG9ja3MuIEFyZW4ndCB0aGVzZSBwYXJ0IG9mIGNsb2NrIGNvbnRyb2xs
ZXI/DQoNCk5vdCBvbmUgdGhhdCBJIGhhdmUgYW55IGluZm9ybWF0aW9uIG9uLiBNYXJ2ZWxsIGRv
bid0IHB1dCBpdCBpbiB0aGVpciANCmN1c3RvbWVyIGZhY2luZyBkb2N1bWVudGF0aW9uIHNvIEkg
Y2FuIG9ubHkgc3BlY3VsYXRlLiBUaGUgMjVNSHogDQpvc2NpbGxhdG9yIGdvZXMgaW50byB0aGUg
Y2hpcCwgZnJvbSB0aGVyZSBJIGd1ZXNzIHRoYXQgaXQgaXMgZmVkIGluIHNvbWUgDQpmYXNoaW9u
IHRvIGJvdGggdGhlIENQVSBibG9jayAoQ25NIGluIE1hcnZlbGwgc3BlYWspIGFuZCB0byB0aGUg
c3dpdGNoIA0KYmxvY2suIFdoZXJlIGV4YWN0bHkgaXQgZ2V0cyBkaXZpZGVkIGludG8gdGhlc2Ug
aW5kaXZpZHVhbCBwZXJpcGhlcmFsIA0KY2xvY2tzIEkgZG9uJ3QgcmVhbGx5IGtub3cuDQoNCj4+
ICsJfTsNCj4+ICt9Ow0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9yZC1hYzV4LmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9yZC1hYzV4LmR0cw0K
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uN2FjODc0MTNl
MDIzDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZl
bGwvcmQtYWM1eC5kdHMNCj4+IEBAIC0wLDAgKzEsOTAgQEANCj4+ICsvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjArIE9SIE1JVCkNCj4+ICsvKg0KPj4gKyAqIERldmljZSBUcmVl
IEZvciBBQzVYLg0KPj4gKyAqDQo+PiArICogQ29weXJpZ2h0IChDKSAyMDIxIE1hcnZlbGwNCj4+
ICsgKg0KPj4gKyAqLw0KPj4gKy8qDQo+PiArICogRGV2aWNlIFRyZWUgZmlsZSBmb3IgTWFydmVs
bCBBbGxleWNhdCA1WCBkZXZlbG9wbWVudCBib2FyZA0KPj4gKyAqIFRoaXMgYm9hcmQgZmlsZSBz
dXBwb3J0cyB0aGUgQiBjb25maWd1cmF0aW9uIG9mIHRoZSBib2FyZA0KPj4gKyAqLw0KPj4gKw0K
Pj4gKy9kdHMtdjEvOw0KPj4gKw0KPj4gKyNpbmNsdWRlICJhcm1hZGEtOThkeDI1MzAuZHRzaSIN
Cj4+ICsNCj4+ICsvIHsNCj4+ICsJbW9kZWwgPSAiTWFydmVsbCBSRC1BQzVYIEJvYXJkIjsNCj4+
ICsJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFjNXgiLCAibWFydmVsbCxhYzUiOw0KPiAgRnJvbSB0
aGUgYmluZGluZ3MgSSB1bmRlcnN0b29kIGFjNXggaXMgYSBTb0MsIG5vdCBib2FyZC4gSWYgYWM1
eCBpcyBhDQo+IGJvYXJkLCBub3QgYSBTb0MsIHRoZW4gY29tcGF0aWJsZSBzaG91bGQgYmUgcmF0
aGVyICJtYXJ2ZWxsLHJkLWFjNXgiLg0KDQpTbyBJZiBJIHVuZGVyc3RhbmQgdGhlIGNvbnZlbnRp
b24gdGhlIGZ1bGwgY29tcGF0aWJsZSB3b3VsZCBiZToNCg0KY29tcGF0aWJsZSA9ICJtYXJ2ZWxs
LHJkLWFjNXgiLCAibWFydmVsbCxhYzV4IiwgIm1hcnZlbGwsYWM1IjsNCg0KPg0KPj4gKw0KPj4g
KwltZW1vcnlAMCB7DQo+PiArCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KPj4gKwkJcmVnID0g
PDB4MiAweDAwMDAwMDAwIDB4MCAweDQwMDAwMDAwPjsNCj4+ICsJfTsNCj4+ICt9Ow0KPj4gKw0K
Pj4gKyZtZGlvIHsNCj4+ICsJcGh5MDogZXRoZXJuZXQtcGh5QDAgew0KPj4gKwkJcmVnID0gPDA+
Ow0KPj4gKwl9Ow0KPj4gK307DQo+PiArDQo+PiArJmkyYzAgew0KPj4gKwlzdGF0dXMgPSAib2th
eSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmaTJjMSB7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+
ICt9Ow0KPj4gKw0KPj4gKyZldGgwIHsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gKwlwaHkt
aGFuZGxlID0gPCZwaHkwPjsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZ1c2IwIHsNCj4+ICsJc3RhdHVz
ID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJnVzYjEgew0KPj4gKwlzdGF0dXMgPSAib2th
eSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmc3BpMCB7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+
ICsNCj4+ICsJc3BpZmxhc2gwOiBmbGFzaEAwIHsNCj4+ICsJCWNvbXBhdGlibGUgPSAiamVkZWMs
c3BpLW5vciI7DQo+PiArCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDw1MDAwMDAwMD47DQo+PiArCQlz
cGktdHgtYnVzLXdpZHRoID0gPDE+OyAvKiAxLXNpbmdsZSwgMi1kdWFsLCA0LXF1YWQgKi8NCj4+
ICsJCXNwaS1yeC1idXMtd2lkdGggPSA8MT47IC8qIDEtc2luZ2xlLCAyLWR1YWwsIDQtcXVhZCAq
Lw0KPj4gKwkJcmVnID0gPDA+Ow0KPj4gKw0KPj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
PiArCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4+ICsNCj4+ICsJCXBhcnRpdGlvbkAwIHsNCj4+ICsJ
CQlsYWJlbCA9ICJzcGlfZmxhc2hfcGFydDAiOw0KPj4gKwkJCXJlZyA9IDwweDAgMHg4MDAwMDA+
Ow0KPj4gKwkJfTsNCj4+ICsNCj4+ICsJCXBhcml0aW9uQDEgew0KPj4gKwkJCWxhYmVsID0gInNw
aV9mbGFzaF9wYXJ0MSI7DQo+PiArCQkJcmVnID0gPDB4ODAwMDAwIDB4NzAwMDAwPjsNCj4+ICsJ
CX07DQo+PiArDQo+PiArCQlwYXJpdGlvbkAyIHsNCj4+ICsJCQlsYWJlbCA9ICJzcGlfZmxhc2hf
cGFydDIiOw0KPj4gKwkJCXJlZyA9IDwweEYwMDAwMCAweDEwMDAwMD47DQo+PiArCQl9Ow0KPj4g
Kwl9Ow0KPj4gK307DQo+PiArDQo+PiArJnVzYjEgew0KPj4gKwljb21wYXRpYmxlID0gImNoaXBp
ZGVhLHVzYjIiOw0KPiBXaHkgY29tcGF0aWJsZSBpcyBkZWZpbmVkIHBlciBib2FyZD8NCg0KVGhh
dCBjYW1lIGZyb20gdGhlIE1hcnZlbGwgU0RLLiBPbiBzb21lIGJvYXJkcyB0aGlzIGlzIHVzZWQg
YXMgYSANCmRldmljZS9PVEcgaW50ZXJmYWNlLiBCdXQgcmVnYXJkbGVzcyBpdCBzaG91bGQgaGF2
ZSBvbmUgaW4gdGhlIFNvQyBkdHNpLiANCkFzIGZvciB3aHkgdGhleSB1c2VkIHRoZSAiY2hpcGlk
ZWEsdXNiMiIgY29tcGF0aWJsZSBJIGhhdmUgbm8gaWRlYS4gSSdsbCANCnJlbW92ZSB0aGlzIGFu
ZCBhZGQgdGhlIGNvcnJlY3QgY29tcGF0aWJsZSB0byB0aGUgU29DLg0KDQo+PiArCXBoeXMgPSA8
JnVzYjFwaHk+Ow0KPj4gKwlwaHktbmFtZXMgPSAidXNiLXBoeSI7DQo+PiArCWRyX21vZGUgPSAi
cGVyaXBoZXJhbCI7DQo+PiArfTsNCj4+ICsNCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2Y=
