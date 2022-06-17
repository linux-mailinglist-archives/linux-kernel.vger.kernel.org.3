Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C530E54FA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbiFQPjU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 11:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiFQPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:39:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C764ECD4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:39:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-23-jFPDc8AHPBG7KoJDq-Oxtg-1; Fri, 17 Jun 2022 16:39:13 +0100
X-MC-Unique: jFPDc8AHPBG7KoJDq-Oxtg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 17 Jun 2022 16:39:10 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 17 Jun 2022 16:39:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alan Stern' <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:USB HID/HIDBP DRIVERS [USB KEYBOARDS, MICE, REM..." 
        <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@amd.com>
Subject: RE: [PATCH v2] HID: usbhid: set mouse as a wakeup resource
Thread-Topic: [PATCH v2] HID: usbhid: set mouse as a wakeup resource
Thread-Index: AQHYgluyoC2hoFBpKUup69QWlLdMjq1Tuqsg
Date:   Fri, 17 Jun 2022 15:39:10 +0000
Message-ID: <419f8edc2a7744ecbfaa0728227db180@AcuMS.aculab.com>
References: <20220616183142.14472-1-mario.limonciello@amd.com>
 <YqugZQiDu35Y8lTu@kroah.com> <YqyYIt2MLmoCRSA9@rowland.harvard.edu>
In-Reply-To: <YqyYIt2MLmoCRSA9@rowland.harvard.edu>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern
> Sent: 17 June 2022 16:05
...
> Another issue is whether wakeup for a mouse means pressing a button or
> just moving the mouse.  For a mouse that uses LEDs to sense motion,
> moving it won't generate a wakeup request -- USB suspend does not allow
> the mouse to use enough current to keep the LEDs illuminated.  On the
> other hand, there's no reason why wakeup by pressing a button shouldn't
> always work.

I'm not even sure I want a system to wake up because it's mouse
gets knocked.
I guess a mouse could include accelerometers so that you can shake it!

I've an idea that one of my systems manages to boot if the mouse
is knocked (and it was last shutdown from windows).
At least, that it why I think it is sometimes booting up.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

