Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C98152EF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350958AbiETPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350926AbiETPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:38:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7281790B3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s28so11868823wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0P/8s/fnquYrCgMbfh1fWaQZ42tpgsmUmRUnAJPSmHg=;
        b=KZ5P97q2qbLL7U/7vG48uFvMF+4zuU8A3EoCS1T+AuCLRTLrwPq5BL+PYqujTsyK7T
         wWeYgj/3x4buPwJWEuH+AEE6YOLuA7M5/t5icXP4JpPBGjLdjy2JvmwSBCrBtqxP5W4c
         VTC+gI9erFyC8/9TzgAw5ojYL5d+lTZ06LFEEmITg7e60MS5jBLa1wEH7IzjavSPI33R
         zEHpRDD0hSuWy5LmoKW65nKS0aKRIabXy+dY54jtDKFEbw8hZBq6uE3LQDTeNHA4s0+L
         6uvSK+u46lez7x4Gp9ToepgUIgF+UIBnCyWm//lCKQ2wds9igT0SO0glR0fS7ECJKxHm
         GPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0P/8s/fnquYrCgMbfh1fWaQZ42tpgsmUmRUnAJPSmHg=;
        b=VDNJDE0NzdMMEAt18tQTk93rmW+Q1bYRH4CYJT4vxjyCSdMWdIOhYCb1uet/ciXkdS
         QCgTGdrST7OdQq9nxQV4FsO8JX7XH0catoior3VjOSZntwrNOe4UEgacLPbfief0vJXB
         rkOSCYIOyrYdxhKb2QIoqpoWk0If6d8wWimkzNOKce7nQEg2Jk8BusDaztM9ku7vZTK4
         2brzlH2OP6BNC9JCvIGvzG4UWkbugCyX1xETNcEaZI3dAP3VkfoDS1MlxhAT2x6997Hn
         0aYLT+EF6inxd5q2PMIxYPsX2C82UKknFV9HaYaC6MpHXNOOe/C/cX+DsXd2vM+elLPK
         GAtw==
X-Gm-Message-State: AOAM5328+Sf7Dqif4lN3WER3prmeEmY8cNP4c80NnUDcKBRL9hSyirgR
        baqeatIOAa8xQgK9PqaVev7HdQ==
X-Google-Smtp-Source: ABdhPJyr5f9yvgfb4L6pqhK59EzL6jv+MJ3P41uNYdBPn2XprO5csnWJ28908wYiFL2D7eKWGsd3/A==
X-Received: by 2002:a5d:5984:0:b0:20f:c37b:d2d4 with SMTP id n4-20020a5d5984000000b0020fc37bd2d4mr1043605wri.169.1653061115823;
        Fri, 20 May 2022 08:38:35 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:41e3:1219:c56c:30b8])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b00397243d3dbcsm2319750wmq.31.2022.05.20.08.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:38:35 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] Input: mtk-pmic-keys - Move long press debounce
 mask to mtk_pmic_regs
