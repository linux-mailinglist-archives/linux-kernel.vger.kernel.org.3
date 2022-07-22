Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D019057DA8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiGVHB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:01:23 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6E317E33;
        Fri, 22 Jul 2022 00:01:21 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 5B458E0008;
        Fri, 22 Jul 2022 07:01:18 +0000 (UTC)
Date:   Fri, 22 Jul 2022 09:01:16 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: mt9v111: Fix typo 'the the' in comment
Message-ID: <20220722070116.ibqjejnttr55ciwh@uno.localdomain>
References: <20220722015211.63609-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220722015211.63609-1-slark_xiao@163.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Slark Xiao

On Fri, Jul 22, 2022 at 09:52:11AM +0800, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Thanks

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

> ---
>  drivers/media/i2c/mt9v111.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
> index 2dc4a0f24ce8..7beca0b70b72 100644
> --- a/drivers/media/i2c/mt9v111.c
> +++ b/drivers/media/i2c/mt9v111.c
> @@ -633,7 +633,7 @@ static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
>
>  	/*
>  	 * Set pixel integration time to the whole frame time.
> -	 * This value controls the the shutter delay when running with AE
> +	 * This value controls the shutter delay when running with AE
>  	 * disabled. If longer than frame time, it affects the output
>  	 * frame rate.
>  	 */
> --
> 2.25.1
>
