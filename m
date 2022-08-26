Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67185A32A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 01:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbiHZXbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 19:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiHZXbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 19:31:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC229E01E4;
        Fri, 26 Aug 2022 16:31:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id k22so2932504ljg.2;
        Fri, 26 Aug 2022 16:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ExYc4uvaCFufLZ26mduLkbydtrmyr0sueN7I2Fzqp24=;
        b=bL85Mylrzl0HuN8sObnsBB9Olk6ESD7ZQ0o3d5dlR5ye0V3/aLrxZfpQpBjrB4k9Cp
         R22pgVm5Z3VGntAcqwFn28FKVRtqUnQonCAJtk5cF7+ec7TbJ69sdt/lc4LyDyOLoc2x
         z+RJfQ+eNh3wUcfZcFzDszBacunmMyJeD0a8RKtVPfypWlHnM3u7KgXJrlfxH856QYUJ
         LrzBt0+zHKMvpi5Vdx7m2ijVziaQCDvqO5HZ7O12gfVizrV7AaBYUXQbLZg6lSmyJ3oU
         DnD2grOSrl7ed9Jk/sBS7WZfs5VHBFTCfitm6qiEg12zSyu8LjipX3uUkLqmPwPGiUCz
         z6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ExYc4uvaCFufLZ26mduLkbydtrmyr0sueN7I2Fzqp24=;
        b=DAxeXvtQK77Zck2fUX2vQwcSA6lRRP3DYyOi0XQcqic0KL2i5EiMWJ3Vi7NH6CtkUy
         s6Y+JBtyTlrbMf2on/Hg5/JTqYo/YLiXYSJVaVygYiGdN4/fug2PBwYYwaRiAFXRxU0G
         8NMFnkUXHb2WTs35cRvnr+VlUFwju/Ynd8Deep4+PiNKqsE7/u8mKEfCHpMyQptLAB6k
         YmDaroQtWYMlzpUpKJdTVKJ5HLFasRZ93n2LWSO6UaicBIiMPGe+8A9ZX/nBdLbqBiV1
         riCUt1jGDGJL/Wq1CMelMNO7S4Pk1r/Fm0W7WXXjZYfEGXCezIUPXKiqOF3/xv2of66B
         btbA==
X-Gm-Message-State: ACgBeo0Rbix60nnouRhggAkuXJDyd1Wam48f26FhljDorOhWJsfrzZjo
        zUFh/CUGQ3kqcNH3k4y8OmYT+zl+cqj7QA==
X-Google-Smtp-Source: AA6agR6OMOplZC2jTSuBANWUs0p93LMh9qbMtpQAQCxQjVwQVHnaiUPx6LoDTX7d30PJvn+il6eVbA==
X-Received: by 2002:a2e:bcc7:0:b0:261:8fb3:d4ec with SMTP id z7-20020a2ebcc7000000b002618fb3d4ecmr2743363ljp.96.1661556679116;
        Fri, 26 Aug 2022 16:31:19 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id o21-20020a05651205d500b00492b7d7ee20sm508353lfo.87.2022.08.26.16.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 16:31:18 -0700 (PDT)
Date:   Sat, 27 Aug 2022 02:31:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 11/11] spi: dw: initialize dwc-ssi-1.03a controller
Message-ID: <20220826233116.uulisbo663cxiadt@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-12-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-12-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:55PM +0100, Sudip Mukherjee wrote:
> Define the initialization of dwc-ssi-1.03a controller and mark it with
> the capability of enhanced SPI supporting dual/quad/octal modes of
> transfer.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 26c40ea6dd12..db80e0645172 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -237,6 +237,15 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int dw_spi_hssi_ext_init(struct platform_device *pdev,
> +				struct dw_spi_mmio *dwsmmio)
> +{
> +	dwsmmio->dws.ip = DW_HSSI_ID;

> +	dwsmmio->dws.caps = DW_SPI_CAP_EXT_SPI;

The eSPI capability shall be auto-detectable by checking whether the
CTRLR0.SPI_FRF field is writable. If it is then you'll need to check
whether the clock stretching is also available by setting to the
SPI_CTRLR0.CLK_STRETCH_EN flag. After that you can set the capability
flag.

Since the auto-detection procedure is available you won't need the
dw_spi_hssi_ext_init() method here. So just drop it and use
dw_spi_hssi_init() for the platform-specific initialization. Note it
will also check the DMA-capability for you.

> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -352,6 +361,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},

> +	{ .compatible = "snps,dwc-ssi-1.03a", dw_spi_hssi_ext_init},

Add "snps,dw-ahb-ssi" with the generic dw_spi_hssi_init() init method.

-Sergey

>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> -- 
> 2.30.2
> 
