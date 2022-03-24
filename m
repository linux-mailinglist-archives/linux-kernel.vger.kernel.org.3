Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1B4E6458
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiCXNtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350578AbiCXNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEAFA76D5;
        Thu, 24 Mar 2022 06:47:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EF4CE1844;
        Thu, 24 Mar 2022 14:47:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1648129632;
        bh=ZDQwLhHu9BX68dgyTsaT+mwfT2zruz8G3u6J4r3K2cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOB/AXJeO0XDd1dbpV8yE2I/UDw7fvyj9pThOryRP95pOQJptGoq4cfKT9TzNH4Gy
         snKcBnGlYp5t1VbG6TNWR6JlO55OQ028KDgocLWnDetbzxbWz9PmawS/rVr9RzS1uY
         aH5nipf1D78Ldh1toCPcmTyngw2R4vndfNSvCVRA=
Date:   Thu, 24 Mar 2022 15:47:10 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     sakari.ailus@linux.intel.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mc: delete redundant code in
 __media_device_unregister_entity
Message-ID: <Yjx2Xm7JmS+E8d7M@pendragon.ideasonboard.com>
References: <20220324102752.47077-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324102752.47077-1-hbh25y@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hangyu,

Thank you for the patch.

On Thu, Mar 24, 2022 at 06:27:52PM +0800, Hangyu Hua wrote:
> media_gobj_destroy has already set graph_obj.mdev to NULL. There is no need to
> set it again.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/mc/mc-device.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
> index cf5e459b1d96..7727c619043e 100644
> --- a/drivers/media/mc/mc-device.c
> +++ b/drivers/media/mc/mc-device.c
> @@ -605,7 +605,6 @@ static void __media_device_unregister_entity(struct media_entity *entity)
>  
>  	/* invoke entity_notify callbacks to handle entity removal?? */
>  
> -	entity->graph_obj.mdev = NULL;
>  }
>  
>  /**

-- 
Regards,

Laurent Pinchart
