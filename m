Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4524A7B03
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbiBBWUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:20:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:52339 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232942AbiBBWUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:20:30 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-246-3uFb0Gx1Ohm3qFSiuXJfVw-1; Wed, 02 Feb 2022 22:20:28 +0000
X-MC-Unique: 3uFb0Gx1Ohm3qFSiuXJfVw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 2 Feb 2022 22:20:25 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 2 Feb 2022 22:20:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miguel Ojeda' <miguel.ojeda.sandonis@gmail.com>
CC:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] linux/const.h: Explain how __is_constexpr() works
Thread-Topic: [PATCH] linux/const.h: Explain how __is_constexpr() works
Thread-Index: AQHYFuNHRL4oDGFcTkyEh79ubpGBJ6yAbZqwgABHZoCAACDEgA==
Date:   Wed, 2 Feb 2022 22:20:25 +0000
Message-ID: <6d75ee32e7c3415ebcfa12e61d26aa87@AcuMS.aculab.com>
References: <20220131204357.1133674-1-keescook@chromium.org>
 <6641e01b86374ce197020d57c65ae3b3@AcuMS.aculab.com>
 <CANiq72neVsdLRyLn24avMhLCaHxMEiG0bD-ZkG46O7J29FanYA@mail.gmail.com>
In-Reply-To: <CANiq72neVsdLRyLn24avMhLCaHxMEiG0bD-ZkG46O7J29FanYA@mail.gmail.com>
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

RnJvbTogTWlndWVsIE9qZWRhIDxtaWd1ZWwub2plZGEuc2FuZG9uaXNAZ21haWwuY29tPg0KPiBT
ZW50OiAwMiBGZWJydWFyeSAyMDIyIDIwOjE0DQo+IFRvOiBEYXZpZCBMYWlnaHQNCj4gDQo+IE9u
IFdlZCwgRmViIDIsIDIwMjIgYXQgNToxOSBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IC0gVGhlIGNvbmRpdGlvbmFsIG9wZXJhdG9yICg/
OikgcmVxdWlyZXMgdGhhdCBib3RoIGV4cHJlc3Npb25zIGhhdmUgdGhlDQo+ID4gICB0aGUgc2Ft
ZSB0eXBlIChhZnRlciBudW1lcmljIHByb21vdGlvbnMpLg0KPiANCj4gSSB0aGluayB5b3UgYXJl
IHJlZmVycmluZyB0byB0aGUgYXJpdGhtZXRpYyB0eXBlcyBjYXNlLCBidXQgdGhhdCBvbmUNCj4g
ZG9lcyBub3QgYXBwbHkgaGVyZS4NCg0KVGhlIHR5cGUgb2YgdGhlIHJlc3VsdCBkZXBlbmRzIG9u
IHRoZSB0eXBlIG9mIHRoZSAybmQgYW5kIDNyZCBhcmd1bWVudHMuDQpOb3Qgb24gdGhlIHZhbHVl
IG9mIHRoZSBmaXJzdCBvbmUuDQoNCj4gPiAtIElmIHRoZSBleHByZXNzaW9ucyBoYXZlIGRpc3Rp
bmN0IG5vbi1OVUxMIHBvaW50ZXIgdHlwZXMgdGhlbiB0aGV5IGFyZSBib3RoDQo+ID4gICBjYXN0
IHRvICh2b2lkICopIGFuZCB0aGUgcmVzdWx0IGhhcyB0eXBlICd2b2lkIConLg0KPiANCj4gR0ND
IGFuZCBDbGFuZyBnaXZlIGB2b2lkICpgIGZvciB0aGlzLCBidXQgc29tZXRoaW5nIGxpa2UgYGZs
b2F0ICpgIGFuZA0KPiBgaW50ICpgIGRvIG5vdCBmaXQgdGhlIGNvbnN0cmFpbnMgb2YgdGhlIG9w
ZXJhdG9yLg0KDQpDb21waWxpbmc6DQoNCiNkZWZpbmUgayh4KSAoc2l6ZW9mKCooMSA/IChmbG9h
dCAqKTggOiAoaW50ICopOCkpKQ0KDQppbnQgZjEodm9pZCl7IHJldHVybiBrKDYpOyB9DQoNCmdp
dmVzOg0KDQpmMToNCiAgICAgICAgbW92bCAgICAkMSwgJWVheA0KICAgICAgICByZXQNCg0KKHNl
ZSBodHRwczovL2dvZGJvbHQub3JnL3ovZTFNdllZeEd6KQ0KDQpDaGFuZ2UgdG8gI2RlZmluZSBr
KHgpIChzaXplb2YoKigxID8gKHZvaWQgKikoeCkgOiAoaW50ICopMCkpKQ0KYW5kIHlvdSBvbmx5
IGdldCA0IHdoZW4geCBpcyBhIGNvbXBpbGUtdGltZSBjb25zdGFudCAwLg0KDQpJdCBoYXMgbm90
aGluZyB0byB3aXRoIHRoZSBjb25kaXRpb24sIHRoZSBjb21waWxlciBpcyB0cnlpbmcgdG8gJ3Nv
cnQgb3V0Jw0KYSBzdWl0YWJsZSByZXR1cm4gdHlwZS4NCg0KSSBzdXNwZWN0IHRoZSBtaXNtYXRj
aGVkIHBvaW50ZXIgdHlwZXMgbWlnaHQgZXZlbiBiZSBhIGdjYyBleHRlbnNpb24uDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

