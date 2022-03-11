Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A984D58D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbiCKD0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243806AbiCKD0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:26:40 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01741C4E06
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:25:35 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0184E2C06A1;
        Fri, 11 Mar 2022 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1646969133;
        bh=c4qLgOpKZ1gZfnCQRCjcsENEsv49Bq8JTRrlmUorGtc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iWfhNW6mzFUAPt2/IlpeVgZFla2Vn9bEDI/sKVeA2K7ejzHR5XkzqPJKize5hJxah
         hjtYXnZLoRVWkZVcfZaO2qBp4LaldZvfBJzJy5rRRG4exx71csmaDtiFjrsEMvfvB6
         5OxV8QkuKsn+rzNTai4uiRvPIaKliRuLENoFT5OK6mCPuCf0mrQvGx5aK9+Ob2lLR5
         v4qotBj0rG5d1pt/0lovJmxrwXRqsK22B5SKq0hVCbfpCycf8qZU+YDI5ZztoC9jG/
         OmXXq58ge1g2eI1VGBluGDnzsJjaVQZH4CEerYxTlrMQRRMqsxpPLIsQqUrDQvSPjJ
         OpMp/qsjI3Ibg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B622ac12c0001>; Fri, 11 Mar 2022 16:25:32 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 11 Mar 2022 16:25:32 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 11 Mar 2022 16:25:32 +1300
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
Thread-Index: AQHYNCsIl5tLb0xtVEaOzKMz8FW+tay4ae4AgAAH5YCAADs5gA==
Date:   Fri, 11 Mar 2022 03:25:31 +0000
Message-ID: <efe43828-f359-1d1d-5049-3331d15483e0@alliedtelesis.co.nz>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
 <20220310030039.2833808-2-chris.packham@alliedtelesis.co.nz>
 <YiqI3Gjcf8AFVQYL@robh.at.kernel.org>
 <bdbe78d5-8e86-940f-0cb8-19ffe0f74ef7@alliedtelesis.co.nz>
In-Reply-To: <bdbe78d5-8e86-940f-0cb8-19ffe0f74ef7@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BD12F9856FD344D86A8367F1FD8753B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=VuVhcBtJkGh1O9dNQScA:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
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

