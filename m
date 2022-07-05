Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA756628F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiGEFAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGEFAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:00:06 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD8512624
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 22:00:01 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9767C2C00C5;
        Tue,  5 Jul 2022 04:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1656997198;
        bh=nEAGP8BexA4Br6d5XUWdR9WKFFOfEdkRj1ujMu1qSFw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=C/778WF6Bs4Frq2FJzcy7id5KNIsEI85gwqK3gY74V0ShLt0+FNSLH2yp8BG2JPfa
         kq+lgiqqvDMFeSJusNmM8RZ2lZWaVsApDx6+Y2QijqQ+e0cbfDbsxe59K06J4fIK2V
         iWDAv3bOVpSbB71wHXmrToj89s6UWERnnYSjeukEiC0T+lFMXNbbB1t1ab7y7BTqhR
         6Hgqazl2DKQUn8Itf75xhK6KzkGGvCgHM4DiEkU5p/5fTV+BTJT86Aoy8NIvICeUL0
         rp0TppUg1OpR5rNyRBhlpGf3Dck19qZhIkO4262c40vELcfviOioOPW+QpP4GqpKK+
         a5dywvtLeoC7w==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62c3c54e0001>; Tue, 05 Jul 2022 16:59:58 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.36; Tue, 5 Jul 2022 16:59:58 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.036; Tue, 5 Jul 2022 16:59:58 +1200
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
Thread-Index: AQHYf3ivRDlWE7CQx0aHryZFsklnE61NkiuAgAAEXoCAAC94gIAA3IWAgAAsI4CAH8FggA==
Date:   Tue, 5 Jul 2022 04:59:57 +0000
Message-ID: <e5eee65d-1d05-f956-d087-8b7a8ea4dc6e@alliedtelesis.co.nz>
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
 <20220613225338.393-3-vadym.kochan@plvision.eu>
 <4670aab9-b7fa-f2c7-567a-12ca24535b0c@alliedtelesis.co.nz>
 <37d7b4f1-fd39-dc05-374a-764070c56cc6@alliedtelesis.co.nz>
 <20220614081633.GA14160@plvision.eu>
 <81548de1-dbb4-ce3e-b1ca-d28a92dc3025@alliedtelesis.co.nz>
 <a22447b1-bd4d-58de-2e0d-a034288ea353@alliedtelesis.co.nz>
