Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D924F527A5C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiEOVUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiEOVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:20:44 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E97B1EC
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 14:20:42 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EA3152C0108;
        Sun, 15 May 2022 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652649639;
        bh=EUAR0cBghWxl7G4fZXuKFlVs4KGWvAXvCy6CY2T13oA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jZUGwEdxkvH9ATC99IXtjinP6GakA5afvZ9z4z8YyY/OSKn37XEB6GmkMAkrLLvH0
         KOwHaCcHEJ1C3gXsGDcw/6W7ZtmSZLSSWtZ7FDoTmdTps8CVliRzDz24dLDLW/BrAl
         K5+9SrDZXJk/WYW1jRv0yFgKrly1mfASf9JwGvopJP+omTmBCCl6MkMCw3r+JQqwnL
         1zAA/PFhCLDES3GjmZzCSpX1YT0WU617Tk0Lfay9hffPwXd/XrO/32yzoBr5cA9DBv
         ODKvfXlRKngiQUsSzf+JXjz+6YvhKMy7b03XmayBqz/suuOkXr+BVqRCd8NXxays7T
         YNCxUsYs5ytjw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62816ea70001>; Mon, 16 May 2022 09:20:39 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.36; Mon, 16 May 2022 09:20:39 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.036; Mon, 16 May 2022 09:20:39 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        "enachman@marvell.com" <enachman@marvell.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: gpio-mvebu: convert txt binding
 to YAML
Thread-Topic: [PATCH v3 1/2] dt-bindings: gpio: gpio-mvebu: convert txt
 binding to YAML
Thread-Index: AQHYZeR1GWszU87KukS0xyAOLq6As60btNMAgAEor4CAAS/OAIABoPyA
Date:   Sun, 15 May 2022 21:20:39 +0000
Message-ID: <f2dbaf38-d010-502c-99a7-29f6e0bedafa@alliedtelesis.co.nz>
References: <20220512094125.3748197-1-chris.packham@alliedtelesis.co.nz>
 <32aab734-5890-99b2-09c9-8ec7418c7649@linaro.org>
 <e87482cb-20b1-fe09-7233-d56786d5eda6@alliedtelesis.co.nz>
 <4714c388-47ec-776a-7a50-362b258ffc25@linaro.org>
