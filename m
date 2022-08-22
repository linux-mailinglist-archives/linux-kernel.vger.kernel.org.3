Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8034159B9CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiHVGtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiHVGtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:49:00 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE251902C;
        Sun, 21 Aug 2022 23:48:56 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 7C40AFF804;
        Mon, 22 Aug 2022 06:48:53 +0000 (UTC)
Date:   Mon, 22 Aug 2022 08:48:51 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/renesas: fix repeated words in comments
Message-ID: <20220822064851.hkspsfw47etr4ovq@uno.localdomain>
References: <20220821145435.49842-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220821145435.49842-1-wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello wangjianli

On Sun, Aug 21, 2022 at 10:54:35PM +0800, wangjianli wrote:
>  Delete the redundant word 'on'.
 ^ unecessary space, can be fixed when applying maybe ?

>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Is this your full name ? Should it be spelled with spaces ?
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

I'm sorry to ask, but I'm actually not sure if the signature here
counts as your full name or not

The patch is obviously fine
Acked-by: Jacopo Mondi <jacopo@jmondi.org>


> ---
>  drivers/media/platform/renesas/renesas-ceu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/renesas/renesas-ceu.c b/drivers/media/platform/renesas/renesas-ceu.c
> index f70f91b006b7..69723b51e4dc 100644
> --- a/drivers/media/platform/renesas/renesas-ceu.c
> +++ b/drivers/media/platform/renesas/renesas-ceu.c
> @@ -1101,7 +1101,7 @@ static int ceu_open(struct file *file)
>  		return ret;
>
>  	mutex_lock(&ceudev->mlock);
> -	/* Causes soft-reset and sensor power on on first open */
> +	/* Causes soft-reset and sensor power on first open */
>  	ret = pm_runtime_resume_and_get(ceudev->dev);
>  	mutex_unlock(&ceudev->mlock);
>
> --
> 2.36.1
>
