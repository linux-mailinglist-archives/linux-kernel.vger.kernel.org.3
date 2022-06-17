Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FDC54F90C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382663AbiFQOVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiFQOVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:21:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EAF443F5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:20:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m24so5954716wrb.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DiUqu/ZvQMOhjtUVfOlgfb3YMlzVWJ3V5xvmxD/pgOo=;
        b=Kf/CeLJMAEn0XCZZoL763C6InA7fYrW3/0r08jUFf/0bN3UqkcghfdNrNmY2R7g+R9
         SGQul+4nxXssTOIA2IhYn5UWTTyTb+OufWoeUr1WWBI2ZWcmm1vRW6xcO+Ihk3nKYAdL
         /f6v2hMRfwRpol0pUg3yhuFRxHIL8LUipnCUZH38Ry+fZXY2ajHi8le/S5o8RiG2t9aO
         uZ+eGCnuvLwzFcSVjvWo9KNJnk0AxGvE6NX0GwhE4draaYD1AZqBxR152b9xtWxcDUla
         0MZ0SeYlwRlYMAe0Ta80Vj3k+7s0a4H+aBaI80pDfVcddIZ4jF7+ILVlf4z16ZbWQl9B
         SjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DiUqu/ZvQMOhjtUVfOlgfb3YMlzVWJ3V5xvmxD/pgOo=;
        b=syEnPZKlbIC4Rk/mFChOwDMCaKlpssKdjsNZtr46oZFW5t2Ep1WA0vhZ6zTuuHacch
         SWpvKR4bhuLjdkM6G0Z8yaBYkhTO72Qbkbi4iK5MbqNtS3m8Mb69KOAXtgDk7jRmlaDt
         iEeOJmvcT1pN18E0QTp0jT1/iLlQTH53Y5clh6DH/mvHcF9evhfL/4SsOP3X+A2+2JVe
         UzNAzre0oixY6JTQxBJGWSjKiF1N/ZOpJLd9JsYMqlcRxyy9JjxWvOIEFYf+KB/IkO1s
         CTN6R4W9EwZLfPicEaYh53MhJ6aIjeSajYcrfJlwCG+YZdivoe0M9o3kNJIiwtEtgAdh
         CYVg==
X-Gm-Message-State: AJIora/azmiTaHTNGFMPdSJ9PtE4E+RLhFHMBNguyslSx99NQOZp6jno
        mvUB40wJPRHyebjzYP++Wp+hHi2z5Fsi+Q==
X-Google-Smtp-Source: AGRyM1srTE67A9a63p6nduZvVQjcBeOscO0fRW1gvDbt3V9Q+jeuxrZQd6n86OSPkaXKnqZhikdKRQ==
X-Received: by 2002:a5d:5a18:0:b0:21a:2b34:7074 with SMTP id bq24-20020a5d5a18000000b0021a2b347074mr9555683wrb.590.1655475657348;
        Fri, 17 Jun 2022 07:20:57 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id v6-20020a1cac06000000b0039c673952bfsm9448983wme.6.2022.06.17.07.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 07:20:56 -0700 (PDT)
Message-ID: <fc9f18aa-fc32-c1ec-9056-e6158d0bd1ce@gmail.com>
Date:   Fri, 17 Jun 2022 16:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] soc: mediatek: Add support of WAYEN operations
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220530204214.913251-1-fparent@baylibre.com>
 <20220530204214.913251-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220530204214.913251-2-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2022 22:42, Fabien Parent wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This updates the power domain to support WAYEN operations.

Please explain better what the WAYEN operation is. Never heard of that word.

Regards,
Matthias

