Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88684DA468
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351893AbiCOVOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbiCOVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:14:05 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902EC262C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:12:48 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3F27B2C02D7;
        Tue, 15 Mar 2022 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647378767;
        bh=35QIpIUHHkRNTEJEkURa99F4DaNn04DRlFCYuZIV18k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gq824tMgz3tPVMvr8ZRveFREtendrwV17mHj/pLzec716aXGqpVZ+C+fOI1odxzwo
         2skanZYY94gb3wtVh7hzuNbXsZtTAFf9tT0dQZykJVhizGuzrsHfSQ1GWwTu8m8oi1
         GJVHNl/6j+WL6O3gLWcF0XckYlNH93zCKiyhAmbR7zci59NuLM2akXfc13ycb8IQss
         lMeo8AtBgnUFYX8KWmASEk9TcUi/mSqwWrR1vcQiW849HYhQXxx34uJlR7EFQGUvbo
         12xa+OoJmD/iZm4Iel65gj9xmoIuBd4esvtZ66fOyr6EZC60wf6Emd1+SFWq2Y13HY
         ZBbFit+zgpCmA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6231014f0001>; Wed, 16 Mar 2022 10:12:47 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 16 Mar 2022 10:12:46 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Wed, 16 Mar 2022 10:12:46 +1300
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
Thread-Index: AQHYN+r1YarBXjvcwESVFtaA5OJaJay/ajqAgACu0AA=
Date:   Tue, 15 Mar 2022 21:12:45 +0000
Message-ID: <7e73bba0-8b54-772c-2e94-8fca4e4e3294@alliedtelesis.co.nz>
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-2-chris.packham@alliedtelesis.co.nz>
 <4e6df448-5562-8f50-6f46-91acb279bc1a@canonical.com>
In-Reply-To: <4e6df448-5562-8f50-6f46-91acb279bc1a@canonical.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EBA50F0A43A724C865E36709E876A99@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=IDRCGsx7AxePA5swuwEA:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
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

