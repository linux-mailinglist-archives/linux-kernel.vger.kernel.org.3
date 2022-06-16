Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B554E2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiFPN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiFPN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:56:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0C46B38
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:56:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e5so838014wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m6uBZVuyEz2LJoe25N52zu3vkj3sZBGqGpB8uE3jv7A=;
        b=FCcdLGR8f+Nh4u2S5InboaIgmcQQkJa1/T5sIaER5b1erKLX9DvZqJNGD7loQo/q7C
         2952kKcUSS0KV+Y8KCAA2obrp6Y7UwwaB/Pq5FcS+zSpkx7tWMmapHDfShl4e/pt0Rxu
         /acX5/8UCfH0p0Kw9wexWShHNrRFe81xuW+3iCzpM6BLg34RyYTX8NwW/PmHwy7+joru
         O9lks34OHP+dOji5ulmU7tW46oqOySDujx/+lIOJwUWX+1sRiOxHGobuNE4qEL5zAjj9
         tGaXFzLgjYRHKA0q72nZauUDuqLWqwwLkD5RD9KB0TMTc+HrUsZ55yS61/GGqUt4DMhA
         uZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m6uBZVuyEz2LJoe25N52zu3vkj3sZBGqGpB8uE3jv7A=;
        b=5RJ9KHDyZAjGKrhLrNJY9N1avjHmde+8kZvhLM80A6FMZIAPztjqcl3cSi1/SKPxNP
         LqCdfkZa/0ycv4cH9dKZD0i6LBSi+gs9cdXDvUXx4JNquG5D3D7fKDzXHqJE/hUCOTlG
         yDMFiJsTOYxYPUo9CLF3vOlY+TlbAqagTQPX1tqi9p19t8gyAB6PJAv69oE/G2GnYHkg
         +hUIz1ne0YzI8/+u9Jl9bCzv4W66V3cCShhPwBVRfA+MLguTajc9cnauSPrlAF1vPAoQ
         Jr8kKCF843JewFuOAZGqdUKNXiUYbb/9YvRG/dXLm1p54BjKEScf+IjJJ0EbowTU1OZI
         CUuQ==
X-Gm-Message-State: AJIora9uB9PR1x6dfso57DUXeAxfIPvsqeGP721UJLc+7GlRGc+nYqHP
        nCrZ+FboxNbl244gxW7CEjZK4VvQNDFVzg==
X-Google-Smtp-Source: AGRyM1vaMBvDopUDTt0s4tdWKsT6HUNecCRsYk/m/z7HxI6lnV8qvwV44VhHPlGJhcCQclZE98LQ/Q==
X-Received: by 2002:a05:600c:34cf:b0:39c:4dfb:1398 with SMTP id d15-20020a05600c34cf00b0039c4dfb1398mr5161884wmq.133.1655387801411;
        Thu, 16 Jun 2022 06:56:41 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b0039c811077d3sm2518057wmq.22.2022.06.16.06.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:56:40 -0700 (PDT)
Message-ID: <65ebee0a-391a-294f-13f1-bc039f0a748c@gmail.com>
Date:   Thu, 16 Jun 2022 15:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 5/5] iommu/mediatek: Remove a unused "mapping" which is
 only for v1
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-6-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616054203.11365-6-yong.wu@mediatek.com>
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



On 16/06/2022 07:42, Yong Wu wrote:
> Just remove a unused variable that only is for mtk_iommu_v1.
> 
> Fixes: 9485a04a5bb9 ("iommu/mediatek: Separate mtk_iommu_data for v1 and v2")

It does not fix a bug, so no fixes tag here needed.

With that:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 5e86fd48928a..e65e705d9fc1 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -221,10 +221,7 @@ struct mtk_iommu_data {
>   	struct device			*smicomm_dev;
>   
>   	struct mtk_iommu_bank_data	*bank;
> -
> -	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
>   	struct regmap			*pericfg;
> -
>   	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
>   
>   	/*
