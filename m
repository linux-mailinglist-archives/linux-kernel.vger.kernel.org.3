Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22F94DD0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiCQW2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCQW2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:28:38 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CE5247C1A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:27:19 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5B7482C0851;
        Thu, 17 Mar 2022 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647556037;
        bh=Vv4hXBPavOFWlUbMbfosV+jTdHJgbul6PZgpzYRONTs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RJ+p6wcjHz44302nYbc6R7fAqCB0mAwQq7c9KJ1FzSoOM+xiCQ9EelNhZDnreWSxE
         di6iPRN/i7wykivdxlx3tQnWIbfSrNwkK+oDjY2AjdhkLr9bvf71hXyCZO4iFOBipJ
         LNllxXHzYE1iFz9HarofF48u2IeaY7nEvhJt1p02km1hiH51JH3xZtTEhVCT41o+qs
         Z4ylOAkcHvWoegi1okINelt+VMwkJgls4pcFMzeo5xQ4LQW/6YBwXZAjYyujQ9AUfM
         Xwse49xatblRZa2jLQqLajeD64GdbZ46x0puF0TPgnZV4mgRHDAudtoAvLjXnuk/7L
         NOyZmNSsIzHYw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6233b5c50001>; Fri, 18 Mar 2022 11:27:17 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 11:27:17 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 18 Mar 2022 11:27:17 +1300
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
Thread-Index: AQHYOLjW35wiX+ouW0qUKMLPAQyjVKzCg9cAgADNFgA=
Date:   Thu, 17 Mar 2022 22:27:16 +0000
Message-ID: <4b27d0bf-cf30-9c96-f519-9df71091671c@alliedtelesis.co.nz>
References: <20220315220549.2749328-1-chris.packham@alliedtelesis.co.nz>
 <20220315220549.2749328-2-chris.packham@alliedtelesis.co.nz>
 <CAPDyKFpMnno1RjnSMhgUAZc=q4erdNGEFYOW=k13MMMPti7aQA@mail.gmail.com>
