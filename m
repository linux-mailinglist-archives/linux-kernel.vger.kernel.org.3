Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1761354BCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353559AbiFNVZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiFNVZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:25:56 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF15550B2F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:25:54 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5E64D2C04A2;
        Tue, 14 Jun 2022 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1655241950;
        bh=rBzq/2Efd36JQEBZ9lzBfFUCeZiJz6rTsoAHZInVSNw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bGRMOhA6W5vYAgPgDUw4kKRKi/PjDhkGaZ16nPBV6ERcEjdyZ+ZiCC6iesif4b1Al
         BraXyF/ZQo0oWzUJW/HwKyFuQvkOwnb+kVTjc5EntlkH53B4imZf74YvABkyXWVJ3u
         kOrCT6gscQELRN1xA7qx+NCVF0ijOOLJejTUWdJrGa3prJRSFK42clQCXw4ihmy5b9
         uxMQZbkVsATzPp4mh4Q0TvUkEcKJNDII2dCoaZKS3fs349pBrxPkgjaLTP0Tiy0WkG
         26RXB5QHxniDzjTm2+NWAK6+tLsRRiFtZTWlvhK89GRp3z4xsgxZCNfY80mnG/nt+7
         w694QjI1YG0bQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62a8fcde0001>; Wed, 15 Jun 2022 09:25:50 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.36; Wed, 15 Jun 2022 09:25:49 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.036; Wed, 15 Jun 2022 09:25:49 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Robert Marko <robert.marko@sartura.hr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v9 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v9 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYf3ivRDlWE7CQx0aHryZFsklnE61NkiuAgAAEXoCAAC94gIAA3IWA
Date:   Tue, 14 Jun 2022 21:25:48 +0000
Message-ID: <81548de1-dbb4-ce3e-b1ca-d28a92dc3025@alliedtelesis.co.nz>
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
 <20220613225338.393-3-vadym.kochan@plvision.eu>
 <4670aab9-b7fa-f2c7-567a-12ca24535b0c@alliedtelesis.co.nz>
 <37d7b4f1-fd39-dc05-374a-764070c56cc6@alliedtelesis.co.nz>
 <20220614081633.GA14160@plvision.eu>
