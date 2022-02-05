Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1894AAA2F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 17:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiBEQfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 11:35:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43136 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBEQfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:35:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D6BDB80837;
        Sat,  5 Feb 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CCDC340E8;
        Sat,  5 Feb 2022 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644078908;
        bh=pf+QDY5ILQrzr0TL1PIpiXAY5ACouBdzcFNWEsLc2nk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Up5qsBnP2IKd2Kuxb1kdb3h3Y75vHt97mP8aBVw1lrKJTvjnjOF8F/OHiBJEATlz7
         HyKCGytdtw1/rQg1yI47B8q83oa+MJPX8p9+g2jD70ZsFV6Egyw+I71m4G2y0+I2BW
         mrPsU3h3O5JomEqSc3v3jwFmULkOBBXdefg4gbd5EhZkhnTeyshC+bHH5HxMzeDDpT
         RO9PulMcCWQYsxmtgFQWvOfzYUyLFacDkdLhVRsPnRlTlkKzweSrbgVnb7SYzLZtKa
         d1mtoBeRinMDT/oHtMHueh08bHNFufKkeRh57I9buc1+tmxWjkfn91AljDLUSFnFd5
         AdjGjb+WmV0qw==
Date:   Sat, 5 Feb 2022 16:41:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 1/1] iio: dac: ad5592r: Drop leftover header
 inclusion
Message-ID: <20220205164139.7b1a12e3@jic23-huawei>
In-Reply-To: <20220203123354.76573-1-andriy.shevchenko@linux.intel.com>
References: <20220203123354.76573-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Feb 2022 14:33:54 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no use of of.h in the module, drop it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied,

Thanks,

J
> ---
>  drivers/iio/dac/ad5592r-base.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 2fcc59728fd6..a9c654b614a4 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -11,7 +11,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio/driver.h>

