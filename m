Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3D4D55FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbiCJXyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344993AbiCJXyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:54:40 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF34156C42
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:53:37 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2017C2C0E1F;
        Thu, 10 Mar 2022 23:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1646956415;
        bh=vujzJPHjSKmwl+2dUU5zKMRoFcHfP9RY8LWRfAitMbQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=qmcvywYGeh9qw3i49CPyGdlDi9Rc9ObLWf4vULR5+fapIYjTJ39qbEniJj/XZk1s6
         RHijyngx+RDQPWG5gFfRUkGX1oFNsL3AuejFqk9pJxl2M5n4IE7R2eRhG8n93i65yx
         0e+7fyiQ2xf3RJeXw1DNdo8oJsD8o8So37FjJwwq5j6sAPKZqtG2Ds0X5eFN+Vd+eN
         TGeRgfR7QFoemn97c/wYT2Ry7XySbI/5X9qjEyLFEuOugGK0mbtwqkM0ZM4+POU4Gn
         9cZplCwVOvVB64Qyg3n5uE3BXTd4iTVZFevoFgb9046HYceT8KNHY1zELi+KjskrUM
         y68AhSNQu/vfw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B622a8f7f0001>; Fri, 11 Mar 2022 12:53:35 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Mar 2022 12:53:34 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 11 Mar 2022 12:53:34 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Rob Herring <robh@kernel.org>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 1/4] dt-bindings: pinctrl: mvebu: Document bindings for
 AC5
Thread-Topic: [PATCH v1 1/4] dt-bindings: pinctrl: mvebu: Document bindings
 for AC5
Thread-Index: AQHYNCsIl5tLb0xtVEaOzKMz8FW+tay4ae4AgAAH5YA=
Date:   Thu, 10 Mar 2022 23:53:34 +0000
Message-ID: <bdbe78d5-8e86-940f-0cb8-19ffe0f74ef7@alliedtelesis.co.nz>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
 <20220310030039.2833808-2-chris.packham@alliedtelesis.co.nz>
 <YiqI3Gjcf8AFVQYL@robh.at.kernel.org>
In-Reply-To: <YiqI3Gjcf8AFVQYL@robh.at.kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <72F3A25E5BCA8E4E84EC0B9AD7A9B1BE@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=GfO8bRqPlC0C9X70s78A:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
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

