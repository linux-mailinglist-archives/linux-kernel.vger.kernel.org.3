Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B564A7B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbiBBWmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:42:53 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:53833 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347930AbiBBWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:42:46 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-222-4tYY-hjeOVu5KHCJ3wWYMA-1; Wed, 02 Feb 2022 22:42:38 +0000
X-MC-Unique: 4tYY-hjeOVu5KHCJ3wWYMA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 2 Feb 2022 22:42:34 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 2 Feb 2022 22:42:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <rasmus.villemoes@prevas.dk>,
        'Kees Cook' <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] linux/const.h: Explain how __is_constexpr() works
Thread-Topic: [PATCH] linux/const.h: Explain how __is_constexpr() works
Thread-Index: AQHYFuNHRL4oDGFcTkyEh79ubpGBJ6yAbZqwgABP1oCAAB82kA==
Date:   Wed, 2 Feb 2022 22:42:34 +0000
Message-ID: <91f0956687b341a9861f467aafe6dc4d@AcuMS.aculab.com>
References: <20220131204357.1133674-1-keescook@chromium.org>
 <6641e01b86374ce197020d57c65ae3b3@AcuMS.aculab.com>
 <311c9ca5-e2d4-22fb-0299-d47f84470677@prevas.dk>
In-Reply-To: <311c9ca5-e2d4-22fb-0299-d47f84470677@prevas.dk>
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

