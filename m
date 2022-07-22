Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BF57DD8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiGVJUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiGVJTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:19:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA7175AB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:13:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t3so5131930edd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JSAECi8sgajhN4HPSrW/tW526BrlCSjcOiM42VddLYA=;
        b=QC/4tQNMWDsqBRLAmCHARVYXQFTe7n0gdL6ig+xVAHPRJJ5pZcXuQSdEUB/iIi3Fh8
         wZR+Qlu1LZqFZJ0sPrV7xY8GTuvWwl+JcDb5NbIWTBElatsQW+jzUehlUGQ2BkGZFLmP
         6ECsPxKpFJUrYODW/r6WbpNW+IoRNT3EheCykftKk6Eb21NaOxSo7E4J9XXxq26N5RpK
         dflg8EIRghDqvuOEPtU3EBZuM1EIDTSpH7LmLzDQYQqNkXOsurW5S6G4LBkzYNBsqIfS
         mj0UxAbdPRgQNMQcxx50EfGi84OcwWlW6XH4TvPR7YshM1iGnVeHcT0fbuCcr/Ln2Ctv
         a0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JSAECi8sgajhN4HPSrW/tW526BrlCSjcOiM42VddLYA=;
        b=Y+Ztnoi2X1Jg5xP9Oc4DwL1VCb+8jEy7JGbmN7pNLdpMUd8zkFXye/P5PvM062eIiG
         0/3qlkoc9Woh2GQmgLr9zUj0CLl0R0pUfiCWoPdLmj5KndAdMbmnpcCU+nXMRO8r7Mus
         XkAgmaJ7vTSXdeT5IKlDi7LylsU1UFfTnO4MOc19nz0q65JGQVo7NtIF+KiBU6UJgQJV
         ez+7J7SeGADhaCcOB9+uaV0XOH6rKAbu0kA4/7Vq1Nz7h9Z2jNzLCDnXeqBs01oUQfFg
         idZVy7vAvwAwa5Mi88xKBY8iTFLQbZoIBir4i9x+cqEU2YiB+8jWQ5RzEoOiZmeF1aWQ
         s3mw==
X-Gm-Message-State: AJIora9kTQkZSFfsg9UE2vkYTTrDDNBas0MIH24eijk6CgiKO9SesrJ/
        SpneEKkNoyxlZ1xUzyqrlyhU5Q==
X-Google-Smtp-Source: AGRyM1s61pYE1oFmicK9kBMG/TYCWQHDXwh6f4kdIxuT5FdGXlphF0OGM4Opshh0goHUmL8SR3yJSA==
X-Received: by 2002:a05:6402:331e:b0:43b:cd65:a3ed with SMTP id e30-20020a056402331e00b0043bcd65a3edmr2491102eda.118.1658481199973;
        Fri, 22 Jul 2022 02:13:19 -0700 (PDT)
Received: from blmsp ([2001:4090:a243:806e:25e7:daa:8208:ceb])
        by smtp.gmail.com with ESMTPSA id p9-20020a056402074900b00431962fe5d4sm2217523edy.77.2022.07.22.02.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 02:13:19 -0700 (PDT)
Date:   Fri, 22 Jul 2022 11:13:17 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] soc: mediatek: Add support of WAYEN operations
Message-ID: <20220722091317.c2phi3c24kpendbg@blmsp>
References: <20220530204214.913251-1-fparent@baylibre.com>
 <20220530204214.913251-2-fparent@baylibre.com>
 <fc9f18aa-fc32-c1ec-9056-e6158d0bd1ce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc9f18aa-fc32-c1ec-9056-e6158d0bd1ce@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Fri, Jun 17, 2022 at 04:20:55PM +0200, Matthias Brugger wrote:
> 
> 
> On 30/05/2022 22:42, Fabien Parent wrote:
> > From: Alexandre Bailon <abailon@baylibre.com>
> > 
> > This updates the power domain to support WAYEN operations.
> 
> Please explain better what the WAYEN operation is. Never heard of that word.

