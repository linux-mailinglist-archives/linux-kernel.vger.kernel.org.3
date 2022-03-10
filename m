Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411024D54A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbiCJWdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbiCJWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:33:30 -0500
X-Greylist: delayed 2446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 14:32:28 PST
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855A3C48A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:32:27 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 839A62C0F87;
        Thu, 10 Mar 2022 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1646951545;
        bh=sSG97l7O7pZq+412xraxx6D6a83hWUpOr9XJFu6cexg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Dcx0XeUMm4R+oCxi5+3BPkxoAp2MNS22CtQqr2+mqYVYghoQMPxkzyanFsMlBufHH
         cjsq3XXFobuFkRSssLkNXdBveEOkWZ8QLN4TX3iW7DRWLrgCsg0w8Ro3hjvP62ctl6
         fg1U1WKEn9RmMYtGaXSsnx7DNpc5E1DoIttqbBx/OVjZFipFq56b62VV6XrN0PDUb8
         t7CmBSAw1+L2TgaIM6d9ce43B4TWqxPAwrNU0E1UxqedGxVz/yqcVqsC1KKCPQ/ici
         P3jKzz6b586nGkNpBQAURcrH3Hz3NwL5B7ZfCPEvy6nCYVscISLfnS075bx9AR2pw2
         1ay7K4WvF14IQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B622a7c790001>; Fri, 11 Mar 2022 11:32:25 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 11 Mar 2022 11:32:25 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 11 Mar 2022 11:32:25 +1300
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
Subject: Re: [PATCH v1 3/4] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v1 3/4] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYNCsI5NkW0HDdWkGhFx9zkUPdX6y3008AgACH1IA=
Date:   Thu, 10 Mar 2022 22:32:24 +0000
Message-ID: <b6128e83-3f97-e728-66f2-25507d0f7abe@alliedtelesis.co.nz>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
 <20220310030039.2833808-4-chris.packham@alliedtelesis.co.nz>
 <YioKgjhEnqylB24M@lunn.ch>
In-Reply-To: <YioKgjhEnqylB24M@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <83B2E9EF1B9359419467BBA74D26A1C8@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=e0hhgOJKJfi28Izc15kA:9 a=QEXdDO2ut3YA:10
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