DQpPbiAxMS8wMy8yMiAxMjo1MywgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gSGkgUm9iLA0KPg0K
PiBPbiAxMS8wMy8yMiAxMjoyNSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+PiBPbiBUaHUsIE1hciAx
MCwgMjAyMiBhdCAwNDowMDozNlBNICsxMzAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+IEFk
ZCBKU09OIHNjaGVtYSBmb3IgbWFydmVsbCxhYzUtcGluY3RybCBwcmVzZW50IG9uIHRoZSBNYXJ2
ZWxsIDk4RFgyNTMwDQo+Pj4gU29DLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFj
a2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4+IC0tLQ0KPj4+IMKg
IC4uLi9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGwsYWM1LXBpbmN0cmwueWFtbCB8IDczIA0KPj4+
ICsrKysrKysrKysrKysrKysrKysNCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNzMgaW5zZXJ0aW9u
cygrKQ0KPj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4+PiBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGluY3RybC9tYXJ2ZWxsLGFjNS1waW5jdHJsLnlhbWwNCj4+Pg0KPj4+
IGRpZmYgLS1naXQgDQo+Pj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGlu
Y3RybC9tYXJ2ZWxsLGFjNS1waW5jdHJsLnlhbWwgDQo+Pj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGluY3RybC9tYXJ2ZWxsLGFjNS1waW5jdHJsLnlhbWwNCj4+PiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uYzdhYjNkMGU4NDIwDQo+
Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyANCj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGwsYWM1LXBpbmN0cmwueWFtbA0KPj4+IEBAIC0wLDAg
KzEsNzMgQEANCj4+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5IE9S
IEJTRC0yLUNsYXVzZQ0KPj4+ICslWUFNTCAxLjINCj4+PiArLS0tDQo+Pj4gKyRpZDogDQo+Pj4g
aHR0cDovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD01SWlxNG82RG1yN3hpd2tK
TnJyMjVUTnhZeEs3OGxJVUVXZUoteXEwVUEmdT1odHRwJTNhJTJmJTJmZGV2aWNldHJlZSUyZW9y
ZyUyZnNjaGVtYXMlMmZwaW5jdHJsJTJmbWFydmVsbCUyY2FjNS1waW5jdHJsJTJleWFtbCUyMw0K
Pj4+ICskc2NoZW1hOiANCj4+PiBodHRwOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0yMDk4
OCZkPTVJaXE0bzZEbXI3eGl3a0pOcnIyNVROeFl4Szc4bElVRVdQZV9YMnlYZyZ1PWh0dHAlM2El
MmYlMmZkZXZpY2V0cmVlJTJlb3JnJTJmbWV0YS1zY2hlbWFzJTJmY29yZSUyZXlhbWwlMjMNCj4+
PiArDQo+Pj4gK3RpdGxlOiBNYXJ2ZWxsIEFDNSBwaW4gY29udHJvbGxlcg0KPj4+ICsNCj4+PiAr
bWFpbnRhaW5lcnM6DQo+Pj4gK8KgIC0gQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxp
ZWR0ZWxlc2lzLmNvLm56Pg0KPj4+ICsNCj4+PiArZGVzY3JpcHRpb246DQo+Pj4gK8KgIEJpbmRp
bmdzIGZvciBNYXJ2ZWxsJ3MgQUM1IG1lbW9yeS1tYXBwZWQgcGluIGNvbnRyb2xsZXIuDQo+Pj4g
Kw0KPj4+ICtwcm9wZXJ0aWVzOg0KPj4+ICvCoCBjb21wYXRpYmxlOg0KPj4+ICvCoMKgwqAgaXRl
bXM6DQo+Pj4gK8KgwqDCoMKgwqAgLSBjb25zdDogbWFydmVsbCxhYzUtcGluY3RybA0KPj4+ICvC
oMKgwqDCoMKgIC0gY29uc3Q6IHN5c2Nvbg0KPj4+ICvCoMKgwqDCoMKgIC0gY29uc3Q6IHNpbXBs
ZS1tZmQNCj4+IEhvdyBpcyB0aGlzIGEgJ3N5c2Nvbicgb3IgJ3NpbXBsZS1tZmQnIEZvciBzeXNj
b24sIHdoYXQgb3RoZXINCj4+IGZ1bmN0aW9ucy9yZWdpc3RlcnMgZG9lcyBpdCBoYXZlPyBGb3Ig
c2ltcGxlLW1mZCwgd2hhdCBvdGhlciBmdW5jdGlvbnM/DQo+PiBZb3UgaGF2ZW4ndCBkZWZpbmVk
IHRoZW0gaW4gdGhlIHNjaGVtYS4NCj4NCj4gSXQncyBpbiB0aGUgdmVuZG9yIGR0cyBJIGhhdmUg
YW5kIGl0J3MgbGlrZWx5IHRoZXJlIGJlY2F1c2UgDQo+IG1hcnZlbGwsYXJtYWRhLTM3eHgtcGlu
Y3RybC50eHQgaGFzIHRoZSBzYW1lIHN5c2NvbiBhbmQgc2ltcGxlLW1mZCANCj4gY29tcGF0aWJs
ZXMuIExvb2tpbmcgYXQgaG93IHRoaXMgaXMgdXNlZCBJIHRoaW5rIGl0J3MgbW9yZSBsaWtlIHRo
ZSANCj4gb2xkZXIgbXZlYnUgcGluY3RybCBkZXZpY2VzLiBJJ2xsIHJlbW92ZSB0aGVzZSB0d28g
Y29tcGF0aWJsZXMgYW5kIA0KPiB1cGRhdGUgdGhlIGR0c2kgZmlsZS4NCkFjdHVhbGx5IHR1cm5z
IG91dCBJIGRvIG5lZWQgdGhlIHN5c2NvbiBjb21wYXRpYmxlIGJlY2F1c2UgdGhlIGRyaXZlciAN
CmNhbGxzIG12ZWJ1X3BpbmN0cmxfc2ltcGxlX3JlZ21hcF9wcm9iZSgpIHdoaWNoIHJlbGllcyBv
biB0aGUgc3lzY29uIA0KY29tcGF0aWJsZS4gSSdtIHN0aWxsIG5vdCBzdXJlIHdoYXQgdG8gcHV0
IGluIHRoZSBiaW5kaW5nIGRvYyBvdGhlciB0aGFuIA0KInN5c2NvbiIgaXMgbmVlZGVkIGJlY2F1
c2UgaXQgaXMgbmVlZGVkLg0KPg0KPj4NCj4+IGJsYW5rIGxpbmUgbmVlZGVkIGhlcmUuDQo+Pg0K
Pj4+ICvCoCByZWc6DQo+Pj4gK8KgwqDCoCBtYXhJdGVtczogMQ0KPj4+ICsNCj4+PiArcGF0dGVy
blByb3BlcnRpZXM6DQo+Pj4gK8KgICctcGlucyQnOg0KPj4+ICvCoMKgwqAgdHlwZTogb2JqZWN0
DQo+Pj4gK8KgwqDCoCAkcmVmOiBwaW5tdXgtbm9kZS55YW1sIw0KPj4+ICsNCj4+PiArwqDCoMKg
IHByb3BlcnRpZXM6DQo+Pj4gK8KgwqDCoMKgwqAgbWFydmVsbCxmdW5jdGlvbjoNCj4+PiArwqDC
oMKgwqDCoMKgwqAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmlu
ZyINCj4+PiArwqDCoMKgwqDCoMKgwqAgZGVzY3JpcHRpb246DQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoCBJbmRpY2F0ZXMgdGhlIGZ1bmN0aW9uIHRvIHNlbGVjdC4NCj4+PiArwqDCoMKgwqDCoMKg
wqAgZW51bTogWyBncGlvLCBpMmMwLCBpMmMxLCBuYW5kLCBzZGlvLCBzcGkwLCBzcGkxLCB1YXJ0
MCwgDQo+Pj4gdWFydDEsIHVhcnQyLCB1YXJ0MyBdDQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgIG1h
cnZlbGwscGluczoNCj4+PiArwqDCoMKgwqDCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCMvZGVmaW5pdGlvbnMvc3RyaW5nLWFycmF5DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGRlc2NyaXB0
aW9uOg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgQXJyYXkgb2YgTVBQIHBpbnMgdG8gYmUgdXNl
ZCBmb3IgdGhlIGdpdmVuIGZ1bmN0aW9uLg0KPj4+ICvCoMKgwqDCoMKgwqDCoCBtaW5JdGVtczog
MQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCBpdGVtczoNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgIGVu
dW06IFsgbXBwMCwgbXBwMSwgbXBwMiwgbXBwMywgbXBwNCwgbXBwNSwgbXBwNiwgbXBwNywgDQo+
Pj4gbXBwOCwgbXBwOSwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
cHAxMCwgbXBwMTEsIG1wcDEyLCBtcHAxMywgbXBwMTQsIG1wcDE1LCBtcHAxNiwgDQo+Pj4gbXBw
MTcsIG1wcDE4LCBtcHAxOSwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtcHAyMCwgbXBwMjEsIG1wcDIyLCBtcHAyMywgbXBwMjQsIG1wcDI1LCBtcHAyNiwgDQo+Pj4g
bXBwMjcsIG1wcDI4LCBtcHAyOSwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtcHAzMCwgbXBwMzEsIG1wcDMyLCBtcHAzMywgbXBwMzQsIG1wcDM1LCBtcHAzNiwgDQo+
Pj4gbXBwMzcsIG1wcDM4LCBtcHAzOSwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtcHA0MCwgbXBwNDEsIG1wcDQyLCBtcHA0MywgbXBwNDQsIG1wcDQ1IF0NCj4+PiAr
DQo+Pj4gK2FsbE9mOg0KPj4+ICvCoCAtICRyZWY6ICJwaW5jdHJsLnlhbWwjIg0KPj4+ICsNCj4+
PiArcmVxdWlyZWQ6DQo+Pj4gK8KgIC0gY29tcGF0aWJsZQ0KPj4+ICvCoCAtIHJlZw0KPj4+ICsN
Cj4+PiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+Pj4gKw0KPj4+ICtleGFtcGxlczoN
Cj4+PiArwqAgLSB8DQo+Pj4gK8KgwqDCoCBwaW5jdHJsQDgwMDIwMTAwIHsNCj4+PiArwqDCoMKg
wqDCoCBjb21wYXRpYmxlID0gIm1hcnZlbGwsYWM1LXBpbmN0cmwiLA0KPj4+ICvCoMKgwqDCoMKg
ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+Pj4gK8KgwqDCoMKgwqAgcmVnID0gPDB4ODAwMjAx
MDAgMHgyMD47DQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgIGkyYzBfcGluczogaTJjMC1waW5zIHsN
Cj4+PiArwqDCoMKgwqDCoMKgwqAgbWFydmVsbCxwaW5zID0gIm1wcDI2IiwgIm1wcDI3IjsNCj4+
PiArwqDCoMKgwqDCoMKgwqAgbWFydmVsbCxmdW5jdGlvbiA9ICJpMmMwIjsNCj4+PiArwqDCoMKg
wqDCoCB9Ow0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoCBpMmMwX2dwaW86IGkyYzAtZ3Bpby1waW5z
IHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgbWFydmVsbCxwaW5zID0gIm1wcDI2IiwgIm1wcDI3IjsN
Cj4+PiArwqDCoMKgwqDCoMKgwqAgbWFydmVsbCxmdW5jdGlvbiA9ICJncGlvIjsNCj4+PiArwqDC
oMKgwqDCoCB9Ow0KPj4+ICvCoMKgwqAgfTsNCj4+PiAtLSANCj4+PiAyLjM1LjENCj4+Pg0KPj4+
