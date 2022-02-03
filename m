Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E994A8168
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiBCJZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:25:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:34611 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230204AbiBCJZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:25:11 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-32-mMsgCqnFOQGl0x65lu6MTQ-1; Thu, 03 Feb 2022 09:25:08 +0000
X-MC-Unique: mMsgCqnFOQGl0x65lu6MTQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 3 Feb 2022 09:25:07 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 3 Feb 2022 09:25:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miguel Ojeda' <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Rikard Falkeborn" <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] linux/const.h: Explain how __is_constexpr() works
Thread-Topic: [PATCH] linux/const.h: Explain how __is_constexpr() works
Thread-Index: AQHYGHV8RL4oDGFcTkyEh79ubpGBJ6yBjFag
Date:   Thu, 3 Feb 2022 09:25:07 +0000
Message-ID: <8f41a0e40e78419d947ba322031acd2f@AcuMS.aculab.com>
References: <20220131204357.1133674-1-keescook@chromium.org>
 <CANiq72m+3UKC+PskuGYu_c_u1Ua-=bvkHi9Gess-59+pqXdSwA@mail.gmail.com>
In-Reply-To: <CANiq72m+3UKC+PskuGYu_c_u1Ua-=bvkHi9Gess-59+pqXdSwA@mail.gmail.com>
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

