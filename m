Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301E85241F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349899AbiELBU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349867AbiELBU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:20:56 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC45A145
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:20:54 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D8DD72C0230;
        Thu, 12 May 2022 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652318451;
        bh=LHGs9FWAGvFpn80TD3Uz6Mq+uY0dfK8ZhP13SYUe9xc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FIWHfW7aJo63PWItt9JVvE/515Nbv4SRi6+Yq6HTwJPrOl50GPRYNGtz4v+uRAz5C
         FB+c0b9RJp5XptTrQAXvs7Njio/bBTuja3hNSdvXC9DDkrnqRSl8H+XIWRxxbAxSsA
         7vS/aOY18FsKswUwTcDngx5FLuoLnm0qy6wQBtZ7H3/fcp6Kzh3DANAual0usB9Qak
         cOiN3mNLK/ndxeBG+K1E0bkv2uZ2NPJPRGfArbx/lYoA13Kux5txNEawE55RH6nDFm
         TQSZzDQSIV1F1U7uv0eteUCpSIK6roDqo2xRcecMQoF+Pb/yMba/pRtcrw6uOFxzuG
         MTpSN879GFpIA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627c60f30001>; Thu, 12 May 2022 13:20:51 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 12 May 2022 13:20:51 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 12 May 2022 13:20:51 +1200
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
Thread-Index: AQHYZMMYWG5Tfvy6g0WGHR9i+piz6K0ZFyiAgACTLwA=
Date:   Thu, 12 May 2022 01:20:50 +0000
Message-ID: <6d1e121f-847b-3fc5-c27d-6504f380e4ef@alliedtelesis.co.nz>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
 <5c498985-64bb-b8ba-3e77-9cdb36dd1f16@linaro.org>