In-Reply-To: <20220520125132.229191-5-angelogioacchino.delregno@collabora.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-5-angelogioacchino.delregno@collabora.com>
Date:   Fri, 20 May 2022 17:38:34 +0200
Message-ID: <8735h4kydh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ven., mai 20, 2022 at 14:51, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> As the second and last step of preparation to add support for more
> PMICs in this driver, move the long press debounce mask to struct
> mtk_pmic_regs and use that in mtk_pmic_keys_lp_reset_setup() instead
> of directly using the definition.
>
> While at it, remove the MTK_PMIC_RST_DU_{MASK,SHIFT} definitions, as
> these can be expressed with the GENMASK macro and a new name was
> chosen for that, as to uniform the definition names with the others
> found in this driver.
>
> Lastly, it was necessary to change the function signature of
> mtk_pmic_keys_lp_reset_setup() to now pass a pointer to the main
> mtk_pmic_regs structure, since that's what contains the reset
> debounce mask now and, for readability purposes, for this function,
> all of the references to keys->regmap were changed to use a local
> 'rmap' pointer, or the calls to regmap_{set,clear}_bits would be
> ~94 columns long.
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 33 +++++++++++++++-----------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index d8285612265f..acd5aefac5f9 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -18,11 +18,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> -#define MTK_PMIC_RST_DU_MASK		0x3
> -#define MTK_PMIC_RST_DU_SHIFT		8
> -
>  #define MTK_PMIC_MT6397_HOMEKEY_RST_EN	BIT(5)
>  #define MTK_PMIC_MT6397_PWRKEY_RST_EN	BIT(6)
> +#define MTK_PMIC_MT6397_RST_DU_MASK	GENMASK(9, 8)
>  
>  #define MTK_PMIC_PWRKEY_INDEX	0
>  #define MTK_PMIC_HOMEKEY_INDEX	1
> @@ -58,10 +56,12 @@ struct mtk_pmic_keys_regs {
>   * struct mtk_pmic_regs - PMIC Keys registers
>   * @keys_regs:           Specific key registers
>   * @pmic_rst_reg:        PMIC Keys reset register
> + * @rst_lprst_mask:      Long-press reset timeout bitmask
>   */
>  struct mtk_pmic_regs {
>  	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
>  	u32 pmic_rst_reg;
> +	u32 rst_lprst_mask;
>  };
>  
>  static const struct mtk_pmic_regs mt6397_regs = {
> @@ -72,6 +72,7 @@ static const struct mtk_pmic_regs mt6397_regs = {
>  		MTK_PMIC_KEYS_REGS(MT6397_OCSTATUS2,
>  		0x10, MT6397_INT_RSV, 0x8, MTK_PMIC_MT6397_HOMEKEY_RST_EN),
>  	.pmic_rst_reg = MT6397_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_MT6397_RST_DU_MASK,
>  };
>  
>  static const struct mtk_pmic_regs mt6323_regs = {
> @@ -82,6 +83,7 @@ static const struct mtk_pmic_regs mt6323_regs = {
>  		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
>  		0x4, MT6323_INT_MISC_CON, 0x8, MTK_PMIC_MT6397_HOMEKEY_RST_EN),
>  	.pmic_rst_reg = MT6323_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_MT6397_RST_DU_MASK,
>  };
>  
>  static const struct mtk_pmic_regs mt6358_regs = {
> @@ -94,6 +96,7 @@ static const struct mtk_pmic_regs mt6358_regs = {
>  				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa,
>  				   MTK_PMIC_MT6397_HOMEKEY_RST_EN),
>  	.pmic_rst_reg = MT6358_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_MT6397_RST_DU_MASK,
>  };
>  
>  /**
> @@ -135,24 +138,26 @@ enum mtk_pmic_keys_lp_mode {
>  };
>  
>  static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
> -		u32 pmic_rst_reg)
> +					 const struct mtk_pmic_regs *regs)
>  {
>  	int ret;
> +	struct regmap *rmap;
>  	u32 long_press_mode, long_press_debounce;
>  	const struct mtk_pmic_keys_regs *kregs_pwr;
>  	const struct mtk_pmic_keys_regs *kregs_home;
>  
>  	kregs_pwr = keys->keys[MTK_PMIC_PWRKEY_INDEX].regs;
>  	kregs_home = keys->keys[MTK_PMIC_HOMEKEY_INDEX].regs;
> +	rmap = keys->regmap;
>  
>  	ret = of_property_read_u32(keys->dev->of_node,
>  		"power-off-time-sec", &long_press_debounce);
>  	if (ret)
>  		long_press_debounce = 0;
>  
> -	regmap_update_bits(keys->regmap, pmic_rst_reg,
> -			   MTK_PMIC_RST_DU_MASK << MTK_PMIC_RST_DU_SHIFT,
> -			   long_press_debounce << MTK_PMIC_RST_DU_SHIFT);
> +	regmap_update_bits(rmap, regs->pmic_rst_reg,
> +			   regs->rst_lprst_mask,
> +			   long_press_debounce << ffs(regs->rst_lprst_mask));
>  
>  	ret = of_property_read_u32(keys->dev->of_node,
>  		"mediatek,long-press-mode", &long_press_mode);
> @@ -161,16 +166,16 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
>  
>  	switch (long_press_mode) {
>  	case LP_ONEKEY:
> -		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
> -		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
> +		regmap_set_bits(rmap, regs->pmic_rst_reg, kregs_pwr->rst_en_mask);
> +		regmap_clear_bits(rmap, regs->pmic_rst_reg, kregs_home->rst_en_mask);
>  		break;
>  	case LP_TWOKEY:
> -		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
> -		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
> +		regmap_set_bits(rmap, regs->pmic_rst_reg, kregs_pwr->rst_en_mask);
> +		regmap_set_bits(rmap, regs->pmic_rst_reg, kregs_home->rst_en_mask);
>  		break;
>  	case LP_DISABLE:
> -		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
> -		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
> +		regmap_clear_bits(rmap, regs->pmic_rst_reg, kregs_pwr->rst_en_mask);
> +		regmap_clear_bits(rmap, regs->pmic_rst_reg, kregs_home->rst_en_mask);
>  		break;
>  	default:
>  		break;
> @@ -378,7 +383,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> -	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs->pmic_rst_reg);
> +	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs);
>  
>  	platform_set_drvdata(pdev, keys);
>  
> -- 
> 2.35.1