In-Reply-To: <20220614081633.GA14160@plvision.eu>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7B0258C625D6445BDA3084F0538E109@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=dM/YZ9Rb c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=g8kJ_gb0AAAA:8 a=YvgSNHyjtYHdYafAP4wA:9 a=QEXdDO2ut3YA:10 a=ecSNLfPMzbq-p5zXJZOg:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K2NjOiBFbGFkDQoNCk9uIDE0LzA2LzIyIDIwOjE2LCBWYWR5bSBLb2NoYW4gd3JvdGU6DQo+IEhp
IENocmlzLA0KPg0KPiBPbiBUdWUsIEp1biAxNCwgMjAyMiBhdCAwNToyNjozOUFNICswMDAwLCBD
aHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gT24gMTQvMDYvMjIgMTc6MTEsIENocmlzIFBhY2toYW0g
d3JvdGU6DQo+Pj4gT24gMTQvMDYvMjIgMTA6NTMsIFZhZHltIEtvY2hhbiB3cm90ZToNCj4+Pj4g
RnJvbTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0K
Pj4+Pg0KPj4+PiBUaGUgOThEWDI1MzAgU29DIGlzIHRoZSBDb250cm9sIGFuZCBNYW5hZ2VtZW50
IENQVSBpbnRlZ3JhdGVkIGludG8NCj4+Pj4gdGhlIE1hcnZlbGwgOThEWDI1eHggYW5kIDk4RFgz
NXh4IHNlcmllcyBvZiBzd2l0Y2ggY2hpcCAoaW50ZXJuYWxseQ0KPj4+PiByZWZlcnJlZCB0byBh
cyBBbGxleUNhdDUgYW5kIEFsbGV5Q2F0NVgpLg0KPj4+Pg0KPj4+PiBUaGVzZSBmaWxlcyBoYXZl
IGJlZW4gdGFrZW4gZnJvbSB0aGUgTWFydmVsbCBTREsgYW5kIGxpZ2h0bHkgY2xlYW5lZA0KPj4+
PiB1cCB3aXRoIHRoZSBMaWNlbnNlIGFuZCBjb3B5cmlnaHQgcmV0YWluZWQuDQo+Pj4+DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNp
cy5jby5uej4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmFkeW0gS29jaGFuIDx2YWR5bS5rb2NoYW5A
cGx2aXNpb24uZXU+DQo+Pj4+IC0tLQ0KPj4+Pg0KPj4+PiBOb3RlczoNCj4+Pj4gIMKgwqDCoMKg
IFRoZSBNYXJ2ZWxsIFNESyBoYXMgYSBudW1iZXIgb2YgbmV3IGNvbXBhdGlibGUgc3RyaW5ncy4g
SSd2ZQ0KPj4+PiBicm91Z2h0DQo+Pj4+ICDCoMKgwqDCoCB0aHJvdWdoIHNvbWUgb2YgdGhlIGRy
aXZlcnMgb3Igd2hlcmUgcG9zc2libGUgdXNlZCBhbiBpbi10cmVlDQo+Pj4+ICDCoMKgwqDCoCBh
bHRlcm5hdGl2ZSAoZS5nLiB0aGVyZSBpcyBTREsgY29kZSBmb3IgYSBhYzUtZ3BpbyBidXQgdHdv
DQo+Pj4+IGluc3RhbmNlcyBvZg0KPj4+PiAgwqDCoMKgwqAgdGhlIGV4aXN0aW5nIG1hcnZlbGws
b3Jpb24tZ3BpbyBzZWVtcyB0byBjb3ZlciB3aGF0IGlzIG5lZWRlZCBpZg0KPj4+PiB5b3UgdXNl
DQo+Pj4+ICDCoMKgwqDCoCBhbiBhcHByb3ByaWF0ZSBiaW5kaW5nKS4gSSBleHBlY3QgdGhhdCB0
aGVyZSB3aWxsIGEgbmV3IHNlcmllcyBvZg0KPj4+PiAgwqDCoMKgwqAgcGF0Y2hlcyB3aGVuIEkg
Z2V0IHNvbWUgZGlmZmVyZW50IGhhcmR3YXJlIChvciBhZGRpdGlvbnMgdG8gdGhpcw0KPj4+PiBz
ZXJpZXMNCj4+Pj4gIMKgwqDCoMKgIGRlcGVuZGluZyBvbiBpZi93aGVuIGl0IGxhbmRzKS4NCj4+
Pj4gIMKgwqDCoMKgIMKgwqDCoMKgIENoYW5nZXMgaW4gdjkgKHByb3Bvc2VkIGJ5IE1hcnZlbGwp
Og0KPj4+PiAgwqDCoMKgwqDCoMKgIEl0IHdhcyBkaXNjdXNzZWQgd2l0aCBDaHJpcyB0aGF0IE1h
cnZlbGwgd2lsbCBhZGQgc29tZSBjaGFuZ2VzOg0KPj4+Pg0KPj4+PiAgwqDCoMKgwqDCoMKgwqDC
oMKgIDEpIFJlbmFtZSAiYXJtYWRhLSIgcHJlZml4IGluIGR0cyhpKSBmaWxlIG5hbWVzIHRvIGFj
NSwNCj4+Pj4gYmVjYXVzZQ0KPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFybWFkYSBo
YXMgbm90IG11Y2ggY29tbW9uIHdpdGggQUM1IFNvQy4NCj4+Pj4NCj4+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoCAyKSBBZGQgY2xvY2sgZml4ZXM6DQo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSByZW5hbWUgY29yZV9jbG9jayB0byBjbm1fY2xvY2sNCj4+Pj4gIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAtIHJlbW92ZSBheGlfY2xvY2sNCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAtIGNoYW5nZSBjbm1fY2xvY2sgdG8gMzI1TUhaDQo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLSB1c2UgY25tX2Nsb2NrIGZvciB0aGUgVUFSVA0KPj4+Pg0KPj4+PiAgwqDCoMKg
wqAgQ2hhbmdlcyBpbiB2ODoNCj4+Pj4gIMKgwqDCoMKgIC0gUmVtb3ZlIHVubmVjZXNzYXJ5IGNs
b2NrLWZyZXF1ZW5jeSBwcm9wZXJ0eSBvbiBhcm12OC10aW1lcg0KPj4+PiAgwqDCoMKgwqAgLSBS
ZW1vdmUgdW5uZWNlc3NhcnkgcmVkaXN0cmlidXRvci1zdHJpZGUgcHJvcGVydHkgb24gZ2ljDQo+
Pj4+ICDCoMKgwqDCoCAtIEFkZCBHSUNfU1BJIGludGVycnVwdHMgZm9yIGdwaW9zDQo+Pj4+ICDC
oMKgwqDCoCBDaGFuZ2VzIGluIHY3Og0KPj4+PiAgwqDCoMKgwqAgLSBBZGQgbWlzc2luZyBjb21w
YXRpYmxlIG9uIHVzYjENCj4+Pj4gIMKgwqDCoMKgIC0gQWRkICJyZC1hYzV4IiBjb21wYXRpYmxl
IGZvciBib2FyZA0KPj4+PiAgwqDCoMKgwqAgLSBNb3ZlIGFsaWFzZXMgdG8gYm9hcmQgZHRzDQo+
Pj4+ICDCoMKgwqDCoCAtIE1vdmUgYm9hcmQgc3BlY2lmaWMgdXNiIGluZm8gdG8gYm9hcmQgZHRz
DQo+Pj4+ICDCoMKgwqDCoCAtIENvbnNvbGlkYXRlIHVzYjEgYm9hcmQgc2V0dGluZ3MgYW5kIHJl
bW92ZSB1bm5lY2Vzc2FyeSBjb21wYXRpYmxlDQo+Pj4+ICDCoMKgwqDCoCAtIEFkZCBBbGxpZWQg
VGVsZXNpcyBjb3B5cmlnaHQNCj4+Pj4gIMKgwqDCoMKgIC0gUmVuYW1lIGZpbGVzIGFmdGVyIG1h
aWxuZy1saXN0IGRpc2N1c3Npb24NCj4+Pj4gIMKgwqDCoMKgIENoYW5nZXMgaW4gdjY6DQo+Pj4+
ICDCoMKgwqDCoCAtIE1vdmUgQ1BVIG5vZGVzIGFib3ZlIHRoZSBTb0MgKEtyenlzenRvZikNCj4+
Pj4gIMKgwqDCoMKgIC0gTWlub3IgZm9ybWF0dGluZyBjbGVhbiB1cHMgKEtyenlzenRvZikNCj4+
Pj4gIMKgwqDCoMKgIC0gUnVuIHRocm91Z2ggYG1ha2UgZHRic19jaGVja2ANCj4+Pj4gIMKgwqDC
oMKgIC0gTW92ZSBnaWMgbm9kZXMgaW5zaWRlIFNvQw0KPj4+PiAgwqDCoMKgwqAgLSBHcm91cCBj
bG9ja3MgdW5kZXIgYSBjbG9jayBub2RlDQo+Pj4+ICDCoMKgwqDCoCBDaGFuZ2VzIGluIHY1Og0K
Pj4+PiAgwqDCoMKgwqAgLSBhZGQgI3thZGRyZXNzLHNpemV9LWNlbGxzIHByb3BlcnR5IHRvIGky
YyBub2Rlcw0KPj4+PiAgwqDCoMKgwqAgLSBtYWtlIGkyYyBub2RlcyBkaXNhYmxlZCBpbiB0aGUg
U29DIGFuZCBlbmFibGUgdGhlbSBpbiB0aGUgYm9hcmQNCj4+Pj4gIMKgwqDCoMKgIC0gYWRkIGlu
dGVycnVwdCBjb250cm9sbGVyIGF0dHJpYnV0ZXMgdG8gZ3BpbyBub2Rlcw0KPj4+PiAgwqDCoMKg
wqAgLSBNb3ZlIGZpeGVkLWNsb2NrIG5vZGVzIHVwIGEgbGV2ZWwgYW5kIHJlbW92ZSB1bm5lY2Vz
c2FyeSBAMA0KPj4+PiAgwqDCoMKgwqAgQ2hhbmdlcyBpbiB2NDoNCj4+Pj4gIMKgwqDCoMKgIC0g
dXNlICdwaHktaGFuZGxlJyBpbnN0ZWFkIG9mICdwaHknDQo+Pj4+ICDCoMKgwqDCoCAtIG1vdmUg
c3RhdHVzPSJva2F5IiBvbiB1c2Igbm9kZXMgdG8gYm9hcmQgZHRzDQo+Pj4+ICDCoMKgwqDCoCAt
IEFkZCByZXZpZXcgZnJvbSBBbmRyZXcNCj4+Pj4gIMKgwqDCoMKgIENoYW5nZXMgaW4gdjM6DQo+
Pj4+ICDCoMKgwqDCoCAtIE1vdmUgbWVtb3J5IG5vZGUgdG8gYm9hcmQNCj4+Pj4gIMKgwqDCoMKg
IC0gVXNlIHNpbmdsZSBkaWdpdCByZWcgdmFsdWUgZm9yIHBoeSBhZGRyZXNzDQo+Pj4+ICDCoMKg
wqDCoCAtIFJlbW92ZSBNTUMgbm9kZSAoZHJpdmVyIG5lZWRzIHdvcmspDQo+Pj4+ICDCoMKgwqDC
oCAtIFJlbW92ZSBzeXNjb24gJiBzaW1wbGUtbWZkIGZvciBwaW5jdHJsDQo+Pj4+ICDCoMKgwqDC
oCBDaGFuZ2VzIGluIHYyOg0KPj4+PiAgwqDCoMKgwqAgLSBNYWtlIHBpbmN0cmwgYSBjaGlsZCBu
b2RlIG9mIGEgc3lzY29uIG5vZGUNCj4+Pj4gIMKgwqDCoMKgIC0gVXNlIG1hcnZlbGwsYXJtYWRh
LThrLWdwaW8gaW5zdGVhZCBvZiBvcmlvbi1ncGlvDQo+Pj4+ICDCoMKgwqDCoCAtIFJlbW92ZSBu
YW5kIHBlcmlwaGVyYWwuIFRoZSBNYXJ2ZWxsIFNESyBkb2VzIGhhdmUgc29tZSBjaGFuZ2VzDQo+
Pj4+IGZvciB0aGUNCj4+Pj4gIMKgwqDCoMKgwqDCoCBhYzUtbmFuZC1jb250cm9sbGVyIGJ1dCBJ
IGN1cnJlbnRseSBsYWNrIGhhcmR3YXJlIHdpdGggTkFORA0KPj4+PiBmaXR0ZWQgc28NCj4+Pj4g
IMKgwqDCoMKgwqDCoCBJIGNhbid0IHRlc3QgaXQgcmlnaHQgbm93LiBJJ3ZlIHRoZXJlZm9yZSBj
aG9zZW4gdG8gb21pdCB0aGUNCj4+Pj4gbm9kZSBhbmQNCj4+Pj4gIMKgwqDCoMKgwqDCoCBub3Qg
YXR0ZW1wdGVkIHRvIGJyaW5nIGluIHRoZSBkcml2ZXIgb3IgYmluZGluZy4NCj4+Pj4gIMKgwqDC
oMKgIC0gUmVtb3ZlIHBjaWUgcGVyaXBoZXJhbC4gQWdhaW4gdGhlcmUgYXJlIGNoYW5nZXMgaW4g
dGhlIFNESyBhbmQNCj4+Pj4gSSBoYXZlDQo+Pj4+ICDCoMKgwqDCoMKgwqAgbm8gd2F5IG9mIHRl
c3RpbmcgdGhlbS4NCj4+Pj4gIMKgwqDCoMKgIC0gUmVtb3ZlIHByZXN0ZXJhIG5vZGUuDQo+Pj4+
ICDCoMKgwqDCoCAtIFJlbW92ZSAibWFydmVsbCxhYzUtZWhjaSIgY29tcGF0aWJsZSBmcm9tIFVT
QiBub2RlIGFzDQo+Pj4+ICDCoMKgwqDCoMKgwqAgIm1hcnZlbGwsb3Jpb24tZWhjaSIgaXMgc3Vm
ZmljaWVudA0KPj4+PiAgwqDCoMKgwqAgLSBSZW1vdmUgd2F0Y2hkb2cgbm9kZS4gVGhlcmUgaXMg
YSBidWdneSBkcml2ZXIgZm9yIHRoZSBhYzUNCj4+Pj4gd2F0Y2hkb2cgaW4NCj4+Pj4gIMKgwqDC
oMKgwqDCoCB0aGUgU0RLIGJ1dCBpdCBuZWVkcyBzb21lIHdvcmsgc28gSSd2ZSBkcm9wcGVkIHRo
ZSBub2RlIGZvciBub3cuDQo+Pj4+DQo+Pj4+ICDCoCBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZl
bGwvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+Pj4+ICDCoCBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL21hcnZlbGwvYWM1LTk4ZHgyNXh4LmR0c2kgfCAyOTEgKysrKysrKysrKysr
KysrKysrDQo+Pj4+ICDCoCAuLi4vYm9vdC9kdHMvbWFydmVsbC9hYzUtOThkeDM1eHgtcmQuZHRz
wqDCoMKgwqDCoCB8IDEwMSArKysrKysNCj4+Pj4gIMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFy
dmVsbC9hYzUtOThkeDM1eHguZHRzaSB8wqAgMTMgKw0KPj4+PiAgwqAgNCBmaWxlcyBjaGFuZ2Vk
LCA0MDYgaW5zZXJ0aW9ucygrKQ0KPj4+PiAgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWFydmVsbC9hYzUtOThkeDI1eHguZHRzaQ0KPj4+PiAgwqAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hYzUtOThkeDM1eHgtcmQuZHRz
DQo+Pj4+ICDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxs
L2FjNS05OGR4MzV4eC5kdHNpDQo+Pj4+DQo+IFtzbmlwXQ0KPg0KPj4+PiArDQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVhcnQwOiBzZXJpYWxAMTIwMDAgew0KPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAic25wcyxkdy1hcGItdWFydCI7DQo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4MTIwMDAgMHgxMDA+
Ow0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZy1zaGlmdCA9IDwyPjsN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRzID0gPEdJQ19T
UEkgODMgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmVnLWlvLXdpZHRoID0gPDE+Ow0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNsb2NrcyA9IDwmY25tX2Nsb2NrPjsNCj4+PiBXaXRoIHRoaXMgY2hhbmdlIEkg
c2VlIHNvbWUgZ2FyYmxlZCBvdXRwdXQgd2hlbiB0aGUgIlNlcmlhbDogQU1CQQ0KPj4+IFBMMDEx
IFVBUlQiIGRyaXZlciBzdGFydHMuDQo+Pj4NCj4+PiBJdCBjb3VsZCBiZSB0aGF0IG15IGJvb3Rs
b2FkZXIgaGFzIHRoZSBzYW1lIHdyb25nIGNsb2NrIHZhbHVlIGFzIHRoZQ0KPj4+IGVhcmxpZXIg
aXRlcmF0aW9uIG9mIHRoaXMgZGV2aWNlIHRyZWUuDQo+PiBGaXhpbmcgdS1ib290IGRvZXNuJ3Qg
aGVscCBidXQgdGhlcmUgYXJlIGFsc28gcmVmZXJlbmNlcyB0byAzMjgwMDAwMDAgaW4NCj4+IG12
LWRkciBhbmQgQVRGIHNvIEknbGwgbG9vayB0byBzZWUgaWYgdXBkYXRpbmcgdGhlbSBmaXhlcyB0
aGUgaXNzdWUNCj4+IHRvbW9ycm93Lg0KDQpFdmVuwqAgd2l0aCBjaGFuZ2luZyBBVEYgYW5kIG12
X2RkciB0byB1c2UgMzI1MDAwMDAwIEkgc3RpbGwgZW5kIHVwIHdpdGggDQp0aGUgZ2FyYmxlZCBv
dXRwdXQgd2hlbiB0aGUgZHJpdmVyIHN0YXJ0cy4gSSBkb24ndCBrbm93IGlmIHRoZXJlJ3MgDQpz
b21ldGhpbmcgc3BlY2lhbCBhYm91dCB0aGUgZmFjdCBJIGhhdmUgYSBSRC1BQzVYLVNSMiBib2Fy
ZC4gQXMgZmFyIGFzIEkgDQprbm93IHRoZSBvbmx5IGRpZmZlcmVuY2Ugd2l0aCB0aGUgU1IyIGJv
YXJkIHdhcyBhbiBpbmNyZWFzZWQgRERSIHNpemUuDQoNCj4gSW50ZXJlc3RpbmcsIGJlY2F1c2Ug
TWFydmVsbCBzdWdnZXN0ZWQgdG8gdXNlIGNubV9jbG9jayB3aXRoIDMyOE1IeiBmb3IgQUM1LCBh
bmQgMzI1TUh6DQo+IGZvciBBQzVYLg0KDQpEaWQgeW91IGdldCB0aGF0IHRoZSByaWdodCB3YXkg
cm91bmQ/IFRoZSBhYzUtOThkeDI1eHguZHRzaSBpcyBBQzUgc28gaWYgDQp3aGF0IHlvdSBoYXZl
IHdyaXR0ZW4gaXMgY29ycmVjdCBzaG91bGRuJ3QgdGhlIGNubSBjbG9jay1mcmVxdWVuY3kgaW4g
DQphYzUtOThkeDI1eHguZHRzaSBiZSAzMjhNSHogYW5kIHRoZSBhYzUtOThkeDM1eHguZHRzaSAo
d2hpY2ggaXMgQUM1WCkgDQpvdmVycmlkZSB0aGlzIHRvIDMyNU1Iej8NCg0KRWxhZCwgY2FuIHlv
dSBzaGluZSBhbnkgbGlnaHQgb24gdGhpcz8NCg0KPiBbc25pcF0NCj4NCj4+Pj4gKw0KPj4+PiAr
wqDCoMKgIGNsb2NrcyB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBjbm1fY2xvY2s6IGNvcmUtY2xv
Y2sgew0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImZpeGVkLWNs
b2NrIjsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI2Nsb2NrLWNlbGxzID0gPDA+Ow0K
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9jay1mcmVxdWVuY3kgPSA8MzI1MDAwMDAw
PjsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH07DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IHNwaV9jbG9jazogc3BpLWNsb2NrIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29t
cGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNj
bG9jay1jZWxscyA9IDwwPjsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2stZnJl
cXVlbmN5ID0gPDIwMDAwMDAwMD47DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9Ow0KPj4+PiArwqDC
oMKgIH07DQo+Pj4+ICt9Ow0KPiBbc25pcF0NCj4NCj4gUmVnYXJkcyw=
