Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE05A8B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiIAB5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiIAB5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:57:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F90E925F;
        Wed, 31 Aug 2022 18:57:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j5so11880632plj.5;
        Wed, 31 Aug 2022 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6mfyiPwc22bEhXPHxCTjwhtmTBJgN0EskNQJLK9ocf4=;
        b=np6HoEXPlccCcEBkEwpVM5Adn/NikjRSwAdoYnm5GrfkAnplsltFKUhefPSOdBRLmw
         XzsownVhC9R2OgvHMJaqYjOjisnB76Nh8yGbsIiEtvjMqK/N+n+GfuSt8DTv+y+Ho4i0
         WnFAsdwiHD/lvRcdXxCEUjjefyH6pw0MUburBKeHJetSioBYhlEP5nKnDc0FdvCeSZjE
         KjOninB0VySAySpjmgWrWcnWVT4N/oxSpMYUqJLQ4J8S4W8om9lBXofhZa7Vu07fNN0q
         Z2ZRKjVZWiEFGmb6xvsGKWA3CgPTAhhg+VeAhn6SRhur3qc+sXR5RqjXknaMF/odR8Lc
         AMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6mfyiPwc22bEhXPHxCTjwhtmTBJgN0EskNQJLK9ocf4=;
        b=ZIJ4+k7HZuZce4UYHyhCUgFVHQP6KYjLgahPwNowq1G9WhDnpAcSE25AfuKxzCnXRT
         1VWlj68whcNFjZlCvPYTT4EL4peQp2y4iAy3cHSuQAMntIKianlB55Vf4S2MojNiO6G2
         f318VpxmcYNYaKcqw7XAjlvM4HZkIO934Fz26ZNpMBqaeUc1JefOv19+pFn/Q00P8tEm
         3KIvpEoNIykbC1+5r+TTfbIsIDjts9OAOhWeS7+J3dXrtiBhH7fNk601Hy2YmdNjUfRy
         DPmrXvaxLBQkR42c+tJ9VIevJ46BDQp9GtDWS24rj5veEBk7RvHIkS0+1Fdv/Q8uo5Or
         SaVQ==
X-Gm-Message-State: ACgBeo0B8yIkkU0FrVKlzjvVcO079tNkxlTDTfqMZF4lwy97HCz0ZZE9
        wTlqlq5vjtJJEr6AlPP6mos=
X-Google-Smtp-Source: AA6agR6OozjYna21kOAlB6A2VXRScEvdY16r4UBayrh+1JNxlRY7yw/4+EOWyepGNJDNARUEeL21fw==
X-Received: by 2002:a17:90a:d150:b0:1fd:9336:5db3 with SMTP id t16-20020a17090ad15000b001fd93365db3mr6107263pjw.242.1661997461490;
        Wed, 31 Aug 2022 18:57:41 -0700 (PDT)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id z15-20020a170902cccf00b0016c0eb202a5sm12367728ple.225.2022.08.31.18.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 18:57:40 -0700 (PDT)
Message-ID: <11077b0e-0a79-401e-5232-1dc1d1a04d83@gmail.com>
Date:   Thu, 1 Sep 2022 10:57:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
        git@amd.com, takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
 <20220829090528.21613-3-sai.krishna.potthuri@amd.com>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20220829090528.21613-3-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 8/29/2022 6:05 PM, Sai Krishna Potthuri wrote:
> Add support for spi-nor flash reset via GPIO controller by reading the
> reset-gpio property. If there is a valid GPIO specifier then reset will
> be performed by asserting and deasserting the GPIO using gpiod APIs
> otherwise it will not perform any operation.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  drivers/mtd/spi-nor/core.c | 50 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index f2c64006f8d7..d4703ff69ad0 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2401,12 +2401,8 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
>   */
>  static void spi_nor_init_flags(struct spi_nor *nor)
>  {
> -	struct device_node *np = spi_nor_get_flash_node(nor);
>  	const u16 flags = nor->info->flags;
>  
> -	if (of_property_read_bool(np, "broken-flash-reset"))
> -		nor->flags |= SNOR_F_BROKEN_RESET;
> -
>  	if (flags & SPI_NOR_SWP_IS_VOLATILE)
>  		nor->flags |= SNOR_F_SWP_IS_VOLATILE;
>  
> @@ -2933,9 +2929,47 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
>  	mtd->_put_device = spi_nor_put_device;
>  }
>  
> +static int spi_nor_hw_reset(struct spi_nor *nor)
> +{
> +	struct gpio_desc *reset;
> +	int ret;
> +
> +	reset = devm_gpiod_get_optional(nor->dev, "reset", GPIOD_ASIS);
> +	if (IS_ERR_OR_NULL(reset))
> +		return PTR_ERR_OR_ZERO(reset);
> +
> +	/* Set the direction as output and enable the output */
> +	ret = gpiod_direction_output(reset, 1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Experimental Minimum Chip select high to Reset delay value
> +	 * based on the flash device spec.
> +	 */
> +	usleep_range(1, 5);
> +	gpiod_set_value(reset, 0);
> +
> +	/*
> +	 * Experimental Minimum Reset pulse width value based on the
> +	 * flash device spec.
> +	 */
> +	usleep_range(10, 15);
> +	gpiod_set_value(reset, 1);
> +
> +	/*
> +	 * Experimental Minimum Reset recovery delay value based on the
> +	 * flash device spec.
> +	 */
> +	usleep_range(35, 40);
Infineon (Spansion/Cypress) SEMPER flash (S25HL/HS, S28HL/HS) family
specifies minimum tRH (Reset Pulse Hold - RESET# Low to CS# Low) as
450~600us. Please take care for this.

Please find datasheets at the following links.

https://www.infineon.com/dgdl/Infineon-S25HS256T_S25HS512T_S25HS01GT_S25HL256T_S25HL512T_S25HL01GT_256-Mb_(32-MB)_512-Mb_(64-MB)_1-Gb_(128-MB)_HS-T_(1.8-V)_HL-T_(3.0-V)_Semper_Flash_with_Quad_SPI-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee674b86ee3&da=t

https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HS512T_S28HS01GT_S28HL256T_S28HL512T_S28HL01GT_256-Mb_(32-MB)_512-Mb_(64-MB)_1-Gb_(128-MB)_HS-T_(1.8-V)_HL-T_(3.0-V)_Semper_Flash_with_Octal_Interface-DataSheet-v03_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee6bca96f97&da=t

Thanks,
Takahiro Kuwano
