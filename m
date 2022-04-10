Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271604FAF00
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243652AbiDJQlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238345AbiDJQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537014B1DE;
        Sun, 10 Apr 2022 09:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAC0361126;
        Sun, 10 Apr 2022 16:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A94C385A1;
        Sun, 10 Apr 2022 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649608763;
        bh=le7VTby28qDZRTdyYn91f4YnkwNsrt1b0tZymqNAtBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BzOuwwF0VJy7xH/UQfMvxKQn+DEMQZEYL98Dv2vy5QrzZCpc7rzPjO1TZyN2mts7x
         uympxRBYpJLkUYc9lPIlUUiNYqzyhulVOW0UYfRPQYVSU8b1hoEOf5hlqyQ4cRwbbl
         uzf/0dslp6rlVsUfi6t3mmT09HTbExwLQVelsQ85btyHfjUFKfULiOZBSZRJPXaLlq
         dsB6TCusSMPcMAMU1g/6/28tyO8e+LPxyRGTkOkOSfwPw3K/CMd++iwgus4VG8vylO
         1dBaVHJDoUSo3uDshbUQExSy1BVesvV94h0n6JaT5g9eOctsNWiDkHI70WyOz2tndE
         /prqDv1SXEkwg==
Date:   Sun, 10 Apr 2022 17:47:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] iio: adc: Kconfig: Make RZG2L_ADC depend on ARCH_RZG2L
Message-ID: <20220410174713.1a4e013f@jic23-huawei>
In-Reply-To: <20220406070315.13862-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220406070315.13862-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Wed,  6 Apr 2022 08:03:15 +0100
Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> ADC block is common on Renesas RZ/G2L and RZ/V2L SoC's, so instead of
> adding dependency for each SoC's add dependency on ARCH_RZG2L. The
> ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
> ARCH_R9A07G054.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Sounds like a fix?

If so, please supply a Fixes tag.
no need to resend, just reply with one to this email.

thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 71ab0a06aa82..48ace7412874 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -910,7 +910,7 @@ config ROCKCHIP_SARADC
>  
>  config RZG2L_ADC
>  	tristate "Renesas RZ/G2L ADC driver"
> -	depends on ARCH_R9A07G044 || COMPILE_TEST
> +	depends on ARCH_RZG2L || COMPILE_TEST
>  	help
>  	  Say yes here to build support for the ADC found in Renesas
>  	  RZ/G2L family.

