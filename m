Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5A54BE89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiFOAD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiFOADz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:03:55 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E31E183BB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:03:52 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DC1882C0659;
        Wed, 15 Jun 2022 00:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1655251428;
        bh=ZgiRhY+cUyfwGghw7yaVDFNBq5MyTtHS1Ng2x/gUrio=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=th362PPwza6BK1sInnwu8IDbJbR2UsG6KF5aYR34NOuDT4Anw9XCglTQaUJALntU8
         DUqfOZPlmJeDrx2YpwFsh0FwyDM1OGAsg2Uyb5Zkm6bg6dl2vJBqzWnMTsQfz8SE41
         yYkz+DkIHq61FTpFhDmk7jWnkKV0ML+jlRh4pBGnA0J4x8+HNRF7qw2tAxKZZ6y1B3
         q6OnmE9hVZEHhV0fQgkjpWKombOrRrA+Us/KVZpT/lfYLoYYOEPwwv8zEhb99wPeYP
         7SVyxFVRWKOUI+Yxl808SAwwQl8L2pU+MLM31edz/Bb1NjdFUu0zvgrEkGqJ80cZiB
         6Z4eoPRZlc5EA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62a921e40001>; Wed, 15 Jun 2022 12:03:48 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.36; Wed, 15 Jun 2022 12:03:48 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.036; Wed, 15 Jun 2022 12:03:48 +1200
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
Thread-Index: AQHYf3ivRDlWE7CQx0aHryZFsklnE61NkiuAgAAEXoCAAC94gIAA3IWAgAAsI4A=
Date:   Wed, 15 Jun 2022 00:03:47 +0000
Message-ID: <a22447b1-bd4d-58de-2e0d-a034288ea353@alliedtelesis.co.nz>
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
 <20220613225338.393-3-vadym.kochan@plvision.eu>
 <4670aab9-b7fa-f2c7-567a-12ca24535b0c@alliedtelesis.co.nz>
 <37d7b4f1-fd39-dc05-374a-764070c56cc6@alliedtelesis.co.nz>
 <20220614081633.GA14160@plvision.eu>
 <81548de1-dbb4-ce3e-b1ca-d28a92dc3025@alliedtelesis.co.nz>
