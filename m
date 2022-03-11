Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAA74D595F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346164AbiCKEBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242746AbiCKEBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:01:43 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3139A4FF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:00:39 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 36B312C06A1;
        Fri, 11 Mar 2022 04:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1646971238;
        bh=fI5ElAgFpBygZYrOTBcm5px7Y1c6hHVlnSDtWs+kTyk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WFfAbYsUsE3RJA7dKBUE4uWBe2/0ZDRgskH2POcXlAN8xx0Yy5aH1BQhyzoLOdaog
         M15yCmkllmK3gJbuydl9FzCSmDS7dK//b0rsAuRukV5zhu5MosMND78D7eMwZVfKHI
         GJol4wvZwYnTOdVCkycIxulgoZZcknDl+vDH24uLfdwQITnvdVf2r+qGGWqmzKXUru
         i0ZVBlfhypV4c/DX4DrFy6BCAIjwMHvcyMJ/NSKRMC889GMIuXugpL7Yy94WKdI/us
         VigecX8wkwzB4qnptKDuqiz2+RuAiHaZWpJ/svlJIQm+EdPuONd6L715l44zEthEVz
         yMX6HRrm0gBKQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B622ac93e0001>; Fri, 11 Mar 2022 16:59:58 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Mar 2022 16:59:58 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 11 Mar 2022 16:59:58 +1300
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
Thread-Index: AQHYNCsIl5tLb0xtVEaOzKMz8FW+tay4ae4AgAAH5YCAADs5gIAACZyA
Date:   Fri, 11 Mar 2022 03:59:57 +0000
Message-ID: <bfabb9a3-b1ad-c10a-a4f5-b2774148d18b@alliedtelesis.co.nz>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
 <20220310030039.2833808-2-chris.packham@alliedtelesis.co.nz>
 <YiqI3Gjcf8AFVQYL@robh.at.kernel.org>
 <bdbe78d5-8e86-940f-0cb8-19ffe0f74ef7@alliedtelesis.co.nz>
 <efe43828-f359-1d1d-5049-3331d15483e0@alliedtelesis.co.nz>
