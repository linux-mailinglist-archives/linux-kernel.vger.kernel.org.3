Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B40848E795
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbiANJfM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jan 2022 04:35:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53078 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230141AbiANJfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:35:11 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-113-N-IQipKrO-i71OVc75YCcg-1; Fri, 14 Jan 2022 09:35:09 +0000
X-MC-Unique: N-IQipKrO-i71OVc75YCcg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 14 Jan 2022 09:35:08 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 14 Jan 2022 09:35:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "deller@gmx.de" <deller@gmx.de>
Subject: RE: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Thread-Topic: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Thread-Index: AQHYBkLm7AQ+C6qOvkCW4jNyMLz0qKxce3DQgAAF6wCAAEoUEIAFASf/gAB6SdA=
Date:   Fri, 14 Jan 2022 09:35:08 +0000
Message-ID: <0a249160215a44ee8789f12727667a42@AcuMS.aculab.com>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <7a0fefb7ed3542b4a49dee1e78b1668b@AcuMS.aculab.com>
        <yt9d8rvmt2jq.fsf@linux.ibm.com>
        <20220113125754.0cb5273f@gandalf.local.home>
        <yt9dwnj3wcke.fsf@linux.ibm.com>
        <20220113165115.0c844df9@gandalf.local.home>
 <20220113211501.473ab5ca@gandalf.local.home>
In-Reply-To: <20220113211501.473ab5ca@gandalf.local.home>
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

From: Steven Rostedt
> Sent: 14 January 2022 02:15
> 
> On Thu, 13 Jan 2022 16:51:15 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > We could add something later. As it is currently the merge window, and this
> > is a real bug, I'm going to just leave it as is, and we can work to fix the
> > other archs later. I need to get a pull request ready by tomorrow.
> 
> Actually I got this working, and looks like a reasonable answer to the
> problem. It basically requires that the user specify that the pointer
> points into user space for the kernel to read it.

Certainly look better.

I'm not sure about the difference between the _inatomic() and _nocheck()
user access functions though.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

