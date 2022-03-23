Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA3C4E518F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbiCWLrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiCWLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:47:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E2CA7939D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:45:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-251-3EBf9A9TPvaSMLqZWsEjrw-1; Wed, 23 Mar 2022 11:45:55 +0000
X-MC-Unique: 3EBf9A9TPvaSMLqZWsEjrw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 23 Mar 2022 11:45:55 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 23 Mar 2022 11:45:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>, "Jann Horn" <jannh@google.com>
Subject: RE: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Thread-Topic: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Thread-Index: AQHYPiElHr6Egf4vbEGW28icqj7YNKzMOPHggAAMXYCAAJACUA==
Date:   Wed, 23 Mar 2022 11:45:55 +0000
Message-ID: <0f9b31b346504d28a908d16884df5e02@AcuMS.aculab.com>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <6716f3ffefae4ed8b5fd332bfcca8a9a@AcuMS.aculab.com>
 <YjqLAWbZ8K7eg3Fw@zx2c4.com>
In-Reply-To: <YjqLAWbZ8K7eg3Fw@zx2c4.com>
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

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDIzIE1hcmNoIDIwMjIgMDI6NTENCj4g
DQo+IE9uIFR1ZSwgTWFyIDIyLCAyMDIyIGF0IDg6MTYgUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5M
YWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4gTmV2ZXIgbWluZCBzY3JpcHRzIHRoYXQgdHJ5
IHRvIGltbWVkaWF0ZWx5IHNhdmUgYSBuZXcgc2VlZGZpbGUgWzFdLg0KPiA+DQo+ID4gV2hhdCBh
Ym91dCBjb2RlIHJ1biBieSBsYXRlciBzdGFydHVwIHNjcmlwdHMgdGhhdCB3YW50cyByYW5kb20g
bnVtYmVycy4NCj4gPiBUaGV5IHJlYWxseSBkbyB3YW50IHRoZSBzZWVkZmlsZSBkYXRhIHRvIGJl
IHVzZWQuDQo+ID4gSWYgaXQgaXNuJ3QgdXNlZCB0aGVuIHRoZXkgYXJlIGxpa2VseSB0byBnZXQg
dmVyeSB3ZWFrIHJhbmRvbSBudW1iZXJzLg0KPiA+DQo+ID4gWW91IGNhbid0IHJlYWxseSBleHBl
Y3Qgc3RhcnR1cCBzY3JpcHRzIHRvIGJlIGlzc3VpbmcgaW9jdGwgcmVxdWVzdHMuDQo+IA0KPiBU
byBiZSBjbGVhciwgdGhpcyAiZXhwZWN0W2F0aW9uXSIgb2YgeW91cnMgaXMgdmVyeSBtdWNoIGEg
bmV3DQo+IGV4cGVjdGF0aW9uLiBDcmVkaXRpbmcgYml0cyBoYXMgcmVxdWlyZWQgYW4gaW9jdGwg
c2luY2UgZm9yZXZlci4gVGhvc2UNCj4gc2hlbGwgc2NyaXB0cyBoYXZlIGJlZW4gYnJva2VuIGZv
cmV2ZXIuIFRoZSBwcm9wb3NhbCBoZXJlIGlzIHRvIGFkZCBuZXcNCj4gYmVoYXZpb3IgdG8gc3Vw
cG9ydCB0aG9zZSBvbGQgYnJva2VuIHNoZWxsIHNjcmlwdHMuDQouLi4NCg0KSSBwZXJzb25hbGx5
IHdvbid0IGhhdmUgZXhwZWN0ZWQgdGhlIGJlaGF2aW91ciBmb3IgbG9uZyENCkkgd2FzIG9ubHkg
dHJ5aW5nIHRvIGdldCBhIGJ1aWxkcm9vdCBzeXN0ZW0gdG8gaW5pdGlhbGlzZSB0aGUNCnJhbmRv
bSBudW1iZXIgZ2VuZXJhdG9yIGxhc3QgeWVhci4NCkJ1dCBJJ20gc3VyZSBJIHJlYWQgc29tZSBv
ZiB0aGUgZG9jdW1lbnRhdGlvbiBhcyB3ZWxsIGFzIGxvb2tpbmcNCmF0IHRoZSBzY3JpcHRzIGFu
ZCB0aGUga2VybmVsIHNvdXJjZXMuDQoNClRoZSBidWlsZHJvb3Qgc2NyaXB0cyBhY3R1YWxseSBu
ZWVkIGZpeGluZyBzbyB0aGV5IGFjdHVhbGx5DQphZGQgZW50cm9weSBvbiBvbGRlciBrZXJuZWwu
DQoNCkkgZG8gcmVtZW1iZXIgbG9va2luZyBhdCBvbmUgb2YgdGhlIGtlcm5lbCBlbnRyb3B5IHN0
b3Jlcw0KKHByb2JhYmx5IHRoZSBMaW51eCBvbmUpIGEgZmV3IHllYXJzIGJhY2sgYW5kIHRoaW5r
aW5nDQp0aGF0IGl0IHdhcyBvdmVyLWNvbXBsZXggYW5kIHByb2JhYmx5IGRpZG4ndCBhY3R1YWxs
eSB3b3JrDQp0aGF0IHdlbGwgaW4gcmVhbGl0eS4NCklJUkMgaXQgc2F2ZWQgJ2VudHJvcHkgYnl0
ZXMnIGFuZCB0aGUgbnVtYmVyIG9mIGJpdHMgb2YgZW50cm9weQ0KdGhleSByZXByZXNlbnRlZCAt
IGFuZCB0aGVuIHJlYWQgb3V0IGVub3VnaCBieXRlcyB0byBnZXQNCnRoZSByZXF1aXJlZCBlbnRy
b3B5IHRvIHJlc2VlZCB0aGUgUFJORy4NCk5vdyBpZiB5b3VyIFBSTkcgaGFzIE4gYml0cyBvZiBz
dGF0ZS4gSW4gcHJpbmNpcGxlIGF0IGxlYXN0DQphZnRlciB5b3UndmUgb3V0cHV0IE4gYml0cyBz
b21lb25lIGNhbiBzb2x2ZSB0aGUgc2ltdWx0YW5lb3VzDQplcXVhdGlvbnMgYW5kIGRldGVybWlu
ZSB0aGUgUFJORyBzdGF0ZS4NCkJ1dCBhcyBzb29uIGFzIHlvdSB1c2UgYSBjcnlwdG9ncmFwaGlj
IGhhc2ggZnVuY3Rpb24gdGhhdA0KaXMgbm90IHJlYWxseSBwb3NzaWJsZSBpbiBhbnkgcmVhc29u
YWJsZSB0aW1lZnJhbWUuDQooSXMgZXZlbiBNRDUgdGhhdCBicm9rZW4/KQ0KDQpCdXQgdGhlICdl
bnRyb3B5IHN0b3JlJyBjYW4ganVzdCBzdGlyIGluIG5ldyBieXRlcyBhbmQNCmNvdW50IHRoZSBu
dW1iZXIgb2YgZW50cm9weSBiaXRzLg0KVGhlbiBpdCBkb2Vzbid0IHJlYWxseSBjYXJlIGhvdyBy
YW5kb20gdGhlIGJ5dGVzIGFyZS4NCihBcGFydCBmcm9tIGFuIGVzdGltYXRpb24gb2YgaG93ICdm
dWxsJyBpdCBpcy4pDQpDb3B5IGJpdHMgdG8gdGhlIFBSTkcgYW5kIHlvdSByZWR1Y2UgdGhlIG51
bWJlciBvZg0KYml0cyBpbiB0aGUgZW50cm9weSBzdG9yZSAtIGJ1dCBjb250aW51ZSBqdXN0IHN0
aXJyaW5nDQppbiBuZXcgZGF0YS4NCg0KSSd2ZSBvZnRlbiB3b25kZXJlZCB3aGV0aGVyIHRoZSBS
QzUgYWxnb3JpdGhtIHdvdWxkDQptYWtlIGEgZ29vZCBlbnRyb3B5IHN0b3JlLg0KSnVzdCBjeWNs
ZSB0aGUgYWxnb3JpdGhtIHdpdGggZWFjaCBlbnRyb3B5IGJ5dGUgYXMNCmlzIGRvbmUgd2hlbiBz
ZXR0aW5nIGVhY2gga2V5IGJ5dGUuDQpDbGVhcmx5IHlvdSBkb24ndCB3YW50IHRvIHVzZSB0aGUg
UkM1IG91dHB1dCBhcyByYW5kb20gZGF0YS4NCkJ1dCBpdCBvdWdodCB0byBiZSBwbGVudHkgZ29v
ZCBlbm91Z2ggdG8ga2VlcCBlbnRyb3B5Lg0KVGhlIG9ubHkgcmVhbCBwcm9ibGVtIGlzIHRoYXQg
UkM1IGlzIHByZXR0eSBob3JyaWQgb24NCnRoZSBkYXRhIGNhY2hlLCBhbmQgcHJvYmFibHkgYSBi
aXQgYmlnIGZvciBwZXItY3B1IGRhdGEuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

