Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E717A55B479
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiFZXcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 19:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiFZXco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 19:32:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3672BEC;
        Sun, 26 Jun 2022 16:32:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EF44C47C;
        Mon, 27 Jun 2022 01:32:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1656286362;
        bh=mf04BO1qSQaOvy22fBoJ2iokU5ZzrFY1ylZMqc/12T8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2FEhP4ItuGMiJEABMqL16fngg9viF0DD6QgcFqW/3QV+UUqxwzWsW4QpANr8HcU2
         QEwyMIp24n9o1Lw7Y/Vp9oygBRp8rTuDfpw/+QgELpEgglf71mneUoMc5e6qCBGKSB
         iGZxWRLqYQugxnBXRbJp86B4yS3P4bk6V/CK2jS4=
Date:   Mon, 27 Jun 2022 02:32:24 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     mchehab@kernel.org, hyun.kwon@xilinx.com, michal.simek@xilinx.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: xilinx: drop unexpected word 'with' in comments
Message-ID: <YrjsiEgcNWTFFkUc@pendragon.ideasonboard.com>
References: <20220623122948.54839-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220623122948.54839-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiang,

Thank you for the patch.

On Thu, Jun 23, 2022 at 08:29:48PM +0800, Jiang Jian wrote:
> there is an unexpected word 'with' in the comments that need to be dropped
> 
> file - drivers/media/platform/xilinx/xilinx-vip.h
> line -31
> 
>  * Pad IDs. IP cores with with multiple inputs or outputs should define
> 
> changed to:
> 
>  * Pad IDs. IP cores with multiple inputs or outputs should define

The first line of the commit message is enough, the rest duplicates the
content of the patch. No need to resubmit, I'll fix this when applying.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/media/platform/xilinx/xilinx-vip.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/xilinx/xilinx-vip.h b/drivers/media/platform/xilinx/xilinx-vip.h
> index d0b0e0600952..1c8dd59067fe 100644
> --- a/drivers/media/platform/xilinx/xilinx-vip.h
> +++ b/drivers/media/platform/xilinx/xilinx-vip.h
> @@ -28,7 +28,7 @@ struct clk;
>  #define XVIP_MAX_HEIGHT			7680
>  
>  /*
> - * Pad IDs. IP cores with with multiple inputs or outputs should define
> + * Pad IDs. IP cores with multiple inputs or outputs should define
>   * their own values.
>   */
>  #define XVIP_PAD_SINK			0

-- 
Regards,

Laurent Pinchart
