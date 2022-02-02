Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EAE4A6D41
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbiBBItj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Feb 2022 03:49:39 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:53285 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245198AbiBBIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:49:38 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-b17IQterPEaZVCdKoaVgMA-1; Wed, 02 Feb 2022 08:49:35 +0000
X-MC-Unique: b17IQterPEaZVCdKoaVgMA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 2 Feb 2022 08:49:33 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 2 Feb 2022 08:49:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
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
Thread-Index: AQHYF2x1W+MAhayA/keZ5Xju46h+qqx/89kw
Date:   Wed, 2 Feb 2022 08:49:33 +0000
Message-ID: <8e166131c01b4fbc83a1ca95b83bc362@AcuMS.aculab.com>
References: <20220131204357.1133674-1-keescook@chromium.org>
 <dc86fdf7-3202-e836-6f71-af1e2458b105@rasmusvillemoes.dk>
In-Reply-To: <dc86fdf7-3202-e836-6f71-af1e2458b105@rasmusvillemoes.dk>
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes
> Sent: 01 February 2022 13:06
...
> > + * - The C standard defines an "integer constant expression" as different
> > + *   from a "null pointer constant" (an integer constant 0 pointer).
> 
> I don't see the point of this bullet. Yes, an ICE is a distinct concept
> from a null pointer constant, obviously. One is defined in terms of the
> other - and your parenthesis is not an accurate paraphrase of the
> definition of a null pointer constant.

From what I remember a "null pointer constant" is in "integer constant
expression with value 0 cast to a pointer type".
So (void *)(1-1) is just as valid as (void *)0.

Not sure any of it is relevant here.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

