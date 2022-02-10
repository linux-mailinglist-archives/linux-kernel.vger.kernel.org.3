Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345764B1033
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbiBJOVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:21:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiBJOVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:21:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B274AF5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:21:10 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-314-1bdjv44kN9i2uVm1sW-Fng-1; Thu, 10 Feb 2022 14:21:08 +0000
X-MC-Unique: 1bdjv44kN9i2uVm1sW-Fng-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Feb 2022 14:21:07 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Feb 2022 14:21:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>
CC:     Michal Simek <monstr@monstr.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] microblaze: remove CONFIG_SET_FS
Thread-Topic: [PATCH] microblaze: remove CONFIG_SET_FS
Thread-Index: AQHYHcQ6EgAhsRrDe0u1y8RgHhFzdayMhlsAgABCtoCAAAcZYA==
Date:   Thu, 10 Feb 2022 14:21:07 +0000
Message-ID: <cc2a0d0eb77b4ace872263db7bf0c115@AcuMS.aculab.com>
References: <20220209144910.1484686-1-arnd@kernel.org>
 <80c6df0717014472aa81093ae3894d39@AcuMS.aculab.com>
 <CAK8P3a3tZEc30AaiNENbHKf8+x5VOw7Q=4dVDMNwz0F6+v9YrQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3tZEc30AaiNENbHKf8+x5VOw7Q=4dVDMNwz0F6+v9YrQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxMCBGZWJydWFyeSAyMDIyIDEzOjMwDQouLi4N
