Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255E6545D08
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbiFJHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245441AbiFJHTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:19:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90972365507
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:19:42 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-265-E67PabsDNFybFXr5kYm1dQ-1; Fri, 10 Jun 2022 08:19:40 +0100
X-MC-Unique: E67PabsDNFybFXr5kYm1dQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 10 Jun 2022 08:19:38 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 10 Jun 2022 08:19:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Justin Stitt <jstitt007@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Richard Smith <richardsmith@google.com>
Subject: RE: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16
 conditional
Thread-Topic: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16
 conditional
Thread-Index: AQHYe27ya6wpBKIBkUONwhnsoYlXO61IPC9w
Date:   Fri, 10 Jun 2022 07:19:38 +0000
Message-ID: <ef8069e60f7a4e23a26dcbedd0bc77d7@AcuMS.aculab.com>
References: <20220607222006.22719-1-jstitt007@gmail.com>
 <20220607152744.d7c801d092529309500ac9a6@linux-foundation.org>
 <CAKwvOdmXeRbFjkHgFXps4pLH6Q6pGWRNOqA85=h2aFnR=uaggg@mail.gmail.com>
 <20220607162128.b5d4aa70f4a8a7610ce29250@linux-foundation.org>
 <YqArhaiEu+6YWZfg@zeniv-ca.linux.org.uk>
 <CAKwvOdnSSY0jexXioDTZOWSTi0fkaudZbgSjigPr5uzTRmA_Rg@mail.gmail.com>
In-Reply-To: <CAKwvOdnSSY0jexXioDTZOWSTi0fkaudZbgSjigPr5uzTRmA_Rg@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAwOCBKdW5lIDIwMjIgMjA6MzUNCi4uLi4N
Cj4gVGhlIGlzc3VlIHdlJ3JlIGZhY2luZyBpcyBtb3JlIHNvIHRoYXQgYG50b2hzYCBpcyBiZWlu
ZyB1c2VkIGluDQo+IHByaW50Zi1saWtlIGV4cHJlc3Npb25zOyBjbGFuZydzIC1XZm9ybWF0IHdh
cm5zIGFib3V0IGRlZmF1bHQgYXJndW1lbnQNCj4gcHJvbW90aW9uIHNvIHdlIG5lZWQgdG8gY2xl
YW4gdXAgY2FzZXMgd2hlcmUgc21hbGxlci10aGFuLWludCBmb3JtYXQNCj4gZmxhZ3MgYXJlIGJl
aW5nIHVzZWQgZm9yIHByb21vdGVkLXRvLWludCBwYXJhbXMuICBXaGlsZSBsb29raW5nIGF0DQo+
IHRoYXQsIE5hdGhhbiBub3RpY2VkIHRoYXQgX19zd2FiMTYgd2lsbCByZXR1cm4gZWl0aGVyIGEg
X191MTYgb3IgYW4NCj4gaW50IGJhc2VkIG9uIHdoZXRoZXIgX19IQVZFX0JVSUxUSU5fQlNXQVAx
Nl9fIGlzIGRlZmluZWQsIHdoaWNoDQo+IGRlcGVuZHMgb24gQk9USCB0aGUgY29tcGlsZXIgYmVp
bmcgdXNlZCBhbmQgdGFyZ2V0IGFyY2hpdGVjdHVyZS4gIFRoaXMNCj4gcGF0Y2ggZnJvbSBKdXN0
aW4ganVzdCBjbGVhbnMgdGhhdCB1cC4NCg0KVGhlICdwcm9ibGVtJyBpcyB0aGF0IHRoZSAoX191
MTYpIGNhc3QgaXMgbGlrZWx5IHRvIGFkZCBhbg0KZXh0cmEgJyYgMHhmZmZmJyBpbnN0cnVjdGlv
biB0aGF0IGlzIGFsbW9zdCBjZXJ0YWlubHkgbm90DQpyZXF1aXJlZC4NCg0KT1RPSCB0aGUgbGFj
ayBvZiB0aGlzIG1hc2tpbmcgaGFzIGFsd2F5cyBiZWVuIGEgZGlmZmVyZW5jZSBiZXR3ZWVuDQpo
dG9ucygpIG9uIEJFIGFuZCBMRSBzeXN0ZW1zLg0KDQpCdXQgY2xhbmcgaXMgYWxzbyBiZWluZyBv
dmVyLWVudGh1c2lhc3RpYyB3aXRoIGl0cyB3YXJuaW5ncy4NCklJUkMgdmFyYXJncyBwYXJhbWV0
ZXJzIGFsd2F5cyBnZXQgaW50ZWdlciBwcm9tb3Rpb24uDQpTbyBpZiAlaGQgZXZlciBtYWtlcyBz
ZW5zZSBmb3IgcHJpbnRmIHRoZW4gaXQgaW1wbGllcyBhDQptYXNrIGluc2lkZSBwcmludGYuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