SGkgUm9iLA0KDQpPbiAxMS8wMy8yMiAxMjoyNSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFRo
dSwgTWFyIDEwLCAyMDIyIGF0IDA0OjAwOjM2UE0gKzEzMDAsIENocmlzIFBhY2toYW0gd3JvdGU6
DQo+PiBBZGQgSlNPTiBzY2hlbWEgZm9yIG1hcnZlbGwsYWM1LXBpbmN0cmwgcHJlc2VudCBvbiB0
aGUgTWFydmVsbCA5OERYMjUzMA0KPj4gU29DLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlz
IFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+IC0tLQ0KPj4g
ICAuLi4vYmluZGluZ3MvcGluY3RybC9tYXJ2ZWxsLGFjNS1waW5jdHJsLnlhbWwgfCA3MyArKysr
KysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3MyBpbnNlcnRpb25zKCspDQo+
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGluY3RybC9tYXJ2ZWxsLGFjNS1waW5jdHJsLnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbWFydmVsbCxhYzUtcGluY3Ry
bC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbWFydmVs
bCxhYzUtcGluY3RybC55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAw
MDAwMDAwMDAwLi5jN2FiM2QwZTg0MjANCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGwsYWM1LXBpbmN0cmwu
eWFtbA0KPj4gQEAgLTAsMCArMSw3MyBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+
ICskaWQ6IGh0dHA6Ly9zY2FubWFpbC50cnVzdHdhdmUuY29tLz9jPTIwOTg4JmQ9NUlpcTRvNkRt
cjd4aXdrSk5ycjI1VE54WXhLNzhsSVVFV2VKLXlxMFVBJnU9aHR0cCUzYSUyZiUyZmRldmljZXRy
ZWUlMmVvcmclMmZzY2hlbWFzJTJmcGluY3RybCUyZm1hcnZlbGwlMmNhYzUtcGluY3RybCUyZXlh
bWwlMjMNCj4+ICskc2NoZW1hOiBodHRwOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0yMDk4
OCZkPTVJaXE0bzZEbXI3eGl3a0pOcnIyNVROeFl4Szc4bElVRVdQZV9YMnlYZyZ1PWh0dHAlM2El
MmYlMmZkZXZpY2V0cmVlJTJlb3JnJTJmbWV0YS1zY2hlbWFzJTJmY29yZSUyZXlhbWwlMjMNCj4+
ICsNCj4+ICt0aXRsZTogTWFydmVsbCBBQzUgcGluIGNvbnRyb2xsZXINCj4+ICsNCj4+ICttYWlu
dGFpbmVyczoNCj4+ICsgIC0gQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxl
c2lzLmNvLm56Pg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgQmluZGluZ3MgZm9yIE1h
cnZlbGwncyBBQzUgbWVtb3J5LW1hcHBlZCBwaW4gY29udHJvbGxlci4NCj4+ICsNCj4+ICtwcm9w
ZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBj
b25zdDogbWFydmVsbCxhYzUtcGluY3RybA0KPj4gKyAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPj4g
KyAgICAgIC0gY29uc3Q6IHNpbXBsZS1tZmQNCj4gSG93IGlzIHRoaXMgYSAnc3lzY29uJyBvciAn
c2ltcGxlLW1mZCcgRm9yIHN5c2Nvbiwgd2hhdCBvdGhlcg0KPiBmdW5jdGlvbnMvcmVnaXN0ZXJz
IGRvZXMgaXQgaGF2ZT8gRm9yIHNpbXBsZS1tZmQsIHdoYXQgb3RoZXIgZnVuY3Rpb25zPw0KPiBZ
b3UgaGF2ZW4ndCBkZWZpbmVkIHRoZW0gaW4gdGhlIHNjaGVtYS4NCg0KSXQncyBpbiB0aGUgdmVu
ZG9yIGR0cyBJIGhhdmUgYW5kIGl0J3MgbGlrZWx5IHRoZXJlIGJlY2F1c2UgDQptYXJ2ZWxsLGFy
bWFkYS0zN3h4LXBpbmN0cmwudHh0IGhhcyB0aGUgc2FtZSBzeXNjb24gYW5kIHNpbXBsZS1tZmQg
DQpjb21wYXRpYmxlcy4gTG9va2luZyBhdCBob3cgdGhpcyBpcyB1c2VkIEkgdGhpbmsgaXQncyBt
b3JlIGxpa2UgdGhlIA0Kb2xkZXIgbXZlYnUgcGluY3RybCBkZXZpY2VzLiBJJ2xsIHJlbW92ZSB0
aGVzZSB0d28gY29tcGF0aWJsZXMgYW5kIA0KdXBkYXRlIHRoZSBkdHNpIGZpbGUuDQoNCj4NCj4g
YmxhbmsgbGluZSBuZWVkZWQgaGVyZS4NCj4NCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6
IDENCj4+ICsNCj4+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4+ICsgICctcGlucyQnOg0KPj4gKyAg
ICB0eXBlOiBvYmplY3QNCj4+ICsgICAgJHJlZjogcGlubXV4LW5vZGUueWFtbCMNCj4+ICsNCj4+
ICsgICAgcHJvcGVydGllczoNCj4+ICsgICAgICBtYXJ2ZWxsLGZ1bmN0aW9uOg0KPj4gKyAgICAg
ICAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmluZyINCj4+ICsg
ICAgICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgICAgICBJbmRpY2F0ZXMgdGhlIGZ1bmN0aW9u
IHRvIHNlbGVjdC4NCj4+ICsgICAgICAgIGVudW06IFsgZ3BpbywgaTJjMCwgaTJjMSwgbmFuZCwg
c2Rpbywgc3BpMCwgc3BpMSwgdWFydDAsIHVhcnQxLCB1YXJ0MiwgdWFydDMgXQ0KPj4gKw0KPj4g
KyAgICAgIG1hcnZlbGwscGluczoNCj4+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL3N0cmluZy1hcnJheQ0KPj4gKyAgICAgICAgZGVzY3JpcHRpb246DQo+
PiArICAgICAgICAgIEFycmF5IG9mIE1QUCBwaW5zIHRvIGJlIHVzZWQgZm9yIHRoZSBnaXZlbiBm
dW5jdGlvbi4NCj4+ICsgICAgICAgIG1pbkl0ZW1zOiAxDQo+PiArICAgICAgICBpdGVtczoNCj4+
ICsgICAgICAgICAgZW51bTogWyBtcHAwLCBtcHAxLCBtcHAyLCBtcHAzLCBtcHA0LCBtcHA1LCBt
cHA2LCBtcHA3LCBtcHA4LCBtcHA5LA0KPj4gKyAgICAgICAgICAgICAgICAgIG1wcDEwLCBtcHAx
MSwgbXBwMTIsIG1wcDEzLCBtcHAxNCwgbXBwMTUsIG1wcDE2LCBtcHAxNywgbXBwMTgsIG1wcDE5
LA0KPj4gKyAgICAgICAgICAgICAgICAgIG1wcDIwLCBtcHAyMSwgbXBwMjIsIG1wcDIzLCBtcHAy
NCwgbXBwMjUsIG1wcDI2LCBtcHAyNywgbXBwMjgsIG1wcDI5LA0KPj4gKyAgICAgICAgICAgICAg
ICAgIG1wcDMwLCBtcHAzMSwgbXBwMzIsIG1wcDMzLCBtcHAzNCwgbXBwMzUsIG1wcDM2LCBtcHAz
NywgbXBwMzgsIG1wcDM5LA0KPj4gKyAgICAgICAgICAgICAgICAgIG1wcDQwLCBtcHA0MSwgbXBw
NDIsIG1wcDQzLCBtcHA0NCwgbXBwNDUgXQ0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVm
OiAicGluY3RybC55YW1sIyINCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJs
ZQ0KPj4gKyAgLSByZWcNCj4+ICsNCj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4+
ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0KPj4gKyAgICBwaW5jdHJsQDgwMDIwMTAwIHsN
Cj4+ICsgICAgICBjb21wYXRpYmxlID0gIm1hcnZlbGwsYWM1LXBpbmN0cmwiLA0KPj4gKyAgICAg
ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+PiArICAgICAgcmVnID0gPDB4ODAwMjAxMDAgMHgy
MD47DQo+PiArDQo+PiArICAgICAgaTJjMF9waW5zOiBpMmMwLXBpbnMgew0KPj4gKyAgICAgICAg
bWFydmVsbCxwaW5zID0gIm1wcDI2IiwgIm1wcDI3IjsNCj4+ICsgICAgICAgIG1hcnZlbGwsZnVu
Y3Rpb24gPSAiaTJjMCI7DQo+PiArICAgICAgfTsNCj4+ICsNCj4+ICsgICAgICBpMmMwX2dwaW86
IGkyYzAtZ3Bpby1waW5zIHsNCj4+ICsgICAgICAgIG1hcnZlbGwscGlucyA9ICJtcHAyNiIsICJt
cHAyNyI7DQo+PiArICAgICAgICBtYXJ2ZWxsLGZ1bmN0aW9uID0gImdwaW8iOw0KPj4gKyAgICAg
IH07DQo+PiArICAgIH07DQo+PiAtLSANCj4+IDIuMzUuMQ0KPj4NCj4+
