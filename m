Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6E4AAA8B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380702AbiBER1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:27:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52360 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbiBER1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:27:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5B36114D;
        Sat,  5 Feb 2022 17:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33E6C340E8;
        Sat,  5 Feb 2022 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644082072;
        bh=mJwGNW5EUMf3hjVlJ0ExsLkB/eSlL0cslnX7MOJNZbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ktkAPNBAPnFOq2np6P731gOaBTa70ze3Q2T9QGyWQvfqhfZ8nir6KxCw0V61sGfRd
         TOYxBCnu/ek9uX3ggwbcF4s8nrG1Vzs3PHuYXE1lkYTYyhK2wgcU2U52tiDHKE8gc6
         Pizbjamr7l7nvpt7c3xFHNToVOkPv1Grx8BurYqI+nchc0bluCaMUbGKdnY2sbl/CJ
         FYnLCUi9rHF+p2Y9GsNdXLf8VsrcSjJDATYxeEhgcLho6YIbsYVxYG08FzGEoI7Qvj
         AouRDhBR4SByh4rlYX4Ylvtc9Klbq3f1HXNljYXWW/FOtjDM/jIgHFaHuZSbALqoz+
         fCXLiHw6SXPgg==
Date:   Sat, 5 Feb 2022 17:34:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: temperature: maxim_thermocouple: Switch
 from of headers to mod_devicetable.h
Message-ID: <20220205173423.44834f4d@jic23-huawei>
In-Reply-To: <20220202205328.57837-1-andriy.shevchenko@linux.intel.com>
References: <20220202205328.57837-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Feb 2022 22:53:28 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is nothing directly using of specific interfaces in this driver,
> so lets not include the headers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied,

Thanks,

J
> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index 0297e215b61a..98c41cddc6f0 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -6,12 +6,11 @@
>   * Author: <matt.ranostay@konsulko.com>
>   */
>  
> -#include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/err.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

