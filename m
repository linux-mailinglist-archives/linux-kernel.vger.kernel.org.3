Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E16952DB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbiESRSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiESRSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:18:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153C932EFF;
        Thu, 19 May 2022 10:18:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [45.131.31.124])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7CE666E0;
        Thu, 19 May 2022 19:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1652980696;
        bh=55k1bJOY3Jt3Q5mBq3/VD6m9w5TeeNrndlmJVqblSOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvE6CUqf247O3eYbekxQ+PR8CXjTuia0dyT5/RRom0auavRue2qFQMX97d0lpcU8l
         7G3xHO8g85zQYw+qb1Ls8+Fi8i2cRu7TLUJ5Tzmw7WyzAAwGzQ+0Le9Gozz+qDdCVJ
         /CZbedEjBEmxOFo7O5BIPR4YU9QsQAWgA0AE/6Q0=
Date:   Thu, 19 May 2022 20:18:09 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@google.com>
Subject: Re: [PATCH 1/4] media: uvcvideo: Add missing value for
 power_line_frequency
Message-ID: <YoZ70Ssf4PTq3OaL@pendragon.ideasonboard.com>
References: <20220519154100.333091-1-ribalda@chromium.org>
 <20220519154100.333091-2-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220519154100.333091-2-ribalda@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Thu, May 19, 2022 at 05:40:56PM +0200, Ricardo Ribalda wrote:
> UVC 1.5 class defines 4 values for this control on:
> 4.2.2.3.6 Power Line Frequency Control

But UVC 1.1 doesn't. This thus has to be conditioned on the UVC version.

> Add the missing value.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index b4f6edf968bc..13cad4aa7573 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -366,6 +366,7 @@ static const struct uvc_menu_info power_line_frequency_controls[] = {
>  	{ 0, "Disabled" },
>  	{ 1, "50 Hz" },
>  	{ 2, "60 Hz" },
> +	{ 3, "Auto" },
>  };
>  
>  static const struct uvc_menu_info exposure_auto_controls[] = {

-- 
Regards,

Laurent Pinchart
