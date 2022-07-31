Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF71585E9B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiGaLUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiGaLUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:20:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B7D6428;
        Sun, 31 Jul 2022 04:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE122B80D1D;
        Sun, 31 Jul 2022 11:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B511C433D6;
        Sun, 31 Jul 2022 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659266427;
        bh=K8XMnjLrVWD4hf/TSjDR6ccL8BtOsnjvFMSZEJF/67Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lzL//zYodUHTGytXfvrpXUiDMZwS+emJlOHZ4IOBNn+zzSEpUy72POGAFWXIPXvgF
         wGTNtID6YSbV4AW9KfkTx6Qs444rLO3VjwWoA9X0140p8P0bLVTiRl2iOiAqWtbJoG
         cO3M9fApNzmD7qJKBpyQBF1gVT1SQuvJOwY0FQONvyi390ZzXEHaJ/KilrYpdrc0Zf
         71HKqsYDKClaaK5kakwGNzKl3RmB3yIPDRbFkBJOoWF0/64CmN8dlf2kNYAGdMC15Y
         N1AALLfxbOgc/UHEP1ajEu+FZA7HkqoMSqOvzab+LpQUPzsZ716MKNIjUeYNiMJxLq
         JP1Dno34aCuGg==
Date:   Sun, 31 Jul 2022 12:30:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Use parens with sizeof
Message-ID: <20220731123039.600347b0@jic23-huawei>
In-Reply-To: <20220717153438.10800-1-joetalbott@gmail.com>
References: <20220717153438.10800-1-joetalbott@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2022 11:34:38 -0400
Joe Simmons-Talbott <joetalbott@gmail.com> wrote:

> Prefer 'sizeof(var)' over 'sizeof var' as reported by checkpatch.pl.
> 
> Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
to let 0-day take a poke at it.

oops. Email got stuck in my outbox when I went away for a week.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-trigger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index f504ed351b3e..88bccb0676c8 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -368,7 +368,7 @@ struct iio_poll_func
>  	va_list vargs;
>  	struct iio_poll_func *pf;
>  
> -	pf = kmalloc(sizeof *pf, GFP_KERNEL);
> +	pf = kmalloc(sizeof(*pf), GFP_KERNEL);
>  	if (pf == NULL)
>  		return NULL;
>  	va_start(vargs, fmt);
> @@ -560,7 +560,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  	struct iio_trigger *trig;
>  	int i;
>  
> -	trig = kzalloc(sizeof *trig, GFP_KERNEL);
> +	trig = kzalloc(sizeof(*trig), GFP_KERNEL);
>  	if (!trig)
>  		return NULL;
>  

