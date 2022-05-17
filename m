Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E432D529DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbiEQJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiEQJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:23:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F18EA6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:23:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so915917wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bb8/nB+kmhmFWXO5zVpYOav19fcBlS1D1P8aaZq8+TA=;
        b=NLuQyV1W/2pAV/8qtAsbjvwJT0bp3/m6yP8/qSf4DNkBZWjJ2qSE9Ic+KESK+AZYBD
         8YEie4oWlMR8nMC/+PrzaXDerzR9c1lFCh3BL0dZm7WN+oqSJqVcj7Lk4zHOAy0LhAmb
         JLklEJdmplbSd2ydk6O/obwQazWLkGFoYwdMLrPGhqlAaOaq6bhNTc2crWk/GzOyYI1+
         nSi7ffaNCjsaSz1SLD+6yRcsp42Ea3m1BpOU1mi8qeXcn29E77fvHCiS7tClfy6BmNpT
         asg2VsBo4JEL5yc4L48803bAga1iwd1AJDvDkmI4tZvSn0DccQdt2Wekvfe0Ah4bj7/O
         6n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bb8/nB+kmhmFWXO5zVpYOav19fcBlS1D1P8aaZq8+TA=;
        b=qEzUcF3Ae9KSHsceF/6/4h6AvFtWx4cD8PH/F0QxRTmDgzKmMJYNUWR+kEkd+zcLva
         57QJwosrScWRX371K8Hkj/T9tSWkLtuYeip5e3TIwIGNxCbGQsVAG+yY48sqmq+KtL9y
         HLjMDb0P1nv86W5Ih1RK++KdpTgA37cpj9ljTcW+2xfCAd0BmJH3/NaD/VPSMuvPE1t6
         M1U3k3d4Luh476dpoqMwgg9n2v0Jh7J80iJsdJEh6Nh3PxoczrsEMgad768X0+YUjO+5
         M/dkbWzh2lE1d7kAUrqwHxJFm1RuOwpNWE82QTatSWrYBifKEtiHZzKHEhhiLqq3k1wk
         Ip6A==
X-Gm-Message-State: AOAM533zSwTjQUQ7zEKyiRSTIX942QxLN+RG4LVJm+MXz6EBXDSIoNsB
        voUoScUgHTYCPit3/fSbybM=
X-Google-Smtp-Source: ABdhPJzPJ0rigZkAme1aN3XhsVvyYFk3+d9ermcQUZyB/s2knhda9Ri1e6wxK/jVN7+UIOAlVEsbYQ==
X-Received: by 2002:a7b:c081:0:b0:394:789b:915 with SMTP id r1-20020a7bc081000000b00394789b0915mr20241355wmh.105.1652779402461;
        Tue, 17 May 2022 02:23:22 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l21-20020a7bcf15000000b003942a244ec8sm1409496wmg.13.2022.05.17.02.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:23:21 -0700 (PDT)
Message-ID: <6917bfeb-2f20-dafd-14e9-2dd0dc42ab91@gmail.com>
Date:   Tue, 17 May 2022 11:23:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 5/5] soc: mediatek: pwrap: Compress of_device_id
 entries to one line
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
 <20220516124659.69484-6-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220516124659.69484-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/05/2022 14:46, AngeloGioacchino Del Regno wrote:
