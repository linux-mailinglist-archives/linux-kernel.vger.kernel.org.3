Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA821503604
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiDPKwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiDPKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3E42BB1D;
        Sat, 16 Apr 2022 03:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20A6660EAE;
        Sat, 16 Apr 2022 10:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABC0C385A1;
        Sat, 16 Apr 2022 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650106194;
        bh=oDLCkMRADmxDo95yvxm8tNKdm75FXfwgQkqsx2TCL00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U2fwCsFo5VJ3faDVnD0m9dRaXk+L17nVWOIvSRBsd9JjRASoTvs9XOmZbNGhyfgDQ
         Q+VFgY/LiBuCj5JIJZZQkyd+1AyCLz31t3KchGf6WbYtHmd00DtYauaKDUayGlIxwB
         moxbim8Vh1cGspw4Xka15jhFmnqv4H8j3vnLxjwKPL/UBnoFmmGnM3ELaw4lAAR43S
         yW5TxKKHNCgD9HB7f8zMgZqIBYGSYyPm3a2zTmaWs6BLLYhdZCm8JiWv0+8usAJd+c
         QqnNReWpp9+VlBTKj+slBPsG1EqhsXBUKtmU4QUCn6I3bosTGHkcCmA3LamvUmwBLY
         Kmp10pliSfm8w==
Date:   Sat, 16 Apr 2022 11:57:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: magnetometer: ak8974: Drop dependency on OF
Message-ID: <20220416115752.50bed492@jic23-huawei>
In-Reply-To: <20220413184502.20998-1-andriy.shevchenko@linux.intel.com>
References: <20220413184502.20998-1-andriy.shevchenko@linux.intel.com>
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

On Wed, 13 Apr 2022 21:45:02 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Nothing in this driver depends on OF firmware so drop the dependency
> and update the headers to remove the false impression such a dependency
> exists.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied with description amended to not mention headers.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 54445365c4bc..07eb619bcfe8 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -9,7 +9,6 @@ menu "Magnetometer sensors"
>  config AK8974
>  	tristate "Asahi Kasei AK8974 3-Axis Magnetometer"
>  	depends on I2C
> -	depends on OF
>  	select REGMAP_I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER

