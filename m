Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47694922B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344451AbiARJ2C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jan 2022 04:28:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20916 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234638AbiARJ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:28:01 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-65-UKP7NHATNSOzPFPjhdG_nQ-1; Tue, 18 Jan 2022 09:27:58 +0000
X-MC-Unique: UKP7NHATNSOzPFPjhdG_nQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 18 Jan 2022 09:27:57 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 18 Jan 2022 09:27:57 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     Andrew Lunn <andrew@lunn.ch>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: list iterator spacing: clang-format vs checkpatch
Thread-Topic: list iterator spacing: clang-format vs checkpatch
Thread-Index: AQHYC8zMXnUUMjrv/kWzvC/rbrfnP6xogwQA
Date:   Tue, 18 Jan 2022 09:27:57 +0000
Message-ID: <87f5fe31ee8748658ca5849cdcad832e@AcuMS.aculab.com>
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
         <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
         <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
         <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
         <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
         <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
 <e67388e4bdd25ca5ccb4cf20df0527d82ba31277.camel@perches.com>
In-Reply-To: <e67388e4bdd25ca5ccb4cf20df0527d82ba31277.camel@perches.com>
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

From: Joe Perches
> Sent: 17 January 2022 18:05
> 
> On Mon, 2022-01-17 at 13:47 +0100, Jason A. Donenfeld wrote:
> > Hey again,
> 
> Rehi.
> 
> > Four years later I went through basically the same motions: "oh hey I
> > should clean this up", "I'll start with clang format", "oh cool it
> > adds spaces before the iterator paren so it looks like a normal for
> > loop to me", "that seems so reasonable; I love clang format", "oh no
> > checkpatch.pl complains; I hope it's wrong", "I wonder if anybody has
> > thought about this before", "oh, look, I asked about this already in
> > 2018."

Personally I think it should look like a #define expansion, not
part of the language.

I did notice it in the recent patch - and though it looked wrong.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

