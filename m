Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538BA464503
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbhLACnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhLACnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:43:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DDFC061574;
        Tue, 30 Nov 2021 18:39:48 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ECEBC8AE;
        Wed,  1 Dec 2021 03:39:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638326386;
        bh=qsjoq1gfHMdS+0EpXveSjAj2n4SHM2OuNH/XEIDYpIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUmgiZ9z4gZI4x/U8uDs3Rd37tb2fk+nE+5RgamMJSg44bTVA9ry4fCB/JERld0hC
         RU/gl8uLb6BMsrhE7+O0pHynvxMc2yUIS8JeQJd4Zg8zJsPLPLg5TEUWzorxnuuPQw
         SQ/uGaK/ziv01XJzo1s9cjclLzi7psTharKivSb0=
Date:   Wed, 1 Dec 2021 04:39:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: uvcvideo: Avoid returning invalid controls
Message-ID: <YabgWHPxxtFfkDqh@pendragon.ideasonboard.com>
References: <20211130155026.1082594-1-ribalda@chromium.org>
 <20211130155026.1082594-2-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130155026.1082594-2-ribalda@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tue, Nov 30, 2021 at 03:50:26PM +0000, Ricardo Ribalda wrote:
> If the memory where ctrl_found is places has the value of uvc_ctrl and

s/places/placed/
s/uvc_ctrl/uvc_control/

> __uvc_find_control does not find the control we will return and invalid

s/and invalid/an invalid/

> index.

The change of this happening is small, but it exists.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Fixes: 6350d6a4ed487 ("media: uvcvideo: Set error_idx during ctrl_commit errors")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index f7b7add3cfa59..f1f6bb14fb0a6 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1639,7 +1639,7 @@ static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
>  				  struct uvc_control *uvc_control)
>  {
>  	struct uvc_control_mapping *mapping = NULL;
> -	struct uvc_control *ctrl_found;
> +	struct uvc_control *ctrl_found = NULL;
>  	unsigned int i;
>  
>  	if (!entity)

-- 
Regards,

Laurent Pinchart