RnJvbTogUmFzbXVzIFZpbGxlbW9lcw0KPiBTZW50OiAwMiBGZWJydWFyeSAyMDIyIDIwOjQ0DQo+
IA0KPiBPbiAwMi8wMi8yMDIyIDE3LjE5LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTog
S2VlcyBDb29rDQo+ID4+IFNlbnQ6IDMxIEphbnVhcnkgMjAyMiAyMDo0NA0KPiA+Pg0KPiA+PiBU
aGUgX19pc19jb25zdGV4cHIoKSBtYWNybyBpcyBkYXJrIG1hZ2ljLiBTaGVkIHNvbWUgbGlnaHQg
b24gaXQgd2l0aA0KPiA+PiBhIGNvbW1lbnQgdG8gZXhwbGFpbiBob3cgYW5kIHdoeSBpdCB3b3Jr
cy4NCj4gPj4NCj4gPiAuLi4NCj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY29uc3Qu
aCBiL2luY2x1ZGUvbGludXgvY29uc3QuaA0KPiA+PiBpbmRleCA0MzVkZGQ3MmQyYzQuLjcxMjJk
NmExZjhjZSAxMDA2NDQNCj4gPj4gLS0tIGEvaW5jbHVkZS9saW51eC9jb25zdC5oDQo+ID4+ICsr
KyBiL2luY2x1ZGUvbGludXgvY29uc3QuaA0KPiA+PiBAQCAtNyw2ICs3LDMwIEBADQo+ID4+ICAg
KiBUaGlzIHJldHVybnMgYSBjb25zdGFudCBleHByZXNzaW9uIHdoaWxlIGRldGVybWluaW5nIGlm
IGFuIGFyZ3VtZW50IGlzDQo+ID4+ICAgKiBhIGNvbnN0YW50IGV4cHJlc3Npb24sIG1vc3QgaW1w
b3J0YW50bHkgd2l0aG91dCBldmFsdWF0aW5nIHRoZSBhcmd1bWVudC4NCj4gPj4gICAqIEdsb3J5
IHRvIE1hcnRpbiBVZWNrZXIgPE1hcnRpbi5VZWNrZXJAbWVkLnVuaS1nb2V0dGluZ2VuLmRlPg0K
PiA+PiArICoNCj4gPj4gKyAqIERldGFpbHM6DQo+ID4+ICsgKiAtIHNpemVvZigpIGlzIGFuIGlu
dGVnZXIgY29uc3RhbnQgZXhwcmVzc2lvbiwgYW5kIGRvZXMgbm90IGV2YWx1YXRlIHRoZQ0KPiA+
PiArICogICB2YWx1ZSBvZiBpdHMgb3BlcmFuZDsgaXQgb25seSBleGFtaW5lcyB0aGUgdHlwZSBv
ZiBpdHMgb3BlcmFuZC4NCj4gPj4gKyAqIC0gVGhlIHJlc3VsdHMgb2YgY29tcGFyaW5nIHR3byBp
bnRlZ2VyIGNvbnN0YW50IGV4cHJlc3Npb25zIGlzIGFsc28NCj4gPj4gKyAqICAgYW4gaW50ZWdl
ciBjb25zdGFudCBleHByZXNzaW9uLg0KPiA+PiArICogLSBUaGUgdXNlIG9mIGxpdGVyYWwgIjgi
IGlzIHRvIGF2b2lkIHdhcm5pbmdzIGFib3V0IHVuYWxpZ25lZCBwb2ludGVyczsNCj4gPj4gKyAq
ICAgdGhlc2UgY291bGQgb3RoZXJ3aXNlIGp1c3QgYmUgIjEicy4NCj4gPj4gKyAqIC0gKGxvbmcp
KHgpIGlzIHVzZWQgdG8gYXZvaWQgd2FybmluZ3MgYWJvdXQgNjQtYml0IHR5cGVzIG9uIDMyLWJp
dA0KPiA+PiArICogICBhcmNoaXRlY3R1cmVzLg0KPiA+PiArICogLSBUaGUgQyBzdGFuZGFyZCBk
ZWZpbmVzIGFuICJpbnRlZ2VyIGNvbnN0YW50IGV4cHJlc3Npb24iIGFzIGRpZmZlcmVudA0KPiA+
PiArICogICBmcm9tIGEgIm51bGwgcG9pbnRlciBjb25zdGFudCIgKGFuIGludGVnZXIgY29uc3Rh
bnQgMCBwb2ludGVyKS4NCj4gPj4gKyAqIC0gVGhlIGNvbmRpdGlvbmFsIG9wZXJhdG9yICgiLi4u
ID8gLi4uIDogLi4uIikgcmV0dXJucyB0aGUgdHlwZSBvZiB0aGUNCj4gPj4gKyAqICAgb3BlcmFu
ZCB0aGF0IGlzbid0IGEgbnVsbCBwb2ludGVyIGNvbnN0YW50LiBUaGlzIGJlaGF2aW9yIGlzIHRo
ZQ0KPiA+PiArICogICBjZW50cmFsIG1lY2hhbmlzbSBvZiB0aGUgbWFjcm8uDQo+ID4+ICsgKiAt
IElmICh4KSBpcyBhbiBpbnRlZ2VyIGNvbnN0YW50IGV4cHJlc3Npb24sIHRoZW4gdGhlICIqIDBs
IiByZXNvbHZlcyBpdA0KPiA+PiArICogICBpbnRvIGEgbnVsbCBwb2ludGVyIGNvbnN0YW50LCB3
aGljaCBmb3JjZXMgdGhlIGNvbmRpdGlvbmFsIG9wZXJhdG9yDQo+ID4+ICsgKiAgIHRvIHJldHVy
biB0aGUgdHlwZSBvZiB0aGUgbGFzdCBvcGVyYW5kOiAiKGludCAqKSIuDQo+ID4+ICsgKiAtIElm
ICh4KSBpcyBub3QgYW4gaW50ZWdlciBjb25zdGFudCBleHByZXNzaW9uLCB0aGVuIHRoZSB0eXBl
IG9mIHRoZQ0KPiA+PiArICogICBjb25kaXRpb25hbCBvcGVyYXRvciBpcyBmcm9tIHRoZSBmaXJz
dCBvcGVyYW5kOiAiKHZvaWQgKikiLg0KPiA+PiArICogLSBzaXplb2YoaW50KSA9PSA0IGFuZCBz
aXplb2Yodm9pZCkgPT0gMS4NCj4gPj4gKyAqIC0gVGhlIHVsdGltYXRlIGNvbXBhcmlzb24gdG8g
InNpemVvZihpbnQpIiBjaG9vc2VzIGJldHdlZW4gZWl0aGVyOg0KPiA+PiArICogICAgIHNpemVv
ZigqKChpbnQgKikgKDgpKSA9PSBzaXplb2YoaW50KSAgICh4IHdhcyBhIGNvbnN0YW50IGV4cHJl
c3Npb24pDQo+ID4+ICsgKiAgICAgc2l6ZW9mKCooKHZvaWQgKikoOCkpID09IHNpemVvZih2b2lk
KSAgKHggd2FzIG5vdCBhIGNvbnN0YW50IGV4cHJlc3Npb24pDQo+ID4+ICAgKi8NCj4gPj4gICNk
ZWZpbmUgX19pc19jb25zdGV4cHIoeCkgXA0KPiA+PiAgCShzaXplb2YoaW50KSA9PSBzaXplb2Yo
Kig4ID8gKCh2b2lkICopKChsb25nKSh4KSAqIDBsKSkgOiAoaW50ICopOCkpKQ0KPiA+DQo+ID4g
VGhpcyBoYXMgYmVlbiBtYWtpbmcgbXkgaGVhZCBodXJ0IGFsbCBkYXkuDQo+ID4gVGhlIGFib3Zl
IGlzbid0IHJlYWxseSBhIHRydWUgZGVzY3JpcHRpb24gLSA/OiBkb2Vzbid0IHdvcmsgdGhhdCB3
YXkuDQo+ID4gVHJ5IHRoZSBmb2xsb3dpbmcgZm9yIHNpemU6DQo+ID4NCj4gPiAtIFRoZSBjb25k
aXRpb25hbCBvcGVyYXRvciAoPzopIHJlcXVpcmVzIHRoYXQgYm90aCBleHByZXNzaW9ucyBoYXZl
IHRoZQ0KPiA+ICAgdGhlIHNhbWUgdHlwZSAoYWZ0ZXIgbnVtZXJpYyBwcm9tb3Rpb25zKS4NCj4g
DQo+IE5vLiBQbGVhc2UgcmVhZCA2LjUuMTUuMyBmb3IgdGhlIHByZWNvbmRpdGlvbnMsIGFuZCA2
LjUuMTUuNSBhbmQNCj4gNi41LjE1LjYgZm9yIHRoZSBydWxlcyBnb3Zlcm5pbmcgdGhlIHR5cGUg
b2YgdGhlIHdob2xlIGV4cHJlc3Npb24uDQo+IA0KPiA+ICAgVGhlIHR5cGUgb2YgdGhlIHJlc3Vs
dCBpcyBhIGNvbXBpbGUgdGltZSBjb25zdGFudCBhbmQgZG9lc24ndCBkZXBlbmQgb24gYW55DQo+
ID4gICB2YXJpYWJsZXMuDQo+IA0KPiBZZXMsIHRoZSB0eXBlIG9mIGFueSBleHByZXNzaW9uIGlu
IEMgaXMga25vd24gYXQgY29tcGlsZSB0aW1lLCBhbmQgaXMNCj4gZGV0ZXJtaW5lZCB2aWEgdGhl
IHJ1bGVzIGluIHRoZSBDIHN0YW5kYXJkLiBJIHdvdWxkbid0IGNhbGwgaXQgYQ0KPiAiY29tcGls
ZSB0aW1lIGNvbnN0YW50IiB0aG91Z2guDQo+IA0KPiA+IC0gSWYgdGhlIGV4cHJlc3Npb25zIGhh
dmUgZGlzdGluY3Qgbm9uLU5VTEwgcG9pbnRlciB0eXBlcyB0aGVuIHRoZXkgYXJlIGJvdGgNCj4g
PiAgIGNhc3QgdG8gKHZvaWQgKikgYW5kIHRoZSByZXN1bHQgaGFzIHR5cGUgJ3ZvaWQgKicuDQo+
IA0KPiBXcm9uZy4NCg0KZ2FoIHNlcnZlciBtZSByaWdodCBmb3IgdXNpbmcgZ29kYm9sdCB0byB0
ZXN0IGl0Lg0KDQo+IA0KPiA+IC0gQSBOVUxMIHBvaW50ZXIgY2FuIGJlIG1hZGUgZnJvbSBhbnkg
aW50ZWdlciBjb25zdGFudCBleHByZXNzaW9uIHRoYXQNCj4gPiAgIGV2YWx1YXRlcyB0byAwLCBu
b3QganVzdCBhIGxpdGVyYWwgMC4NCj4gPiAtIFNvIHRoZSB0eXBlIG9mICgwID8gKHZvaWQgKiko
eCkgOiAoaW50ICopOCkgaXMgJ2ludCAqJyBpZiAoeCkgaXMgemVybw0KPiA+ICAgKGJlY2F1c2Ug
b2YgdGhlIE5VTEwpIGFuZCAodm9pZCAqKSBvdGhlcndpc2UgYmVjYXVzZSB0aGUgcG9pbnRlciB0
eXBlcw0KPiA+ICAgZG9uJ3QgbWF0Y2guDQo+IA0KPiBUaGF0J3MgYmFzaWNhbGx5IGhvdyB0aGlz
IG1hY3JvIHdvcmtzLCBidXQgIlNvIiBpcyBub3Qgd2FycmFudGVkIGFzIGl0DQo+IGRvZXMgbm90
IGZvbGxvdyBmcm9tIGFueSBvZiB0aGUgcHJldmlvdXMsIHdyb25nLCBzdGF0ZW1lbnRzLg0KPiAN
Cj4gPiBZb3UgY2FuIHRlc3QgdGhpcyBieSBldmFsdWF0aW5nOg0KPiA+IAlzaXplb2YgKigwID8g
KGZsb2F0ICopNCA6IChpbnQgKik0KQ0KPiANCj4gVGhhdCdzIGFuIGlsbC1mb3JtZWQgY29uZGl0
aW9uYWwgb3BlcmF0b3IsIGFuZCBnY2Mgc2F5cyBhcyBtdWNoIGV2ZW4NCj4gd2l0aG91dCBhbnkg
LVdhbGwgaW4gZWZmZWN0Lg0KPiANCj4gd2FybmluZzogcG9pbnRlciB0eXBlIG1pc21hdGNoIGlu
IGNvbmRpdGlvbmFsIGV4cHJlc3Npb24NCj4gICAgIDggfCAgcmV0dXJuIHNpemVvZigqKDAgPyAo
ZmxvYXQgKik0IDogKGludCAqKTQpKTsNCj4gDQo+IA0KPiA+IFRoaXMgaXMgMSBiZWNhdXNlIG9m
IHRoZSBpbXBsaWNpdCAodm9pZCAqKSBjYXN0Lg0KPiANCj4gVGhlcmUgaXMgbm8gc3VjaCB0aGlu
Zy4NCg0KT2sgbGV0J3MgdHJ5IGFnYWluLi4uDQpUaGUgY29tcGlsZXIgbmVlZHMgdG8gZmluZCBh
ICdjb21wYXRpYmxlIHR5cGUnIGVpdGhlciBmb3I6DQoJKHZvaWQgKil4CWFuZAkoaW50ICopOA0K
b3IgZm9yOg0KCSh2b2lkICopMAlhbmQJKGludCAqKTgNCkluIHRoZSBmb3JtZXIgaXQgaXMgJ3Zv
aWQgKicgYW5kIHRoZSBsYXR0ZXIgJ2ludCAqJyBiZWNhdXNlIHRoZSAodm9pZCAqKTANCmlzIE5V
TEwgYW5kIHRodXMgYSB2YWxpZCAnaW50IConIHBvaW50ZXIuDQoNCkluIGFueSBjYXNlIHN1Z2dl
c3RpbmcgdGhhdCBpdCBpcyBiYXNlZCBvbiB0aGUgdmFsdWUgYmVmb3JlIHRoZSA/IGlzIGJvZ3Vz
Lg0KDQpUaGF0IGlzIHByb2JhYmx5IGEgcmVhc29uYWJsZSBkZXNjcmlwdGlvbi4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

