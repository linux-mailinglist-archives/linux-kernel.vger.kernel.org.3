Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119AB4EB449
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbiC2TxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbiC2Twu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:52:50 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52A18B277
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:51:03 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CB0A82C028E;
        Tue, 29 Mar 2022 19:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648583460;
        bh=BNF2UMylQFUCmmIZXcvoQ329GJFVKaMW/CAJjK9WuQ0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Y0hVUzewhYM8L8Vui/dU1oY5bKeGvAXvvgXLPbax8R32hPu5tM+Nno5ZEPF7ZXQ/R
         3QGrBjAOyUxwV9Bko5MiB0stn0ouyzzWMgC7zJXtesD31y3bH0fpEJoOPg12f0lwMX
         Q/Gtryq6kYBwxmrA1wbVvJNINvoZ76bt7wfdSsLeHUUbHHuTFalmuEprw2xFfBG2ke
         y79H8C6Ve4YgvbUJiWh3X9eGYEueKYgNLE1GmLvJ/xyoN+GXBo73q5SdSIAa6eIh3K
         ElrOyeI0W+SHJvDN5boy5UhtGRFVSoMjop6MQln7gP28NBfUQspwrkahKCxt6AgmjK
         4413MexXmo09Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B624363240001>; Wed, 30 Mar 2022 08:51:00 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 30 Mar 2022 08:51:00 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Wed, 30 Mar 2022 08:51:00 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "huziji@marvell.com" <huziji@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Thread-Topic: [PATCH v4 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Thread-Index: AQHYQwBQxHzoaq5k202Ou7T2PLN3cqzVZnGAgAAXboCAAG7SgA==
Date:   Tue, 29 Mar 2022 19:50:59 +0000
Message-ID: <6e118704-3c63-929e-ebf0-9a78fbed5daa@alliedtelesis.co.nz>
References: <20220329000231.3544810-1-chris.packham@alliedtelesis.co.nz>
 <20220329000231.3544810-3-chris.packham@alliedtelesis.co.nz>
 <1648554629.870840.350362.nullmailer@robh.at.kernel.org>
 <d4c477b3-0cf2-e495-6a54-5fcd0301cc14@kernel.org>
In-Reply-To: <d4c477b3-0cf2-e495-6a54-5fcd0301cc14@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2F2FAA0294065438213375A3B0291C0@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=q3wFjaZLP3K7T2WVW-8A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAzMC8wMy8yMiAwMjoxNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMjkv
MDMvMjAyMiAxMzo1MCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+PiBPbiBUdWUsIDI5IE1hciAyMDIy
IDEzOjAyOjMxICsxMzAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+IENvbnZlcnQgdGhlIG1h
cnZlbGwseGVub24tc2RoY2kgYmluZGluZyB0byBKU09OIHNjaGVtYS4gQ3VycmVudGx5IHRoZQ0K
Pj4+IGluLXRyZWUgZHRzIGZpbGVzIGRvbid0IHZhbGlkYXRlIGJlY2F1c2UgdGhleSB1c2Ugc2Ro
Y2lAIGluc3RlYWQgb2YgbW1jQA0KPj4+IGFzIHJlcXVpcmVkIGJ5IHRoZSBnZW5lcmljIG1tYy1j
b250cm9sbGVyIHNjaGVtYS4NCj4+Pg0KPj4+IFRoZSBjb21wYXRpYmxlICJtYXJ2ZWxsLHNkaGNp
LXhlbm9uIiB3YXMgbm90IGRvY3VtZW50ZWQgaW4gdGhlIG9sZA0KPj4+IGJpbmRpbmcgYnV0IGl0
IGFjY29tcGFuaWVzIHRoZSBvZiAibWFydmVsbCxhcm1hZGEtMzcwMC1zZGhjaSIgaW4gdGhlDQo+
Pj4gYXJtYWRhLTM3eHggU29DIGR0c2kgc28gdGhpcyBjb21iaW5hdGlvbiBpcyBhZGRlZCB0byB0
aGUgbmV3IGJpbmRpbmcNCj4+PiBkb2N1bWVudC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IENo
cmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+PiBSZXZp
ZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPj4+IC0tLQ0K
Pj4+DQo+Pj4gTm90ZXM6DQo+Pj4gICAgICBDaGFuZ2VzIGluIHY0Og0KPj4+ICAgICAgLSBBZGQg
cmV2aWV3IGZyb20gS3J6eXN6dG9mDQo+Pj4gICAgICAtIFNxdWFzaCBpbiBhZGRpdGlvbiBvZiBt
YXJ2ZWxsLHNkaGNpLXhlbm9uIHdpdGggYW4gZXhwbGFuYXRpb24gaW4gdGhlDQo+Pj4gICAgICAg
IGNvbW1pdCBtZXNzYWdlDQo+Pj4gICAgICBDaGFuZ2VzIGluIHYzOg0KPj4+ICAgICAgLSBEb24n
dCBhY2NlcHQgYXA4MDcgd2l0aG91dCBhcDgwNg0KPj4+ICAgICAgLSBBZGQgcmVmOiBzdHJpbmcg
Zm9yIHBhZC10eXBlDQo+Pj4gICAgICBDaGFuZ2VzIGluIHYyOg0KPj4+ICAgICAgLSBVcGRhdGUg
TUFJTlRBSU5FUlMgZW50cnkNCj4+PiAgICAgIC0gSW5jb3Jwb3JhdGUgZmVlZGJhY2sgZnJvbSBL
cnp5c3p0b2YNCj4+Pg0KPj4+ICAgLi4uL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNp
LnR4dCAgICAgIHwgMTczIC0tLS0tLS0tLS0tDQo+Pj4gICAuLi4vYmluZGluZ3MvbW1jL21hcnZl
bGwseGVub24tc2RoY2kueWFtbCAgICAgfCAyNzUgKysrKysrKysrKysrKysrKysrDQo+Pj4gICBN
QUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4+
PiAgIDMgZmlsZXMgY2hhbmdlZCwgMjc2IGluc2VydGlvbnMoKyksIDE3NCBkZWxldGlvbnMoLSkN
Cj4+PiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbW1jL21hcnZlbGwseGVub24tc2RoY2kudHh0DQo+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNp
LnlhbWwNCj4+Pg0KPj4gTXkgYm90IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIERUX0NIRUNL
RVJfRkxBR1M9LW0gZHRfYmluZGluZ19jaGVjaycNCj4+IG9uIHlvdXIgcGF0Y2ggKERUX0NIRUNL
RVJfRkxBR1MgaXMgbmV3IGluIHY1LjEzKToNCj4+DQo+PiB5YW1sbGludCB3YXJuaW5ncy9lcnJv
cnM6DQo+Pg0KPj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4+IC9idWlsZHMvcm9i
aGVycmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLmV4YW1wbGUuZHQueWFtbDogbW1jQGFhMDAwMDogY29t
cGF0aWJsZTogJ29uZU9mJyBjb25kaXRpb25hbCBmYWlsZWQsIG9uZSBtdXN0IGJlIGZpeGVkOg0K
Pj4gCVsnbWFydmVsbCxhcm1hZGEtMzcwMC1zZGhjaSddIGlzIHRvbyBzaG9ydA0KPj4gCSdtYXJ2
ZWxsLGFybWFkYS0zNzAwLXNkaGNpJyBpcyBub3Qgb25lIG9mIFsnbWFydmVsbCxhcm1hZGEtY3Ax
MTAtc2RoY2knLCAnbWFydmVsbCxhcm1hZGEtYXA4MDYtc2RoY2knXQ0KPj4gCSdtYXJ2ZWxsLGFy
bWFkYS1hcDgwNy1zZGhjaScgd2FzIGV4cGVjdGVkDQo+PiAJRnJvbSBzY2hlbWE6IC9idWlsZHMv
cm9iaGVycmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnlhbWwNCj4+IC9idWlsZHMvcm9iaGVycmluZy9s
aW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tYXJ2
ZWxsLHhlbm9uLXNkaGNpLmV4YW1wbGUuZHQueWFtbDogbW1jQGFiMDAwMDogY29tcGF0aWJsZTog
J29uZU9mJyBjb25kaXRpb25hbCBmYWlsZWQsIG9uZSBtdXN0IGJlIGZpeGVkOg0KPj4gCVsnbWFy
dmVsbCxhcm1hZGEtMzcwMC1zZGhjaSddIGlzIHRvbyBzaG9ydA0KPj4gCSdtYXJ2ZWxsLGFybWFk
YS0zNzAwLXNkaGNpJyBpcyBub3Qgb25lIG9mIFsnbWFydmVsbCxhcm1hZGEtY3AxMTAtc2RoY2kn
LCAnbWFydmVsbCxhcm1hZGEtYXA4MDYtc2RoY2knXQ0KPj4gCSdtYXJ2ZWxsLGFybWFkYS1hcDgw
Ny1zZGhjaScgd2FzIGV4cGVjdGVkDQo+PiAJRnJvbSBzY2hlbWE6IC9idWlsZHMvcm9iaGVycmlu
Zy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9t
YXJ2ZWxsLHhlbm9uLXNkaGNpLnlhbWwNCj4+DQo+PiBkb2MgcmVmZXJlbmNlIGVycm9ycyAobWFr
ZSByZWZjaGVja2RvY3MpOg0KPiBDaHJpcywgeW91ciBvd24gZHQgYmluZGluZyBkb2VzIG5vdCBw
YXNzIGl0J3MgY2hlY2sgKGV4YW1wbGUpLi4uDQo+DQo+IEFmdGVyIHVwZGF0aW5nIHRoZSBjb21w
YXRpYmxlcywgeW91IG5lZWQgdG8gY2hlY2sgdGhlIGV4YW1wbGUuIFRoZQ0KPiBleGFtcGxlcyBh
cmUgYW55d2F5IGR1cGxpY2F0aW5nIGNvbW1vbiBzdHVmZiwgc28gaGFsZiBvZiB0aGVtIGNvdWxk
IGJlDQo+IHJlbW92ZWQuDQoNClllYWggc2lsbHkgbWUuIEkgc3RhcnRlZCB0YWtpbmcgc2hvcnQg
Y3V0cyB0byBydW4gZHRfYmluZGluZ19jaGVjayANCmR0YnNfY2hlY2sgYXMgb25lIGNvbW1hbmQg
YnV0IHRoZW4gdGhlIGR0X2JpbmRpbmdzX2NoZWNrIG91dHB1dCBzY3JvbGxlZCANCm9mZiB0aGUg
dG9wIG9mIG15IHRlcm1pbmFsLg0KDQpBcyBmb3IgdGhlIGV4YW1wbGVzIHRoZW1zZWx2ZXMgSSB3
YW50IHRvIGxlYXZlIHdoYXQncyB0aGVyZSBhcyBhIGZhaXJseSANCmRpcmVjdCB0cmFuc2xhdGlv
biBvZiB0aGUgb2xkIGJpbmRpbmcuIElmIHdlIGNvbnNpZGVyIHRoZW0gdW5uZWNlc3NhcnkgDQpy
ZW1vdmluZyB0aGVtIGNhbiBiZSBkb25lIGFzIGEgZm9sbG93LXVwLg0KDQo+DQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9m
