Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F47750D3A2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiDXQzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiDXQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC1326AC3;
        Sun, 24 Apr 2022 09:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF02D611B0;
        Sun, 24 Apr 2022 16:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8449C385A9;
        Sun, 24 Apr 2022 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650819116;
        bh=uUHvuDaxzupiV8CC0mle1UJqoM5VjVDjqLLXQIQ5as4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fv600yzwpAsgJRpbJAoJvJRVOf9W770gho10mrJUhiFu/8aCuB8TxY5Mo6gPbFTKm
         ETA6ejRgPeYEOSs5OWndpa4QI7Ixy2ObWp60mNAi+At+LrD5dyNeMJXreKgzu7UHOa
         bovMdW4YIqq2e5D7jJimOEwXbdeBS1Rsib9aZlv4aboR/O8Cw6cfNT6bOR0QikktDe
         8gwA3eNib1B2oZ0QNprPfNH7gAL4ja1q6fRh/Q6iLvClKdUZq/MTMQr3HKJBxrYA+i
         Vr5yaYxbzoWcJ5lIqaeURZweokBEdxCrcCrRqd2xBI6+XtDTbGVrPnF+fRwQDGSoU7
         6DScuEWJACXwA==
Date:   Sun, 24 Apr 2022 18:00:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/7] iio: adc: sc27xx: fix read big scale voltage not
 right
Message-ID: <20220424180002.2d5d893b@jic23-huawei>
In-Reply-To: <20220419142458.884933-3-gengcixi@gmail.com>
References: <20220419142458.884933-1-gengcixi@gmail.com>
        <20220419142458.884933-3-gengcixi@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Tue, 19 Apr 2022 22:24:53 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
> SC27XX_ADC_SCALE_SHIFT by spec documetation.
> Fixes: 5df362a6cf49c (iio: adc: Add Spreadtrum SC27XX PMICs ADC support)
No blank line here.  Fixes tag is part of the main tag block and
some of the automation people use doesn't cope with blank lines
in that block.

If nothing else comes up in reviewing the rest of the series I'll
tidy that up whilst applying.

Thanks,

Jonathan

> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 00098caf6d9e..aee076c8e2b1 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -36,8 +36,8 @@
>  
>  /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
>  #define SC27XX_ADC_CHN_ID_MASK		GENMASK(4, 0)
> -#define SC27XX_ADC_SCALE_MASK		GENMASK(10, 8)
> -#define SC27XX_ADC_SCALE_SHIFT		8
> +#define SC27XX_ADC_SCALE_MASK		GENMASK(10, 9)
> +#define SC27XX_ADC_SCALE_SHIFT		9
>  
>  /* Bits definitions for SC27XX_ADC_INT_EN registers */
>  #define SC27XX_ADC_IRQ_EN		BIT(0)

