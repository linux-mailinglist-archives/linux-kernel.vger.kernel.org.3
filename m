Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E254AAA88
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380692AbiBER0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:26:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51666 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbiBER0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:26:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E0E06114B;
        Sat,  5 Feb 2022 17:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7189AC340E8;
        Sat,  5 Feb 2022 17:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644081996;
        bh=xBg6p+jyAHkgQvWf4AtKVukClWBlzqLwABZqPxz13zU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ai6TBhpFQELlHrV8usLvRurmnnLM0gnWcse9jJFEtk/zyi7DgWuwJNMnMQbPe2jnk
         ut6dKihhEvaJFgz/LdqeTabPT/7F+5O5D356vBRwO8s2oDXuIQ2bdNz+iDi84Y5Rgn
         3T6Hi4MjOvaVv9fi8rb4n3/+LwTYOJfOW87ocXXpvcFI+2GERJGbwzW2pv/aB7yEtA
         CMUkfMVQXCyoYu7uAmn6b1SZNxjagi1KEhdhj+b2pv+sLg1Ti2t1gfDjkUc6q4TY9U
         CWwX9/HJ1tqBzkhUl29wOw1QjdBBxatxC/iSPRpZifC+Yayuyqu9i/3s6i7nLn/moP
         mTy6GbiI8dXhQ==
Date:   Sat, 5 Feb 2022 17:33:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: temperature: mlx90632: Switch from of
 headers to mod_devicetable.h
Message-ID: <20220205173306.474badd3@jic23-huawei>
In-Reply-To: <20220202205531.57966-1-andriy.shevchenko@linux.intel.com>
References: <20220202205531.57966-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Feb 2022 22:55:31 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is nothing directly using of specific interfaces in this driver,
> so lets not include the headers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied

Thanks,

> ---
>  drivers/iio/temperature/mlx90632.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 608ccb1d8bc8..7ee7ff8047a4 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -13,9 +13,9 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/math64.h>
> -#include <linux/of.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  

