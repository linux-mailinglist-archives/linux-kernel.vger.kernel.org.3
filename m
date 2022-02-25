Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17ED4C3E40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbiBYGNN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Feb 2022 01:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBYGNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:13:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C1EA172E5E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:12:40 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-147-A1-nNgw5OU26roG4mbNyRw-1; Fri, 25 Feb 2022 06:12:37 +0000
X-MC-Unique: A1-nNgw5OU26roG4mbNyRw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 25 Feb 2022 06:12:35 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 25 Feb 2022 06:12:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: RE: Strange output on the console
Thread-Topic: Strange output on the console
Thread-Index: AQHYKfxF0QTTTto/+k+8VsyEcwRQo6yjyM1g
Date:   Fri, 25 Feb 2022 06:12:35 +0000
Message-ID: <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
References: <20220224230035.36547137@gandalf.local.home>
In-Reply-To: <20220224230035.36547137@gandalf.local.home>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 25 February 2022 04:01
> 
> I've been noticing that my tests have been spitting out strange output on
> the console. It would happen at boot up and then clear up. It looks like
> something screwed up with the serial timing.
> 
> Attached is a dmesg of one of my test runs as an example.
> 
> I've noticed this on both 32 bit and 64 bit x86.
> 
> I haven't had time to look deeper into this, but I figured I let you know
> about it.
> 
> And it always seems to happen right after:
> 
>   Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 
> Maybe this is a serial issue and not a printk one? :-/

Looks very much like the serial baud rate is being reset.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

