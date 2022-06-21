Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00909553077
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348838AbiFULLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiFULLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:11:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8687629C89
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:11:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-12-tr4RSfdMOvSW-tkCoCbzDg-1; Tue, 21 Jun 2022 12:11:12 +0100
X-MC-Unique: tr4RSfdMOvSW-tkCoCbzDg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 21 Jun 2022 12:11:11 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 21 Jun 2022 12:11:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH v4 05/34] vsprintf: %pf(%p)
Thread-Topic: [PATCH v4 05/34] vsprintf: %pf(%p)
Thread-Index: AQHYhT0x/Lplvj5JSUOd+zyADHSmrK1ZsXPQ
Date:   Tue, 21 Jun 2022 11:11:11 +0000
Message-ID: <fd4348c1251e4180b3fc0a7eb5fe2daa@AcuMS.aculab.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-6-kent.overstreet@gmail.com>
 <f9224687-ce0c-b41b-f158-1b679a70c2d5@rasmusvillemoes.dk>
In-Reply-To: <f9224687-ce0c-b41b-f158-1b679a70c2d5@rasmusvillemoes.dk>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+ID4gK0NhbGxpbmcgYSBwcmV0dHkgcHJpbnRlciBmdW5jdGlvbg0KPiA+ICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gKzo6DQo+ID4gKw0KPiA+ICsg
ICAgICAgICVwZiglcCkgICAgIHByZXR0eSBwcmludGVyIGZ1bmN0aW9uIHRha2luZyBvbmUgYXJn
dW1lbnQNCj4gPiArICAgICAgICAlcGYoJXAsJXApICBwcmV0dHkgcHJpbnRlciBmdW5jdGlvbiB0
YWtpbmcgdHdvIGFyZ3VtZW50cw0KPiA+ICsNCj4gPiArRm9yIGNhbGxpbmcgZ2VuZXJpYyBwcmV0
dHkgcHJpbnRlcnMuIEEgcHJldHR5IHByaW50ZXIgaXMgYSBmdW5jdGlvbiB0aGF0IHRha2VzDQo+
ID4gK2FzIGl0cyBmaXJzdCBhcmd1bWVudCBhIHBvaW50ZXIgdG8gYSBwcmludGJ1ZiwgYW5kIHRo
ZW4gemVybyBvciBtb3JlIGFkZGl0aW9uYWwNCj4gPiArcG9pbnRlciBhcmd1bWVudHMuIEZvciBl
eGFtcGxlOg0KPiA+ICsNCj4gPiArICAgICAgICB2b2lkIGZvb190b190ZXh0KHN0cnVjdCBwcmlu
dGJ1ZiAqb3V0LCBzdHJ1Y3QgZm9vICpmb28pDQo+ID4gKyAgICAgICAgew0KPiA+ICsgICAgICAg
ICAgICAgICAgcHJfYnVmKG91dCwgImJhcj0ldSBiYXo9JXUiLCBmb28tPmJhciwgZm9vLT5iYXop
Ow0KPiA+ICsgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgcHJpbnRmKCIlcGYoJXApIiwg
Zm9vX3RvX3RleHQsIGZvbyk7DQo+ID4gKw0KPiA+ICtOb3RlIHRoYXQgYSBwcmV0dHktcHJpbnRl
ciBtYXkgbm90IHNsZWVwLCBpZiBjYWxsZWQgZnJvbSBwcmludGsoKS4gSWYgY2FsbGVkDQo+ID4g
K2Zyb20gcHJfYnVmKCkgb3Igc3ByaW50ZigpIHRoZXJlIGFyZSBubyBzdWNoIHJlc3RyaWN0aW9u
cy4NCg0KSSd2ZSBsb3N0IHRoZSBvcmlnaW5hbCBlbWFpbCA6LSkNCg0KSWYgeW91IGFyZSBnb2lu
ZyB0byBpbXBsZW1lbnQgdGhpcyBmb29fdG9fdGV4dCgpIG5lZWRzIHRvDQpiZSBwYXNzZWQgdGhl
IGZpZWxkIHdpZHRoLCBwcmVjaXNpb24gYW5kIGZsYWdzLg0KDQpJcyB0aGVyZSBhIHJlYWwgdXNl
IGZvciBtdWx0aXBsZSBhcmd1bWVudHMgJXBmKCVwLCVwKSB0aGF0IGNhbid0DQpiZSBpbXBsZW1l
bnRlZCBieSByZXF1aXJpbmcgdGhlIGNhbGxlciB1c2UgYSByZWxheSBzdHJ1Y3R1cmU/DQpUaGF0
IChzb3J0IG9mKSBzb2x2ZXMgdGhlIHByb2JsZW0gb2YgcGVvcGxlIGV4cGVjdGluZyB0byBiZQ0K
YWJsZSB0byBwYXNzIGludGVnZXJzIHRob3VnaC4NCg0KQW4gYWx0ZXJuYXRpdmUgd291bGQgYmUg
dXNpbmcgYW4gYXJyYXkgb2YgYSB1bmlvbiB0eXBlDQp0byBwYXNzIHRocm91Z2ggdGhlIHZhbHVl
cyBleHRyYWN0ZWQgZnJvbSB0aGUgb3JpZ2luYWwgdmFfbGlzdC4NCg0KT3IgcGFzcyB0aGUgZmly
c3QgYXMgYSBwb2ludGVyICh0byBnZXQgdGhlIHBvc3NpYmlsaXR5IG9mIGNvbXBpbGUNCnRpbWUg
Zm9ybWF0IGNoZWNraW5nIGFuZCBhbnkgb3RoZXJzIGFzIGEgdW5pb25bXS4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

