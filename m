Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B44DB946
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbiCPUXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbiCPUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:23:22 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5E463533
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:22:06 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 558F72C0ACE;
        Wed, 16 Mar 2022 20:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647462119;
        bh=Kucck+GkMf655DDgQdcPNO4avTGk3k0FGTrWFyIU0oY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QEH5sTJJ76R/b0rMVsNe4M2dU5zmp81FAKvKmHpSVJj9TqQwMjiQbPL5MhN2+2rId
         DWTJd4WRIBozQHtRbHQ42FTgzn/6WMzarhEroHoK/ZiArGWVGwE0YwUY7D93zkg3bI
         5ZeKFNCCR7oky0t6YLLhI/ns7hJWNxAiE5F2rUYAIPmB8klaxXToK6L6jwHfJfml05
         JTdMdO5ST/ZI7X6M5SFesP/pKaSNLLkZsAy657edWCeAIQldDS8yijlwozmcudaNkI
         RNA+WE3yVzoe+kY6QN2vsQQCamB+WonHtRqJNRT3zG8HwLef6mDmDZwxAP2QV9UXHm
         txQXoaJN2qgjQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B623246e70001>; Thu, 17 Mar 2022 09:21:59 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 17 Mar 2022 09:21:58 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 17 Mar 2022 09:21:58 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: pinctrl: mvebu: Document bindings for
 AC5
Thread-Topic: [PATCH v2 1/8] dt-bindings: pinctrl: mvebu: Document bindings
 for AC5
Thread-Index: AQHYN+r1YarBXjvcwESVFtaA5OJaJay/ajqAgACu0ACAALlggIAAyseA
Date:   Wed, 16 Mar 2022 20:21:58 +0000
Message-ID: <6d902e7d-b71f-9dcd-9175-cc706e3d60cc@alliedtelesis.co.nz>
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-2-chris.packham@alliedtelesis.co.nz>
 <4e6df448-5562-8f50-6f46-91acb279bc1a@canonical.com>
 <7e73bba0-8b54-772c-2e94-8fca4e4e3294@alliedtelesis.co.nz>
 <cb0af80e-3e5a-fbd9-cd8b-7b252ebe33fe@canonical.com>