RnJvbTogTWlndWVsIE9qZWRhDQo+IFNlbnQ6IDAyIEZlYnJ1YXJ5IDIwMjIgMjA6NDMNCj4gDQo+
IE9uIE1vbiwgSmFuIDMxLCAyMDIyIGF0IDk6NDMgUE0gS2VlcyBDb29rIDxrZWVzY29va0BjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gKyAqIC0gVGhlIGNvbmRpdGlvbmFsIG9wZXJhdG9y
ICgiLi4uID8gLi4uIDogLi4uIikgcmV0dXJucyB0aGUgdHlwZSBvZiB0aGUNCj4gPiArICogICBv
cGVyYW5kIHRoYXQgaXNuJ3QgYSBudWxsIHBvaW50ZXIgY29uc3RhbnQuIFRoaXMgYmVoYXZpb3Ig
aXMgdGhlDQo+IA0KPiBQZXJoYXBzIGNsYXJpZnkgdGhhdCB0aGlzIGhhcHBlbnMgb25seSBpZiBp
dCBmaXRzIHRoYXQgY2FzZT8gLi4uDQo+IA0KPiA+ICsgKiAtIElmICh4KSBpcyBhbiBpbnRlZ2Vy
IGNvbnN0YW50IGV4cHJlc3Npb24sIHRoZW4gdGhlICIqIDBsIiByZXNvbHZlcyBpdA0KPiA+ICsg
KiAgIGludG8gYSBudWxsIHBvaW50ZXIgY29uc3RhbnQsIHdoaWNoIGZvcmNlcyB0aGUgY29uZGl0
aW9uYWwgb3BlcmF0b3INCj4gPiArICogICB0byByZXR1cm4gdGhlIHR5cGUgb2YgdGhlIGxhc3Qg
b3BlcmFuZDogIihpbnQgKikiLg0KPiA+ICsgKiAtIElmICh4KSBpcyBub3QgYW4gaW50ZWdlciBj
b25zdGFudCBleHByZXNzaW9uLCB0aGVuIHRoZSB0eXBlIG9mIHRoZQ0KPiA+ICsgKiAgIGNvbmRp
dGlvbmFsIG9wZXJhdG9yIGlzIGZyb20gdGhlIGZpcnN0IG9wZXJhbmQ6ICIodm9pZCAqKSIuDQo+
IA0KPiAuLi4gaS5lLiB0aGlzIG9uZSBoYXBwZW5zIGJlY2F1c2UgaXQgaXMgc3BlY2lmaWVkIGFz
IHJldHVybmluZyBhDQo+IHBvaW50ZXIgdG8gdm9pZCAob25lIGNvdWxkIHJlYWQgaXQgYXMgcmV0
dXJuaW5nIHRoZSB0eXBlIG9mIHRoZSBmaXJzdA0KPiBvcGVyYW5kKS4NCj4gDQo+IFdoYXQgYWJv
dXQgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAgIC0gVGhlIGJlaGF2aW9yIChpbmNsdWRpbmcgaXRz
IHJldHVybiB0eXBlKSBvZiB0aGUgY29uZGl0aW9uYWwNCj4gb3BlcmF0b3IgKCIuLi4gPyAuLi4g
OiAuLi4iKSBkZXBlbmRzIG9uIHRoZSBraW5kIG9mIGV4cHJlc3Npb25zIGdpdmVuDQo+IGZvciB0
aGUgc2Vjb25kIGFuZCB0aGlyZCBvcGVyYW5kcy4gVGhpcyBpcyB0aGUgY2VudHJhbCBtZWNoYW5p
c20gb2YNCj4gdGhlIG1hY3JvLg0KPiAgIC0gSWYgKHgpIGlzIGFuIGludGVnZXIgY29uc3RhbnQg
ZXhwcmVzc2lvbiwgdGhlbiB0aGUgIiogMGwiIHJlc29sdmVzDQo+IGl0IGludG8gYSBudWxsIHBv
aW50ZXIgY29uc3RhbnQuIFdoZW4gb25lIG9wZXJhbmQgaXMgYSBudWxsIHBvaW50ZXINCj4gY29u
c3RhbnQgYW5kIHRoZSBvdGhlciBpcyBhIHBvaW50ZXIsIHRoZSBjb25kaXRpb25hbCBvcGVyYXRv
ciByZXR1cm5zDQo+IHRoZSB0eXBlIG9mIHRoZSBwb2ludGVyIG9wZXJhbmQ7IHRoYXQgaXMsICJp
bnQgKiIuDQo+ICAgLSBJZiAoeCkgaXMgbm90IGFuIGludGVnZXIgY29uc3RhbnQgZXhwcmVzc2lv
biwgdGhlbiB0aGF0IG9wZXJhbmQgaXMNCj4gYSBwb2ludGVyIHRvIHZvaWQgKGJ1dCBub3QgYSBu
dWxsIHBvaW50ZXIgY29uc3RhbnQpLiBXaGVuIG9uZSBvcGVyYW5kDQo+IGlzIGEgcG9pbnRlciB0
byB2b2lkIGFuZCB0aGUgb3RoZXIgYSBwb2ludGVyIHRvIGFuIG9iamVjdCB0eXBlLCB0aGUNCj4g
Y29uZGl0aW9uYWwgb3BlcmF0b3IgcmV0dXJucyBhICJ2b2lkICoiIHR5cGUuDQoNCk5pY2sncyBx
dW90ZSBmcm9tIHRoZSBDIHN0YW5kYXJkIGFjdHVhbGx5IHN1bXMgaXQgdXAgbmljZWx5Og0KDQog
ICAgVGhlIGtleSBoZXJlIGlzIHRoYXQgdGhlIGNvbmRpdGlvbmFsIG9wZXJhdG9yIHJldHVybnMg
YSBkaWZmZXJlbnQgdHlwZQ0KICAgIGRlcGVuZGluZyBvbiB3aGV0aGVyIG9uZSBvZiB0aGUgb3Bl
cmFuZHMgaXMgYSBudWxsIHBvaW50ZXIgY29uc3RhbnQNCiAgICAoNi41LjE1LjYpOg0KDQogICAg
Wy4uLl0gaWYgb25lIG9wZXJhbmQgaXMgYSBudWxsIHBvaW50ZXIgY29uc3RhbnQsIHRoZSByZXN1
bHQgaGFzIHRoZQ0KICAgIHR5cGUgb2YgdGhlIG90aGVyIG9wZXJhbmQ7IG90aGVyd2lzZSwgb25l
IG9wZXJhbmQgaXMgYSBwb2ludGVyIHRvIHZvaWQNCiAgICBvciBhIHF1YWxpZmllZCB2ZXJzaW9u
IG9mIHZvaWQsIGluIHdoaWNoIGNhc2UgdGhlIHJlc3VsdCB0eXBlIGlzIGENCiAgICBwb2ludGVy
IHRvIGFuIGFwcHJvcHJpYXRlbHkgcXVhbGlmaWVkIHZlcnNpb24gb2Ygdm9pZC4NCg0KVGhhdCBm
b2xsb3dlZCBieSBhIHJlbWluZGVyIHRoYXQgIih2b2lkICopeCBpcyBhIG51bGwgcG9pbnRlciBj
b25zdGFudCBpZiB4DQppcyBhIGNvbXBpbGUgdGltZSBpbnRlZ2VyIGNvbnN0YW50IGV4cHJlc3Np
b24iIGlzIGVub3VnaC4NCkFsbCB0aGUgcmVzdCBpcyBqdXN0IFRMO0RSLg0KDQpUaGUgJzgnIGFs
c28ganVzdCBjb25mdXNlIHRoaW5ncywgdGhleSBhcmUgbm90IGltcG9ydGFudCBhdCBhbGwuDQpT
byBpdCBjYW4gYmU6DQojZGVmaW5lIF9faXNfY29uc3RleHByKHgpIFwNCiAJKHNpemVvZigqKDAg
PyAoKHZvaWQgKikoKGxvbmcpKHgpICogMCkpIDogKGludCAqKTApKSA9PSBzaXplb2YoaW50KSkN
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