DQpPbiAxMS8wMy8yMiAwMzoyNiwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFRodSwgTWFyIDEw
LCAyMDIyIGF0IDA0OjAwOjM4UE0gKzEzMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBUaGUg
OThEWDI1MzAgU29DIGlzIHRoZSBDb250cm9sIGFuZCBNYW5hZ2VtZW50IENQVSBpbnRlZ3JhdGVk
IGludG8NCj4+IHRoZSBNYXJ2ZWxsIDk4RFgyNXh4IGFuZCA5OERYMzV4eCBzZXJpZXMgb2Ygc3dp
dGNoIGNoaXAgKGludGVybmFsbHkNCj4+IHJlZmVycmVkIHRvIGFzIEFsbGV5Q2F0NSBhbmQgQWxs
ZXlDYXQ1WCkuDQo+Pg0KPj4gVGhlc2UgZmlsZXMgaGF2ZSBiZWVuIHRha2VuIGZyb20gdGhlIE1h
cnZlbGwgU0RLIGFuZCBsaWdodGx5IGNsZWFuZWQNCj4+IHVwIHdpdGggdGhlIExpY2Vuc2UgYW5k
IGNvcHlyaWdodCByZXRhaW5lZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFt
IDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiAtLS0NCj4+DQo+PiBOb3Rl
czoNCj4+ICAgICAgVGhpcyBoYXMgYSBudW1iZXIgb2YgdW5kb2N1bWVudGVkIGNvbXBhdGlibGUg
c3RyaW5ncy4gSSd2ZSBnb3QgdGhlIFNESw0KPj4gICAgICBzb3VyY2Ugc28gSSdsbCBlaXRoZXIg
YnJpbmcgdGhyb3VnaCB3aGF0ZXZlciBkcml2ZXJzIGFyZSBuZWVkZWQgb3IgbG9vaw0KPj4gICAg
ICBhdCBmb3IgYW4gaW4tdHJlZSBhbHRlcm5hdGl2ZSAoZS5nLiB0aGVyZSBpcyBTREsgY29kZSBm
b3IgYSBhYzUtZ3BpbyBidXQNCj4+ICAgICAgdGhlIGV4aXN0aW5nIG1hcnZlbGwsb3Jpb24tZ3Bp
byBzZWVtcyB0byBjb3ZlciB3aGF0IGlzIG5lZWRlZCBpZiB5b3UgdXNlDQo+PiAgICAgIGFuIGFw
cHJvcHJpYXRlIGJpbmRpbmcpLg0KPiBIaSBDaHJpcw0KPg0KPiBNeSB1bmRlcnN0YW5kIGlzLCB5
b3UgZG9uJ3QgYWRkIG5vZGVzIGZvciB3aGljaCB0aGVyZSBpcyBubw0KPiBkcml2ZXIuIFRoZSBk
cml2ZXIgYW5kIGl0cyBiaW5kaW5nIG5lZWRzIHRvIGJlIHJldmlld2VkIGFuZCBhY2NlcHRlZA0K
PiBiZWZvcmUgdXNlcnMgb2YgaXQgYXJlIGFkZGVkLg0KDQpJIHRob3VnaHQgdGhhdCBtaWdodCBi
ZSB0aGUgY2FzZS4gSSdsbCBiZSBsaW1pdGVkIGluIHdoYXQgSSBjYW4gdGVzdCBvbiANCnRoZSBy
ZWZlcmVuY2UgYm9hcmQgSSBoYXZlLiBJJ2xsIHdvcmsgdG8gYnJpbmcgaW4gd2hhdGV2ZXIgYmlu
ZGluZ3MgYW5kIA0KZHJpdmVycyBJIGNhbiB0ZXN0IGFuZCBwcm9iYWJseSByZW1vdmUgYW55dGhp
bmcgdGhhdCBJIGNhbid0Lg0KDQpJIG1pZ2h0IGJlIGFibGUgdG8gZG8gYW5vdGhlciByb3VuZCBv
ZiBwYXRjaGVzIHdoZW4gd2UgZ2V0IG91ciBib2FyZHMuDQoNCj4NCj4+ICsJbXZEbWEgew0KPj4g
KwkJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLG12X2RtYSI7DQo+PiArCQltZW1vcnktcmVnaW9uID0g
PCZwcmVzdGVyYV9yc3ZkPjsNCj4+ICsJCXN0YXR1cyA9ICJva2F5IjsNCj4+ICsJfTsNCj4gSXMg
dGhpcyBkaWZmZXJlbnQgdG8gdGhlIGV4aXN0aW5nIE1hcnZlbGwgWE9SIGVuZ2luZT8NCg0KWWVz
IGl0IGhhcyBzb21ldGhpbmcgdG8gZG8gd2l0aCB0aGUgRE1BIG1lbW9yeSBmb3IgdGhlIGludGVn
cmF0ZWQgTDMgDQpzd2l0Y2guIEJlY2F1c2UgdGhhdCBkcml2ZXIgZG9lc24ndCBleGlzdCBJJ2xs
IHByb2JhYmx5IHJlbW92ZSB0aGlzIG5vZGUgDQooYW5kIHRoZSBvdGhlciBwcmVzdGVyYSBub2Rl
IGJlbG93KSBpbiB2Mi4NCg0KDQo+PiArCQkJbWRpbzogbWRpb0AyMDAwMCB7DQo+PiArCQkJCSNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKwkJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4+ICsJCQkJ
Y29tcGF0aWJsZSA9ICJtYXJ2ZWxsLG9yaW9uLW1kaW8iOw0KPj4gKwkJCQlyZWcgPSA8MHgyMjAw
NCAweDQ+Ow0KPj4gKwkJCQljbG9ja3MgPSA8JmNvcmVfY2xvY2s+Ow0KPj4gKwkJCQlwaHkwOiBl
dGhlcm5ldC1waHlAMCB7DQo+PiArCQkJCQlyZWcgPSA8IDAgMCA+Ow0KPj4gKwkJCQl9Ow0KPiBU
aGlzIGVtYmVkZGVkIFBIWSBsb29rcyB3cm9uZy4gcmVnIHNob3VsZCBiZSBhIHNpbmdsZSB2YWx1
ZS4NCj4NCj4gSXMgdGhlIFBIWSBpbnRlcm5hbD8gR2VuZXJhbGx5LCB0aGUgUEhZIGlzIHB1dCBp
biB0aGUgLmR0cyBmaWxlLCBidXQNCj4gaWYgaXQgaXMgaW50ZXJuYWwsIHRoYXQgdGhlIC5kdHNp
IHdvdWxkIGJlIGNvcnJlY3QuDQoNCkxvb2tzIGxpa2UgYW4gZXh0ZXJuYWwgODhFMTUxMiBQSFkg
c28gSSdsbCBtb3ZlIHRoYXQgdG8gdGhlIGJvYXJkIGR0cy4NCg0KPg0KPj4gKwkJCQlzZGhjaTA6
IHNkaGNpQDgwNWMwMDAwIHsNCj4+ICsJCQkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxhYzUtc2Ro
Y2kiLCAibWFydmVsbCxhcm1hZGEtYXA4MDYtc2RoY2kiOw0KPiBUaGlzIGFkZGl0aW9uYWwgY29t
cGF0aWJsZSBzaG91bGQgYmUgYWRkZWQgdG8gdGhlIGV4aXN0aW5nIGJpbmRpbmcNCj4gZG9jdW1l
bnQuDQpJJ2xsIHNlZSB3aGF0IGRpZmZlcmVuY2VzIHRoZXJlIGFyZSB3aXRoIHRoZSBhcDgwNi1z
ZGhjaS4gSSBtaWdodCBiZSANCmFibGUgdG8gcmVtb3ZlIGl0Lg0KPg0KPj4gKwkJCWV0aDA6IGV0
aGVybmV0QDIwMDAwIHsNCj4+ICsJCQkJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS1hYzUt
bmV0YSI7DQo+IFNvIGl0IGlzIG5vdCBjb21wYXRpYmxlIHdpdGggcGxhaW4gbmF0YT8NCg0KVGhl
cmUgaXMgc29tZSBvZGQgbXV4aW5nIHNldHVwIHdoZXJlIHRoZSBzZXJkZXMgYXJlIGVpdGhlciBT
R01JSSBvciBQQ0llIA0Kb3IgY2FuIGV2ZW4gYmUgY29ubmVjdGVkIHRvIHRoZSBpbnRlcm5hbCBz
d2l0Y2guIFdoZXRoZXIgdGhlIEV0aGVybmV0IA0KZHJpdmVyIG5lZWRzIHRvIGNhcmUgYWJvdXQg
aXQgSSdtIG5vdCBzdXJlLg0KDQo+DQo+PiArCQkJCXJlZyA9IDwweDAgMHgyMDAwMCAweDAgMHg0
MDAwPjsNCj4+ICsJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDQ1IElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPj4gKwkJCQljbG9ja3MgPSA8JmNvcmVfY2xvY2s+Ow0KPj4gKwkJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KPj4gKwkJCQlwaHktbW9kZSA9ICJzZ21paSI7DQo+PiArCQkJfTsNCj4+ICsN
Cj4+ICsJCQlldGgxOiBldGhlcm5ldEAyNDAwMCB7DQo+PiArCQkJCWNvbXBhdGlibGUgPSAibWFy
dmVsbCxhcm1hZGEtYWM1LW5ldGEiOw0KPj4gKwkJCQlyZWcgPSA8MHgwIDB4MjQwMDAgMHgwIDB4
NDAwMD47DQo+PiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA1NSBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsNCj4+ICsJCQkJY2xvY2tzID0gPCZjb3JlX2Nsb2NrPjsNCj4+ICsJCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4+ICsJCQkJcGh5LW1vZGUgPSAic2dtaWkiOw0KPj4gKwkJCQlmaXhlZC1s
aW5rIHsNCj4+ICsJCQkJCXNwZWVkID0gPDEwMD47DQo+PiArCQkJCQlmdWxsLWR1cGxleDsNCj4+
ICsJCQkJfTsNCj4gRmFzdCBFdGhlcm5ldD8gWWV0IFNHTUlJPw0KDQpJIHRoaW5rIHRoZSByZWZl
cmVuY2UgY29kZSBtaWdodCBiZSB0cnlpbmcgdG8gY29ubmVjdCB0aGlzIHRvIHRoZSANCmludGVy
bmFsIHN3aXRjaC4gSSdsbCByZW1vdmUgdGhlIGZpeGVkLWxpbmsgcG9ydGlvbi4NCg0KPj4gKwkJ
CS8qIFVTQjAgaXMgYSBob3N0IFVTQiAqLw0KPj4gKwkJCXVzYjA6IHVzYkA4MDAwMCB7DQo+PiAr
CQkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxhYzUtZWhjaSIsICJtYXJ2ZWxsLG9yaW9uLWVoY2ki
Ow0KPiBQbGVhc2UgYWRkIHRoaXMgY29tcGF0aWJsZSB0byB0aGUgYmluZGluZy4NCldpbGwgZG8g
KG9yIGRlbGV0ZSkuDQo+DQo+PiArCQlwY2llMDogcGNpZUA4MDBhMDAwMCB7DQo+PiArCQkJY29t
cGF0aWJsZSA9ICJtYXJ2ZWxsLGFjNS1wY2llIiwgInNucHMsZHctcGNpZSI7DQo+IFBsZWFzZSBh
ZGQgdGhpcyAuLi4NCldpbGwgZG8gKG9yIGRlbGV0ZSkuDQo+DQo+PiArCQkJc3BpZmxhc2gwOiBz
cGktZmxhc2hAMCB7DQo+PiArCQkJCWNvbXBhdGlibGUgPSAic3BpLW5vciI7DQo+PiArCQkJCXNw
aS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCj4+ICsJCQkJc3BpLXR4LWJ1cy13aWR0aCA9
IDwxPjsgLyogMS1zaW5nbGUsIDItZHVhbCwgNC1xdWFkICovDQo+PiArCQkJCXNwaS1yeC1idXMt
d2lkdGggPSA8MT47IC8qIDEtc2luZ2xlLCAyLWR1YWwsIDQtcXVhZCAqLw0KPj4gKwkJCQlyZWcg
PSA8MD47DQo+PiArDQo+PiArCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKwkJCQkjc2l6
ZS1jZWxscyA9IDwxPjsNCj4+ICsNCj4+ICsJCQkJcGFydGl0aW9uQDAgew0KPj4gKwkJCQkJbGFi
ZWwgPSAic3BpX2ZsYXNoX3BhcnQwIjsNCj4+ICsJCQkJCXJlZyA9IDwweDAgMHg4MDAwMDA+Ow0K
Pj4gKwkJCQl9Ow0KPj4gKw0KPj4gKwkJCQlwYXJpdGlvbkAxIHsNCj4+ICsJCQkJCWxhYmVsID0g
InNwaV9mbGFzaF9wYXJ0MSI7DQo+PiArCQkJCQlyZWcgPSA8MHg4MDAwMDAgMHg3MDAwMDA+Ow0K
Pj4gKwkJCQl9Ow0KPj4gKw0KPj4gKwkJCQlwYXJpdGlvbkAyIHsNCj4+ICsJCQkJCWxhYmVsID0g
InNwaV9mbGFzaF9wYXJ0MiI7DQo+PiArCQkJCQlyZWcgPSA8MHhGMDAwMDAgMHgxMDAwMDA+Ow0K
Pj4gKwkJCQl9Ow0KPiBUaGUgcGFydGl0aW9uaW5nIG9mIHRoZSBmbGFzaCBpIHdvdWxkIGV4cGVj
dCB0byBiZSBib2FyZCBzcGVjaWZpYywgc28NCj4gYmVsb25ncyBvbiB0aGUgLmR0cyBmaWxlLg0K
V2lsbCBtb3ZlLg0KPj4gKwkJbmFuZDogbmFuZEA4MDViMDAwMCB7DQo+PiArCQkJY29tcGF0aWJs
ZSA9ICJtYXJ2ZWxsLGFjNS1uYW5kLWNvbnRyb2xsZXIiOw0KPiBUaGUgY3VycmVudCBOQU5EIGRy
aXZlciBkb2VzIG5vdCB3b3JrPw0KDQpUaGlzIGlzIG9uZSBvZiB0aGUgdGhpbmdzIEkgY2FuJ3Qg
dGVzdCBvbiB0aGUgYm9hcmQgSSBoYXZlICh1c2VzIGVNTUMgDQppbnN0ZWFkIG9mIE5BTkQpLiBT
aG91bGQgSSBwdXQgIm1hcnZlbGwsYXJtYWRhLThrLW5hbmQtY29udHJvbGxlciIgaW4gYXMgDQph
IHBsYWNlaG9sZGVyIG9yIGxlYXZlIHRoZSBub2RlIG91dCBlbnRpcmVseT8NCg0KPg0KPj4gKwkJ
cHJlc3RlcmEgew0KPj4gKwkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxhcm1hZGEtYWM1LXN3aXRj
aCI7DQo+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDB4MjMgSVJRX1RZUEVfTEVWRUxfSElH
SD47DQo+PiArCQkJc3RhdHVzID0gIm9rYXkiOw0KPj4gKwkJfTsNCj4gSGVyZSB3ZSBoYXZlIHRv
IGJlIGNhcmVmdWwgd2l0aCBuYW1pbmcuIEkgYXNzdW1lIE1hcnZlbGwgaW4ga2VybmVsDQo+IFBy
ZXRlcmEgZHJpdmVyIGRvZXMgbm90IGFjdHVhbGx5IHdvcmsgb24gdGhlIHByZXN0ZXJhIGhhcmR3
YXJlPyBUaGF0DQo+IGRyaXZlciBhc3N1bWVzIHlvdSBhcmUgcnVubmluZyBNYXJ2ZWxsIGZpcm13
YXJlIG9uIHRoaXMgU29DLCBhbmQgaGF2ZQ0KPiBhIGhvc3QgcnVubmluZyB0aGF0IGRyaXZlciB3
aGljaCB0YWxrcyB0byB0aGUgU29DIGZpcm13YXJlPw0KPg0KPiBUaGUgbmFtZSBwZXJzdGVyYSBz
ZWVtcyBPLkssIGFuZCB0aGUgY29tcGF0aWJsZQ0KPiBtYXJ2ZWxsLGFybWFkYS1hYzUtc3dpdGNo
IG1ha2VzIGl0IGNsZWFyIHRoZSBwcmVzdGVyYSBkcml2ZXIgY2Fubm90IGJlDQo+IHVzZWQuIEhv
d2V2ZXIsIHVudGlsIHdlIGRvIGFjdHVhbGx5IGhhdmUgYSBkcml2ZXIsIGkgZG9uJ3QgdGhpbmsg
dGhpcw0KPiBub2RlIHNob3VsZCBiZSBhZGRlZC4NCg0KT24gb3RoZXIgU29DcyBJIGRpZCBwdXQg
aW4gc3BlY2lmaWMgcHJlc3RlcmEgY29tcGF0aWJsZXMgd2l0aCANCmRvY3VtZW50YXRpb24uIEkn
dmUgZXZlbiBnb3Qgb3V0IG9mIHRyZWUgY29kZSB0aGF0IHVzZXMgdGhvc2UgDQpjb21wYXRpYmxl
cyBhbHRob3VnaCBNYXJ2ZWxsJ3MgU0RLIGhhc24ndCBjYXVnaHQgdXAgYW5kIGlzIHN0aWxsIHVz
aW5nIA0Kb2ZfZmluZF9ub3RlX2J5X3BhdGgoIi9zb2MvcHJlc3RlcmEiKS4NCg0KPj4gKwkJd2F0
Y2hkb2dAODAyMTYwMDAgew0KPj4gKwkJCWNvbXBhdGlibGUgPSAibWFydmVsbCxhYzUtd2QiOw0K
PiBOb3QgY29tcGF0aWJsZSB3aXRoIHRoZSBleGlzdGluZyB3YXRjaGRvZyBkcml2ZXI/DQpXaWxs
IGNoZWNrIGFuZCBlaXRoZXIgYWRkIGJpbmRpbmcgb3IgdXNlIGEgZGlmZmVyZW50IGNvbXBhdGli
bGUuDQo+DQo+ICAgICAgQW5kcmV3