Thanks, I will clarify this in v2. I had to look it up myself. It is
basically called 'way_en' in the documents and controls the output
paths of the different units. You can select which 'ways' are enabled
with these bits. This is a bit that is present in many registers and it
is necessary for mt8365 to control it for the power domains.

Best,
Markus

> 
> Regards,
> Matthias
> 
> > This is required by the mt8365 for the MM power domain.
> > 
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >   drivers/soc/mediatek/mtk-pm-domains.c | 64 +++++++++++++++++++++------
> >   drivers/soc/mediatek/mtk-pm-domains.h | 27 ++++++-----
> >   2 files changed, 67 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> > index 5ced254b082b..90b91b3b19a8 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -44,6 +44,7 @@ struct scpsys_domain {
> >   	struct clk_bulk_data *subsys_clks;
> >   	struct regmap *infracfg;
> >   	struct regmap *smi;
> > +	struct regmap *infracfg_nao;
> >   	struct regulator *supply;
> >   };
> > @@ -116,23 +117,38 @@ static int scpsys_sram_disable(struct scpsys_domain *pd)
> >   					MTK_POLL_TIMEOUT);
> >   }
> > -static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd, struct regmap *regmap)
> > +static int _scpsys_bus_protect_enable(const struct scpsys_bus_prot_data *bpd,
> > +				      struct regmap *regmap, struct regmap *infracfg_nao)
> >   {
> >   	int i, ret;
> >   	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
> > -		u32 val, mask = bpd[i].bus_prot_mask;
> > +		u32 mask = bpd[i].bus_prot_mask;
> > +		u32 val = mask, sta_mask = mask;
> > +		struct regmap *ack_regmap = regmap;
> >   		if (!mask)
> >   			break;
> > +		if (bpd[i].wayen) {
> > +			if (!infracfg_nao)
> > +				return -ENODEV;
> > +
> > +			val = 0;
> > +			sta_mask = bpd[i].bus_prot_sta_mask;
> > +			ack_regmap = infracfg_nao;
> > +		}
> > +
> >   		if (bpd[i].bus_prot_reg_update)
> > -			regmap_set_bits(regmap, bpd[i].bus_prot_set, mask);
> > +			regmap_update_bits(regmap, bpd[i].bus_prot_set, mask, val);
> >   		else
> >   			regmap_write(regmap, bpd[i].bus_prot_set, mask);
> > -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> > -					       val, (val & mask) == mask,
> > +		if (bpd[i].ignore_clr_ack)
> > +			continue;
> > +
> > +		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
> > +					       val, (val & sta_mask) == sta_mask,
> >   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> >   		if (ret)
> >   			return ret;
> > @@ -145,34 +161,49 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
> >   {
> >   	int ret;
> > -	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg, pd->infracfg);
> > +	ret = _scpsys_bus_protect_enable(pd->data->bp_infracfg,
> > +			pd->infracfg, pd->infracfg_nao);
> >   	if (ret)
> >   		return ret;
> > -	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi);
> > +	return _scpsys_bus_protect_enable(pd->data->bp_smi, pd->smi, NULL);
> >   }
> > +#define mask_cond(wayen, val, mask) \
> > +	((wayen && ((val & mask) == mask)) || (!wayen && !(val & mask)))
> > +
> >   static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
> > -				       struct regmap *regmap)
> > +				       struct regmap *regmap, struct regmap *infracfg_nao)
> >   {
> >   	int i, ret;
> >   	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
> > -		u32 val, mask = bpd[i].bus_prot_mask;
> > +		u32 val = 0, mask = bpd[i].bus_prot_mask;
> > +		u32 sta_mask = mask;
> > +		struct regmap *ack_regmap = regmap;
> >   		if (!mask)
> >   			continue;
> > +		if (bpd[i].wayen) {
> > +			if (!infracfg_nao)
> > +				return -ENODEV;
> > +
> > +			val = mask;
> > +			sta_mask = bpd[i].bus_prot_sta_mask;
> > +			ack_regmap = infracfg_nao;
> > +		}
> > +
> >   		if (bpd[i].bus_prot_reg_update)
> > -			regmap_clear_bits(regmap, bpd[i].bus_prot_clr, mask);
> > +			regmap_update_bits(regmap, bpd[i].bus_prot_clr, mask, val);
> >   		else
> >   			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
> >   		if (bpd[i].ignore_clr_ack)
> >   			continue;
> > -		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
> > -					       val, !(val & mask),
> > +		ret = regmap_read_poll_timeout(ack_regmap, bpd[i].bus_prot_sta,
> > +					       val, mask_cond(bpd[i].wayen, val, sta_mask),
> >   					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> >   		if (ret)
> >   			return ret;
> > @@ -185,11 +216,12 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
> >   {
> >   	int ret;
> > -	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi);
> > +	ret = _scpsys_bus_protect_disable(pd->data->bp_smi, pd->smi, NULL);
> >   	if (ret)
> >   		return ret;
> > -	return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
> > +	return _scpsys_bus_protect_disable(pd->data->bp_infracfg,
> > +			pd->infracfg, pd->infracfg_nao);
> >   }
> >   static int scpsys_regulator_enable(struct regulator *supply)
> > @@ -363,6 +395,10 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
> >   			return ERR_CAST(pd->smi);
> >   	}
> > +	pd->infracfg_nao = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg_nao");
> > +	if (IS_ERR(pd->infracfg_nao))
> > +		return ERR_CAST(pd->infracfg_nao);
> > +
> >   	num_clks = of_clk_get_parent_count(node);
> >   	if (num_clks > 0) {
> >   		/* Calculate number of subsys_clks */
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> > index daa24e890dd4..a3955d960233 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.h
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> > @@ -39,23 +39,28 @@
> >   #define SPM_MAX_BUS_PROT_DATA		6
> > -#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
> > -		.bus_prot_mask = (_mask),			\
> > -		.bus_prot_set = _set,				\
> > -		.bus_prot_clr = _clr,				\
> > -		.bus_prot_sta = _sta,				\
> > -		.bus_prot_reg_update = _update,			\
> > -		.ignore_clr_ack = _ignore,			\
> > +#define _BUS_PROT(_mask, _sta_mask, _set, _clr, _sta, _update, _ignore, _wayen) {	\
> > +		.bus_prot_mask = (_mask),				\
> > +		.bus_prot_set = _set,					\
> > +		.bus_prot_clr = _clr,					\
> > +		.bus_prot_sta = _sta,					\
> > +		.bus_prot_sta_mask = _sta_mask,				\
> > +		.bus_prot_reg_update = _update,				\
> > +		.ignore_clr_ack = _ignore,				\
> > +		.wayen = _wayen,					\
> >   	}
> >   #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
> > -		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
> > +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, false, false)
> >   #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
> > -		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
> > +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, false, true, false)
> >   #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
> > -		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
> > +		_BUS_PROT(_mask, _mask, _set, _clr, _sta, true, false, false)
> > +
> > +#define BUS_PROT_WAYEN(_en_mask, _sta_mask, _set, _sta)		\
> > +		_BUS_PROT(_en_mask, _sta_mask, _set, _set, _sta, true, false, true)
> >   #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
> >   		BUS_PROT_UPDATE(_mask,				\
> > @@ -68,8 +73,10 @@ struct scpsys_bus_prot_data {
> >   	u32 bus_prot_set;
> >   	u32 bus_prot_clr;
> >   	u32 bus_prot_sta;
> > +	u32 bus_prot_sta_mask;
> >   	bool bus_prot_reg_update;
> >   	bool ignore_clr_ack;
> > +	bool wayen;
> >   };
> >   /**
> 
