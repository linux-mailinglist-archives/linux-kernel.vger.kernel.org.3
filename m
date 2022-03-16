Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201F44DADB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354970AbiCPJtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349355AbiCPJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:49:38 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B5B275E6;
        Wed, 16 Mar 2022 02:48:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33999EE;
        Wed, 16 Mar 2022 10:48:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647424103;
        bh=G47j0zdGssROUWfMmmzcjl+YW0aiSILgH3U9eUXsIC0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=H55xmHVBvLP5OodSJ3W5IXZEfKr10xUjWrGBpvQjF0Mj5iGhb1Ckt9rHijPsY3WUv
         W+GRzqstQ+ORDI+0Udjrxe5GWf/skWAj15JqgC2uph4bmRpxjDTiZDAChaup07mycq
         Bt37u7ECp/SlsUNADvrwOhd9TnuPtkwc287R0hYg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220315222146.1051303-1-j.neuschaefer@gmx.net>
References: <20220315222146.1051303-1-j.neuschaefer@gmx.net>
Subject: Re: [PATCH] media: uvcvideo: Send users to linux-media mailing list instead of linux-uvc-devel
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-media@vger.kernel.org
Date:   Wed, 16 Mar 2022 09:48:20 +0000
Message-ID: <164742410075.11309.15188538230455635539@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-03-15 22:21:46)
> The linux-uvc-devel mailing list has been deprecated in documentation
> and MAINTAINERS. Update this message printed by the driver, as well.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

But I believe this will be squashed into the other patch, so it holds
for there too.

--
Kieran


> ---
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index 5f394d4efc21c..6c6a82af07cee 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2443,7 +2443,7 @@ static int uvc_probe(struct usb_interface *intf,
>                          "Forcing device quirks to 0x%x by module paramet=
er for testing purpose.\n",
>                          dev->quirks);
>                 dev_info(&dev->udev->dev,
> -                        "Please report required quirks to the linux-uvc-=
devel mailing list.\n");
> +                        "Please report required quirks to the linux-medi=
a mailing list.\n");
>         }
>=20
>         if (dev->info->uvc_version) {
> --
> 2.35.1
>
