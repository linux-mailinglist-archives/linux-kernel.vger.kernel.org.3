Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F44E1C07
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 15:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245256AbiCTOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiCTOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 10:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D733222A5;
        Sun, 20 Mar 2022 07:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AE6661133;
        Sun, 20 Mar 2022 14:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D11BC340E9;
        Sun, 20 Mar 2022 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647786189;
        bh=BIwFbR0Ye5O5xV7KMBNyXdSWSpjV5sG5PmBhvuIdXPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TmPW1zZ48NXuxQJOPXEDOph5fHNd8NOYna02/RyTJ7FCaGvbAQuFN9bQUTPfFi0Zp
         ISjcxI311dgVWHOUx3iUS2G2A2yWrt5H36cdKjddUCOnaJjV/bwvBpO6cT2RMAn6Pe
         af3VUZi3xNlIYN4koeJD4PKh662XZRfwGUYZWpNRJQrVQSXxqXv6sUbfKRwKanr1Qo
         UKFO5gfrCYYH2S2cmwEbaNNE96sARg6RCCqhGW/ZIZwUvyuSHQr0TquMlXrj0Yuk2q
         zIvSF5TMgyJPKQfnmMNd2NRmxoAZeervrvFAON513y/kXufcuFRxEZrX+5J9Ab+UeA
         C4EkLb9267Atw==
Date:   Sun, 20 Mar 2022 14:30:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/7] iio: adc: sc27xx: add support for PMIC sc2720
 and sc2721
Message-ID: <20220320143031.7229a05d@jic23-huawei>
In-Reply-To: <20220311164628.378849-5-gengcixi@gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
        <20220311164628.378849-5-gengcixi@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2022 00:46:25 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> sc2720 and sc2721 is the product of sc27xx series.
> 
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

For IIO change log should be under the ---
as I don't want to see it in the final git log.

> 
> v2 changes:
> 
> 1. modify code by the baolin's comment
> 
> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
Did Boalin give an RB?  I'm not seeing it from a quick look
at the v1 patch.  You should not add Reviewed-by or
Acked-by unless explicitly given by the person in question

> 
> 2.fix smatch warnings in sc27xx_adc_read()
> 

Again, blank lines in tag block.
If you want to acknowledge the reports which is great, then you need
to do something like.

Reported-by: kernel test robot <lpk@intel.com> #smatch warnings
Reported-by: Dan Carpenter <dan.carpenter@oracle.com> #as above.

So we stick to one line tags with no gaps, but with a comment after them
to provide context.  It is also common to acknowledge these sort of
changes in the change description below the --- only and not in the
tag block.  Either is acceptable in IIO but other maintainers may
disagree in their areas of the kernel.

Comments inline,

Thanks,

Jonathan


> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 201 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 200 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 68629fbcfec5..2603ce313b07 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -9,11 +9,13 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
>  /* PMIC global registers definition */
>  #define SC2731_MODULE_EN		0xc08
>  #define SC27XX_MODULE_ADC_EN		BIT(5)
> +#define SC2721_ARM_CLK_EN		0xc0c
>  #define SC2731_ARM_CLK_EN		0xc10
>  #define SC27XX_CLK_ADC_EN		BIT(5)
>  #define SC27XX_CLK_ADC_CLK_EN		BIT(6)
> @@ -37,7 +39,9 @@
>  /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
>  #define SC27XX_ADC_CHN_ID_MASK		GENMASK(4, 0)
>  #define SC27XX_ADC_SCALE_MASK		GENMASK(10, 9)
> +#define SC2721_ADC_SCALE_MASK		BIT(5)
>  #define SC27XX_ADC_SCALE_SHIFT		9
> +#define SC2721_ADC_SCALE_SHIFT		5
>  
>  /* Bits definitions for SC27XX_ADC_INT_EN registers */
>  #define SC27XX_ADC_IRQ_EN		BIT(0)
> @@ -67,8 +71,20 @@
>  #define SC27XX_RATIO_NUMERATOR_OFFSET	16
>  #define SC27XX_RATIO_DENOMINATOR_MASK	GENMASK(15, 0)
>  
> +/* ADC specific channel reference voltage 3.5V */
> +#define SC27XX_ADC_REFVOL_VDD35		3500000
> +
> +/* ADC default channel reference voltage is 2.8V */
> +#define SC27XX_ADC_REFVOL_VDD28		2800000
> +
> +enum sc27xx_pmic_type {
> +	SC27XX_ADC,
> +	SC2721_ADC,
> +};
> +
>  struct sc27xx_adc_data {
>  	struct device *dev;
> +	struct regulator *volref;
>  	struct regmap *regmap;
>  	/*
>  	 * One hardware spinlock to synchronize between the multiple
> @@ -87,6 +103,7 @@ struct sc27xx_adc_data {
>   * in the device data structure.
>   */
>  struct sc27xx_adc_variant_data {
> +	enum sc27xx_pmic_type pmic_type;
>  	u32 module_en;
>  	u32 clk_en;
>  	u32 scale_shift;
> @@ -188,6 +205,94 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
>  	return 0;
>  }
>  
> +static int sc2720_adc_get_ratio(int channel, int scale)
> +{
> +	switch (channel) {
> +	case 14:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(68, 900);
> +		case 1:
> +			return SC27XX_VOLT_RATIO(68, 1760);
> +		case 2:
> +			return SC27XX_VOLT_RATIO(68, 2327);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(68, 3654);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	case 16:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(48, 100);
> +		case 1:
> +			return SC27XX_VOLT_RATIO(480, 1955);
> +		case 2:
> +			return SC27XX_VOLT_RATIO(480, 2586);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(48, 406);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	case 21:
> +	case 22:
> +	case 23:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(3, 8);
> +		case 1:
> +			return SC27XX_VOLT_RATIO(375, 1955);
> +		case 2:
> +			return SC27XX_VOLT_RATIO(375, 2586);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(300, 3248);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	default:
> +		switch (scale) {
> +		case 0:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		case 1:
> +			return SC27XX_VOLT_RATIO(1000, 1955);
> +		case 2:
> +			return SC27XX_VOLT_RATIO(1000, 2586);
> +		case 3:
> +			return SC27XX_VOLT_RATIO(100, 406);
> +		default:
> +			return SC27XX_VOLT_RATIO(1, 1);
> +		}
> +	}
> +	return SC27XX_VOLT_RATIO(1, 1);
> +}
> +
> +static int sc2721_adc_get_ratio(int channel, int scale)
> +{
> +	switch (channel) {
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		return scale ? SC27XX_VOLT_RATIO(400, 1025) :
> +			SC27XX_VOLT_RATIO(1, 1);
> +	case 5:
> +		return SC27XX_VOLT_RATIO(7, 29);
> +	case 7:
> +	case 9:
> +		return scale ? SC27XX_VOLT_RATIO(100, 125) :
> +			SC27XX_VOLT_RATIO(1, 1);
> +	case 14:
> +		return SC27XX_VOLT_RATIO(68, 900);
> +	case 16:
> +		return SC27XX_VOLT_RATIO(48, 100);
> +	case 19:
> +		return SC27XX_VOLT_RATIO(1, 3);
> +	default:
> +		return SC27XX_VOLT_RATIO(1, 1);
> +	}
> +	return SC27XX_VOLT_RATIO(1, 1);
> +}
> +
>  static int sc2731_adc_get_ratio(int channel, int scale)
>  {
>  	switch (channel) {
> @@ -216,6 +321,34 @@ static int sc2731_adc_get_ratio(int channel, int scale)
>  /*
>   * According to the datasheet set specific value on some channel.
>   */
> +static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> +		switch (i) {
> +		case 5:
> +			data->channel_scale[i] = 3;
> +			break;
> +		case 7:
> +		case 9:
> +			data->channel_scale[i] = 2;
> +			break;
> +		case 13:
> +			data->channel_scale[i] = 1;
> +			break;
> +		case 19:
> +		case 30:
> +		case 31:
> +			data->channel_scale[i] = 3;
> +			break;
> +		default:
> +			data->channel_scale[i] = 0;
> +			break;
> +		}
> +	}
> +}
> +
>  static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
>  {
>  	int i;
> @@ -231,7 +364,7 @@ static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
>  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  			   int scale, int *val)
>  {
> -	int ret;
> +	int ret, ret_volref;
>  	u32 tmp, value, status;
>  
>  	ret = hwspin_lock_timeout_raw(data->hwlock, SC27XX_ADC_HWLOCK_TIMEOUT);
> @@ -240,6 +373,22 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  		return ret;
>  	}
>  
> +	/*
> +	 * According to the sc2721 chip data sheet, the reference voltage of
> +	 * specific channel 30 and channel 31 in ADC module needs to be set from
> +	 * the default 2.8v to 3.5v.
> +	 */
> +	if ((data->var_data->pmic_type == SC2721_ADC) && (channel == 30 || channel == 31)) {
> +		ret = regulator_set_voltage(data->volref,
> +					SC27XX_ADC_REFVOL_VDD35,
> +					SC27XX_ADC_REFVOL_VDD35);
> +		if (ret) {
> +			dev_err(data->dev, "failed to set the volref 3.5V\n");
> +			hwspin_unlock_raw(data->hwlock);
> +			return ret;
> +		}
> +	}
> +
>  	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>  				 SC27XX_ADC_EN, SC27XX_ADC_EN);
>  	if (ret)
> @@ -294,6 +443,18 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>  			   SC27XX_ADC_EN, 0);
>  unlock_adc:
> +	if (data->var_data->pmic_type == SC2721_ADC) {
> +		if ((channel == 30) || (channel == 31)) {
> +			ret_volref = regulator_set_voltage(data->volref,
> +						    SC27XX_ADC_REFVOL_VDD28,
> +						    SC27XX_ADC_REFVOL_VDD28);
> +			if (ret_volref) {
> +				dev_err(data->dev, "failed to set the volref 2.8V, ret_volref = 0x%x\n,ret_volref");
> +				ret = ret || ret_volref;
> +			}
> +		}
> +	}
> +
>  	hwspin_unlock_raw(data->hwlock);
>  
>  	if (!ret)
> @@ -523,6 +684,7 @@ static void sc27xx_adc_disable(void *_data)
>  }
>  
>  static const struct sc27xx_adc_variant_data sc2731_data = {
> +	.pmic_type = SC27XX_ADC,
>  	.module_en = SC2731_MODULE_EN,
>  	.clk_en = SC2731_ARM_CLK_EN,
>  	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
> @@ -533,6 +695,30 @@ static const struct sc27xx_adc_variant_data sc2731_data = {
>  	.get_ratio = sc2731_adc_get_ratio,
>  };
>  
> +static const struct sc27xx_adc_variant_data sc2721_data = {
> +	.pmic_type = SC2721_ADC,
> +	.module_en = SC2731_MODULE_EN,
> +	.clk_en = SC2721_ARM_CLK_EN,
> +	.scale_shift = SC2721_ADC_SCALE_SHIFT,
> +	.scale_mask = SC2721_ADC_SCALE_MASK,
> +	.bscale_cal = &sc2731_big_scale_graph_calib,
> +	.sscale_cal = &sc2731_small_scale_graph_calib,
> +	.init_scale = sc2731_adc_scale_init,
> +	.get_ratio = sc2721_adc_get_ratio,
> +};
> +
> +static const struct sc27xx_adc_variant_data sc2720_data = {
> +	.pmic_type = SC27XX_ADC,
> +	.module_en = SC2731_MODULE_EN,
> +	.clk_en = SC2721_ARM_CLK_EN,
> +	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
> +	.scale_mask = SC27XX_ADC_SCALE_MASK,
> +	.bscale_cal = &big_scale_graph_calib,
> +	.sscale_cal = &small_scale_graph_calib,
> +	.init_scale = sc2720_adc_scale_init,
> +	.get_ratio = sc2720_adc_get_ratio,
> +};
> +
>  static int sc27xx_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -583,6 +769,17 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	sc27xx_data->dev = dev;
> +	if (pdata->pmic_type == SC2721_ADC) {
> +		sc27xx_data->volref = devm_regulator_get_optional(dev, "vref");

What you are doing here is using get_optional to avoid a stub regulator, rather than
because the regulator is in any sense optional.

Perhaps a better approach would be do a normal get() and then check the supplied
regulator is capable of setting the voltage to the two levels required?

> +		if (IS_ERR(sc27xx_data->volref)) {
> +			ret = PTR_ERR(sc27xx_data->volref);
> +			if (ret == -ENODEV)
> +				dev_err(dev, "failed to supply the regulator\n");
> +			dev_err(dev, "failed to get ADC volref, the err volref: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	sc27xx_data->var_data = pdata;
>  	sc27xx_data->var_data->init_scale(sc27xx_data);
>  
> @@ -612,6 +809,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id sc27xx_adc_of_match[] = {
>  	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
> +	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
> +	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);

