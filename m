Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5F56292A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiGACeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiGACeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:34:21 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C23D313AD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:34:17 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E94BA24E0EA;
        Fri,  1 Jul 2022 10:34:08 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 1 Jul
 2022 10:34:09 +0800
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 1 Jul
 2022 10:34:08 +0800
Received: from EXMBX061.cuchost.com ([fe80::3912:9b8d:b65:fa67]) by
 EXMBX061.cuchost.com ([fe80::3912:9b8d:b65:fa67%14]) with mapi id
 15.00.1497.033; Fri, 1 Jul 2022 10:34:08 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     "alexandre.ghiti@canonical.com" <alexandre.ghiti@canonical.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: arch/riscv: SV48 patch series questions
Thread-Topic: arch/riscv: SV48 patch series questions
Thread-Index: AdhxrOkRGR9CQf46QWqljv+TL2tt2AEQwdsAABSqKCAFrAS48A==
Date:   Fri, 1 Jul 2022 02:34:08 +0000
Message-ID: <d1d448faad0e421e9a0b4412d46681c5@EXMBX061.cuchost.com>
References: <83813d991f96428c95c6d681c16ae852@EXMBX161.cuchost.com>
 <mhng-055df44c-3feb-41ae-b8c0-ae3a6489dee1@palmer-ri-x1c9>
 <e99af0ab0a264aadb77d949c4b73fd57@EXMBX161.cuchost.com>
