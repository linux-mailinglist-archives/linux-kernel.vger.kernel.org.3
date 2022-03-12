Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12894D70EA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 21:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiCLUot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 15:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiCLUor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 15:44:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3606EB20;
        Sat, 12 Mar 2022 12:43:41 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D924A8C4;
        Sat, 12 Mar 2022 21:43:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647117819;
        bh=ZeEH/itQEzkuzgNJu5BxrRT3n9gQmJU57PR5oFX6p8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHvUE9q5bHcZFWT6aj0KRl3j4WM7nSI2b+A3nDiy1SWDbDF1y/K7V3XYi5vSfNZaO
         qNsLF8rZKqIbyvRCnpVuoi5SI6P++UBpAgO+mT037IcuKc0xBXlq64hOdIY5R+Hr1g
         i3QINgGKA3/8WvtHOwMIsex/TCzwakAMiuNom4kU=
Date:   Sat, 12 Mar 2022 22:43:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-media@vger.kernel.org, linux-uvc-devel@lists.sourceforge.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: media: uvcvideo: Update mailing list address
Message-ID: <Yi0F6mUm7iCRGvCt@pendragon.ideasonboard.com>
References: <20220312203323.626657-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220312203323.626657-1-j.neuschaefer@gmx.net>
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

On Sat, Mar 12, 2022 at 09:33:22PM +0100, Jonathan Neuschäfer wrote:
> The mailing list address for UVC development has changed a while ago,
> but it was only updated in MAINTAINERS, not in the documentation.
> Update it there, too.

Thanks for bringing this to my attention, I didn't know we were still
referencing that old list.

How about moving to the linux-media@vger.kernel.org mailing list instead
? I don't see many reasons to treat this driver with a special mailing
list anymore.

> Fixes: 616bd4e2573cb ("[media] MAINTAINERS: Update UVC driver's mailing list address")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> The ML is marked "subscribers-only" in MAINTAINERS. Perhaps it would
> be useful to bring that up in the docs too.
> ---
>  Documentation/userspace-api/media/drivers/uvcvideo.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/drivers/uvcvideo.rst b/Documentation/userspace-api/media/drivers/uvcvideo.rst
> index e5fd8fad333c9..dcf992f85d471 100644
> --- a/Documentation/userspace-api/media/drivers/uvcvideo.rst
> +++ b/Documentation/userspace-api/media/drivers/uvcvideo.rst
> @@ -7,7 +7,7 @@ This file documents some driver-specific aspects of the UVC driver, such as
>  driver-specific ioctls and implementation notes.
> 
>  Questions and remarks can be sent to the Linux UVC development mailing list at
> -linux-uvc-devel@lists.berlios.de.
> +linux-uvc-devel@lists.sourceforce.net.
> 
> 
>  Extension Unit (XU) support

-- 
Regards,

Laurent Pinchart
