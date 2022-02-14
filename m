Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398124B51A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354133AbiBNNbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:31:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiBNNbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:31:21 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836CD50E33
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:31:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o34so5885412wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CkVfRRzqd/INU1zv6Rjmy8o6EyxrSkov3LRyAgACX4k=;
        b=sLRDTb5ZDOuxVYVIpiWgWEyJKJ7l5wSF6TvAvKNY+844P81SaZJDsRAaoaZWTt3E+d
         6rc4mRaqJn5U/G75iKbc8qPqXJmIHljXaQjWOU9CIp/ANTCij9xIkN/3o05vRgz2ofSq
         mHpUAVAMWGnQpUZfaWpW9VPdPRkllhW2MFsGEGR6X3t/Ve2vMdybm3yRaBHEZl+Gj3UC
         utFOacf1qnWnVGJyZc6taB3svtSSTH4kKqwvOPZozMEt+XQ5QICj9LcTfQQ7qThhr9IH
         Cz7ED4IgrJhaGs//pXPPwEzAaH0ehcf8sPzd4Ah40lc8TmTc+X97Mcp/bGF78zspQZ6p
         HWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CkVfRRzqd/INU1zv6Rjmy8o6EyxrSkov3LRyAgACX4k=;
        b=StRVWCT9uOuxNt94dVlT1jcbAebO7EHt55vYlp6GR22iq/5LuaE/6kkQaC1NkuUdPv
         DNa7METyeCIRvudxr41KfCG2l4huBrGDDOfLzCGEpR1wP9DbkcTtapKzDTJ7FVeswyIP
         whzB/7JqIL2/cYc5Me2gYVsBiU0vVeqPps//AY49/GLiCOvwSKiROUUQO4rmFcgbNV6I
         NNwRpTh/GOUJ21f2GDOC7ENRGmU+JyHV6DXXazfxp6CDQhGO0hWa90+xF8RkgbX9VdCA
         DaLsO402DGFvODsrUfM9KaUnLQ9gpMzYzBEUyqLh8ZoOmRXKTTpvtpDMQem07rcS4Obo
         4/Yg==
X-Gm-Message-State: AOAM533+FJ3u3ItpdtMLIuT4Sotrp4NGOEiULsFmhdKQ32dBNQwN8+Z/
        tOxeMZSw7uYHlfAnqPijbqpwjQ==
X-Google-Smtp-Source: ABdhPJyRZdi9P1uE7VB1G38eX03IrGP9qP0Y4OWXdXEhWmAAOKOskZe1RZTjEPbmf7ILJB2JY5jKbg==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr11207540wmj.180.1644845471621;
        Mon, 14 Feb 2022 05:31:11 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id b16sm19998483wrj.26.2022.02.14.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:31:11 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:31:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] mfd: syscon: allow mapping a range of addresses
Message-ID: <YgpZnZ5onP5JYVEH@google.com>
References: <20220201112050.3466927-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201112050.3466927-1-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,

> Allow the mapping of a range of addresses for syscon. This is done through
> regmap_config::wr_table, regmap_config::rd_table. Previously, only one
> range could have been allocated to a syscon via
> regmap_config::max_register. The code is needed for SAMA7G5 whose reset
> controller contains a register (at offset 0xE001D0E4, see below) that is
> used to control the USB PHYs but that register is not located continuously
> in reset controller address space, as follows:

Would you be kind enough to look at this please?

> Controller's name    Memory space    Offset
>       ...                ...           ...
>                     +------------+  0xE001D000
> Reset controller    |            |
>                     +------------+  0xE001D010
> Shutdown controller |            |
>                     +------------+  0xE001D020
> RTT controller      |            |
>                     +------------+  0xE001D050
>       ...                ...           ...
>                     +------------+  0xE001D0E4
> Reset controller    |            |
>                     +------------+  0xE001D0E8
>       ...                ...           ...
> 
> To control the PHYs the proper syscon is retrieved from proper driver.
> With previous approach only the first range passed though device tree
> was taken into account by syscon. With the code in this patch the
> following DT bindings:
> 
> reset_controller: rstc@e001d000 {
>         compatible = "microchip,sama7g5-rstc",
>                      "microchip,sam9x60-rstc", "syscon";
>         #address-cells = <1>;
>         #size-cells = <1>;
>         reg = <0xe001d000 0x8>,
>               <0xe001d0e4 0x4>;
>         clocks = <&clk32k 0>;
> };
> 
> Are translated into a syscon regmap with:
> - allowed ranges: [0x0, 0xC) u [0xE4, 0xE8)
> - invalid ranges: [0xC, 0xE0]
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/mfd/syscon.c | 158 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 143 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 191fdb87c424..fe80e6150d95 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -20,9 +20,36 @@
>  #include <linux/platform_data/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/types.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/slab.h>
>  
> +#define syscon_alloc(_dev, args...) ({					\
> +	void *_ptr;							\
> +	if (_dev)							\
> +		_ptr = devm_kzalloc((_dev), args);			\
> +	else								\
> +		_ptr = kzalloc(args);					\
> +	(_ptr);								\
> +})
> +
> +#define syscon_get_resource(_pdev, _np, _idx, _res) ({			\
> +	int _ret = -EINVAL;						\
> +	if (_pdev) {							\
> +		struct resource *_r;					\
> +		_r = platform_get_resource((_pdev), IORESOURCE_MEM, (_idx));\
> +		if (!_r) {						\
> +			_ret = -ENOMEM;					\
> +		} else {						\
> +			(_res) = *_r;					\
> +			_ret = 0;					\
> +		}							\
> +	} else if (_np) {						\
> +		_ret = of_address_to_resource((_np), (_idx), &(_res));	\
> +	}								\
> +	(_ret);								\
> +})
> +
>  static struct platform_driver syscon_driver;
>  
>  static DEFINE_SPINLOCK(syscon_list_slock);
> @@ -40,14 +67,93 @@ static const struct regmap_config syscon_regmap_config = {
>  	.reg_stride = 4,
>  };
>  
> +static const struct regmap_access_table *
> +syscon_prepare_regmap_access_table(struct platform_device *pdev,
> +				   struct device_node *np, u32 reg_io_width,
> +				   int entries)
> +{
> +	struct regmap_access_table *at;
> +	struct regmap_range *yes_ranges, *no_ranges = NULL;
> +	struct device *dev = pdev ? &pdev->dev : NULL;
> +	struct resource res;
> +	resource_size_t base_offset, offset;
> +	int i, ret;
> +
> +	/* Allocate memory for access table. */
> +	at = syscon_alloc(dev, sizeof(*at), GFP_KERNEL);
> +	if (!at)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Allocate memory for allowed ranges. */
> +	yes_ranges = syscon_alloc(dev, entries * sizeof(*yes_ranges),
> +				  GFP_KERNEL);
> +	if (!yes_ranges) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	/* Allocate memory for invalid ranges. */
> +	if (entries > 1) {
> +		no_ranges = syscon_alloc(dev,
> +					 (entries - 1) * sizeof(*no_ranges),
> +					 GFP_KERNEL);
> +		if (!no_ranges) {
> +			ret = -ENOMEM;
> +			goto free;
> +		}
> +	}
> +
> +	/* Populate allowed and invalid ranges. */
> +	ret = syscon_get_resource(pdev, np, 0, res);
> +	if (ret)
> +		goto free;
> +
> +	base_offset = res.start;
> +	yes_ranges[0].range_max = resource_size(&res) - reg_io_width;
> +	if (entries > 1)
> +		no_ranges[0].range_min = resource_size(&res);
> +
> +	for (i = 1; i < entries; i++) {
> +		ret = syscon_get_resource(pdev, np, i, res);
> +		if (ret)
> +			goto free;
> +
> +		offset = res.start - base_offset;
> +		yes_ranges[i].range_min = offset;
> +		yes_ranges[i].range_max = offset + resource_size(&res) -
> +					  reg_io_width;
> +		if (i != entries - 1)
> +			no_ranges[i].range_min = offset + resource_size(&res);
> +		no_ranges[i - 1].range_max = offset - reg_io_width;
> +	}
> +
> +	/* Store them to access table. */
> +	at->yes_ranges = yes_ranges;
> +	at->n_yes_ranges = entries;
> +	at->no_ranges = no_ranges;
> +	at->n_no_ranges = entries > 1 ? entries - 1 : 0;
> +
> +	return at;
> +
> +free:
> +	if (!dev) {
> +		kfree(no_ranges);
> +		kfree(yes_ranges);
> +		kfree(at);
> +	}
> +
> +	return ERR_PTR(ret);
> +}
> +
>  static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  {
>  	struct clk *clk;
>  	struct syscon *syscon;
>  	struct regmap *regmap;
>  	void __iomem *base;
> +	const struct regmap_access_table *at;
>  	u32 reg_io_width;
> -	int ret;
> +	int ret, n_res = 0;
>  	struct regmap_config syscon_config = syscon_regmap_config;
>  	struct resource res;
>  
> @@ -55,11 +161,29 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	if (!syscon)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (of_address_to_resource(np, 0, &res)) {
> +	/* Count the number of resources. */
> +	while (of_address_to_resource(np, n_res, &res) == 0)
> +		n_res++;
> +	if (!n_res) {
>  		ret = -ENOMEM;
>  		goto err_map;
>  	}
>  
> +	/*
> +	 * search for reg-io-width property in DT. If it is not provided,
> +	 * default to 4 bytes. regmap_init_mmio will return an error if values
> +	 * are invalid so there is no need to check them here.
> +	 */
> +	ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
> +	if (ret)
> +		reg_io_width = 4;
> +
> +	at = syscon_prepare_regmap_access_table(NULL, np, reg_io_width, n_res);
> +	if (IS_ERR(at)) {
> +		ret = PTR_ERR(at);
> +		goto err_map;
> +	}
> +
>  	base = of_iomap(np, 0);
>  	if (!base) {
>  		ret = -ENOMEM;
> @@ -74,15 +198,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	else if (of_property_read_bool(np, "native-endian"))
>  		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
>  
> -	/*
> -	 * search for reg-io-width property in DT. If it is not provided,
> -	 * default to 4 bytes. regmap_init_mmio will return an error if values
> -	 * are invalid so there is no need to check them here.
> -	 */
> -	ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
> -	if (ret)
> -		reg_io_width = 4;
> -
>  	ret = of_hwspin_lock_get_id(np, 0);
>  	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
>  		syscon_config.use_hwlock = true;
> @@ -105,7 +220,8 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  				       (u64)res.start);
>  	syscon_config.reg_stride = reg_io_width;
>  	syscon_config.val_bits = reg_io_width * 8;
> -	syscon_config.max_register = resource_size(&res) - reg_io_width;
> +	syscon_config.wr_table = at;
> +	syscon_config.rd_table = at;
>  
>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
>  	kfree(syscon_config.name);
> @@ -147,6 +263,9 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	iounmap(base);
>  err_map:
>  	kfree(syscon);
> +	kfree(at->no_ranges);
> +	kfree(at->yes_ranges);
> +	kfree(at);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -279,22 +398,31 @@ static int syscon_probe(struct platform_device *pdev)
>  	struct syscon_platform_data *pdata = dev_get_platdata(dev);
>  	struct syscon *syscon;
>  	struct regmap_config syscon_config = syscon_regmap_config;
> +	const struct regmap_access_table *at;
>  	struct resource *res;
>  	void __iomem *base;
> +	int n_res = 0;
>  
>  	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
>  	if (!syscon)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> +	/* Count the number of resources. */
> +	while (platform_get_resource(pdev, IORESOURCE_MEM, n_res))
> +		n_res++;
> +	if (!n_res)
>  		return -ENOENT;
>  
>  	base = devm_ioremap(dev, res->start, resource_size(res));
>  	if (!base)
>  		return -ENOMEM;
>  
> -	syscon_config.max_register = resource_size(res) - 4;
> +	at = syscon_prepare_regmap_access_table(pdev, NULL, 4, n_res);
> +	if (IS_ERR(at))
> +		return PTR_ERR(at);
> +
> +	syscon_config.wr_table = at;
> +	syscon_config.rd_table = at;
>  	if (pdata)
>  		syscon_config.name = pdata->label;
>  	syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
