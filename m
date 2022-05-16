Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DBC52834B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiEPLce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiEPLca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:32:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8538D8B;
        Mon, 16 May 2022 04:32:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w4so20048493wrg.12;
        Mon, 16 May 2022 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zNR2zgstDynxCnsgIvM+YFx8Mm5SD6bvInuiy+HlYH4=;
        b=UyLd39lQXbSVZDC9Xe9aH0rJ2WKhYevQ0+yihicysr7I1lEyV0fbrXdI4kHtic0clt
         oPex+0nC7Cflv6YTxnjp9D1s0oeGZvDcKRfE2b5gt3BzFjqRj29cxZth70WtoSOkHybZ
         fkjHRYvNi0p9zdWjobA8DVTsQQJ5LqiJzGs6OHpZHT8qae7duw3R5YXawfiMpNyPgKx5
         MumHCn8i5fLFkGibvUcLBCc8+ZRkRl8o+hGuZcUfhmGtnUy9r+RGqyIM2bkEIAbqVZWm
         WNnwJoTOVhtDKr5Hg8kp7ZABxX/ClcW5Al3UKFgvHBTG8zmoCI5RuHL36vQ4Pz2pOO7Y
         uN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zNR2zgstDynxCnsgIvM+YFx8Mm5SD6bvInuiy+HlYH4=;
        b=keZo2JhdqJskw1NxxhWaUl1IKfJz1T6di5WQuoU+UtVhgyd5b5rPZoEn9bt+FydmIU
         z867I39pzJoqju2GCTXWgrVx9FqzvYgfyf8KBiERluBCZZyasyYutaPty8FYYFnpf8M+
         GFAQRHE4KsNCNdRIrAl0vA2q2JhQYg9v6/BobMdo3sTGqifXkaT7wDn+UR5jIQOfmlqQ
         PLxiFL/GMBIhUtKKA59vNlhdW0we/StExhaxQG9nTl28z4OetN0sOp1/X4x+6EuWF+ES
         gwFMj+2QKdYzC1B47WFekFMDIVFu5mxgWDBOBlTIOu/sgtvoukm+Mw/j5wTbXxUBZU1c
         wv9w==
X-Gm-Message-State: AOAM53275WHHCqf/CQcdpNZ7vQU/wF65MvV7GRkklF0NFeoB7u6ITT6e
        8UzWBrOQ7+OTn3buW8AR0TQ=
X-Google-Smtp-Source: ABdhPJyub9eU480qKQjh8jFlPz4AgCb1FDgUdJPm9VqXaaDrLbu652HkHldv3AQz72yMU3flgGVLZQ==
X-Received: by 2002:a5d:4dcc:0:b0:20a:ddaa:1c30 with SMTP id f12-20020a5d4dcc000000b0020addaa1c30mr13203540wru.419.1652700747506;
        Mon, 16 May 2022 04:32:27 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p2-20020adfaa02000000b0020cd0762f37sm9224270wrd.107.2022.05.16.04.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 04:32:26 -0700 (PDT)
Message-ID: <6f96e6f2-b614-3219-3302-da1679565722@gmail.com>
Date:   Mon, 16 May 2022 13:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] memory: mtk-smi: Add support for MT6795 Helio X10
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513150633.387200-1-angelogioacchino.delregno@collabora.com>
 <20220513150633.387200-3-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220513150633.387200-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/05/2022 17:06, AngeloGioacchino Del Regno wrote:
> The MediaTek Helio X10 (MT6795) SoC has 5 LARBs and one common SMI
> instance without any sub-common and without GALS.
> 
> While the smi-common configuration is specific to this SoC, on the
> LARB side, this is similar to MT8173, in the sense that it doesn't
> need the port in LARB, and the register layout is also compatible
> with that one, which makes us able to fully reuse the smi-larb
> platform data struct that was introduced for MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/memory/mtk-smi.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 86a3d34f418e..7e7c3ede19e4 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -21,11 +21,13 @@
>   /* SMI COMMON */
>   #define SMI_L1LEN			0x100
>   
> +#define SMI_L1_ARB			0x200
>   #define SMI_BUS_SEL			0x220
>   #define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
>   /* All are MMU0 defaultly. Only specialize mmu1 here. */
>   #define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
>   
> +#define SMI_FIFO_TH0			0x230
>   #define SMI_M4U_TH			0x234
>   #define SMI_FIFO_TH1			0x238
>   #define SMI_FIFO_TH2			0x23c
> @@ -360,6 +362,7 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
>   	{.compatible = "mediatek,mt2701-smi-larb", .data = &mtk_smi_larb_mt2701},
>   	{.compatible = "mediatek,mt2712-smi-larb", .data = &mtk_smi_larb_mt2712},
>   	{.compatible = "mediatek,mt6779-smi-larb", .data = &mtk_smi_larb_mt6779},
> +	{.compatible = "mediatek,mt6795-smi-larb", .data = &mtk_smi_larb_mt8173},
>   	{.compatible = "mediatek,mt8167-smi-larb", .data = &mtk_smi_larb_mt8167},
>   	{.compatible = "mediatek,mt8173-smi-larb", .data = &mtk_smi_larb_mt8173},
>   	{.compatible = "mediatek,mt8183-smi-larb", .data = &mtk_smi_larb_mt8183},
> @@ -541,6 +544,13 @@ static struct platform_driver mtk_smi_larb_driver = {
>   	}
>   };
>   
> +static const struct mtk_smi_reg_pair mtk_smi_common_mt6795_init[SMI_COMMON_INIT_REGS_NR] = {
> +	{SMI_L1_ARB, 0x1b},
> +	{SMI_M4U_TH, 0xce810c85},
> +	{SMI_FIFO_TH1, 0x43214c8},
> +	{SMI_FIFO_TH0, 0x191f},
> +};
> +
>   static const struct mtk_smi_reg_pair mtk_smi_common_mt8195_init[SMI_COMMON_INIT_REGS_NR] = {
>   	{SMI_L1LEN, 0xb},
>   	{SMI_M4U_TH, 0xe100e10},
> @@ -565,6 +575,12 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt6779 = {
>   		    F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
>   };
>   
> +static const struct mtk_smi_common_plat mtk_smi_common_mt6795 = {
> +	.type	  = MTK_SMI_GEN2,
> +	.bus_sel  = BIT(0),
> +	.init     = mtk_smi_common_mt6795_init,
> +};
> +
>   static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
>   	.type     = MTK_SMI_GEN2,
>   	.has_gals = true,
> @@ -609,6 +625,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
>   	{.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
>   	{.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
>   	{.compatible = "mediatek,mt6779-smi-common", .data = &mtk_smi_common_mt6779},
> +	{.compatible = "mediatek,mt6795-smi-common", .data = &mtk_smi_common_mt6795},
>   	{.compatible = "mediatek,mt8167-smi-common", .data = &mtk_smi_common_gen2},
>   	{.compatible = "mediatek,mt8173-smi-common", .data = &mtk_smi_common_gen2},
>   	{.compatible = "mediatek,mt8183-smi-common", .data = &mtk_smi_common_mt8183},