In-Reply-To: <efe43828-f359-1d1d-5049-3331d15483e0@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E00F6F94EA7BBC4C85C184F164605249@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=5Tc4EDmR5jvkqzGVchEA:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMS8wMy8yMiAxNjoyNSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4NCj4gT24gMTEvMDMv
MjIgMTI6NTMsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBIaSBSb2IsDQo+Pg0KPj4gT24gMTEv
MDMvMjIgMTI6MjUsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4+IE9uIFRodSwgTWFyIDEwLCAyMDIy
IGF0IDA0OjAwOjM2UE0gKzEzMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4+IEFkZCBKU09O
IHNjaGVtYSBmb3IgbWFydmVsbCxhYzUtcGluY3RybCBwcmVzZW50IG9uIHRoZSBNYXJ2ZWxsIA0K
Pj4+PiA5OERYMjUzMA0KPj4+PiBTb0MuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlz
IFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+Pj4gLS0tDQo+
Pj4+IMKgIC4uLi9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGwsYWM1LXBpbmN0cmwueWFtbCB8IDcz
IA0KPj4+PiArKysrKysrKysrKysrKysrKysrDQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA3MyBp
bnNlcnRpb25zKCspDQo+Pj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4+Pj4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbWFydmVsbCxhYzUtcGluY3RybC55YW1s
DQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgDQo+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BpbmN0cmwvbWFydmVsbCxhYzUtcGluY3RybC55YW1sIA0KPj4+PiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGwsYWM1LXBpbmN0cmwu
eWFtbA0KPj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRleCAwMDAwMDAwMDAwMDAu
LmM3YWIzZDBlODQyMA0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyANCj4+Pj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9tYXJ2ZWxsLGFjNS1waW5jdHJs
LnlhbWwNCj4+Pj4gQEAgLTAsMCArMSw3MyBAQA0KPj4+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZQ0KPj4+PiArJVlBTUwgMS4yDQo+Pj4+
ICstLS0NCj4+Pj4gKyRpZDogDQo+Pj4+IGh0dHA6Ly9zY2FubWFpbC50cnVzdHdhdmUuY29tLz9j
PTIwOTg4JmQ9NUlpcTRvNkRtcjd4aXdrSk5ycjI1VE54WXhLNzhsSVVFV2VKLXlxMFVBJnU9aHR0
cCUzYSUyZiUyZmRldmljZXRyZWUlMmVvcmclMmZzY2hlbWFzJTJmcGluY3RybCUyZm1hcnZlbGwl
MmNhYzUtcGluY3RybCUyZXlhbWwlMjMNCj4+Pj4gKyRzY2hlbWE6IA0KPj4+PiBodHRwOi8vc2Nh
bm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0yMDk4OCZkPTVJaXE0bzZEbXI3eGl3a0pOcnIyNVROeFl4
Szc4bElVRVdQZV9YMnlYZyZ1PWh0dHAlM2ElMmYlMmZkZXZpY2V0cmVlJTJlb3JnJTJmbWV0YS1z
Y2hlbWFzJTJmY29yZSUyZXlhbWwlMjMNCj4+Pj4gKw0KPj4+PiArdGl0bGU6IE1hcnZlbGwgQUM1
IHBpbiBjb250cm9sbGVyDQo+Pj4+ICsNCj4+Pj4gK21haW50YWluZXJzOg0KPj4+PiArwqAgLSBD
aHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+Pj4+ICsN
Cj4+Pj4gK2Rlc2NyaXB0aW9uOg0KPj4+PiArwqAgQmluZGluZ3MgZm9yIE1hcnZlbGwncyBBQzUg
bWVtb3J5LW1hcHBlZCBwaW4gY29udHJvbGxlci4NCj4+Pj4gKw0KPj4+PiArcHJvcGVydGllczoN
Cj4+Pj4gK8KgIGNvbXBhdGlibGU6DQo+Pj4+ICvCoMKgwqAgaXRlbXM6DQo+Pj4+ICvCoMKgwqDC
oMKgIC0gY29uc3Q6IG1hcnZlbGwsYWM1LXBpbmN0cmwNCj4+Pj4gK8KgwqDCoMKgwqAgLSBjb25z
dDogc3lzY29uDQo+Pj4+ICvCoMKgwqDCoMKgIC0gY29uc3Q6IHNpbXBsZS1tZmQNCj4+PiBIb3cg
aXMgdGhpcyBhICdzeXNjb24nIG9yICdzaW1wbGUtbWZkJyBGb3Igc3lzY29uLCB3aGF0IG90aGVy
DQo+Pj4gZnVuY3Rpb25zL3JlZ2lzdGVycyBkb2VzIGl0IGhhdmU/IEZvciBzaW1wbGUtbWZkLCB3
aGF0IG90aGVyIGZ1bmN0aW9ucz8NCj4+PiBZb3UgaGF2ZW4ndCBkZWZpbmVkIHRoZW0gaW4gdGhl
IHNjaGVtYS4NCj4+DQo+PiBJdCdzIGluIHRoZSB2ZW5kb3IgZHRzIEkgaGF2ZSBhbmQgaXQncyBs
aWtlbHkgdGhlcmUgYmVjYXVzZSANCj4+IG1hcnZlbGwsYXJtYWRhLTM3eHgtcGluY3RybC50eHQg
aGFzIHRoZSBzYW1lIHN5c2NvbiBhbmQgc2ltcGxlLW1mZCANCj4+IGNvbXBhdGlibGVzLiBMb29r
aW5nIGF0IGhvdyB0aGlzIGlzIHVzZWQgSSB0aGluayBpdCdzIG1vcmUgbGlrZSB0aGUgDQo+PiBv
bGRlciBtdmVidSBwaW5jdHJsIGRldmljZXMuIEknbGwgcmVtb3ZlIHRoZXNlIHR3byBjb21wYXRp
YmxlcyBhbmQgDQo+PiB1cGRhdGUgdGhlIGR0c2kgZmlsZS4NCj4gQWN0dWFsbHkgdHVybnMgb3V0
IEkgZG8gbmVlZCB0aGUgc3lzY29uIGNvbXBhdGlibGUgYmVjYXVzZSB0aGUgZHJpdmVyIA0KPiBj
YWxscyBtdmVidV9waW5jdHJsX3NpbXBsZV9yZWdtYXBfcHJvYmUoKSB3aGljaCByZWxpZXMgb24g
dGhlIHN5c2NvbiANCj4gY29tcGF0aWJsZS4gSSdtIHN0aWxsIG5vdCBzdXJlIHdoYXQgdG8gcHV0
IGluIHRoZSBiaW5kaW5nIGRvYyBvdGhlciANCj4gdGhhbiAic3lzY29uIiBpcyBuZWVkZWQgYmVj
YXVzZSBpdCBpcyBuZWVkZWQuDQoNCkkgdGhpbmsgSSBnZXQgaXQgbm93LiBJIG5lZWQgYSBzeXNj
b24gbm9kZSB0byBiZSB0aGUgcGFyZW50IG9mIG15IA0KcGluY3RybCBub2RlIChhbmQgcG90ZW50
aWFsbHkgb3RoZXJzKS4gVGhhdCB3b3VsZCBhbHNvIGV4cGxhaW4gc29tZSANCnRoaW5ncyBJIHdh
cyBjb25mdXNlZCBhYm91dCB3aXRoIHRoZSBncGlvIGNvbnRyb2xsZXJzLiBJdCdzIGp1c3QgdGhh
dCANCnRoZSB2ZW5kb3IgZHRzIEkndmUgc3RhcnRlZCB3aXRoIGlzIHdvZWZ1bGx5IG91dCBvZiBk
YXRlIHcuci50IGN1cnJlbnQgDQpiZXN0IHByYWN0aWNlLg0KDQo+Pg0KPj4+DQo+Pj4gYmxhbmsg
bGluZSBuZWVkZWQgaGVyZS4NCj4+Pg0KPj4+PiArwqAgcmVnOg0KPj4+PiArwqDCoMKgIG1heEl0
ZW1zOiAxDQo+Pj4+ICsNCj4+Pj4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPj4+PiArwqAgJy1waW5z
JCc6DQo+Pj4+ICvCoMKgwqAgdHlwZTogb2JqZWN0DQo+Pj4+ICvCoMKgwqAgJHJlZjogcGlubXV4
LW5vZGUueWFtbCMNCj4+Pj4gKw0KPj4+PiArwqDCoMKgIHByb3BlcnRpZXM6DQo+Pj4+ICvCoMKg
wqDCoMKgIG1hcnZlbGwsZnVuY3Rpb246DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAkcmVmOiAiL3Nj
aGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvc3RyaW5nIg0KPj4+PiArwqDCoMKgwqDCoMKg
wqAgZGVzY3JpcHRpb246DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgSW5kaWNhdGVzIHRoZSBm
dW5jdGlvbiB0byBzZWxlY3QuDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBlbnVtOiBbIGdwaW8sIGky
YzAsIGkyYzEsIG5hbmQsIHNkaW8sIHNwaTAsIHNwaTEsIHVhcnQwLCANCj4+Pj4gdWFydDEsIHVh
cnQyLCB1YXJ0MyBdDQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgwqAgbWFydmVsbCxwaW5zOg0KPj4+
PiArwqDCoMKgwqDCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
c3RyaW5nLWFycmF5DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBkZXNjcmlwdGlvbjoNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoCBBcnJheSBvZiBNUFAgcGlucyB0byBiZSB1c2VkIGZvciB0aGUgZ2l2
ZW4gZnVuY3Rpb24uDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBtaW5JdGVtczogMQ0KPj4+PiArwqDC
oMKgwqDCoMKgwqAgaXRlbXM6DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgZW51bTogWyBtcHAw
LCBtcHAxLCBtcHAyLCBtcHAzLCBtcHA0LCBtcHA1LCBtcHA2LCBtcHA3LCANCj4+Pj4gbXBwOCwg
bXBwOSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXBwMTAsIG1w
cDExLCBtcHAxMiwgbXBwMTMsIG1wcDE0LCBtcHAxNSwgbXBwMTYsIA0KPj4+PiBtcHAxNywgbXBw
MTgsIG1wcDE5LA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtcHAy
MCwgbXBwMjEsIG1wcDIyLCBtcHAyMywgbXBwMjQsIG1wcDI1LCBtcHAyNiwgDQo+Pj4+IG1wcDI3
LCBtcHAyOCwgbXBwMjksDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG1wcDMwLCBtcHAzMSwgbXBwMzIsIG1wcDMzLCBtcHAzNCwgbXBwMzUsIG1wcDM2LCANCj4+Pj4g
bXBwMzcsIG1wcDM4LCBtcHAzOSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbXBwNDAsIG1wcDQxLCBtcHA0MiwgbXBwNDMsIG1wcDQ0LCBtcHA0NSBdDQo+Pj4+ICsN
Cj4+Pj4gK2FsbE9mOg0KPj4+PiArwqAgLSAkcmVmOiAicGluY3RybC55YW1sIyINCj4+Pj4gKw0K
Pj4+PiArcmVxdWlyZWQ6DQo+Pj4+ICvCoCAtIGNvbXBhdGlibGUNCj4+Pj4gK8KgIC0gcmVnDQo+
Pj4+ICsNCj4+Pj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4+PiArDQo+Pj4+ICtl
eGFtcGxlczoNCj4+Pj4gK8KgIC0gfA0KPj4+PiArwqDCoMKgIHBpbmN0cmxAODAwMjAxMDAgew0K
Pj4+PiArwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gIm1hcnZlbGwsYWM1LXBpbmN0cmwiLA0KPj4+
PiArwqDCoMKgwqDCoCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KPj4+PiArwqDCoMKgwqDCoCBy
ZWcgPSA8MHg4MDAyMDEwMCAweDIwPjsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgwqDCoCBpMmMwX3Bp
bnM6IGkyYzAtcGlucyB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBtYXJ2ZWxsLHBpbnMgPSAibXBw
MjYiLCAibXBwMjciOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgbWFydmVsbCxmdW5jdGlvbiA9ICJp
MmMwIjsNCj4+Pj4gK8KgwqDCoMKgwqAgfTsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgwqDCoCBpMmMw
X2dwaW86IGkyYzAtZ3Bpby1waW5zIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG1hcnZlbGwscGlu
cyA9ICJtcHAyNiIsICJtcHAyNyI7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBtYXJ2ZWxsLGZ1bmN0
aW9uID0gImdwaW8iOw0KPj4+PiArwqDCoMKgwqDCoCB9Ow0KPj4+PiArwqDCoMKgIH07DQo+Pj4+
IC0tIA0KPj4+PiAyLjM1LjENCj4+Pj4NCj4+Pj4=
