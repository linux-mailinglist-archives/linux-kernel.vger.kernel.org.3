Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E619B59C3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiHVQSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiHVQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:18:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB14C33E2C;
        Mon, 22 Aug 2022 09:18:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so8069115wma.4;
        Mon, 22 Aug 2022 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=6ixFGQG5e9RKRZHpz9Cu92U2YnlZwaXuKgNBpkgvxkE=;
        b=cDRpGmx7LsRKFvYcCRTxTVMl8aKQmv5vX5bo6SPWyEkhiLqp9QMkwVYRNC5BAZ+wR1
         BOoSjyuKZKEu8Z3NSX8Wj92W4KlpRO3iOzt5mVwVTusK5Om+hzKibrjEU0PugeP9PoyA
         nhQJwgIqiDRGyikQzvIyF+0Q6hN2k28XSiBNTkgXvI6kBdOrnylNh6OmRers2WVhyMhX
         UIfaA8iC70+0PYVxTQPvcPMxmM+/2cAAPBcd34RKK+MpOchyR/SEXb8giLxR/jLy1bOx
         dH1WYp+JDfi0ATjYj/NiKnnKiNNFCUOYGBoWo12MJrdhGmHUocs0GsCDrkQ4GE46bMtw
         aLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6ixFGQG5e9RKRZHpz9Cu92U2YnlZwaXuKgNBpkgvxkE=;
        b=7mI1xzCkL6YKLM84oPsDwf5OS4YKFivG7N3SAHMH0cWWTy1rzTLUN9bXzCJPxjU/vc
         QdqIUzR4r2WPFeo5hGcoWXWhvjpqvrxydBC06Jtkty7nlxysI2R6KiFSp5f2yKYVMy1d
         gsu9BFuQGRTZduJ6KZt433iQHORbyLYsl9wo5pr0ua+fwyk6Og//DmFj2oNydLfAOYuL
         NhfCz9QOsiT9C4FxfUTY52k7IB8gBTtab48FCLa+oSs1O0NHH41Bl4lWPfRn+y+TZ/Fo
         Y8xWK77r2H8N9lmkRvctJ/Xr22mwztAGFu7BOK5A9b6gR7YX5MmYt6Ubr8RL1/5iK1Kk
         pP3g==
X-Gm-Message-State: ACgBeo0vdFWxiyeKsVwjuPlB47USWOaI6H/pzKbuISKn5P/13iyePxSR
        KyJ8VvMV7rwDEhA0lwgutomwR/tpo70=
X-Google-Smtp-Source: AA6agR7y7pHj5qGSGOXHJmt+ZxMtu/Zf41zSLzBGKYd5mK6HGK789VisccjsBBRadh0oYVXV5FulIw==
X-Received: by 2002:a05:600c:502b:b0:3a5:d36a:8b93 with SMTP id n43-20020a05600c502b00b003a5d36a8b93mr15707189wmr.180.1661185081107;
        Mon, 22 Aug 2022 09:18:01 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c511700b003a5c1e916c8sm17342525wms.1.2022.08.22.09.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 09:17:59 -0700 (PDT)
Message-ID: <36dde9aa-b6ea-7194-c1bc-94d52c02649b@gmail.com>
Date:   Mon, 22 Aug 2022 18:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
References: <20220822144303.3438467-1-msp@baylibre.com>
 <20220822144303.3438467-3-msp@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 2/4] soc: mediatek: Add support of WAY_EN operations
