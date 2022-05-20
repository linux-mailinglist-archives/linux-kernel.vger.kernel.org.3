Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECD52EF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiETPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350934AbiETPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:38:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016761796EE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u3so12016419wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ZnvK6ktuMG6z7kIuQh9oc4o9U2vLN3omm5vhkUl4qvQ=;
        b=h6ZjivXbYXLq94WOxUL4/sgzsSx6HM0CeDzJh3R/zNe5ZsF8w7YH0BPwc34Mlgy5TB
         RyOc3jMK5YlUxqQ00CNn+B2kZYZ7bSpUGx5PS59kjYX/gR6s201dtYkZGe2lD06amo5l
         i8M1uorqkR5eBdonQZi6cvqm5o0n6Fz0QhRZY1XjpSkoF/aVjJx97ISgfgHUciNnUiMC
         kw1UJ8VnRnNDxpdFHwGeM5j1dYY3IrM805smq7HREQTxyQ7kYe5/yH3qgdC3tUXRlpMt
         WYRanunRlhIdOpRRcUTbHmxuYsmvCoASN+fLAEGB4Ii1zpMqV0tmyxUIOltnsdbmWSW8
         uZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZnvK6ktuMG6z7kIuQh9oc4o9U2vLN3omm5vhkUl4qvQ=;
        b=qLlJZSRH6Aj+87rSiVAQA39l5t+hM5r9t34OaKpG6IZsudI006f4wpmeqlvEzDlGNv
         LGcsB0RQ9cCdjk0iYEhx+h+1OD/uSOUh2cCTj7oewlxvcWDmdUdv2ycSf79xlQHigSoy
         CNjcJvwtKp2vD0CsPi1C/LLyoxILGkq9ZghoC4uFxrhuNS/trfrqNXw2M9dtvDuMlE6i
         wZ8O5YsvAo5T5oU5Jna2OFamFPH4JkqkMdv64BOgQit+IvzcPKr+gLKLzxfuwlJHjoPC
         S67eQFsMh9em/WPWg4LwpkPUAtmehWBNmkyuHXmIxVfO2moae/jCdpmVpuxV8UheBnRC
         GjRg==
X-Gm-Message-State: AOAM533D8tqVMABA4PmGsK3xy/9j9RKt9ctIhTrGjE1XCyPl+qaTNVZh
        Dm4/RigXNCGfiTo5Pz38lJidFQ==
X-Google-Smtp-Source: ABdhPJxRQjeoU324RH2NZNV3sYFQW171hzOW0yMrNpMbN8+QJqIUVyPGkcsWjMf9IfheJl0o7C7ykQ==
X-Received: by 2002:adf:dec1:0:b0:20e:6313:a4a5 with SMTP id i1-20020adfdec1000000b0020e6313a4a5mr8973519wrn.659.1653061118533;
        Fri, 20 May 2022 08:38:38 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:41e3:1219:c56c:30b8])
        by smtp.gmail.com with ESMTPSA id s26-20020adfa29a000000b0020d069148bcsm2828619wra.110.2022.05.20.08.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:38:38 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Input: mtk-pmic-keys - Add support for MT6331 PMIC
 keys
In-Reply-To: <20220520125132.229191-6-angelogioacchino.delregno@collabora.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-6-angelogioacchino.delregno@collabora.com>
Date:   Fri, 20 May 2022 17:38:37 +0200
Message-ID: <871qwokyde.fsf@baylibre.com>
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

> Add support for PMIC Keys of the MT6331 PMIC.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index acd5aefac5f9..4a03fdfe8282 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6331/registers.h>
>  #include <linux/mfd/mt6358/registers.h>
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
> @@ -22,6 +23,10 @@
>  #define MTK_PMIC_MT6397_PWRKEY_RST_EN	BIT(6)
>  #define MTK_PMIC_MT6397_RST_DU_MASK	GENMASK(9, 8)
>  
> +#define MTK_PMIC_MT6331_HOMEKEY_RST_EN	BIT(8)
> +#define MTK_PMIC_MT6331_PWRKEY_RST_EN	BIT(9)
> +#define MTK_PMIC_MT6331_RST_DU_MASK	GENMASK(13, 12)
> +
>  #define MTK_PMIC_PWRKEY_INDEX	0
>  #define MTK_PMIC_HOMEKEY_INDEX	1
>  #define MTK_PMIC_MAX_KEY_COUNT	2
> @@ -86,6 +91,19 @@ static const struct mtk_pmic_regs mt6323_regs = {
>  	.rst_lprst_mask = MTK_PMIC_MT6397_RST_DU_MASK,
>  };
>  
> +static const struct mtk_pmic_regs mt6331_regs = {
> +	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x2,
> +				   MT6331_INT_MISC_CON, 0x4,
> +				   MTK_PMIC_MT6331_PWRKEY_RST_EN),
> +	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x4,
> +				   MT6331_INT_MISC_CON, 0x2,
> +				   MTK_PMIC_MT6331_HOMEKEY_RST_EN),
> +	.pmic_rst_reg = MT6331_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_MT6331_RST_DU_MASK,
> +};
> +
>  static const struct mtk_pmic_regs mt6358_regs = {
>  	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
> @@ -284,6 +302,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
>  	}, {
>  		.compatible = "mediatek,mt6323-keys",
>  		.data = &mt6323_regs,
> +	}, {
> +		.compatible = "mediatek,mt6331-keys",
> +		.data = &mt6331_regs,
>  	}, {
>  		.compatible = "mediatek,mt6358-keys",
>  		.data = &mt6358_regs,
> -- 
> 2.35.1
