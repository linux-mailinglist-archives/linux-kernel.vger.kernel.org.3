Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A7E5A2E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbiHZSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiHZSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:16:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E6D1E17;
        Fri, 26 Aug 2022 11:16:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d8so3052220lfq.0;
        Fri, 26 Aug 2022 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vHBHTJgzZJYWI8oV62UeYLgpgt+QcSdAaz2tHS/pNcQ=;
        b=mnTBfZrugKU6Ahscb41Y9BWnJzirIn34mbG0LDdyX8MJs0LBp+8uRkSCklKCC0hF/M
         LtMHkjoOU10UImooZwu4hUYKY4eu9GS1W+KU8s1Z9CXHqOcRxxgqgxMyZRxALLMznfGV
         tTDHEq4v52EcWdEXLVsUemNG7bqik3FWiLamjMHIx0doqN/dPRssILTtdGU4rS1z0gAu
         caJcbY4uNHzKgRL7zbasrxB52zN0x9H4R5fTRVAn9959hnt1AOqOBFPSOKMlC2RcosTd
         rTmCwQWwlzwH0XuBoBj3EtvZY+FFAUoW7sCVzvuadQ7R2xuG9KaLSDx3vYgSFjKVhC0F
         Yquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vHBHTJgzZJYWI8oV62UeYLgpgt+QcSdAaz2tHS/pNcQ=;
        b=N7MQhGbYCFhgX9z6hC/re+7Mubg6bgCeIkhjIyTIzDDEqFkLcs3T1C/jZ9zMI8Lg47
         qeWheVcKJXxPKMi3djrGyuFCu7VtUI3jJPKe3mNxD+T1a/iuCPYZn05hzdfv+vTiwvzI
         aTLSZV57pbYR3bcM0xFXGx4u3lR/USYp8i8Uuup5J8k02rEMe/ZRFYFhjWApKjxJMfh4
         UwOdIX1m1BVHGL+MDou6YKN6HEp1fuMwXla6ob2ZNQKXZ06gINvyM60mrDnGfuSf6LR4
         V9Sjmj4iBiJTgS8wjpiGthYl/3c1C6VDtexQf1CISJyu/A2HIrNbpQoaGhXqyRgjxYXH
         WE4w==
X-Gm-Message-State: ACgBeo1dQE38/WpMp9IZKtOo0ePI2NUBAq2dP6oNiXlwR1iiyHK6Kraw
        GZqKnudPBu9wOzFc2b3KSGAfCzJtRtNfoQ==
X-Google-Smtp-Source: AA6agR4PNIMIdy4s4Ezpch5htYqTvBKbhJ8uzGhlGErl2Q59Iucgjm6iSnuqzgU+mnpGUH+EXlH39g==
X-Received: by 2002:a05:6512:b01:b0:48b:a065:2a8b with SMTP id w1-20020a0565120b0100b0048ba0652a8bmr2675180lfu.401.1661537799477;
        Fri, 26 Aug 2022 11:16:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id c26-20020a05651200da00b0048b1d92991asm429782lfp.303.2022.08.26.11.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:16:38 -0700 (PDT)
Date:   Fri, 26 Aug 2022 21:16:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 01/11] spi: dw: define capability for enhanced spi
Message-ID: <20220826181636.khl4pq2a32n265on@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-2-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-2-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:45PM +0100, Sudip Mukherjee wrote:
> Some Synopsys SSI controllers support enhanced SPI which includes
> Dual mode, Quad mode and Octal mode. Define the capability and mention
> it in the controller supported modes.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 4 ++++
>  drivers/spi/spi-dw.h      | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index f87d97ccd2d6..97e72da7c120 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -917,6 +917,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  
>  	master->use_gpio_descriptors = true;
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;

> +	if (dws->caps & DW_SPI_CAP_EXT_SPI)
> +		master->mode_bits |= SPI_TX_DUAL | SPI_RX_DUAL |
> +				SPI_TX_QUAD | SPI_RX_QUAD |
> +				SPI_TX_OCTAL | SPI_RX_OCTAL;

Is it possible to auto-detect the highest supported mode by, for
instance, writing to the CTRL0.SPI_FRF field values up to the maximum
one? The DW SSI hardware manual says that the unsupported mode
combinations are reserved. Could the reserved modes still be written
to the SPI_FRF field? If not we could use it to set the
SPI_{TX,RX}_DUAL, SPI_{TX,RX}_QUAD, SPI_{TX,RX}_OCTAL in accordance
with the actual device capabilities rather than setting all of them.

>  	if (dws->caps & DW_SPI_CAP_DFS32)
>  		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>  	else
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 9e8eb2b52d5c..71d18e9291a3 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -32,6 +32,7 @@
>  /* DW SPI controller capabilities */
>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
>  #define DW_SPI_CAP_DFS32		BIT(1)

> +#define DW_SPI_CAP_EXT_SPI		BIT(2)

EXT-prefix is misleading. The feature is called "Enhanced SPI Modes",
not Extended SPI modes. Perhaps something like DW_SPI_CAP_EMODE ?

-Sergey

>  
>  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
>  #define DW_SPI_CTRLR0			0x00
> -- 
> 2.30.2
> 
