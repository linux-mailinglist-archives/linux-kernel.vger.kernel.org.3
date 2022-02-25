Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178634C4533
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbiBYNEc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Feb 2022 08:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiBYNE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:04:29 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 202561E2FFE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:03:56 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-238-3PwpcQMaNcGeF_-ybm3OzQ-1; Fri, 25 Feb 2022 13:03:54 +0000
X-MC-Unique: 3PwpcQMaNcGeF_-ybm3OzQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 25 Feb 2022 13:03:52 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 25 Feb 2022 13:03:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>
CC:     'Steven Rostedt' <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: RE: Strange output on the console
Thread-Topic: Strange output on the console
Thread-Index: AQHYKfxF0QTTTto/+k+8VsyEcwRQo6yjyM1ggAAHToCAADtxAIAABoGAgAAGDGCAABmPAIAACcBQ
Date:   Fri, 25 Feb 2022 13:03:51 +0000
Message-ID: <daa9769e1710410d9679e174cf8d3f41@AcuMS.aculab.com>
References: <20220224230035.36547137@gandalf.local.home>
 <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
 <20220225063637.GA18039@1wt.eu>
 <1dcb185901f04a5ea2476a449e371167@AcuMS.aculab.com>
 <20220225103239.GA18720@1wt.eu>
 <32a7af26f4494f47a03a6d965ac7c99a@AcuMS.aculab.com>
 <20220225122546.GB18720@1wt.eu>
In-Reply-To: <20220225122546.GB18720@1wt.eu>
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

From: Willy Tarreau
> Sent: 25 February 2022 12:26
...
> That could be one option I thought about but still, that sounds quite
> suspicious. You don't even get any #!:$/ etc. Or maybe the UART is
> configured in 6-bit mode (most 16550 support 5-8 bits), and maybe even
> the stop bit and/or parity participates.

I've been known to resort to an oscilloscope to get an async link
working :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