In-Reply-To: <a22447b1-bd4d-58de-2e0d-a034288ea353@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5E537E72807A548BC94FC1035AC6DDA@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=KJck82No c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=RgO8CyIxsXoA:10 a=g8kJ_gb0AAAA:8 a=wj_Lr72uINdgm8W3u9AA:9 a=QEXdDO2ut3YA:10 a=ecSNLfPMzbq-p5zXJZOg:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNS8wNi8yMiAxMjowMywgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gSGkgQWxsLA0KPg0K
Pg0KPiBPbiAxNS8wNi8yMiAwOToyNSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+ICtjYzogRWxh
ZA0KPj4NCj4+IE9uIDE0LzA2LzIyIDIwOjE2LCBWYWR5bSBLb2NoYW4gd3JvdGU6DQo+Pj4gSGkg
Q2hyaXMsDQo+Pj4NCj4+PiBPbiBUdWUsIEp1biAxNCwgMjAyMiBhdCAwNToyNjozOUFNICswMDAw
LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+PiBPbiAxNC8wNi8yMiAxNzoxMSwgQ2hyaXMgUGFj
a2hhbSB3cm90ZToNCj4+Pj4+IE9uIDE0LzA2LzIyIDEwOjUzLCBWYWR5bSBLb2NoYW4gd3JvdGU6
DQo+Pj4+Pj4gRnJvbTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lz
LmNvLm56Pg0KPj4+Pj4+DQo+Pj4+Pj4gVGhlIDk4RFgyNTMwIFNvQyBpcyB0aGUgQ29udHJvbCBh
bmQgTWFuYWdlbWVudCBDUFUgaW50ZWdyYXRlZCBpbnRvDQo+Pj4+Pj4gdGhlIE1hcnZlbGwgOThE
WDI1eHggYW5kIDk4RFgzNXh4IHNlcmllcyBvZiBzd2l0Y2ggY2hpcCAoaW50ZXJuYWxseQ0KPj4+
Pj4+IHJlZmVycmVkIHRvIGFzIEFsbGV5Q2F0NSBhbmQgQWxsZXlDYXQ1WCkuDQo+Pj4+Pj4NCj4+
Pj4+PiBUaGVzZSBmaWxlcyBoYXZlIGJlZW4gdGFrZW4gZnJvbSB0aGUgTWFydmVsbCBTREsgYW5k
IGxpZ2h0bHkgY2xlYW5lZA0KPj4+Pj4+IHVwIHdpdGggdGhlIExpY2Vuc2UgYW5kIGNvcHlyaWdo
dCByZXRhaW5lZC4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0g
PGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5
OiBWYWR5bSBLb2NoYW4gPHZhZHltLmtvY2hhbkBwbHZpc2lvbi5ldT4NCj4+Pj4+PiAtLS0NCj4+
Pj4+Pg0KPj4+Pj4+IE5vdGVzOg0KPj4+Pj4+IMKgwqDCoMKgwqAgVGhlIE1hcnZlbGwgU0RLIGhh
cyBhIG51bWJlciBvZiBuZXcgY29tcGF0aWJsZSBzdHJpbmdzLiBJJ3ZlDQo+Pj4+Pj4gYnJvdWdo
dA0KPj4+Pj4+IMKgwqDCoMKgwqAgdGhyb3VnaCBzb21lIG9mIHRoZSBkcml2ZXJzIG9yIHdoZXJl
IHBvc3NpYmxlIHVzZWQgYW4gaW4tdHJlZQ0KPj4+Pj4+IMKgwqDCoMKgwqAgYWx0ZXJuYXRpdmUg
KGUuZy4gdGhlcmUgaXMgU0RLIGNvZGUgZm9yIGEgYWM1LWdwaW8gYnV0IHR3bw0KPj4+Pj4+IGlu
c3RhbmNlcyBvZg0KPj4+Pj4+IMKgwqDCoMKgwqAgdGhlIGV4aXN0aW5nIG1hcnZlbGwsb3Jpb24t
Z3BpbyBzZWVtcyB0byBjb3ZlciB3aGF0IGlzIA0KPj4+Pj4+IG5lZWRlZCBpZg0KPj4+Pj4+IHlv
dSB1c2UNCj4+Pj4+PiDCoMKgwqDCoMKgIGFuIGFwcHJvcHJpYXRlIGJpbmRpbmcpLiBJIGV4cGVj
dCB0aGF0IHRoZXJlIHdpbGwgYSBuZXcgDQo+Pj4+Pj4gc2VyaWVzIG9mDQo+Pj4+Pj4gwqDCoMKg
wqDCoCBwYXRjaGVzIHdoZW4gSSBnZXQgc29tZSBkaWZmZXJlbnQgaGFyZHdhcmUgKG9yIGFkZGl0
aW9ucyB0byANCj4+Pj4+PiB0aGlzDQo+Pj4+Pj4gc2VyaWVzDQo+Pj4+Pj4gwqDCoMKgwqDCoCBk
ZXBlbmRpbmcgb24gaWYvd2hlbiBpdCBsYW5kcykuDQo+Pj4+Pj4gwqDCoMKgwqDCoCDCoMKgwqDC
oCBDaGFuZ2VzIGluIHY5IChwcm9wb3NlZCBieSBNYXJ2ZWxsKToNCj4+Pj4+PiDCoMKgwqDCoMKg
wqDCoCBJdCB3YXMgZGlzY3Vzc2VkIHdpdGggQ2hyaXMgdGhhdCBNYXJ2ZWxsIHdpbGwgYWRkIHNv
bWUgDQo+Pj4+Pj4gY2hhbmdlczoNCj4+Pj4+Pg0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDEpIFJlbmFtZSAiYXJtYWRhLSIgcHJlZml4IGluIGR0cyhpKSBmaWxlIG5hbWVzIHRvIGFjNSwN
Cj4+Pj4+PiBiZWNhdXNlDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQXJtYWRh
IGhhcyBub3QgbXVjaCBjb21tb24gd2l0aCBBQzUgU29DLg0KPj4+Pj4+DQo+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMikgQWRkIGNsb2NrIGZpeGVzOg0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC0gcmVuYW1lIGNvcmVfY2xvY2sgdG8gY25tX2Nsb2NrDQo+Pj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSByZW1vdmUgYXhpX2Nsb2NrDQo+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjaGFuZ2UgY25tX2Nsb2NrIHRvIDMyNU1IWg0KPj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gdXNlIGNubV9jbG9jayBmb3IgdGhlIFVBUlQN
Cj4+Pj4+Pg0KPj4+Pj4+IMKgwqDCoMKgwqAgQ2hhbmdlcyBpbiB2ODoNCj4+Pj4+PiDCoMKgwqDC
oMKgIC0gUmVtb3ZlIHVubmVjZXNzYXJ5IGNsb2NrLWZyZXF1ZW5jeSBwcm9wZXJ0eSBvbiBhcm12
OC10aW1lcg0KPj4+Pj4+IMKgwqDCoMKgwqAgLSBSZW1vdmUgdW5uZWNlc3NhcnkgcmVkaXN0cmli
dXRvci1zdHJpZGUgcHJvcGVydHkgb24gZ2ljDQo+Pj4+Pj4gwqDCoMKgwqDCoCAtIEFkZCBHSUNf
U1BJIGludGVycnVwdHMgZm9yIGdwaW9zDQo+Pj4+Pj4gwqDCoMKgwqDCoCBDaGFuZ2VzIGluIHY3
Og0KPj4+Pj4+IMKgwqDCoMKgwqAgLSBBZGQgbWlzc2luZyBjb21wYXRpYmxlIG9uIHVzYjENCj4+
Pj4+PiDCoMKgwqDCoMKgIC0gQWRkICJyZC1hYzV4IiBjb21wYXRpYmxlIGZvciBib2FyZA0KPj4+
Pj4+IMKgwqDCoMKgwqAgLSBNb3ZlIGFsaWFzZXMgdG8gYm9hcmQgZHRzDQo+Pj4+Pj4gwqDCoMKg
wqDCoCAtIE1vdmUgYm9hcmQgc3BlY2lmaWMgdXNiIGluZm8gdG8gYm9hcmQgZHRzDQo+Pj4+Pj4g
wqDCoMKgwqDCoCAtIENvbnNvbGlkYXRlIHVzYjEgYm9hcmQgc2V0dGluZ3MgYW5kIHJlbW92ZSB1
bm5lY2Vzc2FyeSANCj4+Pj4+PiBjb21wYXRpYmxlDQo+Pj4+Pj4gwqDCoMKgwqDCoCAtIEFkZCBB
bGxpZWQgVGVsZXNpcyBjb3B5cmlnaHQNCj4+Pj4+PiDCoMKgwqDCoMKgIC0gUmVuYW1lIGZpbGVz
IGFmdGVyIG1haWxuZy1saXN0IGRpc2N1c3Npb24NCj4+Pj4+PiDCoMKgwqDCoMKgIENoYW5nZXMg
aW4gdjY6DQo+Pj4+Pj4gwqDCoMKgwqDCoCAtIE1vdmUgQ1BVIG5vZGVzIGFib3ZlIHRoZSBTb0Mg
KEtyenlzenRvZikNCj4+Pj4+PiDCoMKgwqDCoMKgIC0gTWlub3IgZm9ybWF0dGluZyBjbGVhbiB1
cHMgKEtyenlzenRvZikNCj4+Pj4+PiDCoMKgwqDCoMKgIC0gUnVuIHRocm91Z2ggYG1ha2UgZHRi
c19jaGVja2ANCj4+Pj4+PiDCoMKgwqDCoMKgIC0gTW92ZSBnaWMgbm9kZXMgaW5zaWRlIFNvQw0K
Pj4+Pj4+IMKgwqDCoMKgwqAgLSBHcm91cCBjbG9ja3MgdW5kZXIgYSBjbG9jayBub2RlDQo+Pj4+
Pj4gwqDCoMKgwqDCoCBDaGFuZ2VzIGluIHY1Og0KPj4+Pj4+IMKgwqDCoMKgwqAgLSBhZGQgI3th
ZGRyZXNzLHNpemV9LWNlbGxzIHByb3BlcnR5IHRvIGkyYyBub2Rlcw0KPj4+Pj4+IMKgwqDCoMKg
wqAgLSBtYWtlIGkyYyBub2RlcyBkaXNhYmxlZCBpbiB0aGUgU29DIGFuZCBlbmFibGUgdGhlbSBp
biB0aGUgDQo+Pj4+Pj4gYm9hcmQNCj4+Pj4+PiDCoMKgwqDCoMKgIC0gYWRkIGludGVycnVwdCBj
b250cm9sbGVyIGF0dHJpYnV0ZXMgdG8gZ3BpbyBub2Rlcw0KPj4+Pj4+IMKgwqDCoMKgwqAgLSBN
b3ZlIGZpeGVkLWNsb2NrIG5vZGVzIHVwIGEgbGV2ZWwgYW5kIHJlbW92ZSB1bm5lY2Vzc2FyeSBA
MA0KPj4+Pj4+IMKgwqDCoMKgwqAgQ2hhbmdlcyBpbiB2NDoNCj4+Pj4+PiDCoMKgwqDCoMKgIC0g
dXNlICdwaHktaGFuZGxlJyBpbnN0ZWFkIG9mICdwaHknDQo+Pj4+Pj4gwqDCoMKgwqDCoCAtIG1v
dmUgc3RhdHVzPSJva2F5IiBvbiB1c2Igbm9kZXMgdG8gYm9hcmQgZHRzDQo+Pj4+Pj4gwqDCoMKg
wqDCoCAtIEFkZCByZXZpZXcgZnJvbSBBbmRyZXcNCj4+Pj4+PiDCoMKgwqDCoMKgIENoYW5nZXMg
aW4gdjM6DQo+Pj4+Pj4gwqDCoMKgwqDCoCAtIE1vdmUgbWVtb3J5IG5vZGUgdG8gYm9hcmQNCj4+
Pj4+PiDCoMKgwqDCoMKgIC0gVXNlIHNpbmdsZSBkaWdpdCByZWcgdmFsdWUgZm9yIHBoeSBhZGRy
ZXNzDQo+Pj4+Pj4gwqDCoMKgwqDCoCAtIFJlbW92ZSBNTUMgbm9kZSAoZHJpdmVyIG5lZWRzIHdv
cmspDQo+Pj4+Pj4gwqDCoMKgwqDCoCAtIFJlbW92ZSBzeXNjb24gJiBzaW1wbGUtbWZkIGZvciBw
aW5jdHJsDQo+Pj4+Pj4gwqDCoMKgwqDCoCBDaGFuZ2VzIGluIHYyOg0KPj4+Pj4+IMKgwqDCoMKg
wqAgLSBNYWtlIHBpbmN0cmwgYSBjaGlsZCBub2RlIG9mIGEgc3lzY29uIG5vZGUNCj4+Pj4+PiDC
oMKgwqDCoMKgIC0gVXNlIG1hcnZlbGwsYXJtYWRhLThrLWdwaW8gaW5zdGVhZCBvZiBvcmlvbi1n
cGlvDQo+Pj4+Pj4gwqDCoMKgwqDCoCAtIFJlbW92ZSBuYW5kIHBlcmlwaGVyYWwuIFRoZSBNYXJ2
ZWxsIFNESyBkb2VzIGhhdmUgc29tZSANCj4+Pj4+PiBjaGFuZ2VzDQo+Pj4+Pj4gZm9yIHRoZQ0K
Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIGFjNS1uYW5kLWNvbnRyb2xsZXIgYnV0IEkgY3VycmVudGx5
IGxhY2sgaGFyZHdhcmUgd2l0aCBOQU5EDQo+Pj4+Pj4gZml0dGVkIHNvDQo+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqAgSSBjYW4ndCB0ZXN0IGl0IHJpZ2h0IG5vdy4gSSd2ZSB0aGVyZWZvcmUgY2hvc2Vu
IHRvIG9taXQgdGhlDQo+Pj4+Pj4gbm9kZSBhbmQNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCBub3Qg
YXR0ZW1wdGVkIHRvIGJyaW5nIGluIHRoZSBkcml2ZXIgb3IgYmluZGluZy4NCj4+Pj4+PiDCoMKg
wqDCoMKgIC0gUmVtb3ZlIHBjaWUgcGVyaXBoZXJhbC4gQWdhaW4gdGhlcmUgYXJlIGNoYW5nZXMg
aW4gdGhlIA0KPj4+Pj4+IFNESyBhbmQNCj4+Pj4+PiBJIGhhdmUNCj4+Pj4+PiDCoMKgwqDCoMKg
wqDCoCBubyB3YXkgb2YgdGVzdGluZyB0aGVtLg0KPj4+Pj4+IMKgwqDCoMKgwqAgLSBSZW1vdmUg
cHJlc3RlcmEgbm9kZS4NCj4+Pj4+PiDCoMKgwqDCoMKgIC0gUmVtb3ZlICJtYXJ2ZWxsLGFjNS1l
aGNpIiBjb21wYXRpYmxlIGZyb20gVVNCIG5vZGUgYXMNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCAi
bWFydmVsbCxvcmlvbi1laGNpIiBpcyBzdWZmaWNpZW50DQo+Pj4+Pj4gwqDCoMKgwqDCoCAtIFJl
bW92ZSB3YXRjaGRvZyBub2RlLiBUaGVyZSBpcyBhIGJ1Z2d5IGRyaXZlciBmb3IgdGhlIGFjNQ0K
Pj4+Pj4+IHdhdGNoZG9nIGluDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgdGhlIFNESyBidXQgaXQg
bmVlZHMgc29tZSB3b3JrIHNvIEkndmUgZHJvcHBlZCB0aGUgbm9kZSANCj4+Pj4+PiBmb3Igbm93
Lg0KPj4+Pj4+DQo+Pj4+Pj4gwqDCoCBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZp
bGXCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+Pj4+Pj4gwqDCoCBhcmNoL2FybTY0L2Jv
b3QvZHRzL21hcnZlbGwvYWM1LTk4ZHgyNXh4LmR0c2kgfCAyOTEgDQo+Pj4+Pj4gKysrKysrKysr
KysrKysrKysrDQo+Pj4+Pj4gwqDCoCAuLi4vYm9vdC9kdHMvbWFydmVsbC9hYzUtOThkeDM1eHgt
cmQuZHRzwqDCoMKgwqDCoCB8IDEwMSArKysrKysNCj4+Pj4+PiDCoMKgIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWFydmVsbC9hYzUtOThkeDM1eHguZHRzaSB8wqAgMTMgKw0KPj4+Pj4+IMKgwqAgNCBm
aWxlcyBjaGFuZ2VkLCA0MDYgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4+IMKgwqAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hYzUtOThkeDI1eHguZHRzaQ0KPj4+
Pj4+IMKgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IA0KPj4+Pj4+IGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWFydmVsbC9hYzUtOThkeDM1eHgtcmQuZHRzDQo+Pj4+Pj4gwqDCoCBjcmVhdGUgbW9kZSAxMDA2
NDQgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FjNS05OGR4MzV4eC5kdHNpDQo+Pj4+Pj4N
Cj4+PiBbc25pcF0NCj4+Pg0KPj4+Pj4+ICsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1YXJ0MDogc2VyaWFsQDEyMDAwIHsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbXBhdGlibGUgPSAic25wcyxkdy1hcGItdWFydCI7DQo+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgxMjAwMCAweDEwMD47DQo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWctc2hpZnQgPSA8Mj47DQo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODMgSVJR
X1RZUEVfTEVWRUxfSElHSD47DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZWctaW8td2lkdGggPSA8MT47DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjbG9ja3MgPSA8JmNubV9jbG9jaz47DQo+Pj4+PiBXaXRoIHRoaXMgY2hhbmdlIEkgc2Vl
IHNvbWUgZ2FyYmxlZCBvdXRwdXQgd2hlbiB0aGUgIlNlcmlhbDogQU1CQQ0KPj4+Pj4gUEwwMTEg
VUFSVCIgZHJpdmVyIHN0YXJ0cy4NCj4+Pj4+DQo+Pj4+PiBJdCBjb3VsZCBiZSB0aGF0IG15IGJv
b3Rsb2FkZXIgaGFzIHRoZSBzYW1lIHdyb25nIGNsb2NrIHZhbHVlIGFzIHRoZQ0KPj4+Pj4gZWFy
bGllciBpdGVyYXRpb24gb2YgdGhpcyBkZXZpY2UgdHJlZS4NCj4+Pj4gRml4aW5nIHUtYm9vdCBk
b2Vzbid0IGhlbHAgYnV0IHRoZXJlIGFyZSBhbHNvIHJlZmVyZW5jZXMgdG8gDQo+Pj4+IDMyODAw
MDAwMCBpbg0KPj4+PiBtdi1kZHIgYW5kIEFURiBzbyBJJ2xsIGxvb2sgdG8gc2VlIGlmIHVwZGF0
aW5nIHRoZW0gZml4ZXMgdGhlIGlzc3VlDQo+Pj4+IHRvbW9ycm93Lg0KPj4NCj4+IEV2ZW7CoCB3
aXRoIGNoYW5naW5nIEFURiBhbmQgbXZfZGRyIHRvIHVzZSAzMjUwMDAwMDAgSSBzdGlsbCBlbmQg
dXAgDQo+PiB3aXRoIHRoZSBnYXJibGVkIG91dHB1dCB3aGVuIHRoZSBkcml2ZXIgc3RhcnRzLiBJ
IGRvbid0IGtub3cgaWYgDQo+PiB0aGVyZSdzIHNvbWV0aGluZyBzcGVjaWFsIGFib3V0IHRoZSBm
YWN0IEkgaGF2ZSBhIFJELUFDNVgtU1IyIGJvYXJkLiANCj4+IEFzIGZhciBhcyBJIGtub3cgdGhl
IG9ubHkgZGlmZmVyZW5jZSB3aXRoIHRoZSBTUjIgYm9hcmQgd2FzIGFuIA0KPj4gaW5jcmVhc2Vk
IEREUiBzaXplLg0KPj4NCj4gQWN0dWFsbHkgeW91IG1pZ2h0IGJlIG9mZiB0aGUgaG9vay4gSSd2
ZSBhcHBsaWVkIHlvdXIgcGF0Y2hlcyBvbiB0b3AgDQo+IG9mIHY1LjE4ICh3aGljaCBpcyB3aGF0
IEkgd2FzIHVzaW5nIGxhc3QgdGltZSBJIHdvcmtlZCBvbiB0aGUgc2VyaWVzKSANCj4gYW5kIEkg
ZG9uJ3Qgc2VlIHRoZSBnYXJibGVkIG91dHB1dC4gU28gSSB0aGluayB0aGUgcHJvYmxlbSBpcyBh
Y3R1YWxseSANCj4gbmV3IGJldHdlZW4gdjUuMTggYW5kIHY1LjE5LXJjMi4NCg0KSnVzdCBudWRn
aW5nIHRoaXMgdGhyZWFkLiBUaGluZ3Mgc2VlbSB0byBoYXZlIGJlZW4gZml4ZWQgd2l0aCBjb21t
aXQgDQowN2EyMmI2MTk0NmYgKCJSZXZlcnQgInByaW50azogYWRkIGZ1bmN0aW9ucyB0byBwcmVm
ZXIgZGlyZWN0IA0KcHJpbnRpbmciIikgc28gdGVzdGluZyB3aXNlIHRoaW5ncyBhcmUgYWxsIGdv
b2QuDQoNClRlc3RlZC1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxl
c2lzLmNvLm56Pg0KDQo+Pj4gSW50ZXJlc3RpbmcsIGJlY2F1c2UgTWFydmVsbCBzdWdnZXN0ZWQg
dG8gdXNlIGNubV9jbG9jayB3aXRoIDMyOE1IeiANCj4+PiBmb3IgQUM1LCBhbmQgMzI1TUh6DQo+
Pj4gZm9yIEFDNVguDQo+Pg0KPj4gRGlkIHlvdSBnZXQgdGhhdCB0aGUgcmlnaHQgd2F5IHJvdW5k
PyBUaGUgYWM1LTk4ZHgyNXh4LmR0c2kgaXMgQUM1IHNvIA0KPj4gaWYgd2hhdCB5b3UgaGF2ZSB3
cml0dGVuIGlzIGNvcnJlY3Qgc2hvdWxkbid0IHRoZSBjbm0gY2xvY2stZnJlcXVlbmN5IA0KPj4g
aW4gYWM1LTk4ZHgyNXh4LmR0c2kgYmUgMzI4TUh6IGFuZCB0aGUgYWM1LTk4ZHgzNXh4LmR0c2kg
KHdoaWNoIGlzIA0KPj4gQUM1WCkgb3ZlcnJpZGUgdGhpcyB0byAzMjVNSHo/DQo+Pg0KPj4gRWxh
ZCwgY2FuIHlvdSBzaGluZSBhbnkgbGlnaHQgb24gdGhpcz8NCj4+DQo+Pj4gW3NuaXBdDQo+Pj4N
Cj4+Pj4+PiArDQo+Pj4+Pj4gK8KgwqDCoCBjbG9ja3Mgew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBjbm1fY2xvY2s6IGNvcmUtY2xvY2sgew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICNjbG9jay1jZWxscyA9IDwwPjsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
bG9jay1mcmVxdWVuY3kgPSA8MzI1MDAwMDAwPjsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgfTsN
Cj4+Pj4+PiArDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNwaV9jbG9jazogc3BpLWNsb2NrIHsN
Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImZpeGVkLWNsb2Nr
IjsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjY2xvY2stY2VsbHMgPSA8MD47DQo+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2stZnJlcXVlbmN5ID0gPDIwMDAwMDAw
MD47DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH07DQo+Pj4+Pj4gK8KgwqDCoCB9Ow0KPj4+Pj4+
ICt9Ow0KPj4+IFtzbmlwXQ0KPj4+DQo+Pj4gUmVnYXJkcyw=