In-Reply-To: <5c498985-64bb-b8ba-3e77-9cdb36dd1f16@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D93BABB03082EA4681171998568AB7F8@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=l9mEoNynZyQPEb8fsREA:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wNS8yMiAwNDozNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTEv
MDUvMjAyMiAwMToxMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IERlc2NyaWJlIHRoZSBjb21w
YXRpYmxlIHByb3BlcnRpZXMgZm9yIHRoZSBNYXJ2ZWxsIEFsbGV5Y2F0NS81WCBzd2l0Y2hlcw0K
Pj4gd2l0aCBpbnRlZ3JhdGVkIENQVXMuDQo+Pg0KPj4gQWxsZXljYXQ1Og0KPj4gKiA5OERYMjUz
ODogMjR4MUcgKyAyeDEwRyArIDJ4MTBHIFN0YWNrDQo+PiAqIDk4RFgyNTM1OiAyNHgxRyArIDR4
MUcgU3RhY2sNCj4+ICogOThEWDI1MzI6IDh4MUcgKyAyeDEwRyArIDJ4MUcgU3RhY2sNCj4+ICog
OThEWDI1MzE6IDh4MUcgKyA0eDFHIFN0YWNrDQo+PiAqIDk4RFgyNTI4OiAyNHgxRyArIDJ4MTBH
ICsgMngxMEcgU3RhY2sNCj4+ICogOThEWDI1MjU6IDI0eDFHICsgNHgxRyBTdGFjaw0KPj4gKiA5
OERYMjUyMjogOHgxRyArIDJ4MTBHICsgMngxRyBTdGFjaw0KPj4gKiA5OERYMjUyMTogOHgxRyAr
IDR4MUcgU3RhY2sNCj4+ICogOThEWDI1MTg6IDI0eDFHICsgMngxMEcgKyAyeDEwRyBTdGFjaw0K
Pj4gKiA5OERYMjUxNTogMjR4MUcgKyA0eDFHIFN0YWNrDQo+PiAqIDk4RFgyNTEyOiA4eDFHICsg
MngxMEcgKyAyeDFHIFN0YWNrDQo+PiAqIDk4RFgyNTExOiA4eDFHICsgNHgxRyBTdGFjaw0KPj4N
Cj4+IEFsbGV5Y2F0NVg6DQo+PiAqIDk4RFgzNTAwOiAyNHgxRyArIDZ4MjVHDQo+PiAqIDk4RFgz
NTAxOiAxNngxRyArIDZ4MTBHDQo+PiAqIDk4RFgzNTEwOiA0OHgxRyArIDZ4MjVHDQo+PiAqIDk4
RFgzNTIwOiAyNHgyLjVHICsgNngyNUcNCj4+ICogOThEWDM1MzA6IDQ4eDIuNUcgKyA2eDI1Rw0K
Pj4gKiA5OERYMzU0MDogMTJ4NUcvNngxMEcgKyA2eDI1Rw0KPj4gKiA5OERYMzU1MDogMjR4NUcv
MTJ4MTBHICsgNngyNUcNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJp
cy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiAtLS0NCj4+DQo+PiBOb3RlczoNCj4+
ICAgICAgQ2hhbmdlcyBpbiB2NjoNCj4+ICAgICAgLSBOZXcNCj4+DQo+PiAgIC4uLi9iaW5kaW5n
cy9hcm0vbWFydmVsbC9hcm1hZGEtOThkeDI1MzAueWFtbCB8IDI3ICsrKysrKysrKysrKysrKysr
KysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9h
cm1hZGEtOThkeDI1MzAueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTk4ZHgyNTMwLnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTk4ZHgyNTMw
LnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjZk
OTE4NWJhZjBjNQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2FybWFkYS05OGR4MjUzMC55YW1sDQo+PiBAQCAt
MCwwICsxLDI3IEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25s
eSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRw
Oi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0yMDk4OCZkPWhlWDc0cy1kaDhIU0NBSm1hZlJp
Z1pIT295WTBYUURsODBRU0NYV2l0dyZ1PWh0dHAlM2ElMmYlMmZkZXZpY2V0cmVlJTJlb3JnJTJm
c2NoZW1hcyUyZmFybSUyZm1hcnZlbGwlMmZhcm1hZGEtOThkeDI1MzAlMmV5YW1sJTIzDQo+PiAr
JHNjaGVtYTogaHR0cDovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD1oZVg3NHMt
ZGg4SFNDQUptYWZSaWdaSE9veVkwWFFEbDgwb1ZXbk9sdEEmdT1odHRwJTNhJTJmJTJmZGV2aWNl
dHJlZSUyZW9yZyUyZm1ldGEtc2NoZW1hcyUyZmNvcmUlMmV5YW1sJTIzDQo+PiArDQo+PiArdGl0
bGU6IE1hcnZlbGwgQWxsZXljYXQ1LzVYIFBsYXRmb3Jtcw0KPj4gKw0KPj4gK21haW50YWluZXJz
Og0KPj4gKyAgLSBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28u
bno+DQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgICRub2RlbmFtZToNCj4+ICsgICAgY29u
c3Q6ICcvJw0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgb25lT2Y6DQo+PiArDQo+PiArICAg
ICAgLSBkZXNjcmlwdGlvbjogQWxsZXljYXQ1ICg5OERYMjV4eCkNCj4+ICsgICAgICAgIGl0ZW1z
Og0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFjNQ0KPiBUaGlzIGlzIGNvbmZ1c2lu
ZyBhbmQgZG9lcyBub3QgbG9vayBjb3JyZWN0LiBUaGUgRFRTIGNhbGxzIEFDNSBhIFNvQyBhbmQN
Cj4geW91IGNhbm5vdCBoYXZlIFNvQyBhbG9uZS4gSXQncyB1bnVzYWJsZSB3aXRob3V0IGEgU29N
IG9yIGJvYXJkLg0KPg0KPj4gKw0KPj4gKyAgICAgIC0gZGVzY3JpcHRpb246IEFsbGV5Y2F0NVgg
KDk4RFgzNXh4KQ0KPj4gKyAgICAgICAgaXRlbXM6DQo+PiArICAgICAgICAgIC0gY29uc3Q6IG1h
cnZlbGwsYWM1eA0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFjNQ0KPiBUaGlzIGVu
dHJ5IGxvb2tzIGNvcnJlY3QgZXhjZXB0IGFjNXggb25jZSBpcyBjYWxsZWQgYSBTb0MgYW5kIG9u
Y2UgYQ0KPiBSRC1BQzVYIGJvYXJkLg0KPg0KPiBJdCBjYW5ub3QgYmUgYm90aC4gUHJvYmFibHkg
eW91IG5lZWQgdGhpcmQgY29tcGF0aWJsZSwgYXNzdW1pbmcgQUM1eCBpcw0KPiBhIGZsYXZvciBv
ZiBBQzUuDQoNClllYWggaXQncyBhIGJpdCBjb25mdXNpbmcNCg0KUkQtQUM1WC0oYnVuY2ggb2Yg
ZXh0cmEgbnVtYmVycyBhbmQgbGV0dGVycykgaXMgdGhlIGJvYXJkIEkgaGF2ZS4NCkFDNVggaXMg
YSBMMyBzd2l0Y2ggY2hpcCB3aXRoIGludGVncmF0ZWQgQ1BVLg0KQUM1IGlzIGEgTDMgc3dpdGNo
IGNoaXAgd2l0aCBpbnRlZ3JhdGVkIENQVS4NCg0KU3dpdGNoIHdpc2UgdGhlIEFDNVggYW5kIEFD
NSBhcmUgcXVpdGUgZGlmZmVyZW50IGJ1dCB0aGUgQ1BVIGJsb2NrIGlzIA0KdGhlIHNhbWUgYmV0
d2VlbiB0aGUgdHdvLg0KDQo+DQo+IGl0ZW1zOg0KPiAgIC0gZW51bToNCj4gICAgICAgLSBtYXJ2
ZWxsLHJkLWFjNXgNCj4gICAtIGNvbnN0OiBtYXJ2ZWxsLGFjNXgNCj4gICAtIGNvbnN0OiBtYXJ2
ZWxsLGFjNQ0KDQpJIGNhbiBnbyB3aXRoIHRoYXQgYnV0IEknbSBhIGxpdHRsZSB2YWd1ZSBvbiB3
aGF0IHRoZSByZXF1aXJlbWVudHMgYXJlLiANCkkgd2FzIHRyeWluZyB0byBmb2xsb3cgdGhlIGFy
bWFkYS03ay04ay55YW1sIGFzIGFuIGV4YW1wbGUuDQoNCklmIEkgbG9vayBhdCB0aGUgY245MTMw
LWNyYi1BIGJvYXJkIGl0IGVuZHMgdXAgd2l0aDoNCg0KIMKgIGNvbXBhdGlibGUgPSAibWFydmVs
bCxjbjkxMzAiLCAibWFydmVsbCxhcm1hZGEtYXA4MDctcXVhZCIsIA0KIm1hcnZlbGwsYXJtYWRh
LWFwODA3IjsNCg0KSSBrbm93IHRoZSBhcDgwNyBoYXMgc29tZXRoaW5nIHRvIGRvIHdpdGggdGhl
IHZhZ2FyaWVzIG9mIHRoZSBjbjkxMzAgU29DIA0KYnV0IGlzbid0IHRoZSAibWFydmVsbCxjbjkx
MzAiIHN0aWxsIHJlZmVycmluZyB0byB0aGUgU29DLiBGcm9tIHdoYXQgDQp5b3UndmUgc2FpZCBz
aG91bGRuJ3QgdGhlcmUgYmUgYSAibWFydmVsbCxjbjkxMzAtY3JiIiBzb21ld2hlcmUgaW4gdGhl
IG1peD8NCg0KUGVyaGFwcyBJJ3ZlIHBpY2tlZCBhIGJhZCBleGFtcGxlIGJ1dCB0aGUgb3RoZXIg
ZHRicyBJJ3ZlIHBva2VkIGF0IGRvbid0IA0KaGF2ZSBhbnkgYm9hcmQgYmluZGluZy4NCg0KPj4g
Kw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9m
