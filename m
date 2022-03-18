Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0C4DD3A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiCRDnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiCRDmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:42:52 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1C228B129
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:41:32 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1747D2C035C;
        Fri, 18 Mar 2022 03:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647574890;
        bh=PqLAyMRNRxyVoOd7x6G0yVHaYJc3+OjOYWFlvdBo4qs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QuUCr7FZs8mKD42IzVNUojsfPuojZrX/YBVp8GtsD/RUtOVktFLMq28vlSdjgHvfK
         IKrB0+ENrCQH2HIVVvXWHunxb29oAAdHee0lLbjwGqaXuBHNE9qbH51fzTAVFZex5r
         owfgY3FjT/5Pcc/Rh6YnbU+H8dONPiVVXVKVbYp1Lm96wMWJqPv3N8o9cBJYrj7xwm
         VBYAKvAa+BsxUXihD0EGPXPS2Z+8plD85El3pl/agOyCUlU9USkZ/UVgTCD/A+agKt
         GjJ0bk66XUTXqY646DJkCJd8Rvo7jXHTTys/6Y3UHt8UqtRB3mal/waoYh7vHVS0Xy
         E0IOVumAu0lcQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6233ff6a0001>; Fri, 18 Mar 2022 16:41:30 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 16:41:29 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 18 Mar 2022 16:41:29 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "huziji@marvell.com" <huziji@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: xenon: add AC5 compatible string
Thread-Topic: [PATCH v3 1/2] dt-bindings: mmc: xenon: add AC5 compatible
 string
Thread-Index: AQHYOLjW35wiX+ouW0qUKMLPAQyjVKzCg9cAgADNFgCAAFfHAA==
Date:   Fri, 18 Mar 2022 03:41:29 +0000
Message-ID: <88ec8037-38ef-2978-89dd-526f443a30ea@alliedtelesis.co.nz>
References: <20220315220549.2749328-1-chris.packham@alliedtelesis.co.nz>
 <20220315220549.2749328-2-chris.packham@alliedtelesis.co.nz>
 <CAPDyKFpMnno1RjnSMhgUAZc=q4erdNGEFYOW=k13MMMPti7aQA@mail.gmail.com>
 <4b27d0bf-cf30-9c96-f519-9df71091671c@alliedtelesis.co.nz>
