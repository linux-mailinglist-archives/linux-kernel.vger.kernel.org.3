Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23CE530872
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiEWEeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiEWEd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:33:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C89EEE32;
        Sun, 22 May 2022 21:33:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l14so12936698pjk.2;
        Sun, 22 May 2022 21:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xApiqltHmk4fyXwXr+XV2jx+tTOQK7lfXdQNYlo3OWA=;
        b=dKORMaWHU6VYYZHO/QN/983RYf7FOcdoNBoBChVvfewXi6kGWiFALeOPl4pyCTeDyn
         wDGcce/hVH15VJhJFl4sK8gqtQD78GtlHrgEbdQOo7FYmAzl0LwaUQpJQmBzX3/YIZ1q
         luprMRGI8MhJmIqF+cl8sjzMFIlWA8zIoixeaiFC731EC1Hhxl0vlgF0ojZiphrXDb8k
         7XcOwkce2iFlxiJow/KOK8LjMLmfOOJG4pdon+VmJJO5TYhsXfuY3ETKZiKN7EB1FVRV
         jrTSwY8pWH+D8f/Kp+9nkOXAJxiMqx/qcuLCxZFVsbjbE8aHJXpbeG/r4jQZp/9Ry4R7
         Z5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xApiqltHmk4fyXwXr+XV2jx+tTOQK7lfXdQNYlo3OWA=;
        b=e+1dFViOsxECwoIRyCxzHWf/8kjJIfwxH+GLgaYP048bMx5Z/QG00h3ZDwFm+6I0Q7
         liNX2RmzZTrRA9pxOFJLIwKMcJFOfpI6qm/KQyWhZzcsUhGfC1semjYg1dhK2EUcyDbV
         eXYE2y6Wi4Z1ST3/wz+7q0DBmgKKsRaeGWzhjSp247ZB3KZJKMpPtOMBy6thizOMPKwA
         wiyLMhj8+KP8Pdzm/4KzoMksOy8ZqAoqPT4tPfOVVYywFyuZOjEtNhkJuwsx/0ZvH/s2
         /3Vh9y8BQcJae+hEb/S8p1zV9KrTpGtWKB7VLPAUv8bFuSDsN2lJPFqxFz7obFRLIEUM
         IejQ==
X-Gm-Message-State: AOAM5335CldCV/Lk0DiQLe6C/JKzPSDBdurp6eDcM/GCgthP1Y0GxBL/
        pHJTFl7njbhuw3RTtrjmXaY=
X-Google-Smtp-Source: ABdhPJyaSrK2SdCAtH5n8v0I1+G03otcxlmwvNPisgzXUjAUYDWrroszN1RpvQvnxVOf3DRs6hUm4w==
X-Received: by 2002:a17:902:ef43:b0:156:9c5d:b0fe with SMTP id e3-20020a170902ef4300b001569c5db0femr21193813plx.158.1653280437721;
        Sun, 22 May 2022 21:33:57 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d84e:5dcd:9d68:ebbf])
        by smtp.gmail.com with ESMTPSA id bi10-20020a170902bf0a00b001621a1ef9c7sm1977254plb.137.2022.05.22.21.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 21:33:56 -0700 (PDT)
Date:   Sun, 22 May 2022 21:33:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: mtk-pmic-keys - Add kerneldoc to driver
 structures
Message-ID: <YosOsgPwMGuLk9dv@google.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520125132.229191-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

On Fri, May 20, 2022 at 02:51:28PM +0200, AngeloGioacchino Del Regno wrote:
> To enhance human readability, add kerneldoc to all driver structs.

I am doubtful that this is useful. The reason is that I believe
kerneldoc format is only useful for documenting cross-subsystem APIs.
Kerneldoc for driver-private data and functions simply pollutes API
docs.

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

This new description of the structure and of the keys_regs does not add
any information for me.

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

That is obvious from the field definition.

> + * @regs:                Register offsets/masks for this key

Ditto.

> + * @keycode:             Key code for this key

Yep.

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

I do not find this helpful.

> + * @dev:                 Device pointer

And neither this.

> + * @regmap:              Regmap handle

Nor this.

> + * @keys:                Per-key parameters
> + */
>  struct mtk_pmic_keys {
>  	struct input_dev *input_dev;
>  	struct device *dev;
> -- 
> 2.35.1
> 

In the end we ended up with something that now has a chance of
introducing warning when someone changes code, for very little benefit,
if any at all.

For driver-private data and functions we should rely on expressive
variable and function names and only use comments for something that
might be unclear or requires additional qualification.

Thanks.

-- 
Dmitry
