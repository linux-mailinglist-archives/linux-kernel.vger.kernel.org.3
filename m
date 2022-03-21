Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0484E336A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiCUWyW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Mar 2022 18:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiCUWxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:53:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A41B23D819F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:39:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-96-AKQkeZfLOTaKITOaaCe37w-1; Mon, 21 Mar 2022 22:39:13 +0000
X-MC-Unique: AKQkeZfLOTaKITOaaCe37w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 21 Mar 2022 22:39:14 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 21 Mar 2022 22:39:14 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Martin Kaiser' <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/6] staging: r8188eu: clean up odm dynamic functions
Thread-Topic: [PATCH 0/6] staging: r8188eu: clean up odm dynamic functions
Thread-Index: AQHYPWMAEqIti2f5FEmtSMAd4Wfc1azKba+w
Date:   Mon, 21 Mar 2022 22:39:13 +0000
Message-ID: <d5a5e6d319b244778e7109f4e0f45902@AcuMS.aculab.com>
References: <20220321203031.143486-1-martin@kaiser.cx>
In-Reply-To: <20220321203031.143486-1-martin@kaiser.cx>
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

From: Martin Kaiser
> Sent: 21 March 2022 20:30
> 
> Simplify the code for odm dynamic functions. Remove unused capabilities
> and intermediate steps.

Looks like a reasonable first tidyup to me :-)
There is a lot more goop in there!

	David

> 
> This should be applied after the "remove local BIT macro" patch.
> 
> Martin Kaiser (6):
>   staging: r8188eu: remove two limit defines
>   staging: r8188eu: remove unused defines for dynamic functions
>   staging: r8188eu: DYNAMIC_BB_DYNAMIC_TXPWR is not used
>   staging: r8188eu: DYNAMIC_BB_ANT_DIV is not used
>   staging: r8188eu: DYNAMIC_RF_CALIBRATION is not used
>   staging: r8188eu: refactor dm func set and clear
> 
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  6 ++---
>  drivers/staging/r8188eu/core/rtw_wlan_util.c  | 12 ---------
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 16 +++---------
>  drivers/staging/r8188eu/include/hal_intf.h    |  2 +-
>  .../staging/r8188eu/include/rtw_mlme_ext.h    | 25 -------------------
>  5 files changed, 7 insertions(+), 54 deletions(-)
> 
> --
> 2.30.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