> Compress each entry of the of_device_id tables in this driver to one
> line instead of three, as they fit just fine in a single line.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 90 ++++++++--------------------
>   1 file changed, 24 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 7d02e1d4faf4..c018092e6cbe 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1960,33 +1960,17 @@ static const struct pwrap_slv_type pmic_mt6397 = {
>   };
>   
>   static const struct of_device_id of_slave_match_tbl[] = {
> -	{
> -		.compatible = "mediatek,mt6323",
> -		.data = &pmic_mt6323,
> -	}, {
> -		.compatible = "mediatek,mt6351",
> -		.data = &pmic_mt6351,
> -	}, {
> -		.compatible = "mediatek,mt6357",
> -		.data = &pmic_mt6357,
> -	}, {
> -		.compatible = "mediatek,mt6358",
> -		.data = &pmic_mt6358,
> -	}, {
> -		.compatible = "mediatek,mt6359",
> -		.data = &pmic_mt6359,
> -	}, {
> -		/* The MT6380 PMIC only implements a regulator, so we bind it
> -		 * directly instead of using a MFD.
> -		 */
> -		.compatible = "mediatek,mt6380-regulator",
> -		.data = &pmic_mt6380,
> -	}, {
> -		.compatible = "mediatek,mt6397",
> -		.data = &pmic_mt6397,
> -	}, {
> -		/* sentinel */
> -	}
> +	{ .compatible = "mediatek,mt6323", .data = &pmic_mt6323 },
> +	{ .compatible = "mediatek,mt6351", .data = &pmic_mt6351 },
> +	{ .compatible = "mediatek,mt6357", .data = &pmic_mt6357 },
> +	{ .compatible = "mediatek,mt6358", .data = &pmic_mt6358 },
> +	{ .compatible = "mediatek,mt6359", .data = &pmic_mt6359 },
> +	/* The MT6380 PMIC only implements a regulator, so we bind it

Nit-pick alert: new line here for readability.

Regards,
Matthias

> +	 * directly instead of using a MFD.
> +	 */
> +	{ .compatible = "mediatek,mt6380-regulator", .data = &pmic_mt6380 },
> +	{ .compatible = "mediatek,mt6397", .data = &pmic_mt6397 },
> +	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, of_slave_match_tbl);
>   
> @@ -2145,45 +2129,19 @@ static struct pmic_wrapper_type pwrap_mt8186 = {
>   };
>   
>   static const struct of_device_id of_pwrap_match_tbl[] = {
> -	{
> -		.compatible = "mediatek,mt2701-pwrap",
> -		.data = &pwrap_mt2701,
> -	}, {
> -		.compatible = "mediatek,mt6765-pwrap",
> -		.data = &pwrap_mt6765,
> -	}, {
> -		.compatible = "mediatek,mt6779-pwrap",
> -		.data = &pwrap_mt6779,
> -	}, {
> -		.compatible = "mediatek,mt6797-pwrap",
> -		.data = &pwrap_mt6797,
> -	}, {
> -		.compatible = "mediatek,mt6873-pwrap",
> -		.data = &pwrap_mt6873,
> -	}, {
> -		.compatible = "mediatek,mt7622-pwrap",
> -		.data = &pwrap_mt7622,
> -	}, {
> -		.compatible = "mediatek,mt8135-pwrap",
> -		.data = &pwrap_mt8135,
> -	}, {
> -		.compatible = "mediatek,mt8173-pwrap",
> -		.data = &pwrap_mt8173,
> -	}, {
> -		.compatible = "mediatek,mt8183-pwrap",
> -		.data = &pwrap_mt8183,
> -	}, {
> -		.compatible = "mediatek,mt8186-pwrap",
> -		.data = &pwrap_mt8186,
> -	}, {
> -		.compatible = "mediatek,mt8195-pwrap",
> -		.data = &pwrap_mt8195,
> -	}, {
> -		.compatible = "mediatek,mt8516-pwrap",
> -		.data = &pwrap_mt8516,
> -	}, {
> -		/* sentinel */
> -	}
> +	{ .compatible = "mediatek,mt2701-pwrap", .data = &pwrap_mt2701 },
> +	{ .compatible = "mediatek,mt6765-pwrap", .data = &pwrap_mt6765 },
> +	{ .compatible = "mediatek,mt6779-pwrap", .data = &pwrap_mt6779 },
> +	{ .compatible = "mediatek,mt6797-pwrap", .data = &pwrap_mt6797 },
> +	{ .compatible = "mediatek,mt6873-pwrap", .data = &pwrap_mt6873 },
> +	{ .compatible = "mediatek,mt7622-pwrap", .data = &pwrap_mt7622 },
> +	{ .compatible = "mediatek,mt8135-pwrap", .data = &pwrap_mt8135 },
> +	{ .compatible = "mediatek,mt8173-pwrap", .data = &pwrap_mt8173 },
> +	{ .compatible = "mediatek,mt8183-pwrap", .data = &pwrap_mt8183 },
> +	{ .compatible = "mediatek,mt8186-pwrap", .data = &pwrap_mt8186 },
> +	{ .compatible = "mediatek,mt8195-pwrap", .data = &pwrap_mt8195 },
> +	{ .compatible = "mediatek,mt8516-pwrap", .data = &pwrap_mt8516 },
> +	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
>   
