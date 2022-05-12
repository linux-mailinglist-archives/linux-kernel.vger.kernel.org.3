Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB9524238
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiELBvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiELBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:51:18 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E7E663FD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:51:15 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 113302C06D3;
        Thu, 12 May 2022 01:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652320274;
        bh=zICIKlApLGWZcBglX7elS6/2FrxN1+K1EakNpFHmUXE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CiZj+sT2gbC1suia+d7XtrIJ0RT17CwNsTbkntnr7vnfQuwlGwMliWz92oIQGJ4g/
         BGxoNaKOjzzUIht12+8EDhtpUQv5PT8uZQ1Br7trtMRQoU4AXxqQ+/d/XESmtoglRG
         926jkK0Mj0STMCap10aQ5ueQqyv8/ai9LMrv2YvfelzYZ4M6DLEAcfjBYT7aQ78CME
         KwSY+5Ai6mFe7hP/+zi0SI0cMwxzKF/ggOOM8bqNqtCrC/nO6xA1RSqZCNtkfmYPe+
         HnLCU3GwVC4thUvxR2AunLvjStAKzMmloLTHZ47TQITmy2OYF/NjoVRpeUqQhE+LjP
         RyWv6xCi7oeZQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627c68110001>; Thu, 12 May 2022 13:51:13 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 12 May 2022 13:51:13 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 12 May 2022 13:51:13 +1200
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
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Thread-Topic: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Thread-Index: AQHYZMMYWG5Tfvy6g0WGHR9i+piz6K0ZFyiAgACTLwCAAAh9gA==
Date:   Thu, 12 May 2022 01:51:13 +0000
Message-ID: <340b2ee9-54e5-5092-2a5e-6e7bc42fb611@alliedtelesis.co.nz>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
 <5c498985-64bb-b8ba-3e77-9cdb36dd1f16@linaro.org>
 <6d1e121f-847b-3fc5-c27d-6504f380e4ef@alliedtelesis.co.nz>
