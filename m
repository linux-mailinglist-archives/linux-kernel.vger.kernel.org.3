Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC13E59B5EC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiHUSS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiHUSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:18:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C571BEB1;
        Sun, 21 Aug 2022 11:18:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l19so5647216ljg.8;
        Sun, 21 Aug 2022 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+DXF8MmCRRjjXsat+fPLoT8WiOSQ/UNg64Pi/BRjUh0=;
        b=gxHVJaVkS2jGAor5Dygezerqw/TCX4qeK9cA9h4n1VJZUu4ZiF1uqs7EQnB9+GIfnT
         QbHykg5UDkiCP5kfv0ShFiBNvKTeaJirifd8mWTGwZuIW0IkqL7JPmson4C67LgVgq0L
         kC9rhQXchKtlZEu7JQSPEAxRQnWCUOwGUhxWweNSNUIltF59/dg2UvZfw9RukjN9nG+G
         iQ7cKlhT9HpkpkLfPR9keaB0ZLu4MD3HbbhsF+rElrW+LNCUkmc+ae4J0OObfQHW6MFy
         EN3CZm50wK9Pn3c1WC/g/eC3G/eRpc4Z0NSATgTlrYMXAMp4hkU0NngBeKYbvUUECjB1
         3+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+DXF8MmCRRjjXsat+fPLoT8WiOSQ/UNg64Pi/BRjUh0=;
        b=oj0uY6k5xPWVBPU6tc6cgG7HUuFaNfoRRSvyO6g0ccpsOEalcPqgF1Rp6FkHBP1i93
         7+BfcXmbLyNDddr7VBR/OtY8glSo1TdNpwurTHZUcyeysW0lO9V9ZtueRsjT+FTEnMJr
         L1+6J2defMss47g3qK2JqhvZFOvPwd+wDGZhgpnuW1ovZKNNW17jTE80xLgLLAsOuj+h
         DzG97UweKf/f5s9wCN17vpHz2psgyLuWUt+m92yZWynGGhfB88sDdfGk7fmuvhebD3DT
         VS8npN48WAdCeS0nXaaEb6REntl9RJmJNjRzXaAqK+tuurCi9F4WPA+O1mp/1gcyt8Yl
         a3lg==
X-Gm-Message-State: ACgBeo2t0ZK+jrqqmmWEP3hsrOGmO9CIToZcXJPm24vK6qOUKhZcoTqS
        SzpsS2eSjHuoUlAFvk14Zlg=
X-Google-Smtp-Source: AA6agR4LxdBTHgY9SQsNBQGfG9qgAtgi7b6nH0XV/rU0I4UFYnrkkfNkqpIYMn3puy2rOgwG93TW1A==
X-Received: by 2002:a05:651c:1720:b0:261:bfb0:f832 with SMTP id be32-20020a05651c172000b00261bfb0f832mr3041473ljb.346.1661105932043;
        Sun, 21 Aug 2022 11:18:52 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v15-20020ac258ef000000b0048b08f0c4e9sm853254lfo.176.2022.08.21.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:18:51 -0700 (PDT)
Date:   Sun, 21 Aug 2022 21:18:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 12/17] spi: dw: Add support for AMD Pensando Elba SoC
Message-ID: <20220821181848.cxjpv2f4cqvdtnq3@mobilestation>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-13-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820195750.70861-13-brad@pensando.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 12:57:45PM -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
> with device specific chip-select control.  The Elba SoC
> provides four chip-selects where the native DW IP supports
> two chip-selects.  The Elba DW_SPI instance has two native
> CS signals that are always overridden.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 77 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 26c40ea6dd12..36b8c5e10bb3 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -53,6 +53,24 @@ struct dw_spi_mscc {
>  	void __iomem        *spi_mst; /* Not sparx5 */
>  };
>  
> +struct dw_spi_elba {
> +	struct regmap *syscon;
> +};
> +
> +/*
> + * Elba SoC does not use ssi, pin override is used for cs 0,1 and
> + * gpios for cs 2,3 as defined in the device tree.
> + *
> + * cs:  |       1               0
> + * bit: |---3-------2-------1-------0
> + *      |  cs1   cs1_ovr   cs0   cs0_ovr
> + */
> +#define ELBA_SPICS_REG			0x2468
> +#define ELBA_SPICS_SHIFT(cs)		(2 * (cs))
> +#define ELBA_SPICS_MASK(cs)		(0x3 << ELBA_SPICS_SHIFT(cs))
> +#define ELBA_SPICS_SET(cs, val)	\
> +			((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))

Please take the @Andy' notes into account:
https://lore.kernel.org/lkml/CAHp75Vex0VkECYd=kY0m6=jXBYSXg2UFu7vn271+Q49WZn22GA@mail.gmail.com/

One more nitpick below.

> +
>  /*
>   * The Designware SPI controller (referred to as master in the documentation)
>   * automatically deasserts chip select when the tx fifo is empty. The chip
> @@ -237,6 +255,64 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static void dw_spi_elba_override_cs(struct dw_spi_elba *dwselba, int cs, int enable)
> +{
> +	regmap_update_bits(dwselba->syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
> +			   ELBA_SPICS_SET(cs, enable));
> +}
> +
> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
> +	struct dw_spi_elba *dwselba = dwsmmio->priv;
> +	u8 cs;
> +
> +	cs = spi->chip_select;
> +	if (cs < 2)
> +		dw_spi_elba_override_cs(dwselba, spi->chip_select, enable);
> +
> +	/*
> +	 * The DW SPI controller needs a native CS bit selected to start
> +	 * the serial engine.
> +	 */
> +	spi->chip_select = 0;
> +	dw_spi_set_cs(spi, enable);
> +	spi->chip_select = cs;
> +}
> +
> +static int dw_spi_elba_init(struct platform_device *pdev,
> +			    struct dw_spi_mmio *dwsmmio)
> +{
> +	const char *syscon_name = "amd,pensando-elba-syscon";
> +	struct device_node *np = pdev->dev.of_node;

> +	struct device_node *node;
> +	struct dw_spi_elba *dwselba;

Please, use the reverse xmas tree order of the local variables
as the rest of the driver mainly implies.

-Sergey

> +	struct regmap *regmap;
> +
> +	node = of_parse_phandle(np, syscon_name, 0);
> +	if (!node) {
> +		dev_err(&pdev->dev, "failed to find %s\n", syscon_name);
> +		return -ENODEV;
> +	}
> +
> +	regmap = syscon_node_to_regmap(node);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&pdev->dev, "syscon regmap lookup failed\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	dwselba = devm_kzalloc(&pdev->dev, sizeof(*dwselba), GFP_KERNEL);
> +	if (!dwselba)
> +		return -ENOMEM;
> +
> +	dwselba->syscon = regmap;
> +	dwsmmio->priv = dwselba;
> +	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -352,6 +428,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
> +	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> -- 
> 2.17.1
> 
