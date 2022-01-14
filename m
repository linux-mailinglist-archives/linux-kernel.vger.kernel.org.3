Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5760348E7D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiANJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:51:23 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:24669 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbiANJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:51:22 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-N1R4dQtXO--4qP078nBPcw-1; Fri, 14 Jan 2022 09:51:19 +0000
X-MC-Unique: N1R4dQtXO--4qP078nBPcw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 14 Jan 2022 09:51:19 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 14 Jan 2022 09:51:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, Theodore Ts'o <tytso@mit.edu>
CC:     X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Remove a.out support
Thread-Topic: [PATCH] x86: Remove a.out support
Thread-Index: AQHYCNDslinUgpUO90yy2yXAl8mN3qxiRdeA
Date:   Fri, 14 Jan 2022 09:51:19 +0000
Message-ID: <4c76b01aee5c475a81fccf2fdfcb2080@AcuMS.aculab.com>
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic>
In-Reply-To: <YeCuNapJLK4M5sat@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDEzIEphbnVhcnkgMjAyMiAyMjo1Nw0KLi4u
DQo+IA0KPiBCdHcsIHBscyBkbyBub3RlIHRoYXQgdGhpcyBpcyByZW1vdmluZyBvbmx5IHRoZSB4
ODYgYS5vdXQgc3VwcG9ydCAtDQo+IG90aGVyIGFyY2hlcyAobTY4ayBhbmQgYWxwaGEpIHN0aWxs
IHNlbGVjdCBIQVZFX0FPVVQgYW5kIHRodXMgdGhlDQo+IHJlc3BlY3RpdmUgZ2x1ZSBpbiBmcy9i
aW5mbXRfYW91dC5jDQoNCkkgZGlkbid0IHRoaW5rIGFscGhhIHdhcyB0aGF0IG9sZCA6LSkNCm02
OGsgaXMgYW5vdGhlciBtYXR0ZXIuDQpCdXQgSSd2ZSBwcm9iYWJseSBkaXNtZW1iZXJlZCB0aGUg
b25seSBvbGQgbTY4ayBzeXN0ZW0gZGlzayBJJ3ZlIGhhZA0KdG8gZXh0cmFjdCB0aGUgbWFnbmV0
cy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