In-Reply-To: <6d1e121f-847b-3fc5-c27d-6504f380e4ef@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0588DC8FDFE93744ADAEE49DB4721FA6@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=zjVfdiG-SyPA5Eg8EysA:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wNS8yMiAxMzoyMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4NCj4gT24gMTIvMDUv
MjIgMDQ6MzQsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+PiBPbiAxMS8wNS8yMDIyIDAx
OjEwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+IERlc2NyaWJlIHRoZSBjb21wYXRpYmxlIHBy
b3BlcnRpZXMgZm9yIHRoZSBNYXJ2ZWxsIEFsbGV5Y2F0NS81WCANCj4+PiBzd2l0Y2hlcw0KPj4+
IHdpdGggaW50ZWdyYXRlZCBDUFVzLg0KPj4+DQo+Pj4gQWxsZXljYXQ1Og0KPj4+ICogOThEWDI1
Mzg6IDI0eDFHICsgMngxMEcgKyAyeDEwRyBTdGFjaw0KPj4+ICogOThEWDI1MzU6IDI0eDFHICsg
NHgxRyBTdGFjaw0KPj4+ICogOThEWDI1MzI6IDh4MUcgKyAyeDEwRyArIDJ4MUcgU3RhY2sNCj4+
PiAqIDk4RFgyNTMxOiA4eDFHICsgNHgxRyBTdGFjaw0KPj4+ICogOThEWDI1Mjg6IDI0eDFHICsg
MngxMEcgKyAyeDEwRyBTdGFjaw0KPj4+ICogOThEWDI1MjU6IDI0eDFHICsgNHgxRyBTdGFjaw0K
Pj4+ICogOThEWDI1MjI6IDh4MUcgKyAyeDEwRyArIDJ4MUcgU3RhY2sNCj4+PiAqIDk4RFgyNTIx
OiA4eDFHICsgNHgxRyBTdGFjaw0KPj4+ICogOThEWDI1MTg6IDI0eDFHICsgMngxMEcgKyAyeDEw
RyBTdGFjaw0KPj4+ICogOThEWDI1MTU6IDI0eDFHICsgNHgxRyBTdGFjaw0KPj4+ICogOThEWDI1
MTI6IDh4MUcgKyAyeDEwRyArIDJ4MUcgU3RhY2sNCj4+PiAqIDk4RFgyNTExOiA4eDFHICsgNHgx
RyBTdGFjaw0KPj4+DQo+Pj4gQWxsZXljYXQ1WDoNCj4+PiAqIDk4RFgzNTAwOiAyNHgxRyArIDZ4
MjVHDQo+Pj4gKiA5OERYMzUwMTogMTZ4MUcgKyA2eDEwRw0KPj4+ICogOThEWDM1MTA6IDQ4eDFH
ICsgNngyNUcNCj4+PiAqIDk4RFgzNTIwOiAyNHgyLjVHICsgNngyNUcNCj4+PiAqIDk4RFgzNTMw
OiA0OHgyLjVHICsgNngyNUcNCj4+PiAqIDk4RFgzNTQwOiAxMng1Ry82eDEwRyArIDZ4MjVHDQo+
Pj4gKiA5OERYMzU1MDogMjR4NUcvMTJ4MTBHICsgNngyNUcNCj4+Pg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+
PiAtLS0NCj4+Pg0KPj4+IE5vdGVzOg0KPj4+IMKgwqDCoMKgIENoYW5nZXMgaW4gdjY6DQo+Pj4g
wqDCoMKgwqAgLSBOZXcNCj4+Pg0KPj4+IMKgIC4uLi9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1h
ZGEtOThkeDI1MzAueWFtbCB8IDI3IA0KPj4+ICsrKysrKysrKysrKysrKysrKysNCj4+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0
NCANCj4+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJt
YWRhLTk4ZHgyNTMwLnlhbWwNCj4+Pg0KPj4+IGRpZmYgLS1naXQgDQo+Pj4gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTk4ZHgyNTMwLnlhbWwg
DQo+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJt
YWRhLTk4ZHgyNTMwLnlhbWwNCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+IGluZGV4IDAw
MDAwMDAwMDAwMC4uNmQ5MTg1YmFmMGM1DQo+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyANCj4+
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1hZGEt
OThkeDI1MzAueWFtbA0KPj4+IEBAIC0wLDAgKzEsMjcgQEANCj4+PiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+Pj4gKyVZQU1MIDEu
Mg0KPj4+ICstLS0NCj4+PiArJGlkOiANCj4+PiBodHRwOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNv
bS8/Yz0yMDk4OCZkPWhlWDc0cy1kaDhIU0NBSm1hZlJpZ1pIT295WTBYUURsODBRU0NYV2l0dyZ1
PWh0dHAlM2ElMmYlMmZkZXZpY2V0cmVlJTJlb3JnJTJmc2NoZW1hcyUyZmFybSUyZm1hcnZlbGwl
MmZhcm1hZGEtOThkeDI1MzAlMmV5YW1sJTIzDQo+Pj4gKyRzY2hlbWE6IA0KPj4+IGh0dHA6Ly9z
Y2FubWFpbC50cnVzdHdhdmUuY29tLz9jPTIwOTg4JmQ9aGVYNzRzLWRoOEhTQ0FKbWFmUmlnWkhP
b3lZMFhRRGw4MG9WV25PbHRBJnU9aHR0cCUzYSUyZiUyZmRldmljZXRyZWUlMmVvcmclMmZtZXRh
LXNjaGVtYXMlMmZjb3JlJTJleWFtbCUyMw0KPj4+ICsNCj4+PiArdGl0bGU6IE1hcnZlbGwgQWxs
ZXljYXQ1LzVYIFBsYXRmb3Jtcw0KPj4+ICsNCj4+PiArbWFpbnRhaW5lcnM6DQo+Pj4gK8KgIC0g
Q2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4+ICsN
Cj4+PiArcHJvcGVydGllczoNCj4+PiArwqAgJG5vZGVuYW1lOg0KPj4+ICvCoMKgwqAgY29uc3Q6
ICcvJw0KPj4+ICvCoCBjb21wYXRpYmxlOg0KPj4+ICvCoMKgwqAgb25lT2Y6DQo+Pj4gKw0KPj4+
ICvCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IEFsbGV5Y2F0NSAoOThEWDI1eHgpDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGl0ZW1zOg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWFy
dmVsbCxhYzUNCj4+IFRoaXMgaXMgY29uZnVzaW5nIGFuZCBkb2VzIG5vdCBsb29rIGNvcnJlY3Qu
IFRoZSBEVFMgY2FsbHMgQUM1IGEgU29DIGFuZA0KPj4geW91IGNhbm5vdCBoYXZlIFNvQyBhbG9u
ZS4gSXQncyB1bnVzYWJsZSB3aXRob3V0IGEgU29NIG9yIGJvYXJkLg0KPj4NCj4+PiArDQo+Pj4g
K8KgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogQWxsZXljYXQ1WCAoOThEWDM1eHgpDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGl0ZW1zOg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWFy
dmVsbCxhYzV4DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBtYXJ2ZWxsLGFjNQ0K
Pj4gVGhpcyBlbnRyeSBsb29rcyBjb3JyZWN0IGV4Y2VwdCBhYzV4IG9uY2UgaXMgY2FsbGVkIGEg
U29DIGFuZCBvbmNlIGENCj4+IFJELUFDNVggYm9hcmQuDQo+Pg0KPj4gSXQgY2Fubm90IGJlIGJv
dGguIFByb2JhYmx5IHlvdSBuZWVkIHRoaXJkIGNvbXBhdGlibGUsIGFzc3VtaW5nIEFDNXggaXMN
Cj4+IGEgZmxhdm9yIG9mIEFDNS4NCj4NCj4gWWVhaCBpdCdzIGEgYml0IGNvbmZ1c2luZw0KPg0K
PiBSRC1BQzVYLShidW5jaCBvZiBleHRyYSBudW1iZXJzIGFuZCBsZXR0ZXJzKSBpcyB0aGUgYm9h
cmQgSSBoYXZlLg0KPiBBQzVYIGlzIGEgTDMgc3dpdGNoIGNoaXAgd2l0aCBpbnRlZ3JhdGVkIENQ
VS4NCj4gQUM1IGlzIGEgTDMgc3dpdGNoIGNoaXAgd2l0aCBpbnRlZ3JhdGVkIENQVS4NCj4NCj4g
U3dpdGNoIHdpc2UgdGhlIEFDNVggYW5kIEFDNSBhcmUgcXVpdGUgZGlmZmVyZW50IGJ1dCB0aGUg
Q1BVIGJsb2NrIGlzIA0KPiB0aGUgc2FtZSBiZXR3ZWVuIHRoZSB0d28uDQo+DQo+Pg0KPj4gaXRl
bXM6DQo+PiDCoCAtIGVudW06DQo+PiDCoMKgwqDCoMKgIC0gbWFydmVsbCxyZC1hYzV4DQo+PiDC
oCAtIGNvbnN0OiBtYXJ2ZWxsLGFjNXgNCj4+IMKgIC0gY29uc3Q6IG1hcnZlbGwsYWM1DQo+DQo+
IEkgY2FuIGdvIHdpdGggdGhhdCBidXQgSSdtIGEgbGl0dGxlIHZhZ3VlIG9uIHdoYXQgdGhlIHJl
cXVpcmVtZW50cyANCj4gYXJlLiBJIHdhcyB0cnlpbmcgdG8gZm9sbG93IHRoZSBhcm1hZGEtN2st
OGsueWFtbCBhcyBhbiBleGFtcGxlLg0KPg0KPiBJZiBJIGxvb2sgYXQgdGhlIGNuOTEzMC1jcmIt
QSBib2FyZCBpdCBlbmRzIHVwIHdpdGg6DQo+DQo+IMKgIGNvbXBhdGlibGUgPSAibWFydmVsbCxj
bjkxMzAiLCAibWFydmVsbCxhcm1hZGEtYXA4MDctcXVhZCIsIA0KPiAibWFydmVsbCxhcm1hZGEt
YXA4MDciOw0KPg0KPiBJIGtub3cgdGhlIGFwODA3IGhhcyBzb21ldGhpbmcgdG8gZG8gd2l0aCB0
aGUgdmFnYXJpZXMgb2YgdGhlIGNuOTEzMCANCj4gU29DIGJ1dCBpc24ndCB0aGUgIm1hcnZlbGws
Y245MTMwIiBzdGlsbCByZWZlcnJpbmcgdG8gdGhlIFNvQy4gRnJvbSANCj4gd2hhdCB5b3UndmUg
c2FpZCBzaG91bGRuJ3QgdGhlcmUgYmUgYSAibWFydmVsbCxjbjkxMzAtY3JiIiBzb21ld2hlcmUg
DQo+IGluIHRoZSBtaXg/DQo+DQo+IFBlcmhhcHMgSSd2ZSBwaWNrZWQgYSBiYWQgZXhhbXBsZSBi
dXQgdGhlIG90aGVyIGR0YnMgSSd2ZSBwb2tlZCBhdCANCj4gZG9uJ3QgaGF2ZSBhbnkgYm9hcmQg
YmluZGluZy4NCj4NClRoZSBmc2wsaW14IGJvYXJkcyBzZWVtIGxpa2UgYSBiZXR0ZXIgZXhhbXBs
ZSB0byBmb2xsb3cgDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55
YW1sDQo+Pj4gKw0KPj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZQ0KPj4NCj4+IEJlc3Qg
cmVnYXJkcywNCj4+IEtyenlzenRvZg==
