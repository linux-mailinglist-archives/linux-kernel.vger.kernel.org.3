Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72549A0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848506AbiAXXWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:22:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20586 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1587475AbiAXW2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:28:30 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-wZBAgXQyNgW9L0sW707gJQ-1; Mon, 24 Jan 2022 22:28:24 +0000
X-MC-Unique: wZBAgXQyNgW9L0sW707gJQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 24 Jan 2022 22:28:24 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 24 Jan 2022 22:28:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'michael@michaelkloos.com'" <michael@michaelkloos.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Fixed: Misaligned memory access. Fixed pointer
 comparison.
Thread-Topic: [PATCH v2] Fixed: Misaligned memory access. Fixed pointer
 comparison.
Thread-Index: AQHYEVdKMW4neByjLUyzfoYpVaSTlKxyvXYg
Date:   Mon, 24 Jan 2022 22:28:23 +0000
Message-ID: <394ff54c0b574484a4656e52c3c7e244@AcuMS.aculab.com>
References: <20220123034518.3717116-1-michael@michaelkloos.com>
 <4fa1c4bbf27242cf9835dde0abdc89d5@AcuMS.aculab.com>
 <fdbf6e1c-6ed1-bb82-1a56-f7188de7f83f@michaelkloos.com>
In-Reply-To: <fdbf6e1c-6ed1-bb82-1a56-f7188de7f83f@michaelkloos.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogbWljaGFlbEBtaWNoYWVsa2xvb3MuY29tDQo+IFNlbnQ6IDI0IEphbnVhcnkgMjAyMiAx
OToxOQ0KDQpSZS1pbnN0YXRpbmcgdGhlIGJpdCBJIGNvbW1lbnRlZCBvbiAuLg0KPiA+IC4uLiBB
ZGRpdGlvbmFsbHksIGhhcmR3YXJlIHN1cHBvcnQgbWF5IG5vdCBleGlzdCBhbmQgd291bGQgbGlr
ZWx5DQo+ID4gc3RpbGwgcnVuIHNsb3dlciB0aGFuIGFsaWduZWQgYWNjZXNzZXMgZXZlbiBpZiBp
dCBkaWQuDQo+IA0KPiA+IFRoYXQgbWF5IG5vdCBiZSB0cnVlLg0KPiA+IE9uIHg4NiB0aGUgY29z
dCBvZiBtaXNhbGlnbmVkIGFjY2Vzc2VzIG9ubHkganVzdCBtZWFzdXJhYmxlLg0KPiA+IEl0IGlz
bid0IGV2ZW4gb25lIGNsb2NrIHBlciBjYWNoZSBsaW5lIGZvciByZWFkcyAoZWcgaXBjc3VtKS4N
Cg0KPiBJIGtub3cgdGhhdCB0aGUgSW50ZWwgbWFudWFscyBzdGlsbCByZWNvbW1lbmQgYWxpZ25t
ZW50IG9uIHg4Ni4gIEkNCj4gaGF2ZW4ndCB0cmllZCB0byBtZWFzdXJlIHBlcmZvcm1hbmNlIGRp
ZmZlcmVuY2VzIHlldC4NCg0KSUlSQyB0aGV5IHJlY29tbWVuZCBhbGlnbmVkIHdyaXRlcyBpbiBw
YXJ0aWN1bGFyLg0KKEFuZCBkb24ndCBkbyBtaXNhbGlnbmVkIGxvY2tlZCBhY2Nlc3NlcyB0aGF0
IGNyb3NzIHBhZ2UgYm91bmRhcmllcy4pDQoNCkkndmUgZG9uZSBzb21lIG1lYXN1cmVtZW50cyBm
b3IgcmVhZHMgYW5kIHRoZSBjb3N0IHJlYWxseSB3YXMgbWluaW1hbC4NCllvdSdkIG5lZWQgdG8g
YmUgZG9pbmcgYSBoaWdoIHByb3BvcnRpb24gb2YgbXVsdGkta2IgbWlzYWxpZ25lZCB0cmFuc2Zl
cnMNCnRvIGNvdmVyIHRoZSBjb3N0IG9mIGFueSBjb25kaXRpb25hbCB0ZXN0IG9uIGFsaWduZWQg
dHJhbmZzZXJzLg0KDQo+IEkgdGhpbmsgdGhlIGlzc3VlIGhlcmUgaXMgdGhhdCBSSVNDLVYgaXMg
ZGVzaWduZWQgYXMgYSBtb2R1bGFyDQo+IGFyY2hpdGVjdHVyZS4gIFVubGlrZSB4ODYsIHdlIGRv
bid0IGtub3cgdGhhdCBtaXNhbGlnbmVkIGFjY2Vzc2VzDQo+IHdpbGwgb3Igd2lsbCBub3QgYmUg
c3VwcG9ydGVkLiAgSSB3aWxsIGdyYW50IHlvdSB0aGF0IGlmIHRoZXkgYXJlDQo+IHN1cHBvcnRl
ZCBieSBoYXJkd2FyZSwgaXQgd2lsbCBwcm9iYWJseSBiZSBmYXN0ZXIgdG8gbGV0IHRoZSBoYXJk
d2FyZQ0KPiBuYXRpdmVseSB0YWtlIGNhcmUgb2YgaXQuICBIb3dldmVyLCBpZiB0aGUgaGFyZHdh
cmUgZG9lc24ndCBzdXBwb3J0DQo+IGl0LCB0aGUga2VybmVsIHdvbid0IGJlIGNvbXBhdGlibGUg
d2l0aCB0aGF0IGhhcmR3YXJlLg0KDQpJbmRlZWQgeW91IHJlYWxseSBkb24ndCB3YW50IHRvIGJl
IGZpeGluZyB1cCBhbGlnbm1lbnQgZmF1bHRzIC0gZXZlci4NCkkndmUgbm8gaWRlYSB3aHkgdGhh
dCBldmVyIGJlY2FtZSBhY2NlcHRhYmxlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