In-Reply-To: <CAPDyKFpMnno1RjnSMhgUAZc=q4erdNGEFYOW=k13MMMPti7aQA@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFA3651742F03345B590241822B94934@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=VfbacyVCN9arrbsvsIMA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNy8wMy8yMiAyMzoxMywgVWxmIEhhbnNzb24gd3JvdGU6DQo+IE9uIFR1ZSwgMTUgTWFy
IDIwMjIgYXQgMjM6MDUsIENocmlzIFBhY2toYW0NCj4gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVs
ZXNpcy5jby5uej4gd3JvdGU6DQo+PiBJbXBvcnQgYmluZGluZyBkb2N1bWVudGF0aW9uIGZyb20g
dGhlIE1hcnZlbGwgU0RLIHdoaWNoIGFkZHMNCj4+IG1hcnZlbGwsYWM1LXNkaGNpIGNvbXBhdGli
bGUgc3RyaW5nIGFuZCBkb2N1bWVudHMgdGhlIHJlcXVpcmVtZW50cyBmb3INCj4+IHRoZSBmb3Ig
dGhlIFhlbm9uIFNESENJIGNvbnRyb2xsZXIgb24gdGhlIDk4RFgyNTMwLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5u
ej4NCj4+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+PiAtLS0N
Cj4+DQo+PiBOb3RlczoNCj4+ICAgICAgQ2hhbmdlcyBpbiB2MzoNCj4+ICAgICAgLSBTcGxpdCBm
cm9tIGxhcmdlciBzZXJpZXMNCj4+ICAgICAgLSBBZGQgcmV2aWV3IGZyb20gQW5kcmV3DQo+PiAg
ICAgIENoYW5nZXMgaW4gdjI6DQo+PiAgICAgIC0gTmV3DQo+Pg0KPj4gICAuLi4vYmluZGluZ3Mv
bW1jL21hcnZlbGwseGVub24tc2RoY2kudHh0ICAgICAgfCA1MiArKysrKysrKysrKysrKysrKysr
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspDQo+IFdvdWxkIHlvdSBtaW5k
IGNvbnZlcnRpbmcgdGhlc2UgYmluZGluZ3MgdG8gdGhlIG5ldyB5YW1sIGZvcm1hdCwgYXMNCj4g
dGhlIGZpcnN0IHN0ZXA/DQo+DQo+IFVwIHVudGlsIHRoaXMgcG9pbnQsIEkgaGF2ZSBhY2NlcHRl
ZCBvbmx5IHZlcnkgc21hbGwgY2hhbmdlcyB0byB0aGUNCj4gbGVnYWN5IHR4dCBiYXNlZCBiaW5k
aW5ncywgYnV0IEkgYW0gc3RhcnRpbmcgdG8gdGhpbmsgdGhhdCBpdCdzIHRpbWUNCj4gdG8gcmVq
ZWN0IHRob3NlIHRvby4gV2UgbmVlZCBhbGwgYmluZGluZ3MgdG8gbW92ZSB0byB5YW1sLg0KPg0K
PiBTb3JyeSwgaWYgdGhpcyBjYXVzZXMgYWRkaXRpb25hbCBjaHVybnMgZm9yIHlvdS4NCg0KSWYg
aXQgZWFybnMgbWUgc29tZSBnb29kIGthcm1hIGl0J2xsIHByb2JhYmx5IGJlIHdvcnRoIGl0LiBD
YW4gSSBwdXQgeW91IA0KZG93biBhcyB0aGUgbWFpbnRhaW5lciBpbiB0aGUgeWFtbCBiaW5kaW5n
Pw0KDQo+DQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnR4dCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbWFydmVsbCx4ZW5vbi1zZGhj
aS50eHQNCj4+IGluZGV4IGM1MWE2MmQ3NTFkYy4uNDNkZjQ2NmYwY2IzIDEwMDY0NA0KPj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNk
aGNpLnR4dA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9t
YXJ2ZWxsLHhlbm9uLXNkaGNpLnR4dA0KPj4gQEAgLTE0LDYgKzE0LDcgQEAgUmVxdWlyZWQgUHJv
cGVydGllczoNCj4+ICAgICAtICJtYXJ2ZWxsLGFybWFkYS1hcDgwNi1zZGhjaSI6IEZvciBjb250
cm9sbGVycyBvbiBBcm1hZGEgQVA4MDYuDQo+PiAgICAgLSAibWFydmVsbCxhcm1hZGEtYXA4MDct
c2RoY2kiOiBGb3IgY29udHJvbGxlcnMgb24gQXJtYWRhIEFQODA3Lg0KPj4gICAgIC0gIm1hcnZl
bGwsYXJtYWRhLWNwMTEwLXNkaGNpIjogRm9yIGNvbnRyb2xsZXJzIG9uIEFybWFkYSBDUDExMC4N
Cj4+ICsgIC0gIm1hcnZlbGwsYWM1LXNkaGNpIjogRm9yIENuTSBvbiBBQzUsIEFDNVggYW5kIGRl
cml2ZWQuDQo+Pg0KPj4gICAtIGNsb2NrczoNCj4+ICAgICBBcnJheSBvZiBjbG9ja3MgcmVxdWly
ZWQgZm9yIFNESEMuDQo+PiBAQCAtMzMsNiArMzQsMTMgQEAgUmVxdWlyZWQgUHJvcGVydGllczoN
Cj4+ICAgICAgIGluIGJlbG93Lg0KPj4gICAgICAgUGxlYXNlIGFsc28gY2hlY2sgcHJvcGVydHkg
bWFydmVsbCxwYWQtdHlwZSBpbiBiZWxvdy4NCj4+DQo+PiArICAqIEZvciAibWFydmVsbCxhYzUt
c2RoY2kiLCBvbmUgb3IgdHdvIHJlZ2lzdGVyIGFyZWFzLg0KPj4gKyAgICAocmVnLW5hbWVzICJj
dHJsIiAmICJkZWNvZGVyIikuDQo+PiArICAgIFRoZSBmaXJzdCBvbmUgaXMgbWFuZGF0b3J5IGZv
ciB0aGUgWGVub24gSVAgcmVnaXN0ZXJzLg0KPj4gKyAgICBUaGUgc2Vjb25kIG9uZSBpcyBmb3Ig
c3lzdGVtcyB3aGVyZSBETUEgbWFwcGluZyBpcyByZXF1aXJlZCBhbmQgaXMgdGhlDQo+PiArICAg
IHJlbGF0ZWQgYWRkcmVzcyBkZWNvZGVyIHJlZ2lzdGVyICh0aGUgdmFsdWUgdG8gY29uZmlndXJl
IGlzIGRlcml2ZWQgZnJvbQ0KPj4gKyAgICB0aGUgcGFyZW50ICJkbWEtcmFuZ2VzIikuDQo+PiAr
DQo+PiAgICAgKiBGb3Igb3RoZXIgY29tcGF0aWJsZSBzdHJpbmdzLCBvbmUgcmVnaXN0ZXIgYXJl
YSBmb3IgWGVub24gSVAuDQo+Pg0KPj4gICBPcHRpb25hbCBQcm9wZXJ0aWVzOg0KPj4gQEAgLTE3
MSwzICsxNzksNDcgQEAgRXhhbXBsZToNCj4+DQo+PiAgICAgICAgICAgICAgICAgIG1hcnZlbGws
cGFkLXR5cGUgPSAic2QiOw0KPj4gICAgICAgICAgfTsNCj4+ICsNCj4+ICsNCj4+ICstIEZvciBl
TU1DIHdpdGggY29tcGF0aWJsZSAibWFydmVsbCxhYzUtc2RoY2kiIHdpdGggb25lIHJlZyByYW5n
ZSAobm8gZG1hKToNCj4+ICsgICAgICAgc2RoY2kwOiBzZGhjaUA4MDVjMDAwMCB7DQo+PiArICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFjNS1zZGhjaSI7DQo+PiArICAgICAg
ICAgICAgICAgcmVnID0gPDB4MCAweDgwNWMwMDAwIDB4MCAweDMwMD47DQo+PiArICAgICAgICAg
ICAgICAgcmVnLW5hbWVzID0gImN0cmwiLCAiZGVjb2RlciI7DQo+PiArICAgICAgICAgICAgICAg
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDkyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gKyAgICAg
ICAgICAgICAgIGNsb2NrcyA9IDwmY29yZV9jbG9jaz47DQo+PiArICAgICAgICAgICAgICAgY2xv
Y2stbmFtZXMgPSAiY29yZSI7DQo+PiArICAgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0K
Pj4gKyAgICAgICAgICAgICAgIGJ1cy13aWR0aCA9IDw4PjsNCj4+ICsgICAgICAgICAgICAgICAv
Km1hcnZlbGwseGVub24tcGh5LXNsb3ctbW9kZTsqLw0KPj4gKyAgICAgICAgICAgICAgIG5vbi1y
ZW1vdmFibGU7DQo+PiArICAgICAgICAgICAgICAgbW1jLWRkci0xXzh2Ow0KPj4gKyAgICAgICAg
ICAgICAgIG1tYy1oczIwMC0xXzh2Ow0KPj4gKyAgICAgICAgICAgICAgIG1tYy1oczQwMC0xXzh2
Ow0KPj4gKyAgICAgICB9Ow0KPj4gKw0KPj4gKy0gRm9yIGVNTUMgd2l0aCBjb21wYXRpYmxlICJt
YXJ2ZWxsLGFjNS1zZGhjaSIgd2l0aCB0d28gcmVnIHJhbmdlcyAod2l0aCBkbWEpOg0KPj4gKyAg
ICAgICBtbWNfZG1hOiBtbWMtZG1hLXBlcmlwaGVyYWxzQDgwNTAwMDAwIHsNCj4+ICsgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPj4gKyAgICAgICAgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDB4Mj47DQo+PiArICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8
MHgyPjsNCj4+ICsgICAgICAgICAgICAgICByYW5nZXM7DQo+PiArICAgICAgICAgICAgICAgZG1h
LXJhbmdlcyA9IDwweDIgMHgwIDB4MiAweDgwMDAwMDAwIDB4MSAweDA+Ow0KPj4gKyAgICAgICAg
ICAgICAgIGRtYS1jb2hlcmVudDsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICBzZGhjaTA6IHNk
aGNpQDgwNWMwMDAwIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
bWFydmVsbCxhYzUtc2RoY2kiLCAibWFydmVsbCxhcm1hZGEtYXA4MDYtc2RoY2kiOw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDgwNWMwMDAwIDB4MCAweDMwMD4sIDww
eDAgMHg4MDQ0MDIzMCAweDAgMHg0PjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZy1u
YW1lcyA9ICJjdHJsIiwgImRlY29kZXIiOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaW50
ZXJydXB0cyA9IDxHSUNfU1BJIDkyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjb3JlX2Nsb2NrPjsNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGNsb2NrLW5hbWVzID0gImNvcmUiOw0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgc3RhdHVzID0gIm9rYXkiOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnVzLXdpZHRo
ID0gPDg+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyptYXJ2ZWxsLHhlbm9uLXBoeS1z
bG93LW1vZGU7Ki8NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIG5vbi1yZW1vdmFibGU7DQo+
PiArICAgICAgICAgICAgICAgICAgICAgICBtbWMtZGRyLTFfOHY7DQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICBtbWMtaHMyMDAtMV84djsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIG1t
Yy1oczQwMC0xXzh2Ow0KPj4gKyAgICAgICAgICAgICAgIH07DQo+PiArICAgICAgIH07DQo+PiAt
LQ0KPj4gMi4zNS4xDQo+Pg==