In-Reply-To: <cb0af80e-3e5a-fbd9-cd8b-7b252ebe33fe@canonical.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7881AC14AEB5B6478F0413054E22DDC4@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=HC_-440reMnop7FHCZAA:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNi8wMy8yMiAyMToxNiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTUv
MDMvMjAyMiAyMjoxMiwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+ICh0cmltbWVkIGNjIGxpc3Qg
dG8gdGhlIGFybSwgcGluY3RybCBhbmQgZHQgcGVvcGxlKQ0KPj4NCj4+IE9uIDE1LzAzLzIyIDIz
OjQ2LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+IE9uIDE0LzAzLzIwMjIgMjI6MzEs
IENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4+IEFkZCBKU09OIHNjaGVtYSBmb3IgbWFydmVsbCxh
YzUtcGluY3RybCBwcmVzZW50IG9uIHRoZSBNYXJ2ZWxsIDk4RFgyNTMwDQo+Pj4+IFNvQy4NCj4+
Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxp
ZWR0ZWxlc2lzLmNvLm56Pg0KPj4+PiAtLS0NCj4+Pj4NCj4+Pj4gTm90ZXM6DQo+Pj4+ICAgICAg
IENoYW5nZXMgaW4gdjI6DQo+Pj4+ICAgICAgIC0gUmVtb3ZlIHN5c2NvbiBhbmQgc2ltcGxlLW1m
ZCBjb21wYXRpYmxlcw0KPj4+Pg0KPj4+PiAgICAuLi4vYmluZGluZ3MvcGluY3RybC9tYXJ2ZWxs
LGFjNS1waW5jdHJsLnlhbWwgfCA3MCArKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCspDQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9tYXJ2ZWxsLGFjNS1waW5j
dHJsLnlhbWwNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGwsYWM1LXBpbmN0cmwueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGwsYWM1LXBpbmN0cmwueWFtbA0K
Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjY1YWYx
ZDVmNWZlMA0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGwsYWM1LXBpbmN0cmwueWFtbA0KPj4+PiBA
QCAtMCwwICsxLDcwIEBADQo+Pj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlDQo+Pj4+ICslWUFNTCAxLjINCj4+Pj4gKy0tLQ0KPj4+PiAr
JGlkOiBodHRwOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0yMDk4OCZkPTFweXg0a3Y0S1Ry
VGZFNWZYTnM1NG1MWm1PZ2s4N1VpbTZDWHUtWUMxdyZ1PWh0dHAlM2ElMmYlMmZkZXZpY2V0cmVl
JTJlb3JnJTJmc2NoZW1hcyUyZnBpbmN0cmwlMmZtYXJ2ZWxsJTJjYWM1LXBpbmN0cmwlMmV5YW1s
JTIzDQo+Pj4+ICskc2NoZW1hOiBodHRwOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0yMDk4
OCZkPTFweXg0a3Y0S1RyVGZFNWZYTnM1NG1MWm1PZ2s4N1VpbTZUQXZiRUUyUSZ1PWh0dHAlM2El
MmYlMmZkZXZpY2V0cmVlJTJlb3JnJTJmbWV0YS1zY2hlbWFzJTJmY29yZSUyZXlhbWwlMjMNCj4+
Pj4gKw0KPj4+PiArdGl0bGU6IE1hcnZlbGwgQUM1IHBpbiBjb250cm9sbGVyDQo+Pj4+ICsNCj4+
Pj4gK21haW50YWluZXJzOg0KPj4+PiArICAtIENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1A
YWxsaWVkdGVsZXNpcy5jby5uej4NCj4+Pj4gKw0KPj4+PiArZGVzY3JpcHRpb246DQo+Pj4+ICsg
IEJpbmRpbmdzIGZvciBNYXJ2ZWxsJ3MgQUM1IG1lbW9yeS1tYXBwZWQgcGluIGNvbnRyb2xsZXIu
DQo+Pj4+ICsNCj4+Pj4gK3Byb3BlcnRpZXM6DQo+Pj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4+ICsg
ICAgY29uc3Q6IG1hcnZlbGwsYWM1LXBpbmN0cmwNCj4+Pj4gKw0KPj4+PiArcGF0dGVyblByb3Bl
cnRpZXM6DQo+Pj4+ICsgICctcGlucyQnOg0KPj4+PiArICAgIHR5cGU6IG9iamVjdA0KPj4+PiAr
ICAgICRyZWY6IHBpbm11eC1ub2RlLnlhbWwjDQo+Pj4+ICsNCj4+Pj4gKyAgICBwcm9wZXJ0aWVz
Og0KPj4+PiArICAgICAgbWFydmVsbCxmdW5jdGlvbjoNCj4+Pj4gKyAgICAgICAgJHJlZjogIi9z
Y2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmluZyINCj4+Pj4gKyAgICAgICAgZGVz
Y3JpcHRpb246DQo+Pj4+ICsgICAgICAgICAgSW5kaWNhdGVzIHRoZSBmdW5jdGlvbiB0byBzZWxl
Y3QuDQo+Pj4+ICsgICAgICAgIGVudW06IFsgZ3BpbywgaTJjMCwgaTJjMSwgbmFuZCwgc2Rpbywg
c3BpMCwgc3BpMSwgdWFydDAsIHVhcnQxLCB1YXJ0MiwgdWFydDMgXQ0KPj4+PiArDQo+Pj4+ICsg
ICAgICBtYXJ2ZWxsLHBpbnM6DQo+Pj4+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL3N0cmluZy1hcnJheQ0KPj4+PiArICAgICAgICBkZXNjcmlwdGlvbjoN
Cj4+Pj4gKyAgICAgICAgICBBcnJheSBvZiBNUFAgcGlucyB0byBiZSB1c2VkIGZvciB0aGUgZ2l2
ZW4gZnVuY3Rpb24uDQo+Pj4+ICsgICAgICAgIG1pbkl0ZW1zOiAxDQo+Pj4+ICsgICAgICAgIGl0
ZW1zOg0KPj4+PiArICAgICAgICAgIGVudW06IFsgbXBwMCwgbXBwMSwgbXBwMiwgbXBwMywgbXBw
NCwgbXBwNSwgbXBwNiwgbXBwNywgbXBwOCwgbXBwOSwNCj4+Pj4gKyAgICAgICAgICAgICAgICAg
IG1wcDEwLCBtcHAxMSwgbXBwMTIsIG1wcDEzLCBtcHAxNCwgbXBwMTUsIG1wcDE2LCBtcHAxNywg
bXBwMTgsIG1wcDE5LA0KPj4+PiArICAgICAgICAgICAgICAgICAgbXBwMjAsIG1wcDIxLCBtcHAy
MiwgbXBwMjMsIG1wcDI0LCBtcHAyNSwgbXBwMjYsIG1wcDI3LCBtcHAyOCwgbXBwMjksDQo+Pj4+
ICsgICAgICAgICAgICAgICAgICBtcHAzMCwgbXBwMzEsIG1wcDMyLCBtcHAzMywgbXBwMzQsIG1w
cDM1LCBtcHAzNiwgbXBwMzcsIG1wcDM4LCBtcHAzOSwNCj4+Pj4gKyAgICAgICAgICAgICAgICAg
IG1wcDQwLCBtcHA0MSwgbXBwNDIsIG1wcDQzLCBtcHA0NCwgbXBwNDUgXQ0KPj4+PiArDQo+Pj4+
ICthbGxPZjoNCj4+Pj4gKyAgLSAkcmVmOiAicGluY3RybC55YW1sIyINCj4+Pj4gKw0KPj4+PiAr
cmVxdWlyZWQ6DQo+Pj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4+PiArDQo+Pj4+ICthZGRpdGlvbmFs
UHJvcGVydGllczogZmFsc2UNCj4+Pj4gKw0KPj4+PiArZXhhbXBsZXM6DQo+Pj4+ICsgIC0gfA0K
Pj4+PiArICAgIHN5c3RlbS1jb250cm9sbGVyQDgwMDIwMTAwIHsNCj4+Pj4gKyAgICAgIGNvbXBh
dGlibGUgPSAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KPj4+PiArICAgICAgcmVnID0gPDB4ODAw
MjAwMDAgMHgyMD47DQo+Pj4gVGhpcyBpcyB1bnVzdWFsLiBVc3VhbGx5IHRoZSBwaW5jdHJsIHNo
b3VsZCBiZSBhIGRldmljZSBAODAwMjAxMDAsIG5vdA0KPj4+IGNoaWxkIG9mIHN5c2NvbiBub2Rl
LiBXaHkgZG8geW91IG5lZWQgaXQ/IEluIHYxIHlvdSBtZW50aW9uZWQgdGhhdA0KPj4+IHZlbmRv
ciBzb3VyY2VzIGRvIGxpa2UgdGhpcywgYnV0IGl0J3Mgbm90IGNvcnJlY3QgdG8gY29weSB3cm9u
ZyBEVFMuIDopDQo+PiBUaGUgdmVuZG9yIGR0cyBoYXMgdGhpcw0KPj4NCj4+ICAgwqDCoCDCoMKg
wqDCoCBwaW5jdHJsMDogcGluY3RybEA4MDAyMDEwMCB7DQo+PiAgIMKgwqAgwqDCoMKgwqAgwqDC
oMKgIGNvbXBhdGlibGUgPSAibWFydmVsbCxhYzUtcGluY3RybCIsDQo+PiAgIMKgwqAgwqDCoMKg
wqAgwqDCoMKgIMKgwqDCoCDCoMKgwqDCoCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KPj4gICDC
oMKgIMKgwqDCoMKgIMKgwqDCoCByZWcgPSA8MCAweDgwMDIwMTAwIDAgMHgyMD47DQo+PiAgIMKg
wqAgwqDCoMKgwqAgwqDCoMKgIGkyY19tcHBzOiBpMmMtbXBwcyB7DQo+PiAgIMKgwqAgwqDCoMKg
wqAgwqDCoMKgIMKgwqDCoCBtYXJ2ZWxsLHBpbnMgPSAibXBwMjYiLCAibXBwMjciOw0KPj4gICDC
oMKgIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgbWFydmVsbCxmdW5jdGlvbiA9ICJpMmMwLW9wdCI7
DQo+PiAgIMKgwqAgwqDCoMKgwqAgwqDCoMKgIH07DQo+PiAgIMKgwqDCoMKgIH07DQo+Pg0KPj4g
Um9iIHBvaW50ZWQgb3V0IHRoYXQgInN5c2NvbiIsICJzaW1wbGUtbWZkIiBkb24ndCBiZWxvbmcu
IEkgd2VudCBsb29raW5nDQo+PiBhbmQgZm91bmQgbWFydmVsbCxhcm1hZGEtN2stcGluY3RybCB3
aGljaCBoYXMgdGhlIHBpbmN0cmwgYXMgYSBjaGlsZCBvZg0KPj4gYSBzeXNjb24gbm9kZSBhbmQg
d2hhdCB5b3Ugc2VlIGluIHYyIGlzIHRoZSByZXN1bHQuDQo+Pg0KPj4gSSBwcm9iYWJseSB3ZW50
IGEgYml0IHRvbyBmYXIgb2ZmIHRoZSBkZWVwIGVuZCBhbmQgc2hvdWxkIGhhdmUganVzdA0KPj4g
ZHJvcHBlZCB0aGUgInN5c2NvbiIsICJzaW1wbGUtbWZkIiBjb21wYXRpYmxlcy4gSSBldmVuIHdy
b3RlIHRoYXQNCj4+IHZlcnNpb24gYnV0IGRlY2lkZWQgdG8gYWRkIHNvbWUgZ29sZCBwbGF0aW5n
IGJlZm9yZSBJIHN1Ym1pdHRlZCBpdC4NCj4gTW9yZSBvciBsZXNzIGl0IGlzIGV4cGxhaW5lZCBp
bg0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvY3AxMTAt
c3lzdGVtLWNvbnRyb2xsZXIudHh0IHdoeQ0KPiBhcm1hZGEtN2sgdXNlcyBpdCB0aGF0IHdheS4g
VGhlIHBpbmN0cmwgaXMgcGFydCBvZiBzeXN0ZW0gcmVnaXN0ZXJzDQo+IHdoaWNoIGFwcGFyZW50
bHkgaGFzIHRvIGJlIHNoYXJlZCB3aXRoIG90aGVycyAob24gc2hhcmVkIFNGUiByYW5nZSkuDQo+
DQo+IEl0IGRlcGVuZHMgb24geW91ciBjYXNlLCB5b3VyIFNGUiByYW5nZXMgZm9yIHBpbmN0cmwg
YW5kIG90aGVyIGJsb2Nrcy4NCj4NCkkgY2FuIHRlbGwgeW91IHRoYXQgd2l0aG91dCBhIHN5c2Nv
biBub2RlIGluIHRoZSBtaXggc29tZXdoZXJlIHRoZSANCmRyaXZlciB3aWxsIGZhaWwgdG8gbG9h
ZC4gQW5kIHdoZW4gSSBzd2l0Y2ggdG8gDQptdmVidV9waW5jdHJsX3NpbXBsZV9tbWlvX3Byb2Jl
KCkgdGhlIGRyaXZlciBsb2FkcyBidXQgdGhlbiBrZXJuZWwgDQpwYW5pY3Mgd2hlbiBzb21ldGhp
bmcgdHJpZXMgdG8gdXNlIG9uZSBvZiB0aGUgcGluIGZ1bmN0aW9ucy4NCg0KU28gSSB0aGluayB0
aGUgc3lzY29uIGlzIG5lZWRlZC4gSSBqdXN0IG5lZWQgdG8gY29tZSB1cCB3aXRoIGEgYmV0dGVy
IA0KanVzdGlmaWNhdGlvbiB0aGFuICJiZWNhdXNlIGl0J3MgbmVlZGVkIi4NCg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg==