In-Reply-To: <81548de1-dbb4-ce3e-b1ca-d28a92dc3025@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B73A03543F70DA4592BBEBDA5693528B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=dM/YZ9Rb c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=g8kJ_gb0AAAA:8 a=8uKHY3At9kWPAP_Is0MA:9 a=QEXdDO2ut3YA:10 a=ecSNLfPMzbq-p5zXJZOg:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQoNCk9uIDE1LzA2LzIyIDA5OjI1LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiAr
Y2M6IEVsYWQNCj4NCj4gT24gMTQvMDYvMjIgMjA6MTYsIFZhZHltIEtvY2hhbiB3cm90ZToNCj4+
IEhpIENocmlzLA0KPj4NCj4+IE9uIFR1ZSwgSnVuIDE0LCAyMDIyIGF0IDA1OjI2OjM5QU0gKzAw
MDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4gT24gMTQvMDYvMjIgMTc6MTEsIENocmlzIFBh
Y2toYW0gd3JvdGU6DQo+Pj4+IE9uIDE0LzA2LzIyIDEwOjUzLCBWYWR5bSBLb2NoYW4gd3JvdGU6
DQo+Pj4+PiBGcm9tOiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMu
Y28ubno+DQo+Pj4+Pg0KPj4+Pj4gVGhlIDk4RFgyNTMwIFNvQyBpcyB0aGUgQ29udHJvbCBhbmQg
TWFuYWdlbWVudCBDUFUgaW50ZWdyYXRlZCBpbnRvDQo+Pj4+PiB0aGUgTWFydmVsbCA5OERYMjV4
eCBhbmQgOThEWDM1eHggc2VyaWVzIG9mIHN3aXRjaCBjaGlwIChpbnRlcm5hbGx5DQo+Pj4+PiBy
ZWZlcnJlZCB0byBhcyBBbGxleUNhdDUgYW5kIEFsbGV5Q2F0NVgpLg0KPj4+Pj4NCj4+Pj4+IFRo
ZXNlIGZpbGVzIGhhdmUgYmVlbiB0YWtlbiBmcm9tIHRoZSBNYXJ2ZWxsIFNESyBhbmQgbGlnaHRs
eSBjbGVhbmVkDQo+Pj4+PiB1cCB3aXRoIHRoZSBMaWNlbnNlIGFuZCBjb3B5cmlnaHQgcmV0YWlu
ZWQuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFj
a2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogVmFkeW0gS29j
aGFuIDx2YWR5bS5rb2NoYW5AcGx2aXNpb24uZXU+DQo+Pj4+PiAtLS0NCj4+Pj4+DQo+Pj4+PiBO
b3RlczoNCj4+Pj4+IMKgwqDCoMKgwqAgVGhlIE1hcnZlbGwgU0RLIGhhcyBhIG51bWJlciBvZiBu
ZXcgY29tcGF0aWJsZSBzdHJpbmdzLiBJJ3ZlDQo+Pj4+PiBicm91Z2h0DQo+Pj4+PiDCoMKgwqDC
oMKgIHRocm91Z2ggc29tZSBvZiB0aGUgZHJpdmVycyBvciB3aGVyZSBwb3NzaWJsZSB1c2VkIGFu
IGluLXRyZWUNCj4+Pj4+IMKgwqDCoMKgwqAgYWx0ZXJuYXRpdmUgKGUuZy4gdGhlcmUgaXMgU0RL
IGNvZGUgZm9yIGEgYWM1LWdwaW8gYnV0IHR3bw0KPj4+Pj4gaW5zdGFuY2VzIG9mDQo+Pj4+PiDC
oMKgwqDCoMKgIHRoZSBleGlzdGluZyBtYXJ2ZWxsLG9yaW9uLWdwaW8gc2VlbXMgdG8gY292ZXIg
d2hhdCBpcyANCj4+Pj4+IG5lZWRlZCBpZg0KPj4+Pj4geW91IHVzZQ0KPj4+Pj4gwqDCoMKgwqDC
oCBhbiBhcHByb3ByaWF0ZSBiaW5kaW5nKS4gSSBleHBlY3QgdGhhdCB0aGVyZSB3aWxsIGEgbmV3
IA0KPj4+Pj4gc2VyaWVzIG9mDQo+Pj4+PiDCoMKgwqDCoMKgIHBhdGNoZXMgd2hlbiBJIGdldCBz
b21lIGRpZmZlcmVudCBoYXJkd2FyZSAob3IgYWRkaXRpb25zIHRvIA0KPj4+Pj4gdGhpcw0KPj4+
Pj4gc2VyaWVzDQo+Pj4+PiDCoMKgwqDCoMKgIGRlcGVuZGluZyBvbiBpZi93aGVuIGl0IGxhbmRz
KS4NCj4+Pj4+IMKgwqDCoMKgwqAgwqDCoMKgwqAgQ2hhbmdlcyBpbiB2OSAocHJvcG9zZWQgYnkg
TWFydmVsbCk6DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoCBJdCB3YXMgZGlzY3Vzc2VkIHdpdGggQ2hy
aXMgdGhhdCBNYXJ2ZWxsIHdpbGwgYWRkIHNvbWUgDQo+Pj4+PiBjaGFuZ2VzOg0KPj4+Pj4NCj4+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEpIFJlbmFtZSAiYXJtYWRhLSIgcHJlZml4IGluIGR0
cyhpKSBmaWxlIG5hbWVzIHRvIGFjNSwNCj4+Pj4+IGJlY2F1c2UNCj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEFybWFkYSBoYXMgbm90IG11Y2ggY29tbW9uIHdpdGggQUM1IFNvQy4N
Cj4+Pj4+DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyKSBBZGQgY2xvY2sgZml4ZXM6DQo+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIHJlbmFtZSBjb3JlX2Nsb2NrIHRvIGNu
bV9jbG9jaw0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSByZW1vdmUgYXhpX2Ns
b2NrDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNoYW5nZSBjbm1fY2xvY2sg
dG8gMzI1TUhaDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIHVzZSBjbm1fY2xv
Y2sgZm9yIHRoZSBVQVJUDQo+Pj4+Pg0KPj4+Pj4gwqDCoMKgwqDCoCBDaGFuZ2VzIGluIHY4Og0K
Pj4+Pj4gwqDCoMKgwqDCoCAtIFJlbW92ZSB1bm5lY2Vzc2FyeSBjbG9jay1mcmVxdWVuY3kgcHJv
cGVydHkgb24gYXJtdjgtdGltZXINCj4+Pj4+IMKgwqDCoMKgwqAgLSBSZW1vdmUgdW5uZWNlc3Nh
cnkgcmVkaXN0cmlidXRvci1zdHJpZGUgcHJvcGVydHkgb24gZ2ljDQo+Pj4+PiDCoMKgwqDCoMKg
IC0gQWRkIEdJQ19TUEkgaW50ZXJydXB0cyBmb3IgZ3Bpb3MNCj4+Pj4+IMKgwqDCoMKgwqAgQ2hh
bmdlcyBpbiB2NzoNCj4+Pj4+IMKgwqDCoMKgwqAgLSBBZGQgbWlzc2luZyBjb21wYXRpYmxlIG9u
IHVzYjENCj4+Pj4+IMKgwqDCoMKgwqAgLSBBZGQgInJkLWFjNXgiIGNvbXBhdGlibGUgZm9yIGJv
YXJkDQo+Pj4+PiDCoMKgwqDCoMKgIC0gTW92ZSBhbGlhc2VzIHRvIGJvYXJkIGR0cw0KPj4+Pj4g
wqDCoMKgwqDCoCAtIE1vdmUgYm9hcmQgc3BlY2lmaWMgdXNiIGluZm8gdG8gYm9hcmQgZHRzDQo+
Pj4+PiDCoMKgwqDCoMKgIC0gQ29uc29saWRhdGUgdXNiMSBib2FyZCBzZXR0aW5ncyBhbmQgcmVt
b3ZlIHVubmVjZXNzYXJ5IA0KPj4+Pj4gY29tcGF0aWJsZQ0KPj4+Pj4gwqDCoMKgwqDCoCAtIEFk
ZCBBbGxpZWQgVGVsZXNpcyBjb3B5cmlnaHQNCj4+Pj4+IMKgwqDCoMKgwqAgLSBSZW5hbWUgZmls
ZXMgYWZ0ZXIgbWFpbG5nLWxpc3QgZGlzY3Vzc2lvbg0KPj4+Pj4gwqDCoMKgwqDCoCBDaGFuZ2Vz
IGluIHY2Og0KPj4+Pj4gwqDCoMKgwqDCoCAtIE1vdmUgQ1BVIG5vZGVzIGFib3ZlIHRoZSBTb0Mg
KEtyenlzenRvZikNCj4+Pj4+IMKgwqDCoMKgwqAgLSBNaW5vciBmb3JtYXR0aW5nIGNsZWFuIHVw
cyAoS3J6eXN6dG9mKQ0KPj4+Pj4gwqDCoMKgwqDCoCAtIFJ1biB0aHJvdWdoIGBtYWtlIGR0YnNf
Y2hlY2tgDQo+Pj4+PiDCoMKgwqDCoMKgIC0gTW92ZSBnaWMgbm9kZXMgaW5zaWRlIFNvQw0KPj4+
Pj4gwqDCoMKgwqDCoCAtIEdyb3VwIGNsb2NrcyB1bmRlciBhIGNsb2NrIG5vZGUNCj4+Pj4+IMKg
wqDCoMKgwqAgQ2hhbmdlcyBpbiB2NToNCj4+Pj4+IMKgwqDCoMKgwqAgLSBhZGQgI3thZGRyZXNz
LHNpemV9LWNlbGxzIHByb3BlcnR5IHRvIGkyYyBub2Rlcw0KPj4+Pj4gwqDCoMKgwqDCoCAtIG1h
a2UgaTJjIG5vZGVzIGRpc2FibGVkIGluIHRoZSBTb0MgYW5kIGVuYWJsZSB0aGVtIGluIHRoZSAN
Cj4+Pj4+IGJvYXJkDQo+Pj4+PiDCoMKgwqDCoMKgIC0gYWRkIGludGVycnVwdCBjb250cm9sbGVy
IGF0dHJpYnV0ZXMgdG8gZ3BpbyBub2Rlcw0KPj4+Pj4gwqDCoMKgwqDCoCAtIE1vdmUgZml4ZWQt
Y2xvY2sgbm9kZXMgdXAgYSBsZXZlbCBhbmQgcmVtb3ZlIHVubmVjZXNzYXJ5IEAwDQo+Pj4+PiDC
oMKgwqDCoMKgIENoYW5nZXMgaW4gdjQ6DQo+Pj4+PiDCoMKgwqDCoMKgIC0gdXNlICdwaHktaGFu
ZGxlJyBpbnN0ZWFkIG9mICdwaHknDQo+Pj4+PiDCoMKgwqDCoMKgIC0gbW92ZSBzdGF0dXM9Im9r
YXkiIG9uIHVzYiBub2RlcyB0byBib2FyZCBkdHMNCj4+Pj4+IMKgwqDCoMKgwqAgLSBBZGQgcmV2
aWV3IGZyb20gQW5kcmV3DQo+Pj4+PiDCoMKgwqDCoMKgIENoYW5nZXMgaW4gdjM6DQo+Pj4+PiDC
oMKgwqDCoMKgIC0gTW92ZSBtZW1vcnkgbm9kZSB0byBib2FyZA0KPj4+Pj4gwqDCoMKgwqDCoCAt
IFVzZSBzaW5nbGUgZGlnaXQgcmVnIHZhbHVlIGZvciBwaHkgYWRkcmVzcw0KPj4+Pj4gwqDCoMKg
wqDCoCAtIFJlbW92ZSBNTUMgbm9kZSAoZHJpdmVyIG5lZWRzIHdvcmspDQo+Pj4+PiDCoMKgwqDC
oMKgIC0gUmVtb3ZlIHN5c2NvbiAmIHNpbXBsZS1tZmQgZm9yIHBpbmN0cmwNCj4+Pj4+IMKgwqDC
oMKgwqAgQ2hhbmdlcyBpbiB2MjoNCj4+Pj4+IMKgwqDCoMKgwqAgLSBNYWtlIHBpbmN0cmwgYSBj
aGlsZCBub2RlIG9mIGEgc3lzY29uIG5vZGUNCj4+Pj4+IMKgwqDCoMKgwqAgLSBVc2UgbWFydmVs
bCxhcm1hZGEtOGstZ3BpbyBpbnN0ZWFkIG9mIG9yaW9uLWdwaW8NCj4+Pj4+IMKgwqDCoMKgwqAg
LSBSZW1vdmUgbmFuZCBwZXJpcGhlcmFsLiBUaGUgTWFydmVsbCBTREsgZG9lcyBoYXZlIHNvbWUg
DQo+Pj4+PiBjaGFuZ2VzDQo+Pj4+PiBmb3IgdGhlDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoCBhYzUt
bmFuZC1jb250cm9sbGVyIGJ1dCBJIGN1cnJlbnRseSBsYWNrIGhhcmR3YXJlIHdpdGggTkFORA0K
Pj4+Pj4gZml0dGVkIHNvDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoCBJIGNhbid0IHRlc3QgaXQgcmln
aHQgbm93LiBJJ3ZlIHRoZXJlZm9yZSBjaG9zZW4gdG8gb21pdCB0aGUNCj4+Pj4+IG5vZGUgYW5k
DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoCBub3QgYXR0ZW1wdGVkIHRvIGJyaW5nIGluIHRoZSBkcml2
ZXIgb3IgYmluZGluZy4NCj4+Pj4+IMKgwqDCoMKgwqAgLSBSZW1vdmUgcGNpZSBwZXJpcGhlcmFs
LiBBZ2FpbiB0aGVyZSBhcmUgY2hhbmdlcyBpbiB0aGUgU0RLIA0KPj4+Pj4gYW5kDQo+Pj4+PiBJ
IGhhdmUNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgIG5vIHdheSBvZiB0ZXN0aW5nIHRoZW0uDQo+Pj4+
PiDCoMKgwqDCoMKgIC0gUmVtb3ZlIHByZXN0ZXJhIG5vZGUuDQo+Pj4+PiDCoMKgwqDCoMKgIC0g
UmVtb3ZlICJtYXJ2ZWxsLGFjNS1laGNpIiBjb21wYXRpYmxlIGZyb20gVVNCIG5vZGUgYXMNCj4+
Pj4+IMKgwqDCoMKgwqDCoMKgICJtYXJ2ZWxsLG9yaW9uLWVoY2kiIGlzIHN1ZmZpY2llbnQNCj4+
Pj4+IMKgwqDCoMKgwqAgLSBSZW1vdmUgd2F0Y2hkb2cgbm9kZS4gVGhlcmUgaXMgYSBidWdneSBk
cml2ZXIgZm9yIHRoZSBhYzUNCj4+Pj4+IHdhdGNoZG9nIGluDQo+Pj4+PiDCoMKgwqDCoMKgwqDC
oCB0aGUgU0RLIGJ1dCBpdCBuZWVkcyBzb21lIHdvcmsgc28gSSd2ZSBkcm9wcGVkIHRoZSBub2Rl
IA0KPj4+Pj4gZm9yIG5vdy4NCj4+Pj4+DQo+Pj4+PiDCoMKgIGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWFydmVsbC9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4+Pj4+IMKgwqAg
YXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FjNS05OGR4MjV4eC5kdHNpIHwgMjkxIA0KPj4+
Pj4gKysrKysrKysrKysrKysrKysrDQo+Pj4+PiDCoMKgIC4uLi9ib290L2R0cy9tYXJ2ZWxsL2Fj
NS05OGR4MzV4eC1yZC5kdHPCoMKgwqDCoMKgIHwgMTAxICsrKysrKw0KPj4+Pj4gwqDCoCBhcmNo
L2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYWM1LTk4ZHgzNXh4LmR0c2kgfMKgIDEzICsNCj4+Pj4+
IMKgwqAgNCBmaWxlcyBjaGFuZ2VkLCA0MDYgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4gwqDCoCBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FjNS05OGR4MjV4eC5k
dHNpDQo+Pj4+PiDCoMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21h
cnZlbGwvYWM1LTk4ZHgzNXh4LXJkLmR0cw0KPj4+Pj4gwqDCoCBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FjNS05OGR4MzV4eC5kdHNpDQo+Pj4+Pg0KPj4g
W3NuaXBdDQo+Pg0KPj4+Pj4gKw0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWFydDA6
IHNlcmlhbEAxMjAwMCB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bXBhdGlibGUgPSAic25wcyxkdy1hcGItdWFydCI7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJlZyA9IDwweDEyMDAwIDB4MTAwPjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmVnLXNoaWZ0ID0gPDI+Ow0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODMgSVJRX1RZUEVfTEVWRUxf
SElHSD47DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZy1pby13aWR0
aCA9IDwxPjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tzID0g
PCZjbm1fY2xvY2s+Ow0KPj4+PiBXaXRoIHRoaXMgY2hhbmdlIEkgc2VlIHNvbWUgZ2FyYmxlZCBv
dXRwdXQgd2hlbiB0aGUgIlNlcmlhbDogQU1CQQ0KPj4+PiBQTDAxMSBVQVJUIiBkcml2ZXIgc3Rh
cnRzLg0KPj4+Pg0KPj4+PiBJdCBjb3VsZCBiZSB0aGF0IG15IGJvb3Rsb2FkZXIgaGFzIHRoZSBz
YW1lIHdyb25nIGNsb2NrIHZhbHVlIGFzIHRoZQ0KPj4+PiBlYXJsaWVyIGl0ZXJhdGlvbiBvZiB0
aGlzIGRldmljZSB0cmVlLg0KPj4+IEZpeGluZyB1LWJvb3QgZG9lc24ndCBoZWxwIGJ1dCB0aGVy
ZSBhcmUgYWxzbyByZWZlcmVuY2VzIHRvIA0KPj4+IDMyODAwMDAwMCBpbg0KPj4+IG12LWRkciBh
bmQgQVRGIHNvIEknbGwgbG9vayB0byBzZWUgaWYgdXBkYXRpbmcgdGhlbSBmaXhlcyB0aGUgaXNz
dWUNCj4+PiB0b21vcnJvdy4NCj4NCj4gRXZlbsKgIHdpdGggY2hhbmdpbmcgQVRGIGFuZCBtdl9k
ZHIgdG8gdXNlIDMyNTAwMDAwMCBJIHN0aWxsIGVuZCB1cCANCj4gd2l0aCB0aGUgZ2FyYmxlZCBv
dXRwdXQgd2hlbiB0aGUgZHJpdmVyIHN0YXJ0cy4gSSBkb24ndCBrbm93IGlmIA0KPiB0aGVyZSdz
IHNvbWV0aGluZyBzcGVjaWFsIGFib3V0IHRoZSBmYWN0IEkgaGF2ZSBhIFJELUFDNVgtU1IyIGJv
YXJkLiANCj4gQXMgZmFyIGFzIEkga25vdyB0aGUgb25seSBkaWZmZXJlbmNlIHdpdGggdGhlIFNS
MiBib2FyZCB3YXMgYW4gDQo+IGluY3JlYXNlZCBERFIgc2l6ZS4NCj4NCkFjdHVhbGx5IHlvdSBt
aWdodCBiZSBvZmYgdGhlIGhvb2suIEkndmUgYXBwbGllZCB5b3VyIHBhdGNoZXMgb24gdG9wIG9m
IA0KdjUuMTggKHdoaWNoIGlzIHdoYXQgSSB3YXMgdXNpbmcgbGFzdCB0aW1lIEkgd29ya2VkIG9u
IHRoZSBzZXJpZXMpIGFuZCBJIA0KZG9uJ3Qgc2VlIHRoZSBnYXJibGVkIG91dHB1dC4gU28gSSB0
aGluayB0aGUgcHJvYmxlbSBpcyBhY3R1YWxseSBuZXcgDQpiZXR3ZWVuIHY1LjE4IGFuZCB2NS4x
OS1yYzIuDQo+PiBJbnRlcmVzdGluZywgYmVjYXVzZSBNYXJ2ZWxsIHN1Z2dlc3RlZCB0byB1c2Ug
Y25tX2Nsb2NrIHdpdGggMzI4TUh6IA0KPj4gZm9yIEFDNSwgYW5kIDMyNU1Ieg0KPj4gZm9yIEFD
NVguDQo+DQo+IERpZCB5b3UgZ2V0IHRoYXQgdGhlIHJpZ2h0IHdheSByb3VuZD8gVGhlIGFjNS05
OGR4MjV4eC5kdHNpIGlzIEFDNSBzbyANCj4gaWYgd2hhdCB5b3UgaGF2ZSB3cml0dGVuIGlzIGNv
cnJlY3Qgc2hvdWxkbid0IHRoZSBjbm0gY2xvY2stZnJlcXVlbmN5IA0KPiBpbiBhYzUtOThkeDI1
eHguZHRzaSBiZSAzMjhNSHogYW5kIHRoZSBhYzUtOThkeDM1eHguZHRzaSAod2hpY2ggaXMgDQo+
IEFDNVgpIG92ZXJyaWRlIHRoaXMgdG8gMzI1TUh6Pw0KPg0KPiBFbGFkLCBjYW4geW91IHNoaW5l
IGFueSBsaWdodCBvbiB0aGlzPw0KPg0KPj4gW3NuaXBdDQo+Pg0KPj4+Pj4gKw0KPj4+Pj4gK8Kg
wqDCoCBjbG9ja3Mgew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGNubV9jbG9jazogY29yZS1jbG9j
ayB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImZpeGVkLWNs
b2NrIjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNjbG9jay1jZWxscyA9IDwwPjsN
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2NrLWZyZXF1ZW5jeSA9IDwzMjUwMDAw
MDA+Ow0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH07DQo+Pj4+PiArDQo+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgc3BpX2Nsb2NrOiBzcGktY2xvY2sgew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAjY2xvY2stY2VsbHMgPSA8MD47DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
bG9jay1mcmVxdWVuY3kgPSA8MjAwMDAwMDAwPjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9Ow0K
Pj4+Pj4gK8KgwqDCoCB9Ow0KPj4+Pj4gK307DQo+PiBbc25pcF0NCj4+DQo+PiBSZWdhcmRzLA==
