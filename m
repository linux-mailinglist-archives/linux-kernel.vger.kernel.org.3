Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73402568987
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiGFNcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiGFNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:32:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404D2495E;
        Wed,  6 Jul 2022 06:32:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z12so12491589wrq.7;
        Wed, 06 Jul 2022 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7TOtOp9DDgCuQFSmCL0sSxp9HqC0uywGNi7BY5wOYCA=;
        b=bRnI/QO6vg4k8EqqvSMs5qADxX5jIJ6eBSi6z9cxmtdCZ6pn8MmZaDruaPDiFCRW44
         4vrK6+n0L+rfVeCHD4l8M5mqxvJrmLNNy6ZtqR5peJVf76356NqgakFYRnvwljBvseYQ
         gc7F2WqinIjZ27hbPncGJeZg076luDZ2ODOXZWK2XfES6ybnBZl728M4/lLajrxxVCeL
         SY/UbVcxT+yz38R4XaVFFc5J6n92ILHZAzya7qe/6soAiUkxZBx/ZjCzvlO1ZoUJvi79
         rOZro0xXlpBpMOSghLPvoHSjYqCFHqpTUJ0tcAskTrGhjSzuh9j68rkPP0GKuk34Iciw
         PjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7TOtOp9DDgCuQFSmCL0sSxp9HqC0uywGNi7BY5wOYCA=;
        b=dclmXynZJut5Kx8dmCv3MICT0M4D3aH9K08QLqkqp79gdj9C3CCSver/0ziAxZTqR0
         GVHUaiXICwZMRDL8JnSOO+NckFOBUwWYa+bFpcCwxPMSk00c4RUPVQOU00Vd1IjeJi+x
         xmpPHSRiPEWP6ZPAQSZloCwElt2o6vONd515qMqYxvf0gX1bCwIVtQEl0qOSCgh9eJfs
         BNat/C6YxWpUaUqEBTZE2lRFYjQKzPLHEvyZ5XAUT6KLaLqrWCxflYkfgR/bpeb/6Q7O
         gGP6iFueFrADf6leIzaa50bYpEefEqaPO3KeV/tU6F9o2HCFOWlZgtb+ML8psH0DnKjG
         xN8w==
X-Gm-Message-State: AJIora9eJhtlpi/a4Qfsu7wMaIHQ1UtfkhkBYQrr30wHeA+d9zewD4CN
        kLmbuVJiw9tphj/5MizjtgxPz+BVRUXhzA==
X-Google-Smtp-Source: AGRyM1ti/Wxh3IDrjkuHFZmYCXFfWmQQ6PkxajNWY5pbRz/P7qnGbOgcbRrWKoyx1dmMIHkIvV6XRw==
X-Received: by 2002:a5d:4aca:0:b0:21d:6793:1c11 with SMTP id y10-20020a5d4aca000000b0021d67931c11mr17085716wrs.202.1657114344966;
        Wed, 06 Jul 2022 06:32:24 -0700 (PDT)
Received: from [192.168.0.14] ([37.223.147.254])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003a0fb88a197sm25845925wms.16.2022.07.06.06.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 06:32:24 -0700 (PDT)
Message-ID: <56fca90e-3ab1-a655-4180-37b5d5bc431f@gmail.com>
Date:   Wed, 6 Jul 2022 15:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 RESEND] Input: mtk-pmic-keys - Add support for MT6331
 PMIC keys
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220706101122.201007-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220706101122.201007-1-angelogioacchino.delregno@collabora.com>
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



On 06/07/2022 12:11, AngeloGioacchino Del Regno wrote:
> Add support for PMIC Keys of the MT6331 PMIC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/input/keyboard/mtk-pmic-keys.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 6404081253ea..9b34da0ec260 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -9,6 +9,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/kernel.h>
>   #include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6331/registers.h>
>   #include <linux/mfd/mt6358/registers.h>
>   #include <linux/mfd/mt6397/core.h>
>   #include <linux/mfd/mt6397/registers.h>
> @@ -22,6 +23,10 @@
>   #define MTK_PMIC_PWRKEY_RST	BIT(6)
>   #define MTK_PMIC_HOMEKEY_RST	BIT(5)
>   
> +#define MTK_PMIC_MT6331_RST_DU_MASK	GENMASK(13, 12)
> +#define MTK_PMIC_MT6331_PWRKEY_RST	BIT(9)
> +#define MTK_PMIC_MT6331_HOMEKEY_RST	BIT(8)
> +
>   #define MTK_PMIC_PWRKEY_INDEX	0
>   #define MTK_PMIC_HOMEKEY_INDEX	1
>   #define MTK_PMIC_MAX_KEY_COUNT	2
> @@ -72,6 +77,19 @@ static const struct mtk_pmic_regs mt6323_regs = {
>   	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
>   };
>   
> +static const struct mtk_pmic_regs mt6331_regs = {
> +	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x2,
> +				   MT6331_INT_MISC_CON, 0x4,
> +				   MTK_PMIC_MT6331_PWRKEY_RST),
> +	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x4,
> +				   MT6331_INT_MISC_CON, 0x2,
> +				   MTK_PMIC_MT6331_HOMEKEY_RST),
> +	.pmic_rst_reg = MT6331_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_MT6331_RST_DU_MASK,
> +};
> +
>   static const struct mtk_pmic_regs mt6358_regs = {
>   	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>   		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
> @@ -255,6 +273,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
>   	}, {
>   		.compatible = "mediatek,mt6323-keys",
>   		.data = &mt6323_regs,
> +	}, {
> +		.compatible = "mediatek,mt6331-keys",
> +		.data = &mt6331_regs,
>   	}, {
>   		.compatible = "mediatek,mt6358-keys",
>   		.data = &mt6358_regs,