In-Reply-To: <4b27d0bf-cf30-9c96-f519-9df71091671c@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <58F358275429ED45846A02A3326D4F6B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=3_q91SH1LYu10c-dFQYA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxOC8wMy8yMiAxMToyNywgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4NCj4gT24gMTcvMDMv
MjIgMjM6MTMsIFVsZiBIYW5zc29uIHdyb3RlOg0KPj4gT24gVHVlLCAxNSBNYXIgMjAyMiBhdCAy
MzowNSwgQ2hyaXMgUGFja2hhbQ0KPj4gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5u
ej4gd3JvdGU6DQo+Pj4gSW1wb3J0IGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmcm9tIHRoZSBNYXJ2
ZWxsIFNESyB3aGljaCBhZGRzDQo+Pj4gbWFydmVsbCxhYzUtc2RoY2kgY29tcGF0aWJsZSBzdHJp
bmcgYW5kIGRvY3VtZW50cyB0aGUgcmVxdWlyZW1lbnRzIGZvcg0KPj4+IHRoZSBmb3IgdGhlIFhl
bm9uIFNESENJIGNvbnRyb2xsZXIgb24gdGhlIDk4RFgyNTMwLg0KPj4+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0K
Pj4+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+Pj4gLS0tDQo+
Pj4NCj4+PiBOb3RlczoNCj4+PiDCoMKgwqDCoCBDaGFuZ2VzIGluIHYzOg0KPj4+IMKgwqDCoMKg
IC0gU3BsaXQgZnJvbSBsYXJnZXIgc2VyaWVzDQo+Pj4gwqDCoMKgwqAgLSBBZGQgcmV2aWV3IGZy
b20gQW5kcmV3DQo+Pj4gwqDCoMKgwqAgQ2hhbmdlcyBpbiB2MjoNCj4+PiDCoMKgwqDCoCAtIE5l
dw0KPj4+DQo+Pj4gwqAgLi4uL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnR4dMKg
wqDCoMKgwqAgfCA1MiANCj4+PiArKysrKysrKysrKysrKysrKysrDQo+Pj4gwqAgMSBmaWxlIGNo
YW5nZWQsIDUyIGluc2VydGlvbnMoKykNCj4+IFdvdWxkIHlvdSBtaW5kIGNvbnZlcnRpbmcgdGhl
c2UgYmluZGluZ3MgdG8gdGhlIG5ldyB5YW1sIGZvcm1hdCwgYXMNCj4+IHRoZSBmaXJzdCBzdGVw
Pw0KPj4NCj4+IFVwIHVudGlsIHRoaXMgcG9pbnQsIEkgaGF2ZSBhY2NlcHRlZCBvbmx5IHZlcnkg
c21hbGwgY2hhbmdlcyB0byB0aGUNCj4+IGxlZ2FjeSB0eHQgYmFzZWQgYmluZGluZ3MsIGJ1dCBJ
IGFtIHN0YXJ0aW5nIHRvIHRoaW5rIHRoYXQgaXQncyB0aW1lDQo+PiB0byByZWplY3QgdGhvc2Ug
dG9vLiBXZSBuZWVkIGFsbCBiaW5kaW5ncyB0byBtb3ZlIHRvIHlhbWwuDQo+Pg0KPj4gU29ycnks
IGlmIHRoaXMgY2F1c2VzIGFkZGl0aW9uYWwgY2h1cm5zIGZvciB5b3UuDQo+DQo+IElmIGl0IGVh
cm5zIG1lIHNvbWUgZ29vZCBrYXJtYSBpdCdsbCBwcm9iYWJseSBiZSB3b3J0aCBpdC4gQ2FuIEkg
cHV0IA0KPiB5b3UgZG93biBhcyB0aGUgbWFpbnRhaW5lciBpbiB0aGUgeWFtbCBiaW5kaW5nPw0K
DQpJJ3ZlIGZpcmVkIG9mZiBhIHBhdGNoIGZvciBjb252ZXJ0aW5nIHRoZSBiaW5kaW5nDQoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWRldmljZXRyZWUvMjAyMjAzMTgwMzM1MjEuMTQz
Mjc2Ny0xLWNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uei9ULyN1DQoNCkZvciB0aGlz
IGNoYW5nZSBzcGVjaWZpY2FsbHkgSSBtaWdodCBwYXJrIGl0LiBXaGVuIEkgbG9va2VkIGF0IHRo
ZSANCmFjdHVhbCBjaGFuZ2VzIHRoYXQgd2VyZSBiZWluZyBtYWRlIGluIHRoZSBNYXJ2ZWxsIFNE
SyB0aGV5J3JlIGRvaW5nIA0Kc29tZXRoaW5nIHdlaXJkIHdpdGggZG1hIGFkZHJlc3NlcyBhbmQg
b2ZfZG1hX2dldF9yYW5nZSgpIHdoaWNoIHdvbid0IA0Kd29yayAuIFRoZSBib2FyZHMgd2UncmUg
bWFraW5nIHdvbid0IGhhdmUgTU1DIGFuZCBJIGRvbid0IGhhdmUgdGhlIA0KZGVzaXJlIHRvIGhl
bHAgTWFydmVsbCBicmluZyB0aGVpciBjb2RlIHVwIHRvIHNjcmF0Y2ggKGF0IGxlYXN0IG5vdCBm
b3IgDQphIGRyaXZlciBJIGRvbid0IG5lZWQpLg0KDQo+DQo+Pg0KPj4gS2luZCByZWdhcmRzDQo+
PiBVZmZlDQo+Pg0KPj4+IGRpZmYgLS1naXQgDQo+Pj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbW1jL21hcnZlbGwseGVub24tc2RoY2kudHh0IA0KPj4+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnR4dA0KPj4+
IGluZGV4IGM1MWE2MmQ3NTFkYy4uNDNkZjQ2NmYwY2IzIDEwMDY0NA0KPj4+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbWFydmVsbCx4ZW5vbi1zZGhjaS50eHQN
Cj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21hcnZlbGws
eGVub24tc2RoY2kudHh0DQo+Pj4gQEAgLTE0LDYgKzE0LDcgQEAgUmVxdWlyZWQgUHJvcGVydGll
czoNCj4+PiDCoMKgwqAgLSAibWFydmVsbCxhcm1hZGEtYXA4MDYtc2RoY2kiOiBGb3IgY29udHJv
bGxlcnMgb24gQXJtYWRhIEFQODA2Lg0KPj4+IMKgwqDCoCAtICJtYXJ2ZWxsLGFybWFkYS1hcDgw
Ny1zZGhjaSI6IEZvciBjb250cm9sbGVycyBvbiBBcm1hZGEgQVA4MDcuDQo+Pj4gwqDCoMKgIC0g
Im1hcnZlbGwsYXJtYWRhLWNwMTEwLXNkaGNpIjogRm9yIGNvbnRyb2xsZXJzIG9uIEFybWFkYSBD
UDExMC4NCj4+PiArwqAgLSAibWFydmVsbCxhYzUtc2RoY2kiOiBGb3IgQ25NIG9uIEFDNSwgQUM1
WCBhbmQgZGVyaXZlZC4NCj4+Pg0KPj4+IMKgIC0gY2xvY2tzOg0KPj4+IMKgwqDCoCBBcnJheSBv
ZiBjbG9ja3MgcmVxdWlyZWQgZm9yIFNESEMuDQo+Pj4gQEAgLTMzLDYgKzM0LDEzIEBAIFJlcXVp
cmVkIFByb3BlcnRpZXM6DQo+Pj4gwqDCoMKgwqDCoCBpbiBiZWxvdy4NCj4+PiDCoMKgwqDCoMKg
IFBsZWFzZSBhbHNvIGNoZWNrIHByb3BlcnR5IG1hcnZlbGwscGFkLXR5cGUgaW4gYmVsb3cuDQo+
Pj4NCj4+PiArwqAgKiBGb3IgIm1hcnZlbGwsYWM1LXNkaGNpIiwgb25lIG9yIHR3byByZWdpc3Rl
ciBhcmVhcy4NCj4+PiArwqDCoMKgIChyZWctbmFtZXMgImN0cmwiICYgImRlY29kZXIiKS4NCj4+
PiArwqDCoMKgIFRoZSBmaXJzdCBvbmUgaXMgbWFuZGF0b3J5IGZvciB0aGUgWGVub24gSVAgcmVn
aXN0ZXJzLg0KPj4+ICvCoMKgwqAgVGhlIHNlY29uZCBvbmUgaXMgZm9yIHN5c3RlbXMgd2hlcmUg
RE1BIG1hcHBpbmcgaXMgcmVxdWlyZWQgYW5kIA0KPj4+IGlzIHRoZQ0KPj4+ICvCoMKgwqAgcmVs
YXRlZCBhZGRyZXNzIGRlY29kZXIgcmVnaXN0ZXIgKHRoZSB2YWx1ZSB0byBjb25maWd1cmUgaXMg
DQo+Pj4gZGVyaXZlZCBmcm9tDQo+Pj4gK8KgwqDCoCB0aGUgcGFyZW50ICJkbWEtcmFuZ2VzIiku
DQo+Pj4gKw0KPj4+IMKgwqDCoCAqIEZvciBvdGhlciBjb21wYXRpYmxlIHN0cmluZ3MsIG9uZSBy
ZWdpc3RlciBhcmVhIGZvciBYZW5vbiBJUC4NCj4+Pg0KPj4+IMKgIE9wdGlvbmFsIFByb3BlcnRp
ZXM6DQo+Pj4gQEAgLTE3MSwzICsxNzksNDcgQEAgRXhhbXBsZToNCj4+Pg0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1hcnZlbGwscGFkLXR5cGUgPSAic2QiOw0KPj4+IMKg
wqDCoMKgwqDCoMKgwqAgfTsNCj4+PiArDQo+Pj4gKw0KPj4+ICstIEZvciBlTU1DIHdpdGggY29t
cGF0aWJsZSAibWFydmVsbCxhYzUtc2RoY2kiIHdpdGggb25lIHJlZyByYW5nZSANCj4+PiAobm8g
ZG1hKToNCj4+PiArwqDCoMKgwqDCoMKgIHNkaGNpMDogc2RoY2lAODA1YzAwMDAgew0KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAibWFydmVsbCxhYzUtc2Ro
Y2kiOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwweDAgMHg4MDVj
MDAwMCAweDAgMHgzMDA+Ow0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZy1u
YW1lcyA9ICJjdHJsIiwgImRlY29kZXIiOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGludGVycnVwdHMgPSA8R0lDX1NQSSA5MiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmNvcmVfY2xvY2s+Ow0KPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2NrLW5hbWVzID0gImNvcmUiOw0KPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9ICJva2F5IjsNCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidXMtd2lkdGggPSA8OD47DQo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyptYXJ2ZWxsLHhlbm9uLXBoeS1zbG93LW1vZGU7Ki8NCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBub24tcmVtb3ZhYmxlOw0KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1tYy1kZHItMV84djsNCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBtbWMtaHMyMDAtMV84djsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtbWMtaHM0MDAtMV84djsNCj4+PiArwqDCoMKgwqDCoMKgIH07DQo+Pj4gKw0K
Pj4+ICstIEZvciBlTU1DIHdpdGggY29tcGF0aWJsZSAibWFydmVsbCxhYzUtc2RoY2kiIHdpdGgg
dHdvIHJlZyByYW5nZXMgDQo+Pj4gKHdpdGggZG1hKToNCj4+PiArwqDCoMKgwqDCoMKgIG1tY19k
bWE6IG1tYy1kbWEtcGVyaXBoZXJhbHNAODA1MDAwMDAgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MHgyPjsNCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwweDI+Ow0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJhbmdlczsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkbWEtcmFuZ2VzID0gPDB4MiAweDAgMHgyIDB4ODAwMDAwMDAgMHgxIDB4MD47DQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hLWNvaGVyZW50Ow0KPj4+ICsNCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZGhjaTA6IHNkaGNpQDgwNWMwMDAwIHsNCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJs
ZSA9ICJtYXJ2ZWxsLGFjNS1zZGhjaSIsIA0KPj4+ICJtYXJ2ZWxsLGFybWFkYS1hcDgwNi1zZGhj
aSI7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
ZyA9IDwweDAgMHg4MDVjMDAwMCAweDAgMHgzMDA+LCA8MHgwIA0KPj4+IDB4ODA0NDAyMzAgMHgw
IDB4ND47DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJlZy1uYW1lcyA9ICJjdHJsIiwgImRlY29kZXIiOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTIgSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNsb2NrcyA9IDwmY29yZV9jbG9jaz47DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2NrLW5hbWVzID0gImNvcmUiOw0KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSAib2th
eSI7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1
cy13aWR0aCA9IDw4PjsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyptYXJ2ZWxsLHhlbm9uLXBoeS1zbG93LW1vZGU7Ki8NCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm9uLXJlbW92YWJsZTsNCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbW1jLWRkci0xXzh2
Ow0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtbWMt
aHMyMDAtMV84djsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbW1jLWhzNDAwLTFfOHY7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fTsNCj4+PiArwqDCoMKgwqDCoMKgIH07DQo+Pj4gLS0gDQo+Pj4gMi4zNS4xDQo+Pj4=
