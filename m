Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE504E1BD6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 14:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245138AbiCTNVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 09:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiCTNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:21:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813333D1C7;
        Sun, 20 Mar 2022 06:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20D05B80E66;
        Sun, 20 Mar 2022 13:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718DCC340E9;
        Sun, 20 Mar 2022 13:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647782382;
        bh=SCGdKUEDkIMap61ZmLEGQ7FDg23JeKgWxqSZvQCp27A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T89lYZFv94rarsxQmg+CEwLkcFfJa4MaI6lxYG1kUlIBy6Tey0mz4hiLpjfHxm95g
         VKxSfKLCwVDBzmUkoLdO7cyhjN06nUrWOCLrFYGC3SySmDl9M30J7RDyD43zJgkQ+C
         DgetlioF2m+ueQZQQ0qV20etsgQFt0Xs5j45r1qE3iGauzcU6cFIIhUcV496dFeKDp
         PGr2K2aHtrP5hUSaBgNAh62tNyLiWPruc8lqgp0HPTNzR8f238a9u7Z+iJrtGVcROz
         ZQUvnKwyHtVPCaC9eHCoyliliKdPtyFFHJByRYiEa3HFabP6IDdiK9WaNx7e5bAIuU
         sI4pT117LvvCA==
Date:   Sun, 20 Mar 2022 13:27:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: fix a few code style issues
Message-ID: <20220320132707.44d2a48a@jic23-huawei>
In-Reply-To: <20220312180343.8935-1-alexander.vorwerk@stud.uni-goettingen.de>
References: <20220312180343.8935-1-alexander.vorwerk@stud.uni-goettingen.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2022 19:03:43 +0100
Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de> wrote:

> * Fix indent in else statement
> * Remove unnecessary 'else' after 'break'
> * Remove space in '* attr'
> 
> Signed-off-by: Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>

Applied to the togreg branch of iio.git and pushed out as testing to let the
autobuilders see if they can find any problems.

Note that I'll be rebasing the tree after rc1.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 4 ++--
>  drivers/iio/industrialio-core.c   | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 208b5193c621..15c5405853d7 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -915,7 +915,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  		if (scan_mask == NULL)
>  			return -EINVAL;
>  	} else {
> -	    scan_mask = compound_mask;
> +		scan_mask = compound_mask;
>  	}
>  
>  	config->scan_bytes = iio_compute_scan_bytes(indio_dev,
> @@ -1649,7 +1649,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  	}
>  
>  	attrn = buffer_attrcount + scan_el_attrcount + ARRAY_SIZE(iio_buffer_attrs);
> -	attr = kcalloc(attrn + 1, sizeof(* attr), GFP_KERNEL);
> +	attr = kcalloc(attrn + 1, sizeof(*attr), GFP_KERNEL);
>  	if (!attr) {
>  		ret = -ENOMEM;
>  		goto error_free_scan_mask;
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 409c278a4c2c..346c8fbf18a4 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -892,8 +892,7 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
>  		} else if (*str == '\n') {
>  			if (*(str + 1) == '\0')
>  				break;
> -			else
> -				return -EINVAL;
> +			return -EINVAL;
>  		} else if (!strncmp(str, " dB", sizeof(" dB") - 1) && scale_db) {
>  			/* Ignore the dB suffix */
>  			str += sizeof(" dB") - 1;

