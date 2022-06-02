Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D30053B31D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiFBFoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiFBFn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:43:58 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADBC22735D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:43:53 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0348024DBC0;
        Thu,  2 Jun 2022 13:43:43 +0800 (CST)
Received: from EXMBX164.cuchost.com (172.16.7.74) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 2 Jun
 2022 13:43:43 +0800
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX164.cuchost.com
 (172.16.6.74) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 2 Jun
 2022 13:43:42 +0800
Received: from EXMBX161.cuchost.com ([fe80::5c09:58ab:29b:a780]) by
 EXMBX161.cuchost.com ([fe80::5c09:58ab:29b:a780%15]) with mapi id
 15.00.1497.033; Thu, 2 Jun 2022 13:43:42 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     "alexandre.ghiti@canonical.com" <alexandre.ghiti@canonical.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: arch/riscv: SV48 patch series questions
Thread-Topic: arch/riscv: SV48 patch series questions
Thread-Index: AdhxrOkRGR9CQf46QWqljv+TL2tt2AEQwdsAABSqKCA=
Date:   Thu, 2 Jun 2022 05:43:42 +0000
Message-ID: <e99af0ab0a264aadb77d949c4b73fd57@EXMBX161.cuchost.com>
References: <83813d991f96428c95c6d681c16ae852@EXMBX161.cuchost.com>
 <mhng-055df44c-3feb-41ae-b8c0-ae3a6489dee1@palmer-ri-x1c9>
