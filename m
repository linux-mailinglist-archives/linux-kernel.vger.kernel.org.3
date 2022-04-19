Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D550674E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350236AbiDSJAs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Apr 2022 05:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245424AbiDSJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:00:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB96426545
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:58:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-Ipas3v8SM0OhygXgk1aDHg-1; Tue, 19 Apr 2022 09:58:00 +0100
X-MC-Unique: Ipas3v8SM0OhygXgk1aDHg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 19 Apr 2022 09:57:59 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 19 Apr 2022 09:57:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Philipp Hortmann' <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] staging: vt6655: Replace VNSvInPortB with ioread8
Thread-Topic: [PATCH 2/2] staging: vt6655: Replace VNSvInPortB with ioread8
Thread-Index: AQHYUWgkUiOBuaOBE0usRu+cN1OB7az28+lQ
Date:   Tue, 19 Apr 2022 08:57:59 +0000
Message-ID: <9e33e133c7fd44258d89210d17c9fac2@AcuMS.aculab.com>
References: <cover.1650094595.git.philipp.g.hortmann@gmail.com>
 <fd71797d9d55d53f95c5c4e2df826bf85dd4626a.1650094595.git.philipp.g.hortmann@gmail.com>
In-Reply-To: <fd71797d9d55d53f95c5c4e2df826bf85dd4626a.1650094595.git.philipp.g.hortmann@gmail.com>
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

From: Philipp Hortmann
> Sent: 16 April 2022 09:01
> 
> Replace macro VNSvInPortB with ioread8. Avoid cast of the return
> value is possible with one exception.

Unless the hardware might be using PCI io space (which I doubt)
shouldn't it be using readb() not ioread8() ?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

