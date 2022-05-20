Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC3352EF55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350910AbiETPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350895AbiETPi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:38:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093849D05F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay35so3118606wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=KlTBSZCWETh0qqX3A/oaLoFw8iSftzDLWzA01akJKxg=;
        b=YKQx/qpV28LqgncJMSUr4z1xp9nkwl2mmdiicFVWyHjq92MnczTC/9mXrmsn93wyCy
         wFCR0QsE+x7Esb45znQTf84kFvBGBHoN0ilIJYwu/2trDcd7udMjYtAJDrA4YX/smL+F
         rBRJ3v2mnr+4wMuXjedjiXUKGWacQuP/F+H4met3+hNYDdLaKudMdXAFuPqGTli7O0rJ
         8+NsmNyH7PI4U/QVjRUxcZ80FxF+A7BXpAmyA6cwmw6+LRg+UcGyEQfyAN+0yzos67Ib
         DpPB333O6TzICix4LxHyO3zc8/Di6Qqpqfc4DjvfdwI0L1GZIl60I9fgHUkrw4ctsbtx
         aNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KlTBSZCWETh0qqX3A/oaLoFw8iSftzDLWzA01akJKxg=;
        b=ObH+FM/c0sU+25uvDOO0FcXKDEQnr9gGRsn5Yq9G8NKBrpiXXNpqvq5E5lPDvzNEpW
         w7hRfxdDZbEgeTjyvmnb6Rj9S8TejZkll/89KGqY2OvdEyQ2GNNecvEMBfZrWr/ikbvq
         BbwoP39cQwdIyDjUhBfOojNLAeqLCILWyCbBr6TQL6ulg041OFKD4sKmIzvHZqPF7m5O
         mwtUYEX/ae4OPud1tGZVMWd2ctQRrrnqaCg5C1xWfkgFYPqo90K3fTkLBBnZgmPv+cJp
         ap/KX8Ng/Ow9yrPlDh2dw5dyz+y9ApYCOKoBIfgF8OC1eXEy44hDc+JujPQp9HwR7tFV
         ohSA==
X-Gm-Message-State: AOAM533X9kUzLJAHjpdOkgSyOYot2Z+0y0q0E78t8f+6mLyyfleZnrUu
        126z1Nr0/FZXs0UGCVPzIUTRBQ==
X-Google-Smtp-Source: ABdhPJwvNeH+3EcmO9Gjw9QylbVZH6UgN/87pGUvZeHn8yPRnsZtjsWDiANEQFEqqO5/56LsMdfETw==
X-Received: by 2002:a7b:c20d:0:b0:397:335e:dc7b with SMTP id x13-20020a7bc20d000000b00397335edc7bmr6556391wmi.93.1653061106496;
        Fri, 20 May 2022 08:38:26 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:41e3:1219:c56c:30b8])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c338400b00394708a3d7dsm2266641wmp.15.2022.05.20.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:38:25 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: mtk-pmic-keys - Add kerneldoc to driver
 structures
In-Reply-To: <20220520125132.229191-2-angelogioacchino.delregno@collabora.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-2-angelogioacchino.delregno@collabora.com>
Date:   Fri, 20 May 2022 17:38:25 +0200
Message-ID: <877d6gkydq.fsf@baylibre.com>
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

> To enhance human readability, add kerneldoc to all driver structs.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 30 +++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index c31ab4368388..8e4fa7cd16e6 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -34,6 +34,13 @@
>  #define MTK_PMIC_HOMEKEY_INDEX	1
>  #define MTK_PMIC_MAX_KEY_COUNT	2
>  
> +/**
> + * struct mtk_pmic_keys_regs - PMIC keys per-key registers
> + * @deb_reg:             Debounced key status register
> + * @deb_mask:            Bitmask of this key in status register
> + * @intsel_reg:          Interrupt selector register
> + * @intsel_mask:         Bitmask of this key in interrupt selector
> + */
>  struct mtk_pmic_keys_regs {
>  	u32 deb_reg;
>  	u32 deb_mask;
> @@ -50,6 +57,11 @@ struct mtk_pmic_keys_regs {
>  	.intsel_mask		= _intsel_mask,		\
>  }
>  
> +/**
> + * struct mtk_pmic_regs - PMIC Keys registers
> + * @keys_regs:           Specific key registers
> + * @pmic_rst_reg:        PMIC Keys reset register
> + */
>  struct mtk_pmic_regs {
>  	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
>  	u32 pmic_rst_reg;
> @@ -85,15 +97,31 @@ static const struct mtk_pmic_regs mt6358_regs = {
>  	.pmic_rst_reg = MT6358_TOP_RST_MISC,
>  };
>  
> +/**
> + * struct mtk_pmic_keys_info - PMIC Keys per-key params
> + * @keys:                Pointer to main driver structure
> + * @regs:                Register offsets/masks for this key
> + * @keycode:             Key code for this key
> + * @irq:                 Keypress or press/release interrupt
> + * @irq_r:               Key release interrupt (optional)
> + * @wakeup:              Indicates whether to use this key as a wakeup source
> + */
>  struct mtk_pmic_keys_info {
>  	struct mtk_pmic_keys *keys;
>  	const struct mtk_pmic_keys_regs *regs;
>  	unsigned int keycode;
>  	int irq;
> -	int irq_r; /* optional: release irq if different */
> +	int irq_r;
>  	bool wakeup:1;
>  };
>  
> +/**
> + * struct mtk_pmic_keys - Main driver structure
> + * @input_dev:           Input device pointer
> + * @dev:                 Device pointer
> + * @regmap:              Regmap handle
> + * @keys:                Per-key parameters
> + */
>  struct mtk_pmic_keys {
>  	struct input_dev *input_dev;
>  	struct device *dev;
> -- 
> 2.35.1
