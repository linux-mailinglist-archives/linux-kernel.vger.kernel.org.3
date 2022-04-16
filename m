Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EB65035F4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiDPKaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPKat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:30:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D99D419A7;
        Sat, 16 Apr 2022 03:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A42B81D0A;
        Sat, 16 Apr 2022 10:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A924C385A3;
        Sat, 16 Apr 2022 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650104896;
        bh=xA0Gm6xPW9sfLsGyMDopDPut4JiQe0nUfaa/4vSv7EY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kBNFeAcHdkN2OG3bgcDWZy4juQUpD+uHb6jyRZm9DiFR1lpFWmUGhygwKtvt4QL7Q
         5P9hFuBvh9GKjIcltFuDD+tsoGZHWdEGCZXEY1dIRzeRrwuMWjOOZO9GNy6OLfl/XM
         NHkkiEHgHkwsMNqFVB4wZUdbTNPR9Cgvh77dxoRYtEROVJmaj7+sXZ5YAav+V0LC/L
         PGeKtPyGiRovV6qnFDGA92ZV90ML+PrwyTBlT8p9VELjt81JJi2aVDMy5QRYwIIpM1
         yYY3yd606nTfdmNvgmkBP1MLdPP2gdPgJmKsXbif+9LCqEC6SKc7KT1Qq5hZV1Lj6x
         u3Hwq4pwvLUDQ==
Date:   Sat, 16 Apr 2022 11:36:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 1/1] iio: dac: dpot: Drop dependency on OF
Message-ID: <20220416113612.7272f5db@jic23-huawei>
In-Reply-To: <20220413190632.30365-1-andriy.shevchenko@linux.intel.com>
References: <20220413190632.30365-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 22:06:32 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Nothing in this driver depends on OF firmware so drop the dependency
> and update the headers to remove the false impression such a dependency
> exists.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+CC Peter.

Given it's looks obviously correct applied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index c0bf0d84197f..8d5b3bad75ad 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -285,7 +285,6 @@ config CIO_DAC
>  
>  config DPOT_DAC
>  	tristate "DAC emulation using a DPOT"
> -	depends on OF
>  	help
>  	  Say yes here to build support for DAC emulation using a digital
>  	  potentiometer.