In-Reply-To: <e99af0ab0a264aadb77d949c4b73fd57@EXMBX161.cuchost.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGV5Zm9vbiBUYW4NCj4g
U2VudDogVGh1cnNkYXksIDIgSnVuZSwgMjAyMiAxOjQ0IFBNDQo+IFRvOiAnUGFsbWVyIERhYmJl
bHQnIDxwYWxtZXJAZGFiYmVsdC5jb20+DQo+IENjOiBhbGV4YW5kcmUuZ2hpdGlAY2Fub25pY2Fs
LmNvbTsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IGFyY2gvcmlzY3Y6IFNWNDggcGF0Y2ggc2Vy
aWVzIHF1ZXN0aW9ucw0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4NCj4gPiBTZW50
OiBUaHVyc2RheSwgMiBKdW5lLCAyMDIyIDExOjQ0IEFNDQo+ID4gVG86IExleWZvb24gVGFuIDxs
ZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+IENjOiBhbGV4YW5kcmUuZ2hpdGlAY2Fu
b25pY2FsLmNvbTsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiBsaW51eC0g
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBhcmNoL3Jpc2N2OiBTVjQ4
IHBhdGNoIHNlcmllcyBxdWVzdGlvbnMNCj4gPg0KPiA+IE9uIEZyaSwgMjcgTWF5IDIwMjIgMDI6
Mzc6MzQgUERUICgtMDcwMCksIGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20NCj4gPiB3cm90
ZToNCj4gPiA+IEhpIFBhbG1lcg0KPiA+ID4NCj4gPiA+IEFsZXgncyAiSW50cm9kdWNlIHN2NDgg
c3VwcG9ydCB3aXRob3V0IHJlbG9jYXRhYmxlIGtlcm5lbCIgcGF0Y2gNCj4gPiA+IHNlcmllcyBp
bg0KPiA+IFsxXSB3YXMgcGFydGlhbGx5IG1lcmdlZCB0byBMaW51eCB2NS4xNy4gQnV0IHRoZXJl
IGFyZSA0IHBhdGNoZXMgYXJlDQo+ID4gbm90IG1lcmdlZCAoUGF0Y2gtMTAgdG8gMTMpLg0KPiA+
ID4NCj4gPiA+IE1heSBJIGtub3cgd2hhdCBpcyB0aGUgcGxhbiBmb3IgdGhlc2UgcGF0Y2hlcz8g
V2lsbCB0aGVtIG1lcmdlZCB0bw0KPiA+ID4gbmV4dA0KPiA+IHY1LjE5IG1lcmdpbmcgd2luZG93
PyBPciBkbyB5b3UgZXhwZWN0IGFueSBjaGFuZ2VzIGZvciB0aGVzZSBwYXRjaGVzDQo+ID4gb3Ig
QWxleCBuZWVkcyByZXNlbmQgd2l0aCByZWJhc2UgdG8gbGF0ZXN0IGtlcm5lbCB2ZXJzaW9uPw0K
PiA+DQo+ID4gSSBqdXN0IHNhdyB0aGlzIGFzIEkgd2FzIGRpZ2dpbmcgdXAgQWxleCdzIG9sZCBl
bWFpbCB0byByZXBseSB0bywgYWxsDQo+ID4gYnV0ICMxMyBhcmUgbm93IG9uIGZvci1uZXh0Lg0K
PiA+DQo+ID4gPiBOb3RlLCB3ZSB3b3VsZCBsaWtlIHRvIHVzZSB0aGUgUGF0Y2gtMTMgaW4gdGhp
cyBzZXJpZXMuDQo+ID4NCj4gPiBJcyB5b3VyIHVzZSBjYXNlIGEgQ1BVIGVycmF0YT8gIElmIHNv
IEkgdGhpbmsgd2Ugc2hvdWxkIGp1c3QgZ28gYWhlYWQNCj4gPiBhbmQgYWRkIHRoYXQgZXJyYXRh
IHZpYSB0aGUgZXhpc3RpbmcgZXJyYXRhIG1lY2hhbmlzbS4gIElmIHlvdSd2ZSBnb3QNCj4gPiBz
b21lIG90aGVyIHVzZSBjYXNlLCBkbyB5b3UgbWluZCBlbGFib3JhdGluZz8gIEZyb20gdGhhdCBv
dGhlciB0aHJlYWQNCj4gPiBpdCBzb3VuZHMgbGlrZSBhIGNvbW1hbmQtbGluZSBhcmd1bWVudCBp
cyB0aGUgd2F5IHRvIGdvIGZvciBmb2xrcyB3aG8NCj4gPiB3YW50IHRvIHR1cm4gdGhpcyBvZmYg
bW9yZSBkeW5hbWljYWxseSwgYnV0IGhhcHB5IHRvIGhlYXIgaWYgeW91J3ZlDQo+ID4gZ290IHNv
bWV0aGluZyBkaWZmZXJlbnQgaW4gbWluZC4NCj4gSXQgaXMgbm90IENQVSBlcnJhdGEuDQo+IFJJ
U0MtViBjcHUgY2FuIGhhdmUgc3YzOSwgc3Y0OCBvciBldmVuIHN2NTcuIElmIGl0IGlzIGEgaGV0
ZXJvZ2Vub3VzIHN5c3RlbSwNCj4gY3B1IGNvcmVzIGluIHRoZSBzeXN0ZW0gbWlnaHQgaGF2ZSBk
aWZmZXJlbnQgc3YuIEVnOiBvbmUgY3B1IGNhbiBiZSBzdjM5IGFuZA0KPiBhbm90aGVyIGNvcmUg
aXMgc3Y0OC4NCj4gSW4gdGhpcyBjYXNlLCBhdXRvIGRldGVjdGlvbiBpcyBub3Qgd29yay4gU28s
IFBhdGNoLTEzIGNhbiBoZWxwIGluIHRoaXMgdXNlIGNhc2UuDQo+IA0KPiA+DQpIaSBQYWxtZXIN
Cg0KQW55IGZ1cnRoZXIgY29tbWVudCBmb3IgdGhpcz8NCg0KQW55IGNoYW5jZSBtZXJnaW5nIFBh
dGNoLTEzIGluIFsxXT8NCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC1yaXNjdi9wYXRjaC8yMDIxMTIwNjEwNDY1Ny40MzMzMDQtMTQtYWxleGFuZHJlLmdo
aXRpQGNhbm9uaWNhbC5jb20vDQoNClJlZ2FyZHMNCkxleSBGb29uDQoNCg==
