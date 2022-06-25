Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE555A989
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiFYLm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiFYLmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:42:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77F1DA62;
        Sat, 25 Jun 2022 04:42:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a11so5628617ljb.5;
        Sat, 25 Jun 2022 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7RLaeJAcMzevXo6S5cuXT9EkaWQVtjtmRF8OQ1aZsmw=;
        b=cPW7eonVFazhqeHbP3DDwJ8ZvNMDH9/wuG0LDUJKKjwmn0n/yZgQHrmW7PlnlkPY68
         iE978Nqi6ko4TfhBXw28SKHOP9m0GuCnRMj3nI6b0tsL3aUgEV64rC/ZJVNXyuQNeO6N
         HJlxT/QCFF5rTu8mBRZXQUJNRSuAYHS2y2BbFxOfHD4//5tzjowlzoFRY/A+PqTpbzAR
         sId5Ltv6vDpV/+K2yuJnhn/viAs06uQAqcrd2HjpilHmk8TvxBGsHYwfQ72rzAI0WRvC
         fVkBp/IPRx4ZJj6eJWJ2Sct0R9Xepc3POPaqIPDlFEUDZDePkSpR+DZqZa5nyyzW64U2
         Bksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7RLaeJAcMzevXo6S5cuXT9EkaWQVtjtmRF8OQ1aZsmw=;
        b=3Ikyg/wY6w/DioG4JAVxw6w8iLvgbva0DyiiEnB8TvTBEofsDuC47zppCY0MYRodiA
         YvsXNNIeouV/r40ZiepQqJBD4BmLQcU5+Y0BdX7K4sSDKw42PK9jnhazMMwLD5VPfU+a
         G/M2JCIRe8qOJPaS/ZTE1f846jOZtFTfCL2vluSHd6h3FXo0MRIRZ3xmFVrVtW8nZUYU
         wLybOiK8LYnyws/vtXmrw2DZWBR5FU0nSaVEYgY4kEVLl/0J95UKVG1yeXHD6QfVuKG7
         TlE1ZRq94lbMkgODJoL2JTwJs1kKQTazqZR1uCgSYxFQ1UH4b947ESYfIzchQuh8aQ4I
         x8Tg==
X-Gm-Message-State: AJIora8/iBzdniU2UnYraOMSTi3BT+qInrmFfTPnhGM+DjerAKV+XXOr
        EFELTzdTLCe3F8A16Ep7/rJS2CFlDrs=
X-Google-Smtp-Source: AGRyM1tGmwALELYyesbJ/8S4e5EjJt8hWJvyI11otWJpcvJicDjJqxG5VdpGLTmlwEJxaFkxad/UAw==
X-Received: by 2002:a05:651c:1202:b0:25a:6096:bd7e with SMTP id i2-20020a05651c120200b0025a6096bd7emr1737854lja.304.1656157341774;
        Sat, 25 Jun 2022 04:42:21 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.118.164])
        by smtp.googlemail.com with ESMTPSA id p7-20020a2eb987000000b00255526478f1sm626574ljp.88.2022.06.25.04.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 04:42:21 -0700 (PDT)
Message-ID: <565ff879-11e4-1ae4-08d8-1237a875ef12@gmail.com>
Date:   Sat, 25 Jun 2022 14:42:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] OPP: Remove custom OPP helper support
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>, Keerthy <j-keerthy@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1653991004.git.viresh.kumar@linaro.org>
 <2e6ee73dbc8a231377547a8e9497561cadb38166.1653991004.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <2e6ee73dbc8a231377547a8e9497561cadb38166.1653991004.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.05.2022 13:10, Viresh Kumar пишет:
