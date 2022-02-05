Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957E74AAA39
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380448AbiBEQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 11:42:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45634 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiBEQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:42:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EF68B80B6D;
        Sat,  5 Feb 2022 16:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9993DC340E8;
        Sat,  5 Feb 2022 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644079335;
        bh=F1ISGTsMVFiiRSacnPaEAULWFninCxx3j5837YdbfUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OrKd9n5jRTxthiwYiUbnFn/VHdq0K+46VFctXLpRRSgqtkbhR3gJWV5npZwNgJlfL
         RoWNqcXJDyO1x9P9hkYD34ZiSIb2w0pDxljSVjJB60qcfr+txlz0/+VLk2/HeRxUcR
         afHTA4RQs4kc7rPVWhiqMTk6PdBhsrVdnuJuw+B8BwQQtIZt9y+vjiKaIoEsXtO7CQ
         FlI5e4plvMICAhM0VQOtD9ccB7poV3/E2uzVPZVhKBTQrDy4JsG+WmOG0s2jRm+Pc2
         6Ce9Yr7ZZ5bs1WxzWG8kh5ks27r2KQmq/69mCvBPdHPBaogIbBvvn+X6A2jWuL2Vi7
         jByjwM2DXYDNA==
Date:   Sat, 5 Feb 2022 16:48:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: chemical: bme680: Switch from of headers to
 mod_devicetable.h
Message-ID: <20220205164846.72a1868e@jic23-huawei>
In-Reply-To: <20220203122725.75939-1-andriy.shevchenko@linux.intel.com>
References: <20220203122725.75939-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Feb 2022 14:27:25 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is nothing directly using of specific interfaces in this driver,
> so lets not include the headers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/bme680_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
> index cc579a7ac5ce..0a064a395178 100644
> --- a/drivers/iio/chemical/bme680_spi.c
> +++ b/drivers/iio/chemical/bme680_spi.c
> @@ -4,8 +4,8 @@
>   *
>   * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
>   */
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  