Cj4gI2RlZmluZSBfX2FjY2Vzc19vayhhZGRyLCBzaXplKSBcDQo+ICAgICAgICAgKChnZXRfZnMo
KS5zZWcgPT0gS0VSTkVMX0RTLnNlZykgfHwgXA0KPiAgICAgICAgICgoKHVuc2lnbmVkIGxvbmcp
YWRkciA8IGdldF9mcygpLnNlZykgJiYgXA0KPiAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcpc2l6
ZSA8IChnZXRfZnMoKS5zZWcgLSAodW5zaWduZWQgbG9uZylhZGRyKSkpDQoNClRoYXQgb25lIGlz
IHN0cmFuZ2UuDQpTZWVtcyB0byBiZSBvcHRpbWlzZWQgZm9yIGtlcm5lbCBhY2Nlc3NlcyENCg0K
PiBpYTY0IGFuZCBzcGFyYyBza2lwIHRoZSBzaXplIGNoZWNrIGVudGlyZWx5IGJ1dCByZWx5IG9u
IGFuIHVubWFwcGVkIHBhZ2UNCj4gYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUga2VybmVsIGFkZHJl
c3MgcmFuZ2UsIHdoaWNoIGF2b2lkcyB0aGlzIHByb2JsZW0NCj4gYnV0IG1heSBhbHNvIGJlIGRh
bmdlcm91cy4NCg0KQW4gdW5tYXBwZWQgcGFnZSByZXF1aXJlcyB0aGF0IHRoZSBrZXJuZWwgZG8g
c2VxdWVudGlhbCBhY2Nlc3Nlcw0KKG9yLCBhdCBsZWFzdCwgbm90IGJpZyBvZmZzZXQpIC0gd2hp
Y2ggaXMgbm9ybWFsbHkgZmluZS4NCkVzcGVjaWFsbHkgZm9yIDY0Yml0IHdoZXJlIHRoZXJlIGlz
IHBsZW50eSBvZiBhZGRyZXNzIHNwYWNlLg0KSSBndWVzcyBpdCBjb3VsZCBiZSBwcm9ibGVtYXRp
YyBmb3IgMzJiaXQgaWYgeW91IGNhbi93YW50IHRvDQp1c2UgJ2JpZyBwYWdlcycgZm9yIHRoZSBr
ZXJuZWwgYWRkcmVzc2VzLg0KTG9zaW5nIGEgc2luZ2xlICh0eXBpY2FsbHkpIDRrIHBhZ2UgaXNu
J3QgYSBwcm9ibGVtLg0KDQpDZXJ0YWlubHkgbm90IG1hcHBpbmcgdGhlIHBhZ2UgYXQgVEFTS19T
SVpFIGlzIGEgZ29vZCBzYWZldHkgY2hlY2suDQpBY3R1YWxseSwgc2V0dGluZyBUQVNLX1NJWkUg
dG8gMHhjMDAwMDAwMCAtIFBBR0VfU0laRSBhbmQgbmV2ZXINCm1hcHBpbmcgdGhlIGxhc3QgdXNl
ciBwYWdlIGhhcyB0aGUgc2FtZSBlZmZlY3QuDQpFeGNlcHQgSSBiZXQgdGhlIGxkc28gaGFzIHRv
IGdvIHRoZXJlIDotKA0KTm90IHRvIG1lbnRpb24gdGhlIGluc3RydWN0aW9uIHNldHMgd2hlcmUg
bG9hZGluZyB0aGUgY29uc3RhbnQNCndvdWxkIHRoZW4gYmUgdHdvIGluc3RydWN0aW9ucy4NCg0K
Li4uDQo+ID4gQWx0aG91Z2ggdHlwaWNhbCA2NGJpdCBhcmNoaXRlY3R1cmVzIGNhbiB1c2UgdGhl
IGZhc3RlcjoNCj4gPiAgICAgICAgICgoYWRkciB8IHNpemUpID4+IDYyKQ0KPiANCj4gSSB0aGlu
ayB0aGlzIGlzIHRoZSBiZXN0IHZlcnNpb24sIGFuZCBpdCdzIGFscmVhZHkgd2lkZWx5IHVzZWQ6
DQoNCkkganVzdCBkaWQgYSBxdWljayBjaGVjaywgYm90aCBjbGFuZyBhbmQgZ2NjIG9wdGltaXNl
IG91dA0KY29uc3RhbnQgdmFsdWVzIGZvciAnc2l6ZScuDQoNCj4gc3RhdGljIGlubGluZSBpbnQg
X19yYW5nZV9vayh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gew0K
PiAgICAgICAgIHJldHVybiBzaXplIDw9IFRBU0tfU0laRSAmJiBhZGRyIDw9IChUQVNLX1NJWkUg
LSBzaXplKTsNCj4gfQ0KPiANCj4gc2luY2UgJ3NpemUnIGlzIHVzdWFsbHkgY29uc3RhbnQsIHNv
IHRoaXMgdHVybnMgaW50byBhIHNpbmdsZSBjb21wYXJpc29uDQo+IGFnYWluc3QgYSBjb21waWxl
LXRpbWUgY29uc3RhbnQuDQoNCkhtbW0uLi4gbWF5YmUgdGhlcmUgc2hvdWxkIGJlIGEgY29tbWVu
dCB0aGF0IGl0IGlzIHRoZSBzYW1lIGFzDQp0aGUgbW9yZSBvYnZpb3VzOg0KCShhZGRyIDw9IFRB
U0tfU0laRSAmJiBhZGRyIDw9IFRBU0tfU0laRSAtIHNpemUpDQpidXQgaXMgYmV0dGVyIGZvciBj
b25zdGFudCBzaXplLg0KKFByb3ZpZGVkIFRBU0tfU0laRSBpcyBhIGNvbnN0YW50LikNCg0KSSdt
IHN1cmUgTGludXMgd2FzICd1bmhhcHB5JyBhYm91dCBjaGVja2luZyBhZ2FpbnN0IDJeNjMgZm9y
DQozMmJpdCBwcm9jZXNzZXMgb24gYSA2NGJpdCBrZXJuZWwuDQoNCkhtbW0gY29tcGF0IGNvZGUg
dGhhdCBoYXMgMzJiaXQgYWRkci9zaXplIG5lZWRuJ3QgZXZlbiBjYWxsDQphY2Nlc3Nfb2soKSAt
IGl0IGNhbiBuZXZlciBhY2Nlc3Mga2VybmVsIG1lbW9yeSBhdCBhbGwuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

