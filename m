Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD8F59FC67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbiHXN4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiHXNzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:55:44 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6C62A8A;
        Wed, 24 Aug 2022 06:54:36 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id EA7B61C0003;
        Wed, 24 Aug 2022 13:54:34 +0000 (UTC)
Date:   Wed, 24 Aug 2022 15:54:33 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media/i2c: fix repeated words in comments
Message-ID: <20220824135433.h2udwtnub7mlmtam@uno.localdomain>
References: <20220824131459.52485-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220824131459.52485-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jilin

On Wed, Aug 24, 2022 at 09:14:59PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'the'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Already addressed by
https://patchwork.kernel.org/project/linux-media/patch/20220722015211.63609-1-slark_xiao@163.com/

I wonder what's happening... This is the 3rd if not 4th identical
patch I receive for this issue.

Are you sending this patch as part of a new contributors program like
outreachy or similar ? If that's the case I would like to ask mentors
to require contributors to check patchwork/lore before sending a
patch. I'm reading a lot of "thanks but it's already fixed" replies on
the media list these days..

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
> 2.36.1
>
