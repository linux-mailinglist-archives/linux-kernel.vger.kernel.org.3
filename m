Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF4586190
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbiGaVk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 17:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiGaVk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 17:40:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1A6410;
        Sun, 31 Jul 2022 14:40:25 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A43C0415;
        Sun, 31 Jul 2022 23:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659303623;
        bh=97FHXxocgYc7SAGP4w3juXWQhbadxWYjWPVgSTocU8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKkDwYbR/7NE9aXrONa1+kbmGcIrzk5Xx+0gg9Qpv6nDChsXG49A22jEo08JlmXYY
         xWUiFbFa7pbr0Px563FMmp9rvOvQPUWv4AgHu6oorCCwdk2lVL5Sm3jrNoV5GllVQH
         CG9zj4TF0YFTIOxK6op5D8Swe611zIzpZBkYv8pg=
Date:   Mon, 1 Aug 2022 00:40:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     prabhakar.csengg@gmail.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: platform: ti: Fix typo 'the the' in comment
Message-ID: <Yub2w2GvCqgDI3w3@pendragon.ideasonboard.com>
References: <20220722063341.69913-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220722063341.69913-1-slark_xiao@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Slark,

Thank you for the patch.

On Fri, Jul 22, 2022 at 02:33:41PM +0800, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/ti/davinci/vpbe.c | 2 +-
>  drivers/media/platform/ti/omap3isp/isp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/ti/davinci/vpbe.c b/drivers/media/platform/ti/davinci/vpbe.c
> index 5f0aeb744e81..509ecc84624e 100644
> --- a/drivers/media/platform/ti/davinci/vpbe.c
> +++ b/drivers/media/platform/ti/davinci/vpbe.c
> @@ -280,7 +280,7 @@ static int vpbe_set_default_output(struct vpbe_device *vpbe_dev)
>   * vpbe_get_output - Get output
>   * @vpbe_dev: vpbe device ptr
>   *
> - * return current vpbe output to the the index
> + * return current vpbe output to the index
>   */
>  static unsigned int vpbe_get_output(struct vpbe_device *vpbe_dev)
>  {
> diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
> index 4c937f3f323e..f99dda7337b9 100644
> --- a/drivers/media/platform/ti/omap3isp/isp.c
> +++ b/drivers/media/platform/ti/omap3isp/isp.c
> @@ -1528,7 +1528,7 @@ void omap3isp_print_status(struct isp_device *isp)
>   * To solve this problem power management support is split into prepare/complete
>   * and suspend/resume operations. The pipelines are stopped in prepare() and the
>   * ISP clocks get disabled in suspend(). Similarly, the clocks are re-enabled in
> - * resume(), and the the pipelines are restarted in complete().
> + * resume(), and the pipelines are restarted in complete().
>   *
>   * TODO: PM dependencies between the ISP and sensors are not modelled explicitly
>   * yet.

-- 
Regards,

Laurent Pinchart