In-Reply-To: <4714c388-47ec-776a-7a50-362b258ffc25@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <924797B2F4A66949A981D1BB8370CE9C@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=XNdhXRyAvgjCRblY88YA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNS8wNS8yMiAwODoyOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTQv
MDUvMjAyMiAwNDoyMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+Pj4gKw0KPj4+PiArYWxsT2Y6
DQo+Pj4+ICsgIC0gaWY6DQo+Pj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4+PiArICAgICAgICBj
b21wYXRpYmxlOg0KPj4+PiArICAgICAgICAgIGNvbnRhaW5zOg0KPj4+PiArICAgICAgICAgICAg
Y29uc3Q6IG1hcnZlbGwsYXJtYWRhLThrLWdwaW8NCj4+Pj4gKyAgICB0aGVuOg0KPj4+PiArICAg
ICAgcmVxdWlyZWQ6DQo+Pj4+ICsgICAgICAgIC0gb2Zmc2V0DQo+Pj4+ICsgICAgZWxzZToNCj4+
Pj4gKyAgICAgIHJlcXVpcmVkOg0KPj4+PiArICAgICAgICAtIHJlZw0KPj4+IG9uZSBibGFuayBs
aW5lIHBsZWFzZQ0KPj4+DQo+Pj4+ICsgIC0gaWY6DQo+Pj4+ICsgICAgICBwcm9wZXJ0aWVzOg0K
Pj4+PiArICAgICAgICBjb21wYXRpYmxlOg0KPj4+PiArICAgICAgICAgIGNvbnRhaW5zOg0KPj4+
PiArICAgICAgICAgICAgY29uc3Q6IG1hcnZlbGwsYXJtYWRheHAtZ3Bpbw0KPj4+IE9yaWdpbmFs
IGJpbmRpbmdzIGFyZSBzYXlpbmcgdGhhdCBzZWNvbmQgcmVnIGlzIG9wdGlvbmFsIGZvcg0KPj4+
IG1hcnZlbGwsYXJtYWRhLTM3MC1ncGlvLiBXaGF0IGFib3V0IG90aGVyIGNhc2VzLCBlLmcuIG12
NzgyMDAtZ3Bpbz8gSXMNCj4+PiBpdCBhbHNvIGFsbG93ZWQgKGFuZCBvcHRpb25hbCkgdGhlcmU/
DQo+PiBUaGlzIGlzIHdoZXJlIHRoaW5ncyBnZXQgaW50ZXJlc3RpbmcuIFRoZSBhcm1hZGF4cCAo
YW5kIG9ubHkgdGhlDQo+PiBhcm1hZGF4cCkgcmVxdWlyZXMgYSBzZWNvbmQgcmVnaXN0ZXIgdmFs
dWUgZm9yIHNvbWUgcGVyLWNwdSByZWdpc3RlcnMuDQo+PiBBbGwgb2YgdGhlIG90aGVyIFNvQ3Mg
Y2FuIGhhdmUgYW4gb3B0aW9uYWwgMm5kIHJlZ2lzdGVyIHZhbHVlIGlmIHRoZXkNCj4+IHdhbnQg
dG8gdXNlIHRoZSBQV00gZnVuY3Rpb24uIEkgZ3Vlc3MgdGhhdCBpbXBsaWVzIHRoYXQgdGhlIGFy
bWFkYXhwDQo+PiBjYW4ndCBkbyBQV00uDQo+Pj4+ICsgICAgdGhlbjoNCj4+Pj4gKyAgICAgIHBy
b3BlcnRpZXM6DQo+Pj4+ICsgICAgICAgIHJlZzoNCj4+Pj4gKyAgICAgICAgICBtaW5JdGVtczog
Mg0KPj4+IFRoZW4geW91IGFsc28gc2hvdWxkIHJlcXVpcmUgdHdvIHJlZy1uYW1lcy4NCj4+IFNp
bXBsZSBlbm91Z2ggdG8gYWRkLiBCdXQgY3VycmVudGx5IHdlJ3ZlIHNhaWQgdGhhdCB0aGUgcmVn
LW5hbWVzIGFyZQ0KPj4gImdwaW8iIGFuZCAicHdtIiBidXQgb24gdGhlIGFybWFkYXhwIHRoZSAy
bmQgb25lIGlzIG5vdCAicHdtIiBidXQNCj4+IHNvbWV0aGluZyBlbHNlICgicGVyLWNwdSIgcGVy
aGFwcz8pDQo+IEluIHN1Y2ggY2FzZSB0aGV5IHdvdWxkIGJlIGZhaWxpbmcgd2l0aCBjdXJyZW50
IGJpbmRpbmdzLCBiZWNhdXNlIHRoZXkNCj4gZXhwZWN0ICJwd20iIGFzIHNlY29uZCBuYW1lLCBy
aWdodD8NCg0KVGhlIGRyaXZlciBpcyBhbHJpZ2h0IGJlY2F1c2UgaXQgY2hlY2tzIGZvciB0aGUg
DQoibWFydmVsbCxhcm1hZGEtMzcwLWdwaW8iIGNvbXBhdGlibGUgYmVmb3JlIHVzaW5nIA0KcGxh
dGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZSgicHdtIikuIFRoZSB1bnVzZWQgKGF0IGxlYXN0IGlu
IHRoZW9yeSkgDQphcm1hZGF4cCBjb2RlIGp1c3QgY2FsbHMgZGV2bV9wbGF0Zm9ybV9pb3JlbWFw
X3Jlc291cmNlKHBkZXYsIDEpIHNvIGl0IA0KZG9lc24ndCBjYXJlIGFib3V0IHRoZSBuYW1lLg0K
DQpJJ20gdGVtcHRlZCB0byBsZWF2ZSB0aGUgcmVnTmFtZTogbWluSXRlbXM6IDIgb3V0IGJlY2F1
c2UgdGhlIGFybWFkYXhwIA0KY29kZSBkb2Vzbid0IGNhcmUgYWJvdXQgdGhlbSBhbmQgc2V0dGlu
ZyB0aGUgMm5kIHJlZ25hbWUgdG8gInB3bSIgd2hlbiANCnRoZSBjb21wYXRpYmxlIGlzIGFybWFk
YXhwIHdvdWxkIGJlIG1pc2xlYWRpbmcuDQoNCj4+IE9uIHRoZSBvdGhlciBoYW5kIHRoaXMgaXMg
YWxsIGNvbXBsZXRlbHkgbW9vdCBiZWNhdXNlIHRoZQ0KPj4gYXJtYWRhLXhwLW12NzgqLmR0c2kg
YWN0dWFsbHkgdXNlIHRoZSAibWFydmVsbCxhcm1hZGEtMzcwLWdwaW8iDQo+PiBjb21wYXRpYmxl
IHNvIHRoaXMgYXBwZWFycyB0byBiZSBkb2N1bWVudGluZyBzb21ldGhpbmcgdGhhdCBpcyBubyBs
b25nZXINCj4+IHVzZWQuIEluZGVlZCBpdCBhcHBlYXJzIHRoYXQgdGhlIGFybWFkYXhwIHNwZWNp
ZmljIHVzYWdlIHdhcyByZW1vdmUgaW4NCj4+IDVmNzljNjUxZTgxZSAoImFybTogbXZlYnU6IHVz
ZSBnbG9iYWwgaW50ZXJydXB0cyBmb3IgR1BJT3Mgb24gQXJtYWRhIFhQIikuDQo+Pg0KPj4gU28g
cGVyaGFwcyB0aGUgYmVzdCBjb3Vyc2Ugb2YgYWN0aW9uIGlzIHRvIGRyb3AgbWFydmVsbCxhcm1h
ZGF4cC1ncGlvDQo+PiBmcm9tIHRoZSBuZXcgYmluZGluZyAobm90aW5nIHRoYXQgd2UndmUgZG9u
ZSBzbyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UpLg0KPg0KPiBUaGF0J3MgZmluZSwgbWF5YmUgaW4g
YSBzZXBhcmF0ZSBwYXRjaCAoMm5kIG9uZSk/DQpJJ2xsIGFkZCBhbm90aGVyIHBhdGNoIG9uIHRv
cCB0aGF0IG1hcmtzIHRoZSBjb21wYXRpYmxlIGFzIGRlcHJlY2F0ZWQgDQppbmNsdWRpbmcgc29t
ZSBvZiB0aGUgYWJvdmUgaW5mbyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+DQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9m