KHRyaW1tZWQgY2MgbGlzdCB0byB0aGUgYXJtLCBwaW5jdHJsIGFuZCBkdCBwZW9wbGUpDQoNCk9u
IDE1LzAzLzIyIDIzOjQ2LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAxNC8wMy8y
MDIyIDIyOjMxLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gQWRkIEpTT04gc2NoZW1hIGZvciBt
YXJ2ZWxsLGFjNS1waW5jdHJsIHByZXNlbnQgb24gdGhlIE1hcnZlbGwgOThEWDI1MzANCj4+IFNv
Qy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+DQo+PiAtLS0NCj4+DQo+PiBOb3RlczoNCj4+ICAgICAgQ2hhbmdl
cyBpbiB2MjoNCj4+ICAgICAgLSBSZW1vdmUgc3lzY29uIGFuZCBzaW1wbGUtbWZkIGNvbXBhdGli
bGVzDQo+Pg0KPj4gICAuLi4vYmluZGluZ3MvcGluY3RybC9tYXJ2ZWxsLGFjNS1waW5jdHJsLnlh
bWwgfCA3MCArKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3MCBpbnNl
cnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGluY3RybC9tYXJ2ZWxsLGFjNS1waW5jdHJsLnlhbWwNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbWFydmVs
bCxhYzUtcGluY3RybC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bp
bmN0cmwvbWFydmVsbCxhYzUtcGluY3RybC55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi42NWFmMWQ1ZjVmZTANCj4+IC0tLSAvZGV2L251bGwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGws
YWM1LXBpbmN0cmwueWFtbA0KPj4gQEAgLTAsMCArMSw3MCBAQA0KPj4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UNCj4+ICslWUFNTCAxLjIN
Cj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9zY2FubWFpbC50cnVzdHdhdmUuY29tLz9jPTIwOTg4
JmQ9dnU2dzRsR3ZwYmR4NXg3WTV3U0dNUV9hUGEwMEJuajE5Y2U4ZUdQMFFBJnU9aHR0cCUzYSUy
ZiUyZmRldmljZXRyZWUlMmVvcmclMmZzY2hlbWFzJTJmcGluY3RybCUyZm1hcnZlbGwlMmNhYzUt
cGluY3RybCUyZXlhbWwlMjMNCj4+ICskc2NoZW1hOiBodHRwOi8vc2Nhbm1haWwudHJ1c3R3YXZl
LmNvbS8/Yz0yMDk4OCZkPXZ1Nnc0bEd2cGJkeDV4N1k1d1NHTVFfYVBhMDBCbmoxOWNQcmZqVHlU
ZyZ1PWh0dHAlM2ElMmYlMmZkZXZpY2V0cmVlJTJlb3JnJTJmbWV0YS1zY2hlbWFzJTJmY29yZSUy
ZXlhbWwlMjMNCj4+ICsNCj4+ICt0aXRsZTogTWFydmVsbCBBQzUgcGluIGNvbnRyb2xsZXINCj4+
ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hh
bUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgQmlu
ZGluZ3MgZm9yIE1hcnZlbGwncyBBQzUgbWVtb3J5LW1hcHBlZCBwaW4gY29udHJvbGxlci4NCj4+
ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgY29uc3Q6IG1h
cnZlbGwsYWM1LXBpbmN0cmwNCj4+ICsNCj4+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4+ICsgICct
cGlucyQnOg0KPj4gKyAgICB0eXBlOiBvYmplY3QNCj4+ICsgICAgJHJlZjogcGlubXV4LW5vZGUu
eWFtbCMNCj4+ICsNCj4+ICsgICAgcHJvcGVydGllczoNCj4+ICsgICAgICBtYXJ2ZWxsLGZ1bmN0
aW9uOg0KPj4gKyAgICAgICAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3N0cmluZyINCj4+ICsgICAgICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgICAgICBJbmRpY2F0
ZXMgdGhlIGZ1bmN0aW9uIHRvIHNlbGVjdC4NCj4+ICsgICAgICAgIGVudW06IFsgZ3BpbywgaTJj
MCwgaTJjMSwgbmFuZCwgc2Rpbywgc3BpMCwgc3BpMSwgdWFydDAsIHVhcnQxLCB1YXJ0MiwgdWFy
dDMgXQ0KPj4gKw0KPj4gKyAgICAgIG1hcnZlbGwscGluczoNCj4+ICsgICAgICAgICRyZWY6IC9z
Y2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmluZy1hcnJheQ0KPj4gKyAgICAgICAg
ZGVzY3JpcHRpb246DQo+PiArICAgICAgICAgIEFycmF5IG9mIE1QUCBwaW5zIHRvIGJlIHVzZWQg
Zm9yIHRoZSBnaXZlbiBmdW5jdGlvbi4NCj4+ICsgICAgICAgIG1pbkl0ZW1zOiAxDQo+PiArICAg
ICAgICBpdGVtczoNCj4+ICsgICAgICAgICAgZW51bTogWyBtcHAwLCBtcHAxLCBtcHAyLCBtcHAz
LCBtcHA0LCBtcHA1LCBtcHA2LCBtcHA3LCBtcHA4LCBtcHA5LA0KPj4gKyAgICAgICAgICAgICAg
ICAgIG1wcDEwLCBtcHAxMSwgbXBwMTIsIG1wcDEzLCBtcHAxNCwgbXBwMTUsIG1wcDE2LCBtcHAx
NywgbXBwMTgsIG1wcDE5LA0KPj4gKyAgICAgICAgICAgICAgICAgIG1wcDIwLCBtcHAyMSwgbXBw
MjIsIG1wcDIzLCBtcHAyNCwgbXBwMjUsIG1wcDI2LCBtcHAyNywgbXBwMjgsIG1wcDI5LA0KPj4g
KyAgICAgICAgICAgICAgICAgIG1wcDMwLCBtcHAzMSwgbXBwMzIsIG1wcDMzLCBtcHAzNCwgbXBw
MzUsIG1wcDM2LCBtcHAzNywgbXBwMzgsIG1wcDM5LA0KPj4gKyAgICAgICAgICAgICAgICAgIG1w
cDQwLCBtcHA0MSwgbXBwNDIsIG1wcDQzLCBtcHA0NCwgbXBwNDUgXQ0KPj4gKw0KPj4gK2FsbE9m
Og0KPj4gKyAgLSAkcmVmOiAicGluY3RybC55YW1sIyINCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+
ICsgIC0gY29tcGF0aWJsZQ0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0K
Pj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgIHN5c3RlbS1jb250cm9sbGVy
QDgwMDIwMTAwIHsNCj4+ICsgICAgICBjb21wYXRpYmxlID0gInN5c2NvbiIsICJzaW1wbGUtbWZk
IjsNCj4+ICsgICAgICByZWcgPSA8MHg4MDAyMDAwMCAweDIwPjsNCj4gVGhpcyBpcyB1bnVzdWFs
LiBVc3VhbGx5IHRoZSBwaW5jdHJsIHNob3VsZCBiZSBhIGRldmljZSBAODAwMjAxMDAsIG5vdA0K
PiBjaGlsZCBvZiBzeXNjb24gbm9kZS4gV2h5IGRvIHlvdSBuZWVkIGl0PyBJbiB2MSB5b3UgbWVu
dGlvbmVkIHRoYXQNCj4gdmVuZG9yIHNvdXJjZXMgZG8gbGlrZSB0aGlzLCBidXQgaXQncyBub3Qg
Y29ycmVjdCB0byBjb3B5IHdyb25nIERUUy4gOikNCg0KVGhlIHZlbmRvciBkdHMgaGFzIHRoaXMN
Cg0KIMKgwqAgwqDCoMKgwqAgcGluY3RybDA6IHBpbmN0cmxAODAwMjAxMDAgew0KIMKgwqAgwqDC
oMKgwqAgwqDCoMKgIGNvbXBhdGlibGUgPSAibWFydmVsbCxhYzUtcGluY3RybCIsDQogwqDCoCDC
oMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoMKgICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQog
wqDCoCDCoMKgwqDCoCDCoMKgwqAgcmVnID0gPDAgMHg4MDAyMDEwMCAwIDB4MjA+Ow0KIMKgwqAg
wqDCoMKgwqAgwqDCoMKgIGkyY19tcHBzOiBpMmMtbXBwcyB7DQogwqDCoCDCoMKgwqDCoCDCoMKg
wqAgwqDCoMKgIG1hcnZlbGwscGlucyA9ICJtcHAyNiIsICJtcHAyNyI7DQogwqDCoCDCoMKgwqDC
oCDCoMKgwqAgwqDCoMKgIG1hcnZlbGwsZnVuY3Rpb24gPSAiaTJjMC1vcHQiOw0KIMKgwqAgwqDC
oMKgwqAgwqDCoMKgIH07DQogwqDCoMKgwqAgfTsNCg0KUm9iIHBvaW50ZWQgb3V0IHRoYXQgInN5
c2NvbiIsICJzaW1wbGUtbWZkIiBkb24ndCBiZWxvbmcuIEkgd2VudCBsb29raW5nIA0KYW5kIGZv
dW5kIG1hcnZlbGwsYXJtYWRhLTdrLXBpbmN0cmwgd2hpY2ggaGFzIHRoZSBwaW5jdHJsIGFzIGEg
Y2hpbGQgb2YgDQphIHN5c2NvbiBub2RlIGFuZCB3aGF0IHlvdSBzZWUgaW4gdjIgaXMgdGhlIHJl
c3VsdC4NCg0KSSBwcm9iYWJseSB3ZW50IGEgYml0IHRvbyBmYXIgb2ZmIHRoZSBkZWVwIGVuZCBh
bmQgc2hvdWxkIGhhdmUganVzdCANCmRyb3BwZWQgdGhlICJzeXNjb24iLCAic2ltcGxlLW1mZCIg
Y29tcGF0aWJsZXMuIEkgZXZlbiB3cm90ZSB0aGF0IA0KdmVyc2lvbiBidXQgZGVjaWRlZCB0byBh
ZGQgc29tZSBnb2xkIHBsYXRpbmcgYmVmb3JlIEkgc3VibWl0dGVkIGl0Lg0KDQo+DQo+DQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