> The only user of the custom helper is migrated to use
> config_regulators() interface. Remove the now unused custom OPP helper
> support.
> 
> This cleans up _set_opp() and leaves a single code path to be used by
> all users.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c     | 126 +----------------------------------------
>  drivers/opp/opp.h      |   7 ---
>  include/linux/pm_opp.h |  35 ------------
>  3 files changed, 2 insertions(+), 166 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 58ce1240e808..554a043bc225 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -972,36 +972,6 @@ static int _set_opp_bw(const struct opp_table *opp_table,
>  	return 0;
>  }
>  
> -static int _set_opp_custom(const struct opp_table *opp_table,
> -			   struct device *dev, struct dev_pm_opp *opp,
> -			   unsigned long freq)
> -{
> -	struct dev_pm_set_opp_data *data = opp_table->set_opp_data;
> -	struct dev_pm_opp *old_opp = opp_table->current_opp;
> -	int size;
> -
> -	/*
> -	 * We support this only if dev_pm_opp_set_config() was called
> -	 * earlier to set regulators.
> -	 */
> -	if (opp_table->sod_supplies) {
> -		size = sizeof(*old_opp->supplies) * opp_table->regulator_count;
> -		memcpy(data->old_opp.supplies, old_opp->supplies, size);
> -		memcpy(data->new_opp.supplies, opp->supplies, size);
> -		data->regulator_count = opp_table->regulator_count;
> -	} else {
> -		data->regulator_count = 0;
> -	}
> -
> -	data->regulators = opp_table->regulators;
> -	data->clk = opp_table->clk;
> -	data->dev = dev;
> -	data->old_opp.rate = old_opp->rate;
> -	data->new_opp.rate = freq;
> -
> -	return opp_table->set_opp(data);
> -}
> -
>  static int _set_required_opp(struct device *dev, struct device *pd_dev,
>  			     struct dev_pm_opp *opp, int i)
>  {
> @@ -1186,13 +1156,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>  		}
>  	}
>  
> -	if (opp_table->set_opp) {
> -		ret = _set_opp_custom(opp_table, dev, opp, freq);
> -	} else {
> -		/* Only frequency scaling */
> -		ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
> -	}
> -
> +	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
>  	if (ret)
>  		return ret;
>  
> @@ -2054,7 +2018,6 @@ static void _opp_put_prop_name(struct opp_table *opp_table)
>  static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
>  			       const char * const names[], unsigned int count)
>  {
> -	struct dev_pm_opp_supply *supplies;
>  	struct regulator *reg;
>  	int ret, i;
>  
> @@ -2082,20 +2045,8 @@ static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
>  
>  	opp_table->regulator_count = count;
>  
> -	supplies = kmalloc_array(count * 2, sizeof(*supplies), GFP_KERNEL);
> -	if (!supplies) {
> -		ret = -ENOMEM;
> -		goto free_regulators;
> -	}
> -
> -	mutex_lock(&opp_table->lock);
> -	opp_table->sod_supplies = supplies;
> -	if (opp_table->set_opp_data) {
> -		opp_table->set_opp_data->old_opp.supplies = supplies;
> -		opp_table->set_opp_data->new_opp.supplies = supplies + count;
> -	}
> -
>  	/* Set generic config_regulators() for single regulators here */
> +	mutex_lock(&opp_table->lock);
>  	if (count == 1)
>  		opp_table->config_regulators = _opp_config_regulator_single;
>  	mutex_unlock(&opp_table->lock);
> @@ -2132,16 +2083,6 @@ static void _opp_put_regulators(struct opp_table *opp_table)
>  	for (i = opp_table->regulator_count - 1; i >= 0; i--)
>  		regulator_put(opp_table->regulators[i]);
>  
> -	mutex_lock(&opp_table->lock);
> -	if (opp_table->set_opp_data) {
> -		opp_table->set_opp_data->old_opp.supplies = NULL;
> -		opp_table->set_opp_data->new_opp.supplies = NULL;
> -	}
> -
> -	kfree(opp_table->sod_supplies);
> -	opp_table->sod_supplies = NULL;
> -	mutex_unlock(&opp_table->lock);
> -
>  	kfree(opp_table->regulators);
>  	opp_table->regulators = NULL;
>  	opp_table->regulator_count = -1;
> @@ -2195,61 +2136,6 @@ static void _opp_put_clkname(struct opp_table *opp_table)
>  	}
>  }
>  
> -/**
> - * _opp_register_set_opp_helper() - Register custom set OPP helper
> - * @dev: Device for which the helper is getting registered.
> - * @set_opp: Custom set OPP helper.
> - *
> - * This is useful to support complex platforms (like platforms with multiple
> - * regulators per device), instead of the generic OPP set rate helper.
> - *
> - * This must be called before any OPPs are initialized for the device.
> - */
> -static int _opp_register_set_opp_helper(struct opp_table *opp_table,
> -	struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data))
> -{
> -	struct dev_pm_set_opp_data *data;
> -
> -	/* Another CPU that shares the OPP table has set the helper ? */
> -	if (opp_table->set_opp)
> -		return 0;
> -
> -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> -	mutex_lock(&opp_table->lock);
> -	opp_table->set_opp_data = data;
> -	if (opp_table->sod_supplies) {
> -		data->old_opp.supplies = opp_table->sod_supplies;
> -		data->new_opp.supplies = opp_table->sod_supplies +
> -					 opp_table->regulator_count;
> -	}
> -	mutex_unlock(&opp_table->lock);
> -
> -	opp_table->set_opp = set_opp;
> -
> -	return 0;
> -}
> -
> -/**
> - * _opp_unregister_set_opp_helper() - Releases resources blocked for set_opp helper
> - * @opp_table: OPP table returned from _opp_register_set_opp_helper().
> - *
> - * Release resources blocked for platform specific set_opp helper.
> - */
> -static void _opp_unregister_set_opp_helper(struct opp_table *opp_table)
> -{
> -	if (opp_table->set_opp) {
> -		opp_table->set_opp = NULL;
> -
> -		mutex_lock(&opp_table->lock);
> -		kfree(opp_table->set_opp_data);
> -		opp_table->set_opp_data = NULL;
> -		mutex_unlock(&opp_table->lock);
> -	}
> -}
> -
>  /**
>   * _opp_set_config_regulators_helper() - Register custom set regulator helper.
>   * @dev: Device for which the helper is getting registered.
> @@ -2447,13 +2333,6 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
>  			goto err;
>  	}
>  
> -	/* Configure opp helper */
> -	if (config->set_opp) {
> -		ret = _opp_register_set_opp_helper(opp_table, dev, config->set_opp);
> -		if (ret)
> -			goto err;
> -	}
> -
>  	/* Configure config_regulators helper */
>  	if (config->config_regulators) {
>  		ret = _opp_set_config_regulators_helper(opp_table, dev, config->config_regulators);
> @@ -2516,7 +2395,6 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table)
>  	_opp_put_regulators(opp_table);
>  	_opp_put_supported_hw(opp_table);
>  	_opp_put_config_regulators_helper(opp_table);
> -	_opp_unregister_set_opp_helper(opp_table);
>  	_opp_put_prop_name(opp_table);
>  	_opp_put_clkname(opp_table);
>  
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 4695d315e7f9..407eee9f10ab 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -161,9 +161,6 @@ enum opp_table_access {
>   * @enabled: Set to true if the device's resources are enabled/configured.
>   * @genpd_performance_state: Device's power domain support performance state.
>   * @is_genpd: Marks if the OPP table belongs to a genpd.
> - * @set_opp: Platform specific set_opp callback
> - * @sod_supplies: Set opp data supplies
> - * @set_opp_data: Data to be passed to set_opp callback
>   * @dentry:	debugfs dentry pointer of the real device directory (not links).
>   * @dentry_name: Name of the real dentry.
>   *
> @@ -213,10 +210,6 @@ struct opp_table {
>  	bool genpd_performance_state;
>  	bool is_genpd;
>  
> -	int (*set_opp)(struct dev_pm_set_opp_data *data);
> -	struct dev_pm_opp_supply *sod_supplies;
> -	struct dev_pm_set_opp_data *set_opp_data;
> -
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dentry;
>  	char dentry_name[NAME_MAX];
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 185503aab64d..c6d8f01ef9fd 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -57,39 +57,6 @@ struct dev_pm_opp_icc_bw {
>  	u32 peak;
>  };
>  
> -/**
> - * struct dev_pm_opp_info - OPP freq/voltage/current values
> - * @rate:	Target clk rate in hz
> - * @supplies:	Array of voltage/current values for all power supplies
> - *
> - * This structure stores the freq/voltage/current values for a single OPP.
> - */
> -struct dev_pm_opp_info {
> -	unsigned long rate;
> -	struct dev_pm_opp_supply *supplies;
> -};
> -
> -/**
> - * struct dev_pm_set_opp_data - Set OPP data
> - * @old_opp:	Old OPP info
> - * @new_opp:	New OPP info
> - * @regulators:	Array of regulator pointers
> - * @regulator_count: Number of regulators
> - * @clk:	Pointer to clk
> - * @dev:	Pointer to the struct device
> - *
> - * This structure contains all information required for setting an OPP.
> - */
> -struct dev_pm_set_opp_data {
> -	struct dev_pm_opp_info old_opp;
> -	struct dev_pm_opp_info new_opp;
> -
> -	struct regulator **regulators;
> -	unsigned int regulator_count;
> -	struct clk *clk;
> -	struct device *dev;
> -};
> -
>  typedef int (*config_regulators_t)(struct device *dev, struct dev_pm_opp *old_opp,
>  				   struct dev_pm_opp *new_opp, struct regulator **regulators,
>  				   unsigned int count);
> @@ -97,7 +64,6 @@ typedef int (*config_regulators_t)(struct device *dev, struct dev_pm_opp *old_op
>   * struct dev_pm_opp_config - Device OPP configuration values
>   * @clk_name: Clk name.
>   * @prop_name: Name to postfix to properties.
> - * @set_opp: Custom set OPP helper.
>   * @config_regulators: Custom set regulator helper.
>   * @supported_hw: Array of hierarchy of versions to match.
>   * @supported_hw_count: Number of elements in the array.
> @@ -111,7 +77,6 @@ typedef int (*config_regulators_t)(struct device *dev, struct dev_pm_opp *old_op
>  struct dev_pm_opp_config {
>  	const char *clk_name;
>  	const char *prop_name;
> -	int (*set_opp)(struct dev_pm_set_opp_data *data);
>  	config_regulators_t config_regulators;
>  	unsigned int *supported_hw;
>  	unsigned int supported_hw_count;

Hello Viresh,

Unfortunately we can't remove the set_opp_helper(). It's terrible that
this function is unused by Tegra 3d driver because it should be used.

The patch that supposed to use the devm_pm_opp_register_set_opp_helper()
[1] was merged a half year ago and just today I noticed that the merged
code doesn't have devm_pm_opp_register_set_opp_helper() [2]. I think
Thierry edited my patch before applying it, perhaps there was a merge
conflict :/ This needs to be fixed now.

[1] https://lore.kernel.org/all/20210817012754.8710-16-digetx@gmail.com/

[2]
https://elixir.bootlin.com/linux/v5.19-rc3/source/drivers/gpu/drm/tegra/gr3d.c#L535
