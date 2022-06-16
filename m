Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C199D54E15F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376367AbiFPNDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiFPNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:03:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA920BE0;
        Thu, 16 Jun 2022 06:03:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o8so1812595wro.3;
        Thu, 16 Jun 2022 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=1dVwRcvX/zX2ZvyZyllNzIEz5OjgRw64ZDWPHeywZC8=;
        b=NLgcwNvhdW5LkWEv0Uj6WMcBuQS0Z1MM6opxaEO69IsazSgL5o/21eqAo114sQwXs2
         ZkXtQWXYFdjoNejhiOflb2NYwFTOrZCmVk+R4LosZsDdyZD9GX1+SdXppbuI+3Pl4Dwj
         oZ8LDWShTIDXYFrDt/VL60KBQZskZjrfS9Ujd846ylIsSkNqoYV821AlLBcV1M9k4Uni
         hvgWGjpA7tm8/uhmXNgYXzdZOlb/YAz+dFGZZ3YQFjV1IgK0SCNKEgtcekb73M/l0LwD
         Ea1mOJ4TPFkQ1t9gp7J5SSIcpPoZBufsHPVIxTtW0SXqdT9uP7HfY8MR7wZZT1DYNsT9
         tDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=1dVwRcvX/zX2ZvyZyllNzIEz5OjgRw64ZDWPHeywZC8=;
        b=edCvNqg0eYqn2FkCzWDQA+PHmAEgguvUjdfIoVY2XiN+64yU/PXB0kV6z6koBF15ps
         MxI++wt6YrGBSGHhGkdfkF7B8FhDGEpBnzahF29mHHiBmr/2zlXU7syu/QSqEGXcwgId
         RlSLd+PJtqzptTfNqXfrYJhM7WysrGderjHqPJqbSCLpwDByeps9+vTk1Peyyu1K8LDo
         xDSsfZX7ieEGvP6pM0tZk/wqrBHK6976fuZxXujcoS7dkv1UL5L3ubFoszfmw6Huo8Hk
         ISBUznSMbfczVgJKOkTJoLaKa8VDvoTsOtnN/xSMukdSley+HlRIjlWrIeCUqFABJFXY
         dk5A==
X-Gm-Message-State: AJIora90OzoGcX85wbQfhdc6I61cnd7wKsfLJGgbyNm9PQpS/0nZmnXD
        kMtAmZlqUXt6Qcm7mN4LgBQ=
X-Google-Smtp-Source: AGRyM1sv4JO3boUQn0I7JKR24E8LVGw6lqUPTDh/dIC/Y2zXeT22ejoujCVHN0znkQkj4DjGS0zThA==
X-Received: by 2002:a05:6000:a0b:b0:219:f87e:86b with SMTP id co11-20020a0560000a0b00b00219f87e086bmr4647358wrb.570.1655384627020;
        Thu, 16 Jun 2022 06:03:47 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c4f4f00b0039748be12dbsm6319155wmq.47.2022.06.16.06.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:03:46 -0700 (PDT)
Message-ID: <f47513f3-e1a9-1764-9954-cdf6931281a9@gmail.com>
Date:   Thu, 16 Jun 2022 15:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org, miles.chen@mediatek.com
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
 <20220616110830.26037-6-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 5/5] iommu/mediatek: Cleanup pericfg lookup flow
In-Reply-To: <20220616110830.26037-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2022 13:08, AngeloGioacchino Del Regno wrote:
> Since only the INFRA type IOMMU needs to modify register(s) in the
> pericfg iospace, it's safe to drop the pericfg_comp_str NULL check;
> also, directly assign the regmap handle to data->pericfg instead of
> to the infracfg variable to improve code readability.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 90685946fcbe..b2ae84046249 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1217,15 +1217,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			dev_err(dev, "mm dts parse fail(%d).", ret);
>   			goto out_runtime_disable;
>   		}
> -	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> -		   data->plat_data->pericfg_comp_str) {
> -		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
> -		if (IS_ERR(infracfg)) {
> -			ret = PTR_ERR(infracfg);
> +	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
> +		p = data->plat_data->pericfg_comp_str;
> +		data->pericfg = syscon_regmap_lookup_by_compatible(p);
> +		if (IS_ERR(data->pericfg)) {
> +			ret = PTR_ERR(data->pericfg);
>   			goto out_runtime_disable;
>   		}
> -
> -		data->pericfg = infracfg;
>   	}
>   
>   	platform_set_drvdata(pdev, data);
