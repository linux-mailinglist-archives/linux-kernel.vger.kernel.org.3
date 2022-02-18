Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21B4BC2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 23:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbiBRWhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 17:37:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiBRWhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 17:37:36 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE58E261C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:37:18 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-180-YVzaAXTkNqiX8iWks6RR6A-1; Fri, 18 Feb 2022 22:37:16 +0000
X-MC-Unique: YVzaAXTkNqiX8iWks6RR6A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 18 Feb 2022 22:37:15 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 18 Feb 2022 22:37:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Cooper' <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>
Subject: RE: [PATCH 05/29] x86: Base IBT bits
Thread-Topic: [PATCH 05/29] x86: Base IBT bits
Thread-Index: AQHYJOs4MY/fho88+Uaa/a9ERSiwKKyZyEiAgAAEwLCAAATdAIAAEfnw
Date:   Fri, 18 Feb 2022 22:37:14 +0000
Message-ID: <ae88354f68254b0ab17b67eb8696fa52@AcuMS.aculab.com>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.867389898@infradead.org>
 <96209eb7-f95c-41c5-12c1-da4dbbbf67f3@citrix.com>
 <bf7f2867a77e4ebe8c44fd0577a3ac55@AcuMS.aculab.com>
 <c7fa2998-0532-b46c-7bfb-ed41620f10b8@citrix.com>
In-Reply-To: <c7fa2998-0532-b46c-7bfb-ed41620f10b8@citrix.com>
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

RnJvbTogQW5kcmV3IENvb3Blcg0KPiBTZW50OiAxOCBGZWJydWFyeSAyMDIyIDIxOjI0DQo+IA0K
PiBPbiAxOC8wMi8yMDIyIDIxOjExLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogQW5k
cmV3IENvb3Blcg0KPiA+PiBTZW50OiAxOCBGZWJydWFyeSAyMDIyIDIwOjUwDQo+ID4+DQo+ID4+
IE9uIDE4LzAyLzIwMjIgMTY6NDksIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiA+Pj4gKy8qDQo+
ID4+PiArICogQSBiaXQgY29udm9sdXRlZCwgYnV0IG1hdGNoZXMgYm90aCBlbmRicjMyIGFuZCBl
bmRicjY0IHdpdGhvdXQNCj4gPj4+ICsgKiBoYXZpbmcgZWl0aGVyIGFzIGxpdGVyYWwgaW4gdGhl
IHRleHQuDQo+ID4+PiArICovDQo+ID4+PiArc3RhdGljIGlubGluZSBib29sIGlzX2VuZGJyKGNv
bnN0IHZvaWQgKmFkZHIpDQo+ID4+PiArew0KPiA+Pj4gKwl1bnNpZ25lZCBpbnQgdmFsID0gfioo
dW5zaWduZWQgaW50ICopYWRkcjsNCj4gPj4+ICsJdmFsIHw9IDB4MDEwMDAwMDBVOw0KPiA+Pj4g
KwlyZXR1cm4gdmFsID09IH4weGZhMWUwZmYzOw0KPiA+Pj4gK30NCj4gPj4gQXQgdGhpcyBwb2lu
dCwgSSBmZWVsIEkndmUgZWFybmVkIGFuICJJIHRvbGQgeW91IHNvIi4gOikNCj4gPj4NCj4gPj4g
Q2xhbmcgMTMgc2VlcyBzdHJhaWdodCB0aHJvdWdoIHRoZSB0cmlja2VyeSBhbmQgZ2VuZXJhdGVz
Og0KPiA+Pg0KPiA+PiBpc19lbmRicjrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBAaXNfZW5kYnINCj4gPj4gwqDCoMKgwqDCoMKg
wqAgbW92bMKgwqDCoCAkLTE2Nzc3MjE3LCAlZWF4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICMgaW1tID0gMHhGRUZGRkZGRg0KPiA+PiDCoMKgwqDCoMKgwqDCoCBhbmRswqDCoMKgICgl
cmRpKSwgJWVheA0KPiA+PiDCoMKgwqDCoMKgwqDCoCBjbXBswqDCoMKgICQtOTg2OTMxMzMsICVl
YXjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBpbW0gPSAweEZBMUUwRkYzDQo+ID4+
IMKgwqDCoMKgwqDCoMKgIHNldGXCoMKgwqAgJWFsDQo+ID4+IMKgwqDCoMKgwqDCoMKgIHJldHEN
Cj4gPiBJIHRoaW5rIGl0IGlzIGVub3VnaCB0byBhZGQ6DQo+ID4gCWFzbSgiIiwgIj1yIiAodmFs
KSk7DQo+ID4gc29tZXdoZXJlIGluIHRoZSBtaWRkbGUuDQo+IA0KPiAoRmlyc3QsIHlvdSBtZWFu
ICIrciIgbm90ICI9ciIpLA0KDQpJIGFsd2F5cyBkb3VibGUgY2hlY2suLi4uDQoNCj4gYnV0IG5v
IC0gdGhlIHByb2JsZW0gaXNuJ3QgdmFsLsKgIEl0J3MNCj4gYH4weGZhMWUwZmYzYCB3aGljaCB0
aGUgY29tcGlsZXIgaXMgZnJlZSB0byB0cmFuc2Zvcm0gaW4gc2V2ZXJhbCB1bnNhZmUgd2F5Lg0K
DQpBY3R1YWxseSB5b3UgY291bGQgZG8gKG1vZHVsbyBzdHVwaWQgZXJyb3JzKToNCgl2YWwgPSAo
Kih1bnNpZ25lZCBpbnQgKilhZGRyICYgfjB4MDEwMDAwMDApIF4gMHhmZjM7DQoJYXNtKCIiLCAi
K3IiICh2YWwpKTsNCglyZXR1cm4gdmFsIF4gMHhmYTFlMDAwMDsNCndoaWNoIHNob3VsZCBiZSB6
ZXJvIGZvciBlbmRicmEgYW5kIG5vbi16ZXJvIG92ZXJ3aXNlLg0KU2hhbWUgdGhlIGNvbXBpbGVy
IHdpbGwgcHJvYmFibHkgbmV2ZXIgdXNlIHRoZSBmbGFncyBmcm9tIHRoZSBmaW5hbCB4b3IuDQpD
b252ZXJ0aW5nIHRvIGJvb2wganVzdCBhZGRzIGNvZGUhDQooSSBoYXRlIGJvb2wpDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

