Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8F525796
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359073AbiELWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359057AbiELWKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:10:07 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523C2802F6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:10:04 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 50F572C00E8;
        Thu, 12 May 2022 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652393401;
        bh=0EqfpvRdRlnrFmhFkaLJgrO6e5eZ28CEaOcGMD46m+Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=S/3jui4oHFIGImlzZQuHdObRUttfg7uZjafAChjgyEjXAP3PbU52OF0HkA5/UR6QH
         Qs1pKktcdel4P7eV4zHbX8NGrZF39WJETAfW2IASe2l8S7SWD4ZHCBmUwZb7E6HdHi
         yPoaAFvOib0uY90bQFcApB6zz8/4tr0cZ2rbjNmoV/OVBCREJvULZ2RrmgnkB0bvq+
         f8DcTgP+DkcQp8FIok7cQPPioUwZIEMNkyPEcZV/bXMCjIyE3F2uRxgF6qEXWwck7N
         5We+1ZGtLhsU4zLS4rukTHvjS1W09GSwiSkiMPa5anPLFyXxrXniteqbDl6thOcRMl
         QoksnrF6tUcRg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627d85b90001>; Fri, 13 May 2022 10:10:01 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 13 May 2022 10:10:01 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 13 May 2022 10:10:01 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Marc Zyngier <maz@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v7 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYZbhCZ5RJjp1rLk+xI3fL/9Lp4q0aEemAgADzhwA=
Date:   Thu, 12 May 2022 22:10:01 +0000
Message-ID: <5c01f20a-acd3-da15-081d-7cf878f8a77a@alliedtelesis.co.nz>
References: <20220512042501.3339775-1-chris.packham@alliedtelesis.co.nz>
 <20220512042501.3339775-3-chris.packham@alliedtelesis.co.nz>
 <87wnermc9c.wl-maz@kernel.org>
In-Reply-To: <87wnermc9c.wl-maz@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5848BA660A99C1408566F27C8D8FD044@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=aQaD7UiZWn3mriizGz8A:9 a=QEXdDO2ut3YA:10
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

