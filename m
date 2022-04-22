Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73B250B2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiDVI1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445181AbiDVI1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:27:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 969DD52E6E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:24:43 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-160-RpMxlxWUPReT48akEvTY5g-1; Fri, 22 Apr 2022 09:24:39 +0100
X-MC-Unique: RpMxlxWUPReT48akEvTY5g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 22 Apr 2022 09:24:37 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 22 Apr 2022 09:24:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>
CC:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "krebbel@linux.ibm.com" <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: RE: -Warray-bounds fun again
Thread-Topic: -Warray-bounds fun again
Thread-Index: AQHYVZxuMWLod4b+f0KSneXrWfgc9qz7l3Bw
Date:   Fri, 22 Apr 2022 08:24:37 +0000
Message-ID: <fd6b4de14d944680b5a5674edfe34654@AcuMS.aculab.com>
References: <yt9dzgkelelc.fsf@linux.ibm.com>
 <CAHk-=wgv4NLtEowsmX+0jq_nBWXFp8jtruX6U3SDm52N=ftkgg@mail.gmail.com>
In-Reply-To: <CAHk-=wgv4NLtEowsmX+0jq_nBWXFp8jtruX6U3SDm52N=ftkgg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjEgQXByaWwgMjAyMiAxNzoxMQ0KPiANCj4g
T24gVGh1LCBBcHIgMjEsIDIwMjIgYXQgNzowMiBBTSBTdmVuIFNjaG5lbGxlIDxzdmVuc0BsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBvYnZpb3VzICdmaXgnIGlzIHRvIHVzZSBh
YnNvbHV0ZV9wb2ludGVyKCk6DQo+ID4NCj4gPiAjZGVmaW5lIFMzOTBfbG93Y29yZSAoKigoc3Ry
dWN0IGxvd2NvcmUgKilhYnNvbHV0ZV9wb2ludGVyKDApKSkNCj4gPg0KPiA+IFRoYXQgbWFrZXMg
dGhlIHdhcm5pbmcgZ28gYXdheSwgYnV0IHVuZm9ydHVuYXRlbHkgdGhlIGNvbXBpbGVyIG5vIGxv
bmdlcg0KPiA+IGtub3dzIHRoYXQgdGhlIG1lbW9yeSBhY2Nlc3MgaXMgZml0dGluZyBpbnRvIGEg
bG9hZC9zdG9yZSB3aXRoIGEgMTIgYml0DQo+ID4gZGlzcGxhY2VtZW50Lg0KPiANCj4gSW4gdGhl
IGdjYyBidWd6aWxsYSBmb3IgdXMgbmVlZGluZyB0byBkbyB0aGVzZSBnYW1lczoNCj4gDQo+ICAg
ICBodHRwczovL2djYy5nbnUub3JnL2J1Z3ppbGxhL3Nob3dfYnVnLmNnaT9pZD05OTU3OA0KPiAN
Cj4gb25lIG9mIHRoZSBzdWdnZXN0aW9ucyB3YXMgIkkgcmVjb21tZW5kIHN1cHByZXNzaW5nIHRo
ZSB3YXJuaW5nIGVpdGhlcg0KPiBieSAjcHJhZ21hIEdDQyBkaWFnbm9zdGljIG9yIGJ5IG1ha2lu
ZyB0aGUgcG9pbnRlciB2b2xhdGlsZSIuDQo+IA0KPiBCdXQgUkVBRF9PTkNFKCkgc2hvdWxkIGFs
cmVhZHkgYmUgZG9pbmcgdGhhdCB2b2xhdGlsZSB0aGluZywgc28gdGhhdA0KPiBzdWdnZXN0aW9u
IG1heSBub3Qgd29yayB3aXRoIGdjYy0xMiBhbnkgbW9yZS4NCj4gDQo+IEl0IGlzICpwb3NzaWJs
ZSogdGhhdCBnY2MtMTIgaGFzIG5vdyBzcGVjaWFsLWNhc2VkIHRoZSB2ZXJ5IHNwZWNpYWwNCj4g
aXNzdWUgb2YgYSBjYXN0IG9mIHRoZSBjb25zdGFudCB6ZXJvLiBUaGF0IGlzIGhvdyBOVUxMIHdh
cw0KPiB0cmFkaXRpb25hbGx5IGRlZmluZWQuDQo+IA0KPiBTbyBqdXN0IG91dCBvZiBhIHBlcnZl
cnNlIGN1cmlvc2l0eSwgd2hhdCBoYXBwZW5zIGlmIHlvdSBkbyBzb21ldGhpbmcgbGlrZSB0aGlz
Og0KPiANCj4gICAgI2RlZmluZSBTMzkwX2xvd2NvcmVfZW5kICgoc3RydWN0IGxvd2NvcmUgKilz
aXplb2Yoc3RydWN0IGxvd2NvcmUpKQ0KPiAgICAjZGVmaW5lIFMzOTBfbG93Y29yZSAoUzM5MF9s
b3djb3JlX2VuZFstMV0pDQo+IA0KPiBpbnN0ZWFkPyBJdCBzaG91bGQgZ2V0IHRoZSBzYW1lIHZh
bHVlIGluIHRoZSBlbmQsIGJ1dCBpdCBkb2Vzbid0IGhhdmUNCj4gdGhhdCBzcGVjaWFsIGNhc2Ug
b2YgImNhc3QgYW4gaW50ZWdlciBjb25zdGFudCAwIHRvIGEgcG9pbnRlciIuDQo+IA0KPiBJIHN1
c3BlY3QgaXQgcHJvYmFibHkgZG9lc24ndCBoZWxwLCBiZWNhdXNlIGdjYyB3aWxsIHN0aWxsIHNl
ZSAib2gsDQo+IHlvdSdyZSBiYXNpbmcgdGhpcyBvZmYgYWRkcmVzcyB6ZXJvIi4NCj4gDQo+IEFu
b3RoZXIgdGhpbmcgdG8gdHJ5IG1pZ2h0IGJlIHRvIHJlbW92ZSB0aGUgaW5pdGlhbCAxNiBieXRl
cyBvZg0KPiBwYWRkaW5nIGZyb20gJ3N0cnVjdCBsb3djb3JlJyAoaXQgbG9va3MgbGlrZSB0aGUg
Zmlyc3QgMjAgYnl0ZXMgYXJlDQo+IG5vdCB1c2VkIC0gc28gbGVhdmUgNCBieXRlcyBvZiBwYWRk
aW5nIHN0aWxsKSwgYW5kIHVzZQ0KPiANCj4gICAgI2RlZmluZSBTMzkwX2xvd2NvcmUgKCooKHN0
cnVjdCBsb3djb3JlX25vcGFkICopMTYpKQ0KPiANCj4gaW5zdGVhZC4gVGhlbiBnY2Mgd2lsbCBu
ZXZlciBzZWUgdGhhdCAwLCBhbmQgaG9wZWZ1bGx5IHRoZSAiaGUncw0KPiBhY2Nlc3NpbmcgYmFz
ZWQgb2ZmIGEgTlVMTCBwb2ludGVyIiBsb2dpYyB3aWxsIGdvIGF3YXkuDQo+IA0KPiBCZWNhdXNl
IHJpZ2h0IG5vdywgb3VyIGFic29sdXRlX3BvaW50ZXIoKSBwcm90ZWN0aW9uIGFnYWluc3QgdGhp
cw0KPiBob3JyaWJsZSBnY2MgbWlzLWZlYXR1cmUgaXMgbGl0ZXJhbGx5IGJhc2VkIG9uIGhpZGlu
ZyB0aGUgdmFsdWUgZnJvbQ0KPiB0aGUgY29tcGlsZXIgd2l0aCBhbiBpbmxpbmUgYXNtLCBhbmQg
YnkgdmlydHVlIG9mIGhpZGluZyB0aGUgdmFsdWUNCj4gdGhlbiB5ZXMsIGdjYyB3aWxsIGhhdmUg
dG8gZ28gdGhyb3VnaCBhIHJlZ2lzdGVyIGJhc2UgcG9pbnRlciBhbmQNCj4gY2Fubm90IHNlZSB0
aGF0IGl0IGZpdHMgaW4gMTIgYml0cy4NCg0KSSB0aGluayB5b3UgbWlnaHQgYmUgbWl4aW5nIHVw
IHR3byBwcm9ibGVtcy4NCg0KQWNjZXNzaW5nICgoZm9vICopMCktPm1lbWJlciBpcyBwcm9ibGVt
YXRpYyBiZWNhdXNlIE5VTEwgbWlnaHQgbm90IGJlIHplcm8uDQpJbiB3aGljaCBjYXNlIGFuIHVu
ZXhwZWN0ZWQgYWRkcmVzcyBpcyBnZW5lcmF0ZWQuDQpJIHRoaW5rIHRoaXMgaXMgd2h5IGNsYW5n
IHJlYWxseSBkb2Vzbid0IGxpa2UgeW91IGRvaW5nIHRoYXQuDQpVc2luZyAoKGZvbyAqKShzaXpl
b2YgKGZvbykpWy0xXS5tZW1iZXIgbWlnaHQgZ2V0IGFyb3VuZCB0aGF0Lg0KDQpJIHN1c3BlY3Qg
dGhlIGFycmF5IGJvdW5kcyBpc3N1ZSBpcyBjYXVzZWQgYnkgZ2NjIHVzaW5nIGEgc2l6ZSBvZiAw
DQpmb3IgJ0kgZG9uJ3Qga25vdyB0aGUgc2l6ZScgYW5kIHRoZW4gYXNzdW1pbmcgaXQgaXMgcmVh
bCBzaXplIGxhdGVyIG9uLg0KVGhhdCBzZWVtcyBsaWtlIGEgcmVhbCBnY2MgYnVnLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

