Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66859ADC1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345985AbiHTMAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbiHTMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:00:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F2A3471;
        Sat, 20 Aug 2022 05:00:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39558B80B3B;
        Sat, 20 Aug 2022 11:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846CDC433D6;
        Sat, 20 Aug 2022 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660996797;
        bh=4c9RQckvVtKbqA8jOKUWqxYkOUjptVub6flApRLoGpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oSGlIeXi0ciEQk4/SwDPbuyDW72z+R1sDceNpL1yKRIc7xv840/a3psLykf4nwgtS
         wJP/Gbj6wSrDdzPlmqq+ko9FmJvHihoMZpnbcS8V4aO5PPjlv3jwV36WJH5x/Afa2W
         nn6L19X8U/0M3fyP6cNdeeYIr0I9ul88wqTtP2husI6bOcSSqbxVo76+lIoSIIlhAT
         0fWT76jNM+aoZ1DgmCUfZ6lvIStjZvFYtKO9Alpvt36qmP8VLiU/MlwZlapXRB6Xhg
         PcW3thz7O5+IjYPfrefx4dh4yYosymy1xvKW0MwQItfbQgde8+TaMumvjPrM9/jfvS
         rAz+HObnrJn3A==
Date:   Sat, 20 Aug 2022 13:10:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frede@cmslaser.com
Subject: Re: [PATCH] iio: stx104: Move to addac subdirectory
Message-ID: <20220820131033.038be32e@jic23-huawei>
In-Reply-To: <20220815222921.138945-1-william.gray@linaro.org>
References: <20220815222921.138945-1-william.gray@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 15 Aug 2022 18:29:21 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> The stx104 driver supports both ADC and DAC functionality.
> 
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

I don't care enough to audit all drivers and move them, but I'm
fine with individual driver maintainers deciding they should be
in a different category.

Applied.

Thanks,

> ---
>  MAINTAINERS                         |  2 +-
>  drivers/iio/adc/Kconfig             | 16 ----------------
>  drivers/iio/adc/Makefile            |  1 -
>  drivers/iio/addac/Kconfig           | 16 ++++++++++++++++
>  drivers/iio/addac/Makefile          |  1 +
>  drivers/iio/{adc => addac}/stx104.c |  0
>  6 files changed, 18 insertions(+), 18 deletions(-)
>  rename drivers/iio/{adc => addac}/stx104.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8b6544ba27c..f4ef070f474a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1382,7 +1382,7 @@ APEX EMBEDDED SYSTEMS STX104 IIO DRIVER
>  M:	William Breathitt Gray <william.gray@linaro.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	drivers/iio/adc/stx104.c
> +F:	drivers/iio/addac/stx104.c
>  
>  APM DRIVER
>  M:	Jiri Kosina <jikos@kernel.org>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 5a3e8d9ae26c..e3c2881ed23a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1037,22 +1037,6 @@ config STMPE_ADC
>  	  Say yes here to build support for ST Microelectronics STMPE
>  	  built-in ADC block (stmpe811).
>  
> -config STX104
> -	tristate "Apex Embedded Systems STX104 driver"
> -	depends on PC104 && X86
> -	select ISA_BUS_API
> -	select GPIOLIB
> -	help
> -	  Say yes here to build support for the Apex Embedded Systems STX104
> -	  integrated analog PC/104 card.
> -
> -	  This driver supports the 16 channels of single-ended (8 channels of
> -	  differential) analog inputs, 2 channels of analog output, 4 digital
> -	  inputs, and 4 digital outputs provided by the STX104.
> -
> -	  The base port addresses for the devices may be configured via the base
> -	  array module parameter.
> -
>  config SUN4I_GPADC
>  	tristate "Support for the Allwinner SoCs GPADC"
>  	depends on IIO
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index c1a861a978ad..ab084094263b 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -89,7 +89,6 @@ obj-$(CONFIG_RICHTEK_RTQ6056) += rtq6056.o
>  obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
>  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
> -obj-$(CONFIG_STX104) += stx104.o
>  obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
>  obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
> diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
> index 138492362f20..fcf6d2269bfc 100644
> --- a/drivers/iio/addac/Kconfig
> +++ b/drivers/iio/addac/Kconfig
> @@ -17,4 +17,20 @@ config AD74413R
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad74413r.
>  
> +config STX104
> +	tristate "Apex Embedded Systems STX104 driver"
> +	depends on PC104 && X86
> +	select ISA_BUS_API
> +	select GPIOLIB
> +	help
> +	  Say yes here to build support for the Apex Embedded Systems STX104
> +	  integrated analog PC/104 card.
> +
> +	  This driver supports the 16 channels of single-ended (8 channels of
> +	  differential) analog inputs, 2 channels of analog output, 4 digital
> +	  inputs, and 4 digital outputs provided by the STX104.
> +
> +	  The base port addresses for the devices may be configured via the base
> +	  array module parameter.
> +
>  endmenu
> diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
> index cfd4bbe64ad3..17de20ef0d8e 100644
> --- a/drivers/iio/addac/Makefile
> +++ b/drivers/iio/addac/Makefile
> @@ -5,3 +5,4 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD74413R) += ad74413r.o
> +obj-$(CONFIG_STX104) += stx104.o
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/addac/stx104.c
> similarity index 100%
> rename from drivers/iio/adc/stx104.c
> rename to drivers/iio/addac/stx104.c
> 
> base-commit: b82217e73b5aa6db8453ad91b929ca2366e47184

