Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628EC4A74D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbiBBPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:43:07 -0500
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:35209 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345539AbiBBPnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:43:06 -0500
Received: from umg-exc-04.ads.local.med.uni-goettingen.de ([10.76.100.73]:64300)
        by mail1.med.uni-goettingen.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <Martin.Uecker@med.uni-goettingen.de>)
        id 1nFHmg-0007Re-1Y; Wed, 02 Feb 2022 16:43:02 +0100
Received: from umg-exc-01.ads.local.med.uni-goettingen.de (10.76.100.74) by
 umg-exc-04.ads.local.med.uni-goettingen.de (10.76.100.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 2 Feb 2022 16:43:02 +0100
Received: from umg-exc-01.ads.local.med.uni-goettingen.de
 ([fe80::2886:b6b:10e3:deea]) by umg-exc-01.ads.local.med.uni-goettingen.de
 ([fe80::2886:b6b:10e3:deea%13]) with mapi id 15.01.2375.018; Wed, 2 Feb 2022
 16:43:02 +0100
From:   "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
Thread-Topic: [PATCH] linux/const.h: Explain how __is_constexpr() works
Thread-Index: AQHYFuNImz1ckbOr7ECuQj6wapZL5Kx+mliAgAFKtoCAAHOGgA==
Date:   Wed, 2 Feb 2022 15:43:02 +0000
Message-ID: <4eb192f15c9078984c5e05a9fdc85ab6a9611717.camel@med.uni-goettingen.de>
References: <20220131204357.1133674-1-keescook@chromium.org>
         <dc86fdf7-3202-e836-6f71-af1e2458b105@rasmusvillemoes.dk>
         <8e166131c01b4fbc83a1ca95b83bc362@AcuMS.aculab.com>
In-Reply-To: <8e166131c01b4fbc83a1ca95b83bc362@AcuMS.aculab.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.76.100.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEC27EED84726842A6C3EB7E92C45392@med.uni-goettingen.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gTWl0dHdvY2gsIGRlbiAwMi4wMi4yMDIyLCAwODo0OSArMDAwMCBzY2hyaWViIERhdmlkIExh
aWdodDoNCj4gRnJvbTogUmFzbXVzIFZpbGxlbW9lcw0KPiA+IFNlbnQ6IDAxIEZlYnJ1YXJ5IDIw
MjIgMTM6MDYNCj4gLi4uDQo+ID4gPiArICogLSBUaGUgQyBzdGFuZGFyZCBkZWZpbmVzIGFuICJp
bnRlZ2VyIGNvbnN0YW50IGV4cHJlc3Npb24iIGFzIGRpZmZlcmVudA0KPiA+ID4gKyAqICAgZnJv
bSBhICJudWxsIHBvaW50ZXIgY29uc3RhbnQiIChhbiBpbnRlZ2VyIGNvbnN0YW50IDAgcG9pbnRl
cikuDQo+ID4gDQo+ID4gSSBkb24ndCBzZWUgdGhlIHBvaW50IG9mIHRoaXMgYnVsbGV0LiBZZXMs
IGFuIElDRSBpcyBhIGRpc3RpbmN0IGNvbmNlcHQNCj4gPiBmcm9tIGEgbnVsbCBwb2ludGVyIGNv
bnN0YW50LCBvYnZpb3VzbHkuIE9uZSBpcyBkZWZpbmVkIGluIHRlcm1zIG9mIHRoZQ0KPiA+IG90
aGVyIC0gYW5kIHlvdXIgcGFyZW50aGVzaXMgaXMgbm90IGFuIGFjY3VyYXRlIHBhcmFwaHJhc2Ug
b2YgdGhlDQo+ID4gZGVmaW5pdGlvbiBvZiBhIG51bGwgcG9pbnRlciBjb25zdGFudC4NCj4gDQo+
IEZyb20gd2hhdCBJIHJlbWVtYmVyIGEgIm51bGwgcG9pbnRlciBjb25zdGFudCIgaXMgaW4gImlu
dGVnZXIgY29uc3RhbnQNCj4gZXhwcmVzc2lvbiB3aXRoIHZhbHVlIDAgY2FzdCB0byBhIHBvaW50
ZXIgdHlwZSIuDQo+IFNvICh2b2lkICopKDEtMSkgaXMganVzdCBhcyB2YWxpZCBhcyAodm9pZCAq
KTAuDQo+IA0KPiBOb3Qgc3VyZSBhbnkgb2YgaXQgaXMgcmVsZXZhbnQgaGVyZS4NCg0KVGhlIEMg
c3RhbmRhcmQgKGF0IGxlYXN0IHB1YmxpYyBkcmFmdHMgZXNzZW50aWFsbHkNCmlkZW50aWNhbCB0
byB0aGUgYWN0dWFsIHN0YW5kYXJkcykgY2FuIGJlIGZvdW5kIGhlcmU6DQoNCmh0dHA6Ly93d3cu
b3Blbi1zdGQub3JnL2p0YzEvc2MyMi93ZzE0L3d3dy9wcm9qZWN0cyM5ODk5DQoNCiJBbiBpbnRl
Z2VyIGNvbnN0YW50IGV4cHJlc3Npb24gd2l0aCB0aGUgdmFsdWUgMCwgb3Igc3VjaA0KYW4gZXhw
cmVzc2lvbiBjYXN0IHRvIHR5cGUgdm9pZCAqLCBpcyBjYWxsZWQgYSBudWxsIHBvaW50ZXINCmNv
bnN0YW50LiINCg0KQlRXOiBJIHRoaW5rIGl0IHdvdWxkIGJlIHZlcnkgdmFsdWFibGUgaWYgV0cx
NCB3b3VsZCBnZXQNCnByb3Bvc2FscyBhbmQvb3IgY29tbWVudHMgZnJvbSB0aGUga2VybmVsIGNv
bW11bml0eS4NCg0KTWFydGluDQoNCg0KDQo+IAlEYXZpZA0KPiANCj4gLQ0KPiBSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNCj4gUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCj4gDQo=