In-Reply-To: <20220822144303.3438467-3-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/08/2022 16:43, Markus Schneider-Pargmann wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This updates the power domain to support WAY_EN operations. These
> operations enable a path between different units of the chip and are
> labeled as 'way_en' in the register descriptions.
> 
> This operation is required by the mt8365 for the MM power domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> 
> Notes:
>      Changes in v3:
>      - Separated the way_en functions for clarity
>      - Added some checks for infracfg_nao
>      
>      Changes in v2:
>      - some minor style fixes.
>      - Renamed 'wayen' to 'way_en' to clarify the meaning
>      - Updated commit message
> 
>   drivers/soc/mediatek/mtk-pm-domains.c | 162 +++++++++++++++++++++-----
>   drivers/soc/mediatek/mtk-pm-domains.h |  28 +++--
>   2 files changed, 149 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 9734f1091c69..c2cbe0de6aa1 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -43,6 +43,7 @@ struct scpsys_domain {
>   	struct clk_bulk_data *clks;
>   	int num_subsys_clks;
>   	struct clk_bulk_data *subsys_clks;
> +	struct regmap *infracfg_nao;
>   	struct regmap *infracfg;
>   	struct regmap *smi;
>   	struct regulator *supply;
> @@ -117,26 +118,61 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>   					MTK_POLL_TIMEOUT);
>   }
>   
> -static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
> +static int __scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
> +				       struct regmap *regmap)
> +{
> +	u32 val;
> +	u32 mask = bpd->bus_prot_mask;
> +	u32 sta_mask = bpd->bus_prot_sta_mask;
> +
> +	if (bpd->bus_prot_reg_update)
> +		regmap_set_bits(regmap, bpd->bus_prot_set, mask);
> +	else
> +		regmap_write(regmap, bpd->bus_prot_set, mask);
> +
> +	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta, val,
> +					(val & sta_mask) == sta_mask,
> +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +static int scpsys_bus_way_disable(const struct scpsys_bus_prot_data *bpd,
> +				  struct regmap *regmap,
> +				  struct regmap *ack_regmap)
> +{
> +	u32 val;
> +	u32 mask = bpd->bus_prot_mask;
> +	u32 sta_mask = bpd->bus_prot_sta_mask;
> +
> +	if (bpd->bus_prot_reg_update)
> +		regmap_clear_bits(regmap, bpd->bus_prot_set, mask);
> +	else
> +		regmap_write(regmap, bpd->bus_prot_set, mask);
> +
> +	if (bpd->ignore_clr_ack)
> +		return 0;
> +
> +	return regmap_read_poll_timeout(ack_regmap, bpd->bus_prot_sta, val,
> +					(val & sta_mask) == sta_mask,
> +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
> +				      struct regmap *regmap, struct regmap *infracfg_nao)
>   {
>   	int i, ret;
>   
>   	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> -		u32 val, mask = bpd[i].bus_prot_mask;
> -
> -		if (!mask)
> +		if (!bpd[i].bus_prot_mask)
>   			break;
>   
> -		if (bpd[i].bus_prot_reg_update)
> -			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
> +		if (bpd[i].way_en)
> +			ret = scpsys_bus_way_disable(&bpd[i], regmap, infracfg_nao);
>   		else
> -			regmap_write(regmap, bpd[i].bus_prot_set, mask);
> -
> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> -					       val, (val & mask) == mask,
> -					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -		if (ret)
> +			ret = __scpsys_bus_protect_enable(&bpd[i], regmap);
> +		if (ret) {
> +			pr_err("%s %d %d\n", __PRETTY_FUNCTION__, __LINE__, ret);
>   			return ret;
> +		}
>   	}
>   
>   	return 0;
> @@ -146,37 +182,71 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>   {
>   	int ret;
>   
> -	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
> +	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg,
> +					 pd->infracfg, pd->infracfg_nao);
>   	if (ret)
>   		return ret;
>   
> -	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
> +	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
> +}
> +
> +static int __scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> +					struct regmap *regmap)
> +{
> +	u32 val;
> +	u32 mask = bpd->bus_prot_mask;
> +	u32 sta_mask = bpd->bus_prot_sta_mask;
> +
> +	if (bpd->bus_prot_reg_update)
> +		regmap_clear_bits(regmap, bpd->bus_prot_clr, mask);
> +	else
> +		regmap_write(regmap, bpd->bus_prot_clr, mask);
> +
> +	if (bpd->ignore_clr_ack)
> +		return 0;
> +
> +	return regmap_read_poll_timeout(regmap, bpd->bus_prot_sta, val,
> +					!(val & sta_mask), MTK_POLL_DELAY_US,
> +					MTK_POLL_TIMEOUT);
> +}
> +
> +static int scpsys_bus_way_enable(const struct scpsys_bus_prot_data *bpd,
> +				 struct regmap *regmap,
> +				 struct regmap *ack_regmap)
> +{
> +	u32 val;
> +	u32 mask = bpd->bus_prot_mask;
> +	u32 sta_mask = bpd->bus_prot_sta_mask;
> +
> +	if (bpd->bus_prot_reg_update)
> +		regmap_set_bits(regmap, bpd->bus_prot_clr, mask);
> +	else
> +		regmap_write(regmap, bpd->bus_prot_clr, mask);
> +
> +	return regmap_read_poll_timeout(ack_regmap, bpd->bus_prot_sta, val,
> +					(val & sta_mask) == sta_mask,
> +					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   }
>   
>   static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> -				       struct regmap *regmap)
> +				       struct regmap *regmap,
> +				       struct regmap *infracfg_nao)
>   {
>   	int i, ret;
>   
>   	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
> -		u32 val, mask = bpd[i].bus_prot_mask;
> -
> -		if (!mask)
> +		if (!bpd[i].bus_prot_mask)
>   			continue;
>   
> -		if (bpd[i].bus_prot_reg_update)
> -			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
> +		if (bpd[i].way_en)
> +			ret = scpsys_bus_way_enable(&bpd[i], regmap,
> +						    infracfg_nao);
>   		else
> -			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
> -
> -		if (bpd[i].ignore_clr_ack)
> -			continue;
> -
> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> -					       val, !(val & mask),
> -					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -		if (ret)
> +			ret = __scpsys_bus_protect_disable(&bpd[i], regmap);
> +		if (ret) {
> +			pr_err("%s %d %d\n", __PRETTY_FUNCTION__, __LINE__, ret);
>   			return ret;
> +		}
>   	}
>   
>   	return 0;
> @@ -186,11 +256,12 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>   {
>   	int ret;
>   
> -	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
> +	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi, NULL);
>   	if (ret)
>   		return ret;
>   
> -	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
> +	return _scpsys_bus_protect_disable(pd->data->bp_infracfg,
> +			pd->infracfg, pd->infracfg_nao);
>   }
>   
>   static int scpsys_regulator_enable(struct regulator *supply)
> @@ -294,6 +365,21 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   	return 0;
>   }
>   
> +static bool scpsys_bp_infracfg_has_way_en(const struct scpsys_bus_prot_data *bpd)
> +{
> +	int i;
> +
> +	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> +		if (!bpd[i].bus_prot_mask)
> +			break;

So MT8365_POWER_DOMAIN_MM will return false as the first member of bp_infracfg 
is BUS_PROT_WR(...)

Apart from that, why don't you use a CAPS to acheive the same?

> +
> +		if (bpd[i].way_en)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static struct
>   generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
>   {
> @@ -364,6 +450,20 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   			return ERR_CAST(pd->smi);
>   	}
>   
> +	if (scpsys_bp_infracfg_has_way_en(pd->data->bp_smi)) {
> +		dev_err(scpsys->dev, "bp_smi does not support WAY_EN\n");

Do we really need to check the correctness of the driver data at runtime?

> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	pd->infracfg_nao = syscon_regmap_lookup_by_phandle_optional(
> +		node, "mediatek,infracfg_nao");

Not in the binding description.

> +	if (IS_ERR(pd->infracfg_nao)) {
> +		if (scpsys_bp_infracfg_has_way_en(pd->data->bp_infracfg))
> +			return ERR_CAST(pd->infracfg_nao);
> +
> +		pd->infracfg_nao = NULL;
> +	}
> +
>   	num_clks = of_clk_get_parent_count(node);
>   	if (num_clks > 0) {
>   		/* Calculate number of subsys_clks */
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 7d3c0c36316c..974c68a1d89c 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -41,23 +41,29 @@
>   
>   #define SPM_MAX_BUS_PROT_DATA		6
>   
> -#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
> -		.bus_prot_mask = (_mask),			\
> -		.bus_prot_set = _set,				\
> -		.bus_prot_clr = _clr,				\
> -		.bus_prot_sta = _sta,				\
> -		.bus_prot_reg_update = _update,			\
> -		.ignore_clr_ack = _ignore,			\
> +#define _BUS_PROT(_mask, _sta_mask, _set, _clr, _sta, _update, _ignore, _way_en) {	\
> +		.bus_prot_mask = (_mask),				\
> +		.bus_prot_set = _set,					\
> +		.bus_prot_clr = _clr,					\
> +		.bus_prot_sta = _sta,					\
> +		.bus_prot_sta_mask = _sta_mask,				\
> +		.bus_prot_reg_update = _update,				\
> +		.ignore_clr_ack = _ignore,				\
> +		.way_en = _way_en,					\
>   	}
>   
>   #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
> -		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
> +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, false, false)
>   
>   #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
> +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, true, false)
>   
>   #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
> -		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
> +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, true, false, false)
> +
> +#define BUS_PROT_WAY_EN(_en_mask, _sta_mask, _set, _sta)	\
> +		_BUS_PROT(_en_mask, _sta_mask, _set, _set, _sta, true, false, \
> +			  true)
>   
>   #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
>   		BUS_PROT_UPDATE(_mask,				\
> @@ -70,8 +76,10 @@ struct scpsys_bus_prot_data {
>   	u32 bus_prot_set;
>   	u32 bus_prot_clr;
>   	u32 bus_prot_sta;
> +	u32 bus_prot_sta_mask;

I'm not very happy with the naming. In the end we need an extra mask for bus 
protection using WAY_EN. But right now I can't come up with a good name.

Regards,
Matthias

>   	bool bus_prot_reg_update;
>   	bool ignore_clr_ack;
> +	bool way_en;
>   };
>   
>   /**
