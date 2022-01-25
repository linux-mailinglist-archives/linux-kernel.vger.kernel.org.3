Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E660749BE66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiAYWVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:21:36 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:39873 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233724AbiAYWVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:21:35 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-2-fA7wWCh4Ow2lTbVV-GkDJQ-1; Tue, 25 Jan 2022 22:21:32 +0000
X-MC-Unique: fA7wWCh4Ow2lTbVV-GkDJQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 25 Jan 2022 22:21:31 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 25 Jan 2022 22:21:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aleksey Senin' <aleksey-linux-kernel@senin.name>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Using memcpy instead of copy_to_user. xprtrdma code.
Thread-Topic: Using memcpy instead of copy_to_user. xprtrdma code.
Thread-Index: AQHYEhYs6JOOV6I95k2rDCj4H0ySg6x0T4qw
Date:   Tue, 25 Jan 2022 22:21:31 +0000
Message-ID: <55b4da35b6e44bf48306280d900e0fa8@AcuMS.aculab.com>
References: <CAM=k+5qEfxHOFkiXfobJERr=gMQ9jgcxgpydnkJx3ed3uPPsQg@mail.gmail.com>
In-Reply-To: <CAM=k+5qEfxHOFkiXfobJERr=gMQ9jgcxgpydnkJx3ed3uPPsQg@mail.gmail.com>
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

RnJvbTogQWxla3NleSBTZW5pbiA8YWxla3NleS1saW51eC1rZXJuZWxAc2VuaW4ubmFtZT4NCj4g
U2VudDogMjUgSmFudWFyeSAyMDIyIDE4OjA0DQo+IA0KPiBUaGlzIHNwZWNpZmljIHBhdGNoIC0g
IC0gaW1wbGVtZW50cyB1c2luZyBtZW1jcHkgaW5zdGVhZCBvZg0KPiBjb3B5X3RvX3VzZXIuIFdo
eSBpcyBpdCBjb25zaWRlcmVkIHRvIGJlIHNhZmUgaW4gdGhpcyBzcGVjaWZpYyBjYXNlPw0KPiBB
bGwgcmVhZGluZ3MgYWJvdXQgaG93IHRvIGNvcHkgZGF0YSBhcmUgbWVudGlvbmluZyB0byB1c2UN
Cj4gY29weV90b191c2VyL2NvcHlfZnJvbV91c2VyLiBXaHkgdXNlIGRpcmVjdCBjb3B5IGhlcmU/
IFdoYXQgcHJldmVudHMNCj4gdGhlIGtlcm5lbCBmcm9tIGZhaWx1cmUgaWYgdGhlIHBhZ2UgaXMg
bm90IHByZXNlbnQgb3IgZG9lc24ndCBoYXZlDQo+IHJlcXVpcmVkIGFjY2VzcyByaWdodHM/DQo+
IA0KPiBAQCAtMTAzLDggKzEwMiw4IEBAIHN0YXRpYyBpbnQgcmVhZF9yZXNldF9zdGF0KHN0cnVj
dCBjdGxfdGFibGUNCj4gKnRhYmxlLCBpbnQgd3JpdGUsDQo+ICAgICAgICAgICAgICAgICBsZW4g
LT0gKnBwb3M7DQo+ICAgICAgICAgICAgICAgICBpZiAobGVuID4gKmxlbnApDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGxlbiA9ICpsZW5wOw0KPiAtICAgICAgICAgICAgICAgaWYgKGxlbiAm
JiBjb3B5X3RvX3VzZXIoYnVmZmVyLCBzdHJfYnVmLCBsZW4pKQ0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVGQVVMVDsNCj4gKyAgICAgICAgICAgICAgIGlmIChsZW4pDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIG1lbWNweShidWZmZXIsIHN0cl9idWYsIGxlbik7DQo+IA0K
PiBSZWZlcmVuY2UgdG8gdGhlIHNwZWNpZmljIHBhdGNoIGluIHRoZSBzZXJ2aWNlcyBvZiBjb21t
aXRzOg0KPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC80LzE3LzYwDQoNClJlYWQgdGhlIGNv
bW1pdCBtZXNzYWdlLg0KDQo+IA0KPiBDb21taXQgaXRzZWxmOg0KPiAzMjkyNzM5M2RjMWNjZDYw
ZmIyYmRjMDViOWU4ZTg4NzUzNzYxNDY5DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

