Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3942452EF5C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350967AbiETPjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350916AbiETPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:38:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A38F163286
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r23so12030515wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Ch3JaRYsWBaRQyyQSaegfZcgNn3JYTpcgpD9p93zsi0=;
        b=BY1FqXli4TOEwBg63OaVGNdly8bNSEBgEeoVLGRcCl93RUHxozyzVnLWBxNiiHNnIb
         c6ZAXhhKjXBPC/ksMWrS91Ndv0miTlNWVHfZ80bJaUXIrzPs7jz2JNEP1y3KzcBbL/jL
         qVCbq5xTAu7FA5G/mHnLTq2sLuEka6UNZY3FRmyffiKmcGylcK2smkmIEAB7x294ciz2
         vDwkuiPBYDeV54G6+DudJmv90mS6nqGvhUboo7RYS7Q8MV3stCFBHNmieeUQ3e0GBTVl
         IHmyPBTRATA7v7JVyTpacijgcFCobbXEi2ZfF8RQTbd5BNZQoG+J4UgwPmYxPq3K6zuc
         oisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ch3JaRYsWBaRQyyQSaegfZcgNn3JYTpcgpD9p93zsi0=;
        b=4Gpu9sLXBxA0wyOyUWj9cBUP1BB/QbAYg6m68iORqozj9HBS+9Xzq14q8h9IlZUWrK
         ANi9yX0U7W+PKv/Y0MgxJqGVf4vm9w0wnAOUdj9u7+cSzTiHmUyb4Y4bSETA01rG+xNN
         762SDtqb3jbEjgtDd75doat3zq1OnqY+coyATkxYpPX+VEbDJodzyWXHSKqe5ks1OsvG
         R4r3VJ9g9bFWPnRCxdbtaAMtqgqwxZIjThIDp9+h52lWx4foZIu3wKBp5T1S79NaA3Ms
         Hp+44OV8Mw/bX8ubYuu15cYQcsaCAcekR6a4GYQNHEXQJtEYZ+sVvta4r3GuBY2r6y02
         hDBg==
X-Gm-Message-State: AOAM531BT7E3eEfmlYulESs2ElwwWmVmGEHgI+5R5vBv8/2TwzOQxwwr
        v2c+AH5J3MXl4c5sNsOdQ7QYmQ==
X-Google-Smtp-Source: ABdhPJzVSD4PBgB+VfBmhbz+EkcV3IHwMXyJG3ofUjWKkWJxkcPBsJJki2o9dwaQg7B0ao6+gegkvg==
X-Received: by 2002:adf:dccc:0:b0:20e:5930:9e85 with SMTP id x12-20020adfdccc000000b0020e59309e85mr8837405wrm.20.1653061112894;
        Fri, 20 May 2022 08:38:32 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:41e3:1219:c56c:30b8])
        by smtp.gmail.com with ESMTPSA id k10-20020adfc70a000000b0020c66310845sm2759639wrg.55.2022.05.20.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:38:32 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] Input: mtk-pmic-keys - Transfer per-key bit in
 mtk_pmic_keys_regs
