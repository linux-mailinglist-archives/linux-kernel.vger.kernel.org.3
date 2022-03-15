Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223114DA52E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiCOWU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiCOWU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:20:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A2153E13;
        Tue, 15 Mar 2022 15:19:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ACCD2DEF;
        Tue, 15 Mar 2022 23:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647382752;
        bh=RFSG4qUYggROrA3cLZLYz5mXAbc5yRVnPTiRtvyAiz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PjReL1jpG271AAQRTFo4DVmkkDgk7u5THXh4oAafdvigOHlI/TKwxQyTXbxpH99wU
         FZEbKsx4DowRRg8xQMnWzn43dnhfOMTu8/T5F3uH6+clavOWlV061DAyM2eVPHzeBK
         Yap+IZg9I8TaC7X8e8jPg2dgcOOe6Os+URX96rVM=
Date:   Wed, 16 Mar 2022 00:18:55 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2] docs: media: uvcvideo: Use linux-media mailing list
Message-ID: <YjEQz1GhLV0Kf3mO@pendragon.ideasonboard.com>
References: <20220315221007.1045878-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315221007.1045878-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thank you for the patch.

On Tue, Mar 15, 2022 at 11:10:06PM +0100, Jonathan Neuschäfer wrote:
> As discussed with other developers, the linux-uvc-devel mailing list is
> not very useful anymore, and it's better to send people to the general
> linux-media mailing list.
> 
> Replace/remove the old mailing list address in uvcvideo.rst and
> MAINTAINERS.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - Changed mailing list to linux-media@vger.kernel.org instead
> 
> v1:
> - https://lore.kernel.org/lkml/20220312203323.626657-1-j.neuschaefer@gmx.net/
> ---
>  Documentation/userspace-api/media/drivers/uvcvideo.rst | 2 +-
>  MAINTAINERS                                            | 1 -

This looks good, but I think we should also add the following:

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 5f394d4efc21..6c6a82af07ce 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2443,7 +2443,7 @@ static int uvc_probe(struct usb_interface *intf,
 			 "Forcing device quirks to 0x%x by module parameter for testing purpose.\n",
 			 dev->quirks);
 		dev_info(&dev->udev->dev,
-			 "Please report required quirks to the linux-uvc-devel mailing list.\n");
+			 "Please report required quirks to the linux-media mailing list.\n");
 	}

 	if (dev->info->uvc_version) {

If you're fine with that change, there's no need to resubmit, I can
handle this locally.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/drivers/uvcvideo.rst b/Documentation/userspace-api/media/drivers/uvcvideo.rst
> index e5fd8fad333c9..a290f9fadae9d 100644
> --- a/Documentation/userspace-api/media/drivers/uvcvideo.rst
> +++ b/Documentation/userspace-api/media/drivers/uvcvideo.rst
> @@ -7,7 +7,7 @@ This file documents some driver-specific aspects of the UVC driver, such as
>  driver-specific ioctls and implementation notes.
> 
>  Questions and remarks can be sent to the Linux UVC development mailing list at
> -linux-uvc-devel@lists.berlios.de.
> +linux-media@vger.kernel.org.
> 
> 
>  Extension Unit (XU) support
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05fd080b82f3a..8a0aeb1b98786 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20154,7 +20154,6 @@ F:	drivers/usb/host/uhci*
> 
>  USB VIDEO CLASS
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> -L:	linux-uvc-devel@lists.sourceforge.net (subscribers-only)
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  W:	http://www.ideasonboard.org/uvc/

-- 
Regards,

Laurent Pinchart