In-Reply-To: <mhng-055df44c-3feb-41ae-b8c0-ae3a6489dee1@palmer-ri-x1c9>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFsbWVyIERhYmJlbHQg
PHBhbG1lckBkYWJiZWx0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDIgSnVuZSwgMjAyMiAxMTo0
NCBBTQ0KPiBUbzogTGV5Zm9vbiBUYW4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+
IENjOiBhbGV4YW5kcmUuZ2hpdGlAY2Fub25pY2FsLmNvbTsgbGludXgtcmlzY3ZAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IGFyY2gvcmlzY3Y6IFNWNDggcGF0Y2ggc2VyaWVzIHF1ZXN0aW9ucw0KPiANCj4gT24gRnJp
LCAyNyBNYXkgMjAyMiAwMjozNzozNCBQRFQgKC0wNzAwKSwgbGV5Zm9vbi50YW5Ac3RhcmZpdmV0
ZWNoLmNvbQ0KPiB3cm90ZToNCj4gPiBIaSBQYWxtZXINCj4gPg0KPiA+IEFsZXgncyAiSW50cm9k
dWNlIHN2NDggc3VwcG9ydCB3aXRob3V0IHJlbG9jYXRhYmxlIGtlcm5lbCIgcGF0Y2ggc2VyaWVz
IGluDQo+IFsxXSB3YXMgcGFydGlhbGx5IG1lcmdlZCB0byBMaW51eCB2NS4xNy4gQnV0IHRoZXJl
IGFyZSA0IHBhdGNoZXMgYXJlIG5vdA0KPiBtZXJnZWQgKFBhdGNoLTEwIHRvIDEzKS4NCj4gPg0K
PiA+IE1heSBJIGtub3cgd2hhdCBpcyB0aGUgcGxhbiBmb3IgdGhlc2UgcGF0Y2hlcz8gV2lsbCB0
aGVtIG1lcmdlZCB0byBuZXh0DQo+IHY1LjE5IG1lcmdpbmcgd2luZG93PyBPciBkbyB5b3UgZXhw
ZWN0IGFueSBjaGFuZ2VzIGZvciB0aGVzZSBwYXRjaGVzIG9yDQo+IEFsZXggbmVlZHMgcmVzZW5k
IHdpdGggcmViYXNlIHRvIGxhdGVzdCBrZXJuZWwgdmVyc2lvbj8NCj4gDQo+IEkganVzdCBzYXcg
dGhpcyBhcyBJIHdhcyBkaWdnaW5nIHVwIEFsZXgncyBvbGQgZW1haWwgdG8gcmVwbHkgdG8sIGFs
bCBidXQgIzEzIGFyZQ0KPiBub3cgb24gZm9yLW5leHQuDQo+IA0KPiA+IE5vdGUsIHdlIHdvdWxk
IGxpa2UgdG8gdXNlIHRoZSBQYXRjaC0xMyBpbiB0aGlzIHNlcmllcy4NCj4gDQo+IElzIHlvdXIg
dXNlIGNhc2UgYSBDUFUgZXJyYXRhPyAgSWYgc28gSSB0aGluayB3ZSBzaG91bGQganVzdCBnbyBh
aGVhZCBhbmQgYWRkDQo+IHRoYXQgZXJyYXRhIHZpYSB0aGUgZXhpc3RpbmcgZXJyYXRhIG1lY2hh
bmlzbS4gIElmIHlvdSd2ZSBnb3Qgc29tZSBvdGhlciB1c2UNCj4gY2FzZSwgZG8geW91IG1pbmQg
ZWxhYm9yYXRpbmc/ICBGcm9tIHRoYXQgb3RoZXIgdGhyZWFkIGl0IHNvdW5kcyBsaWtlIGENCj4g
Y29tbWFuZC1saW5lIGFyZ3VtZW50IGlzIHRoZSB3YXkgdG8gZ28gZm9yIGZvbGtzIHdobyB3YW50
IHRvIHR1cm4gdGhpcyBvZmYNCj4gbW9yZSBkeW5hbWljYWxseSwgYnV0IGhhcHB5IHRvIGhlYXIg
aWYgeW91J3ZlIGdvdCBzb21ldGhpbmcgZGlmZmVyZW50IGluDQo+IG1pbmQuDQpJdCBpcyBub3Qg
Q1BVIGVycmF0YS4gDQpSSVNDLVYgY3B1IGNhbiBoYXZlIHN2MzksIHN2NDggb3IgZXZlbiBzdjU3
LiBJZiBpdCBpcyBhIGhldGVyb2dlbm91cyBzeXN0ZW0sIGNwdSBjb3JlcyBpbiB0aGUgc3lzdGVt
IG1pZ2h0IGhhdmUgZGlmZmVyZW50IHN2LiBFZzogb25lIGNwdSBjYW4gYmUgc3YzOSBhbmQgYW5v
dGhlciBjb3JlIGlzIHN2NDguDQpJbiB0aGlzIGNhc2UsIGF1dG8gZGV0ZWN0aW9uIGlzIG5vdCB3
b3JrLiBTbywgUGF0Y2gtMTMgY2FuIGhlbHAgaW4gdGhpcyB1c2UgY2FzZS4NCg0KPiANCj4gPiBQ
YXRjaGVzIG5vdCBtZXJnZWQ6DQo+ID4gW3YzLDEwLzEzXSByaXNjdjogSW1wcm92ZSB2aXJ0dWFs
IGtlcm5lbCBtZW1vcnkgbGF5b3V0IGR1bXAgW3YzLDExLzEzXQ0KPiA+IERvY3VtZW50YXRpb246
IHJpc2N2OiBBZGQgc3Y0OCBkZXNjcmlwdGlvbiB0byBWTSBsYXlvdXQgW3YzLDEyLzEzXQ0KPiA+
IHJpc2N2OiBJbml0aWFsaXplIHRocmVhZCBwb2ludGVyIGJlZm9yZSBjYWxsaW5nIEMgZnVuY3Rp
b25zIFt2MywxMy8xM10NCj4gPiByaXNjdjogQWxsb3cgdXNlciB0byBkb3duZ3JhZGUgdG8gc3Yz
OSB3aGVuIGh3IHN1cHBvcnRzIHN2NDggaWYgIUtBU0FODQo+ID4NCj4gPiBbMV06DQo+ID4gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJpc2N2L2NvdmVyLzIwMjEx
MjA2MTA0NjU3Lg0KPiA+IDQzMzMwNC0xLWFsZXhhbmRyZS5naGl0aUBjYW5vbmljYWwuY29tLw0K
PiA+DQoNClRoYW5rcy4NCg0KUmVnYXJkcw0KTGV5IEZvb24NCg==
