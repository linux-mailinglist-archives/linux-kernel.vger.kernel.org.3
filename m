Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E64DA59C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349665AbiCOWsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244890AbiCOWsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:48:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C9013F1C;
        Tue, 15 Mar 2022 15:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82E64B818FA;
        Tue, 15 Mar 2022 22:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFD8C340E8;
        Tue, 15 Mar 2022 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647384409;
        bh=N9lCbpEw1q3lRoy24tF2qlRq74xnf7ooDJWrMeDL1EY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0NnX8+TBBskcnwrMyXlYjeOCzaFo6VRENFxN4FfJ0dTLKxA7lZm84tm805j+Df37
         NanO9ZYi8lQ0JIPwcsco+QV72L2TRZkis9Ut+dL5tr0GzhUd4qrl4p4fK2UmHZvvoW
         i4sqEjIeZnrV23YLjRhlW1Fh0ygPLVbnlOltyBBX0OL6Ss4AUsocmhd6LYDNQ0GFH6
         fN8AJOTJyc9tPrc3mjxQ5mIvgHekuvrLxJCJtpx7CL8CIm7UPdQF4jwI1NmuzwJ+zz
         hl2jbd8VX9k6RXAGpGCOMxfLKczz5FBK8cXma3rk449E+tNa+GMHakVsbIi6WET5vm
         qXRr5nmARyhYQ==
Received: by pali.im (Postfix)
        id 0795E824; Tue, 15 Mar 2022 23:46:45 +0100 (CET)
Date:   Tue, 15 Mar 2022 23:46:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq2415x: Fix spelling mistake "vender" ->
 "vendor"
Message-ID: <20220315224645.ytcf7y7awc3q2y6j@pali>
References: <20220315223700.2961660-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315223700.2961660-1-colin.i.king@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 March 2022 22:37:00 Colin Ian King wrote:
> There are several spelling mistakes in comments, function names
> and literal strings. Fix these.

I do not think that there are mistakes.

Please look at page 29 of the official bq24150 datasheet:
https://www.ti.com/lit/ds/symlink/bq24150.pdf

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/power/supply/bq2415x_charger.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
> index 5724001e66b9..b35700071966 100644
> --- a/drivers/power/supply/bq2415x_charger.c
> +++ b/drivers/power/supply/bq2415x_charger.c
> @@ -71,7 +71,7 @@
>  #define BQ2415X_BIT_OTG_PL		1
>  #define BQ2415X_BIT_OTG_EN		0
>  
> -/* vender register */
> +/* vendor register */
>  #define BQ2415X_MASK_VENDER		(BIT(5)|BIT(6)|BIT(7))
>  #define BQ2415X_SHIFT_VENDER		5
>  #define BQ2415X_MASK_PN			(BIT(3)|BIT(4))
> @@ -491,8 +491,8 @@ static int bq2415x_detect_revision(struct bq2415x_device *bq)
>  	return -1;
>  }
>  
> -/* return chip vender code */
> -static int bq2415x_get_vender_code(struct bq2415x_device *bq)
> +/* return chip vendor code */
> +static int bq2415x_get_vendor_code(struct bq2415x_device *bq)
>  {
>  	int ret;
>  
> @@ -1501,9 +1501,9 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
>  		sprintf(revstr, "1.%d", ret);
>  
>  	bq->model = kasprintf(GFP_KERNEL,
> -				"chip %s, revision %s, vender code %.3d",
> +				"chip %s, revision %s, vendor code %.3d",
>  				bq2415x_chip_name[chip], revstr,
> -				bq2415x_get_vender_code(bq));
> +				bq2415x_get_vendor_code(bq));
>  	if (!bq->model) {
>  		dev_err(bq->dev, "failed to allocate model name\n");
>  		return -ENOMEM;
> -- 
> 2.35.1
> 
