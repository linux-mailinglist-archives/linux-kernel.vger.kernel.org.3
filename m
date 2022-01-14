Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC9048ED39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiANPjK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jan 2022 10:39:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:49052 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbiANPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:39:09 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-312-5jlSIvp6O4S49Qxj-dKL-Q-1; Fri, 14 Jan 2022 15:39:06 +0000
X-MC-Unique: 5jlSIvp6O4S49Qxj-dKL-Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 14 Jan 2022 15:39:06 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 14 Jan 2022 15:39:06 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: RE: [PATCH] random: cleanup fractional entropy shift constants
Thread-Topic: [PATCH] random: cleanup fractional entropy shift constants
Thread-Index: AQHYCVwNJeBTmh3+qEWqVcWV8TuSV6xipq1A
Date:   Fri, 14 Jan 2022 15:39:06 +0000
Message-ID: <18ec4b57aecc4fa18d8e3bb6e090af1b@AcuMS.aculab.com>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220114153305.98505-1-Jason@zx2c4.com>
In-Reply-To: <20220114153305.98505-1-Jason@zx2c4.com>
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

From: Jason A. Donenfeld
> Sent: 14 January 2022 15:33
> 
> The entropy estimator is calculated in terms of 1/8 bits, which means
> there are various constants where things are shifted by 3. Move these
> into our pool info enum with the other relevant constants, and normalize
> the name a bit, prepending a POOL_ like the rest. While we're at it,
> move an English assertion about sizes into a proper BUILD_BUG_ON so
> that the compiler can ensure this invariant.
> 
...
> -#define ENTROPY_SHIFT 3
> -#define ENTROPY_BITS() (input_pool.entropy_count >> ENTROPY_SHIFT)
..
> +	POOL_ENTROPY_SHIFT = 3,
> +#define POOL_ENTROPY_BITS() (input_pool.entropy_count >> POOL_ENTROPY_SHIFT)

The rename ought to be a different patch.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