> This is required by the mt8365 for the MM power domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c | 64 +++++++++++++++++++++------
>   drivers/soc/mediatek/mtk-pm-domains.h | 27 ++++++-----
>   2 files changed, 67 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 5ced254b082b..90b91b3b19a8 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -44,6 +44,7 @@ struct scpsys_domain {
>   	struct clk_bulk_data *subsys_clks;
>   	struct regmap *infracfg;
>   	struct regmap *smi;
> +	struct regmap *infracfg_nao;
>   	struct regulator *supply;
>   };
>   
> @@ -116,23 +117,38 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
>   					MTK_POLL_TIMEOUT);
>   }
>   
> -static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
> +static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
> +				      struct regmap *regmap, struct regmap *infracfg_nao)
>   {
>   	int i, ret;
>   
>   	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> -		u32 val, mask = bpd[i].bus_prot_mask;
> +		u32 mask = bpd[i].bus_prot_mask;
> +		u32 val = mask, sta_mask = mask;
> +		struct regmap *ack_regmap = regmap;
>   
>   		if (!mask)
>   			break;
>   
> +		if (bpd[i].wayen) {
> +			if (!infracfg_nao)
> +				return -ENODEV;
> +
> +			val = 0;
> +			sta_mask = bpd[i].bus_prot_sta_mask;
> +			ack_regmap = infracfg_nao;
> +		}
> +
>   		if (bpd[i].bus_prot_reg_update)
> -			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
> +			regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, val);
>   		else
>   			regmap_write(regmap, bpd[i].bus_prot_set, mask);
>   
> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> -					       val, (val & mask) == mask,
> +		if (bpd[i].ignore_clr_ack)
> +			continue;
> +
> +		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
> +					       val, (val & sta_mask) == sta_mask,
>   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   		if (ret)
>   			return ret;
> @@ -145,34 +161,49 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>   {
>   	int ret;
>   
> -	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
> +	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg,
> +			pd->infracfg, pd->infracfg_nao);
>   	if (ret)
>   		return ret;
>   
> -	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
> +	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
>   }
>   
> +#define mask_cond(wayen, val, mask) \
> +	((wayen && ((val & mask) == mask)) || (!wayen && !(val & mask)))
> +
>   static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> -				       struct regmap *regmap)
> +				       struct regmap *regmap, struct regmap *infracfg_nao)
>   {
>   	int i, ret;
>   
>   	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
> -		u32 val, mask = bpd[i].bus_prot_mask;
> +		u32 val = 0, mask = bpd[i].bus_prot_mask;
> +		u32 sta_mask = mask;
> +		struct regmap *ack_regmap = regmap;
>   
>   		if (!mask)
>   			continue;
>   
> +		if (bpd[i].wayen) {
> +			if (!infracfg_nao)
> +				return -ENODEV;
> +
> +			val = mask;
> +			sta_mask = bpd[i].bus_prot_sta_mask;
> +			ack_regmap = infracfg_nao;
> +		}
> +
>   		if (bpd[i].bus_prot_reg_update)
> -			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
> +			regmap_update_bits(regmap, bpd[i].bus_prot_clr, mask, val);
>   		else
>   			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
>   
>   		if (bpd[i].ignore_clr_ack)
>   			continue;
>   
> -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> -					       val, !(val & mask),
> +		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
> +					       val, mask_cond(bpd[i].wayen, val, sta_mask),
>   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>   		if (ret)
>   			return ret;
> @@ -185,11 +216,12 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
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
> @@ -363,6 +395,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   			return ERR_CAST(pd->smi);
>   	}
>   
> +	pd->infracfg_nao = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg_nao");
> +	if (IS_ERR(pd->infracfg_nao))
> +		return ERR_CAST(pd->infracfg_nao);
> +
>   	num_clks = of_clk_get_parent_count(node);
>   	if (num_clks > 0) {
>   		/* Calculate number of subsys_clks */
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index daa24e890dd4..a3955d960233 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -39,23 +39,28 @@
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
> +#define _BUS_PROT(_mask, _sta_mask, _set, _clr, _sta, _update, _ignore, _wayen) {	\
> +		.bus_prot_mask = (_mask),				\
> +		.bus_prot_set = _set,					\
> +		.bus_prot_clr = _clr,					\
> +		.bus_prot_sta = _sta,					\
> +		.bus_prot_sta_mask = _sta_mask,				\
> +		.bus_prot_reg_update = _update,				\
> +		.ignore_clr_ack = _ignore,				\
> +		.wayen = _wayen,					\
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
> +#define BUS_PROT_WAYEN(_en_mask, _sta_mask, _set, _sta)		\
> +		_BUS_PROT(_en_mask, _sta_mask, _set, _set, _sta, true, false, true)
>   
>   #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
>   		BUS_PROT_UPDATE(_mask,				\
> @@ -68,8 +73,10 @@ struct scpsys_bus_prot_data {
>   	u32 bus_prot_set;
>   	u32 bus_prot_clr;
>   	u32 bus_prot_sta;
> +	u32 bus_prot_sta_mask;
>   	bool bus_prot_reg_update;
>   	bool ignore_clr_ack;
> +	bool wayen;
>   };
>   
>   /**