In-Reply-To: <20220520125132.229191-4-angelogioacchino.delregno@collabora.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-4-angelogioacchino.delregno@collabora.com>
Date:   Fri, 20 May 2022 17:38:31 +0200
Message-ID: <874k1kkydk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ven., mai 20, 2022 at 14:51, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Place the key bit in struct mtk_pmic_keys_regs to enhance this
> driver's flexibility, in preparation for adding support for more
> PMICs.
>
> While at it, also remove the *_MASK and *_SHIFT definitions, as
> these can be simply expressed as BIT(x), and "slightly rename"
> the MTK_PMIC_{HOME,PWR}KEY_RST macro to better reflect the real
> name for these bits.
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 46 ++++++++++++++------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 83d0b90cc8cb..d8285612265f 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -18,17 +18,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> -#define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
> -#define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
> -#define MTK_PMIC_HOMEKEY_RST_EN_MASK	0x1
> -#define MTK_PMIC_HOMEKEY_RST_EN_SHIFT	5
>  #define MTK_PMIC_RST_DU_MASK		0x3
>  #define MTK_PMIC_RST_DU_SHIFT		8
>  
> -#define MTK_PMIC_PWRKEY_RST		\
> -	(MTK_PMIC_PWRKEY_RST_EN_MASK << MTK_PMIC_PWRKEY_RST_EN_SHIFT)
> -#define MTK_PMIC_HOMEKEY_RST		\
> -	(MTK_PMIC_HOMEKEY_RST_EN_MASK << MTK_PMIC_HOMEKEY_RST_EN_SHIFT)
> +#define MTK_PMIC_MT6397_HOMEKEY_RST_EN	BIT(5)
> +#define MTK_PMIC_MT6397_PWRKEY_RST_EN	BIT(6)
>  
>  #define MTK_PMIC_PWRKEY_INDEX	0
>  #define MTK_PMIC_HOMEKEY_INDEX	1
> @@ -40,21 +34,24 @@
>   * @deb_mask:            Bitmask of this key in status register
>   * @intsel_reg:          Interrupt selector register
>   * @intsel_mask:         Bitmask of this key in interrupt selector
> + * @rst_en_mask:         Bitmask of this key in PMIC keys reset register
>   */
>  struct mtk_pmic_keys_regs {
>  	u32 deb_reg;
>  	u32 deb_mask;
>  	u32 intsel_reg;
>  	u32 intsel_mask;
> +	u32 rst_en_mask;
>  };
>  
>  #define MTK_PMIC_KEYS_REGS(_deb_reg, _deb_mask,		\
> -	_intsel_reg, _intsel_mask)			\
> +	_intsel_reg, _intsel_mask, _rst_mask)		\
>  {							\
>  	.deb_reg		= _deb_reg,		\
>  	.deb_mask		= _deb_mask,		\
>  	.intsel_reg		= _intsel_reg,		\
>  	.intsel_mask		= _intsel_mask,		\
> +	.rst_en_mask		= _rst_mask,		\
>  }
>  
>  /**
> @@ -70,30 +67,32 @@ struct mtk_pmic_regs {
>  static const struct mtk_pmic_regs mt6397_regs = {
>  	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6397_CHRSTATUS,
> -		0x8, MT6397_INT_RSV, 0x10),
> +		0x8, MT6397_INT_RSV, 0x10, MTK_PMIC_MT6397_PWRKEY_RST_EN),
>  	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6397_OCSTATUS2,
> -		0x10, MT6397_INT_RSV, 0x8),
> +		0x10, MT6397_INT_RSV, 0x8, MTK_PMIC_MT6397_HOMEKEY_RST_EN),
>  	.pmic_rst_reg = MT6397_TOP_RST_MISC,
>  };
>  
>  static const struct mtk_pmic_regs mt6323_regs = {
>  	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> -		0x2, MT6323_INT_MISC_CON, 0x10),
> +		0x2, MT6323_INT_MISC_CON, 0x10, MTK_PMIC_MT6397_PWRKEY_RST_EN),
>  	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> -		0x4, MT6323_INT_MISC_CON, 0x8),
> +		0x4, MT6323_INT_MISC_CON, 0x8, MTK_PMIC_MT6397_HOMEKEY_RST_EN),
>  	.pmic_rst_reg = MT6323_TOP_RST_MISC,
>  };
>  
>  static const struct mtk_pmic_regs mt6358_regs = {
>  	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
> -				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5),
> +				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5,
> +				   MTK_PMIC_MT6397_PWRKEY_RST_EN),
>  	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
> -				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa),
> +				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa,
> +				   MTK_PMIC_MT6397_HOMEKEY_RST_EN),
>  	.pmic_rst_reg = MT6358_TOP_RST_MISC,
>  };
>  
> @@ -140,6 +139,11 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
>  {
>  	int ret;
>  	u32 long_press_mode, long_press_debounce;
> +	const struct mtk_pmic_keys_regs *kregs_pwr;
> +	const struct mtk_pmic_keys_regs *kregs_home;
> +
> +	kregs_pwr = keys->keys[MTK_PMIC_PWRKEY_INDEX].regs;
> +	kregs_home = keys->keys[MTK_PMIC_HOMEKEY_INDEX].regs;
>  
>  	ret = of_property_read_u32(keys->dev->of_node,
>  		"power-off-time-sec", &long_press_debounce);
> @@ -157,16 +161,16 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
>  
>  	switch (long_press_mode) {
>  	case LP_ONEKEY:
> -		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
> -		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
> +		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
> +		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
>  		break;
>  	case LP_TWOKEY:
> -		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
> -		regmap_set_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
> +		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
> +		regmap_set_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
>  		break;
>  	case LP_DISABLE:
> -		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_PWRKEY_RST);
> -		regmap_clear_bits(keys->regmap, pmic_rst_reg, MTK_PMIC_HOMEKEY_RST);
> +		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_pwr->rst_en_mask);
> +		regmap_clear_bits(keys->regmap, pmic_rst_reg, kregs_home->rst_en_mask);
>  		break;
>  	default:
>  		break;
> -- 
> 2.35.1