SGkgTWFyYywNCg0KT24gMTIvMDUvMjIgMTk6MzgsIE1hcmMgWnluZ2llciB3cm90ZToNCj4gT24g
VGh1LCAxMiBNYXkgMjAyMiAwNToyNTowMCArMDEwMCwNCj4gQ2hyaXMgUGFja2hhbSA8Y2hyaXMu
cGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cm90ZToNCj4+IFRoZSA5OERYMjUzMCBTb0Mg
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
cyBpbiB2NzoNCj4+ICAgICAgLSBBZGQgbWlzc2luZyBjb21wYXRpYmxlIG9uIHVzYjENCj4+ICAg
ICAgLSBBZGQgInJkLWFjNXgiIGNvbXBhdGlibGUgZm9yIGJvYXJkDQo+PiAgICAgIC0gTW92ZSBh
bGlhc2VzIHRvIGJvYXJkIGR0cw0KPj4gICAgICAtIE1vdmUgYm9hcmQgc3BlY2lmaWMgdXNiIGlu
Zm8gdG8gYm9hcmQgZHRzDQo+PiAgICAgIC0gQ29uc29saWRhdGUgdXNiMSBib2FyZCBzZXR0aW5n
cyBhbmQgcmVtb3ZlIHVubmVjZXNzYXJ5IGNvbXBhdGlibGUNCj4+ICAgICAgLSBBZGQgQWxsaWVk
IFRlbGVzaXMgY29weXJpZ2h0DQo+PiAgICAgIC0gUmVuYW1lIGZpbGVzIGFmdGVyIG1haWxuZy1s
aXN0IGRpc2N1c3Npb24NCj4+ICAgICAgQ2hhbmdlcyBpbiB2NjoNCj4+ICAgICAgLSBNb3ZlIENQ
VSBub2RlcyBhYm92ZSB0aGUgU29DIChLcnp5c3p0b2YpDQo+PiAgICAgIC0gTWlub3IgZm9ybWF0
dGluZyBjbGVhbiB1cHMgKEtyenlzenRvZikNCj4+ICAgICAgLSBSdW4gdGhyb3VnaCBgbWFrZSBk
dGJzX2NoZWNrYA0KPj4gICAgICAtIE1vdmUgZ2ljIG5vZGVzIGluc2lkZSBTb0MNCj4+ICAgICAg
LSBHcm91cCBjbG9ja3MgdW5kZXIgYSBjbG9jayBub2RlDQo+PiAgICAgIENoYW5nZXMgaW4gdjU6
DQo+PiAgICAgIC0gYWRkICN7YWRkcmVzcyxzaXplfS1jZWxscyBwcm9wZXJ0eSB0byBpMmMgbm9k
ZXMNCj4+ICAgICAgLSBtYWtlIGkyYyBub2RlcyBkaXNhYmxlZCBpbiB0aGUgU29DIGFuZCBlbmFi
bGUgdGhlbSBpbiB0aGUgYm9hcmQNCj4+ICAgICAgLSBhZGQgaW50ZXJydXB0IGNvbnRyb2xsZXIg
YXR0cmlidXRlcyB0byBncGlvIG5vZGVzDQo+PiAgICAgIC0gTW92ZSBmaXhlZC1jbG9jayBub2Rl
cyB1cCBhIGxldmVsIGFuZCByZW1vdmUgdW5uZWNlc3NhcnkgQDANCj4+ICAgICAgQ2hhbmdlcyBp
biB2NDoNCj4+ICAgICAgLSB1c2UgJ3BoeS1oYW5kbGUnIGluc3RlYWQgb2YgJ3BoeScNCj4+ICAg
ICAgLSBtb3ZlIHN0YXR1cz0ib2theSIgb24gdXNiIG5vZGVzIHRvIGJvYXJkIGR0cw0KPj4gICAg
ICAtIEFkZCByZXZpZXcgZnJvbSBBbmRyZXcNCj4+ICAgICAgQ2hhbmdlcyBpbiB2MzoNCj4+ICAg
ICAgLSBNb3ZlIG1lbW9yeSBub2RlIHRvIGJvYXJkDQo+PiAgICAgIC0gVXNlIHNpbmdsZSBkaWdp
dCByZWcgdmFsdWUgZm9yIHBoeSBhZGRyZXNzDQo+PiAgICAgIC0gUmVtb3ZlIE1NQyBub2RlIChk
cml2ZXIgbmVlZHMgd29yaykNCj4+ICAgICAgLSBSZW1vdmUgc3lzY29uICYgc2ltcGxlLW1mZCBm
b3IgcGluY3RybA0KPj4gICAgICBDaGFuZ2VzIGluIHYyOg0KPj4gICAgICAtIE1ha2UgcGluY3Ry
bCBhIGNoaWxkIG5vZGUgb2YgYSBzeXNjb24gbm9kZQ0KPj4gICAgICAtIFVzZSBtYXJ2ZWxsLGFy
bWFkYS04ay1ncGlvIGluc3RlYWQgb2Ygb3Jpb24tZ3Bpbw0KPj4gICAgICAtIFJlbW92ZSBuYW5k
IHBlcmlwaGVyYWwuIFRoZSBNYXJ2ZWxsIFNESyBkb2VzIGhhdmUgc29tZSBjaGFuZ2VzIGZvciB0
aGUNCj4+ICAgICAgICBhYzUtbmFuZC1jb250cm9sbGVyIGJ1dCBJIGN1cnJlbnRseSBsYWNrIGhh
cmR3YXJlIHdpdGggTkFORCBmaXR0ZWQgc28NCj4+ICAgICAgICBJIGNhbid0IHRlc3QgaXQgcmln
aHQgbm93LiBJJ3ZlIHRoZXJlZm9yZSBjaG9zZW4gdG8gb21pdCB0aGUgbm9kZSBhbmQNCj4+ICAg
ICAgICBub3QgYXR0ZW1wdGVkIHRvIGJyaW5nIGluIHRoZSBkcml2ZXIgb3IgYmluZGluZy4NCj4+
ICAgICAgLSBSZW1vdmUgcGNpZSBwZXJpcGhlcmFsLiBBZ2FpbiB0aGVyZSBhcmUgY2hhbmdlcyBp
biB0aGUgU0RLIGFuZCBJIGhhdmUNCj4+ICAgICAgICBubyB3YXkgb2YgdGVzdGluZyB0aGVtLg0K
Pj4gICAgICAtIFJlbW92ZSBwcmVzdGVyYSBub2RlLg0KPj4gICAgICAtIFJlbW92ZSAibWFydmVs
bCxhYzUtZWhjaSIgY29tcGF0aWJsZSBmcm9tIFVTQiBub2RlIGFzDQo+PiAgICAgICAgIm1hcnZl
bGwsb3Jpb24tZWhjaSIgaXMgc3VmZmljaWVudA0KPj4gICAgICAtIFJlbW92ZSB3YXRjaGRvZyBu
b2RlLiBUaGVyZSBpcyBhIGJ1Z2d5IGRyaXZlciBmb3IgdGhlIGFjNSB3YXRjaGRvZyBpbg0KPj4g
ICAgICAgIHRoZSBTREsgYnV0IGl0IG5lZWRzIHNvbWUgd29yayBzbyBJJ3ZlIGRyb3BwZWQgdGhl
IG5vZGUgZm9yIG5vdy4NCj4+DQo+PiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9NYWtl
ZmlsZSAgICAgICAgICB8ICAgMSArDQo+PiAgIC4uLi9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS05
OGR4MjV4eC5kdHNpICAgICB8IDI5NSArKysrKysrKysrKysrKysrKysNCj4+ICAgLi4uL2Jvb3Qv
ZHRzL21hcnZlbGwvYXJtYWRhLTk4ZHgzNXh4LXJkLmR0cyAgIHwgMTAxICsrKysrKw0KPj4gICAu
Li4vYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtOThkeDM1eHguZHRzaSAgICAgfCAgMTMgKw0KPj4g
ICA0IGZpbGVzIGNoYW5nZWQsIDQxMCBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTk4ZHgyNXh4LmR0c2kNCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEt
OThkeDM1eHgtcmQuZHRzDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL21hcnZlbGwvYXJtYWRhLTk4ZHgzNXh4LmR0c2kNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL01ha2VmaWxlIGIvYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL01ha2VmaWxlDQo+PiBpbmRleCAxYzc5NGNkY2I4ZTYuLmI3YTRjNzE1YWZiYiAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9NYWtlZmlsZQ0KPj4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL01ha2VmaWxlDQo+PiBAQCAtMjQsMyArMjQs
NCBAQCBkdGItJChDT05GSUdfQVJDSF9NVkVCVSkgKz0gY245MTMyLWRiLmR0Yg0KPj4gICBkdGIt
JChDT05GSUdfQVJDSF9NVkVCVSkgKz0gY245MTMyLWRiLUIuZHRiDQo+PiAgIGR0Yi0kKENPTkZJ
R19BUkNIX01WRUJVKSArPSBjbjkxMzAtY3JiLUEuZHRiDQo+PiAgIGR0Yi0kKENPTkZJR19BUkNI
X01WRUJVKSArPSBjbjkxMzAtY3JiLUIuZHRiDQo+PiArZHRiLSQoQ09ORklHX0FSQ0hfTVZFQlUp
ICs9IGFybWFkYS05OGR4MzV4eC1yZC5kdGINCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL21hcnZlbGwvYXJtYWRhLTk4ZHgyNXh4LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L21hcnZlbGwvYXJtYWRhLTk4ZHgyNXh4LmR0c2kNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjU1YWI0Y2Q4NDNhOQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS05OGR4MjV4eC5kdHNpDQo+
PiBAQCAtMCwwICsxLDI5NSBAQA0KPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMCsgT1IgTUlUKQ0KPj4gKy8qDQo+PiArICogRGV2aWNlIFRyZWUgRm9yIEFDNS4NCj4+ICsg
Kg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyMSBNYXJ2ZWxsDQo+PiArICogQ29weXJpZ2h0IChD
KSAyMDIyIEFsbGllZCBUZWxlc2lzIExhYnMNCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVy
cnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4+ICsNCj4+ICsvIHsNCj4+ICsJbW9kZWwgPSAi
TWFydmVsbCBBQzUgU29DIjsNCj4+ICsJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFjNSI7DQo+PiAr
CWludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+PiArCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0K
Pj4gKwkjc2l6ZS1jZWxscyA9IDwyPjsNCj4+ICsNCj4+ICsJY3B1cyB7DQo+PiArCQkjYWRkcmVz
cy1jZWxscyA9IDwyPjsNCj4+ICsJCSNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKw0KPj4gKwkJY3B1
LW1hcCB7DQo+PiArCQkJY2x1c3RlcjAgew0KPj4gKwkJCQljb3JlMCB7DQo+PiArCQkJCQljcHUg
PSA8JmNwdTA+Ow0KPj4gKwkJCQl9Ow0KPj4gKwkJCQljb3JlMSB7DQo+PiArCQkJCQljcHUgPSA8
JmNwdTE+Ow0KPj4gKwkJCQl9Ow0KPj4gKwkJCX07DQo+PiArCQl9Ow0KPj4gKw0KPj4gKwkJY3B1
MDogY3B1QDAgew0KPj4gKwkJCWRldmljZV90eXBlID0gImNwdSI7DQo+PiArCQkJY29tcGF0aWJs
ZSA9ICJhcm0sYXJtdjgiOw0KPj4gKwkJCXJlZyA9IDwweDAgMHgwPjsNCj4+ICsJCQllbmFibGUt
bWV0aG9kID0gInBzY2kiOw0KPj4gKwkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JmwyPjsNCj4+ICsJ
CX07DQo+PiArDQo+PiArCQljcHUxOiBjcHVAMSB7DQo+PiArCQkJZGV2aWNlX3R5cGUgPSAiY3B1
IjsNCj4+ICsJCQljb21wYXRpYmxlID0gImFybSxhcm12OCI7DQo+PiArCQkJcmVnID0gPDB4MCAw
eDEwMD47DQo+PiArCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4+ICsJCQluZXh0LWxldmVs
LWNhY2hlID0gPCZsMj47DQo+PiArCQl9Ow0KPj4gKw0KPj4gKwkJbDI6IGwyLWNhY2hlIHsNCj4+
ICsJCQljb21wYXRpYmxlID0gImNhY2hlIjsNCj4+ICsJCX07DQo+PiArCX07DQo+PiArDQo+PiAr
DQo+PiArCXBzY2kgew0KPj4gKwkJY29tcGF0aWJsZSA9ICJhcm0scHNjaS0wLjIiOw0KPj4gKwkJ
bWV0aG9kID0gInNtYyI7DQo+PiArCX07DQo+PiArDQo+PiArCXRpbWVyIHsNCj4+ICsJCWNvbXBh
dGlibGUgPSAiYXJtLGFybXY4LXRpbWVyIjsNCj4+ICsJCWludGVycnVwdHMgPSA8R0lDX1BQSSA5
IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPj4gKwkJCQkgPEdJQ19QUEkgOCBJUlFfVFlQRV9MRVZF
TF9ISUdIPiwNCj4+ICsJCQkJIDxHSUNfUFBJIDEwIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPj4g
KwkJCQkgPEdJQ19QUEkgNyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+ICsJCWNsb2NrLWZyZXF1
ZW5jeSA9IDwyNTAwMDAwMD47DQo+IEkgc2FpZCBubyB0byB0aGlzIGhhY2sgaW4gYSBwYXN0IHZl
cnNpb24gb2YgdGhpcyBwYXRjaCwgYW5kIEknbSBnb2luZw0KPiB0byBzYXkgaXQgKmFnYWluKi4N
ClNvcnJ5IEkgbXVzdCBoYXZlIG1pc3NlZCBpdC4NCj4gUGxlYXNlIGZpeCB5b3VyIGZpcm13YXJl
IHRvIHByb2dyYW0gQ05URlJRX0VMMCwgYW5kDQo+IHJlbW92ZSB0aGlzIHVzZWxlc3MgcHJvcGVy
dHkuDQpJJ20ga2luZCBvZiBhdCB0aGUgbWVyY3kgb2Ygd2hhdCBNYXJ2ZWxsIGhhdmUgcHJvdmlk
ZWQgZm9yIEFURi4gSSBhbSANCndvcmtpbmcgb24gdGhlIGJvb3Rsb2FkZXIgcG9ydGlvbiBpbiBw
YXJhbGxlbCBhbmQgYW0gZ2V0dGluZyB0aGluZ3MgDQpyZWFkeSBmb3Igc3VibWl0dGluZyB0aGUg
dS1ib290IHN1cHBvcnQgdXBzdHJlYW0uIEkgd2FzIGhvcGluZyB0byBsZWF2ZSANCkFURiBhbG9u
ZSBJIGNhbiBhdCBsZWFzdCBzZWUgaWYgdGhleSBoYXZlbid0IGZpeGVkIHRoaXMgYWxyZWFkeSAo
dGhlIA0Kb3JpZ2luYWwgZHRzaSBJIHN0YXJ0ZWQgd2l0aCB3YXMgZmFpcmx5IG9sZCkgYW5kIGlm
IHRoZXkgaGF2ZW4ndCBJJ2xsIA0KcmFpc2UgaXQgdmlhIHRoZWlyIHN1cHBvcnQgc3lzdGVtLg0K
PiBZb3UgYXJlIGFsc28gbWlzc2luZyBhIFBQSSBmb3IgdGhlIEVMMiB2aXJ0dWFsIHRpbWVyIHdo
aWNoIGlzIHByZXNlbnQNCj4gb24gYW55IEFSTXY4LjErIENQVSAoYW5kIHNpbmNlIHRoaXMgc3lz
dGVtIGlzIHVzaW5nIEE1NSwgaXQgZGVmaW5pdGVseQ0KPiBoYXMgaXQpLg0KPg0KPiBbLi4uXQ0K
V2lsbCBhZGQuDQo+PiArDQo+PiArCQlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQDgwNjAwMDAw
IHsNCj4+ICsJCQljb21wYXRpYmxlID0gImFybSxnaWMtdjMiOw0KPj4gKwkJCSNpbnRlcnJ1cHQt
Y2VsbHMgPSA8Mz47DQo+PiArCQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+PiArCQkJLyojcmVk
aXN0cmlidXRvci1yZWdpb25zID0gPDE+OyovDQo+PiArCQkJcmVkaXN0cmlidXRvci1zdHJpZGUg
PSA8MHgwIDB4MjAwMDA+OwkvLyAxMjhrQiBzdHJpZGUNCj4gWW91IGRvbid0IG5lZWQgdGhpcyBh
dCBhbGwuIFRoaXMgaXMgdGhlIGFyY2hpdGVjdGVkIHZhbHVlIGZvciBHSUN2My4NCldpbGwgcmVt
b3ZlLg0KPg0KPj4gKwkJCXJlZyA9IDwweDAgMHg4MDYwMDAwMCAweDAgMHgxMDAwMD4sIC8qIEdJ
Q0QgKi8NCj4+ICsJCQkgICAgICA8MHgwIDB4ODA2NjAwMDAgMHgwIDB4NDAwMDA+OyAvKiBHSUNS
ICovDQo+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfUFBJIDYgSVJRX1RZUEVfTEVWRUxfSElHSD47
DQo+PiArCQl9Ow0KPj4gKwl9Ow0KPiBUaGFua3MsDQo+DQo+IAlNLg0KPg==
