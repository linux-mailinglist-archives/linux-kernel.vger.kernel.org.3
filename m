Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAA7568B13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiGFOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGFOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:20:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAAC1F2CD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:20:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d16so15978588wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FSq8WqfHcF8s8rYhY1PS7CBcA+fw5f2mGHNNEiY73pY=;
        b=XhWdtJ8rpY9y7CQyOSXtpCPpTCnYrUYSXQ0jeWL1/I3o8K1eoLiXBrx5ZpHJD6TRJP
         TESsbkDpysXiE6s6LleuwAV9UoOqJAzWL1xZX/8Co9EWLPIzpz0rG6Hw9/bUtZJ92cOG
         5G85XMElRJaMaR6cIVRGMWIJ19YDutxp3OVzZV6lO4YaXq3tiDkrn5+eiqIpu235YGHV
         OiUi6ZLVf/44ItPzGuyaA3vMcwTTVUQxi/texvIWRs0mfJ7rAeBaOvzYEgtxShXBeCMg
         rkWob8AKrLB7n02jNd8hgBJQ9Cb9d0zRIDyJQBmqZ4IS9G8P/UEoLDKZGPbR9ldBmNc5
         6F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FSq8WqfHcF8s8rYhY1PS7CBcA+fw5f2mGHNNEiY73pY=;
        b=bBcwGQIfuwkrSKGaP4R/+CoHrGJ2kLo+x3ZYfY/GajfF9AA+UmS1r7pPARtHjwf+PJ
         oNAhYW5HVv6AgEb336RBkxGaKSeIBJrRsx/+TO2piUhCVsppWuU6lF+b2sTlNl33Pnoq
         SOzYhFB7+S8hiNpLrbTCJ95dDmpaWcS8FzFE0TKeKQxA9pUNuAjVXKx5/DsGS5EI0s4E
         bQVAumdsrxR0pDF8Yo0ageJncN48On5BHU/z4aG9TeL1WJl/w/EmTP0JP6EAwWlTJbZo
         3nkuizVI/lYxLY0iUwX/qjTCe129WTxELbpK2z73ylYwAJvXlcukdDPulVtn/Xs2OiR5
         3ztg==
X-Gm-Message-State: AJIora94L72bcJk+lNS1/+C3pUZDtRScRST7cCBbP2BDM+7idwQrfb6Z
        800vKMtU1JIK5zn8DYBhIak=
X-Google-Smtp-Source: AGRyM1sZXnl/+u5Hd68LiJOgcVcmcBljAIltD5f9WGcN6SPMvlCo3uIgoQrwv5vNdv+1a30cduT9OA==
X-Received: by 2002:adf:d1eb:0:b0:21b:dbb5:fe05 with SMTP id g11-20020adfd1eb000000b0021bdbb5fe05mr38073330wrd.651.1657117208600;
        Wed, 06 Jul 2022 07:20:08 -0700 (PDT)
Received: from [192.168.0.14] ([37.223.147.254])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003a02f957245sm22279041wmq.26.2022.07.06.07.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:20:07 -0700 (PDT)
Message-ID: <65d390ab-7f80-8bd4-66f5-442c46da4f00@gmail.com>
Date:   Wed, 6 Jul 2022 16:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] soc: mediatek: Add mmsys func to adapt to dpi output
 for MT8186
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        yongqiang.niu@mediatek.com, enric.balletbo@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
References: <1656645344-12062-1-git-send-email-xinlei.lee@mediatek.com>
 <1656645344-12062-2-git-send-email-xinlei.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1656645344-12062-2-git-send-email-xinlei.lee@mediatek.com>
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



On 01/07/2022 05:15, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add mmsys func to manipulate dpi output format config for MT8186.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>   drivers/soc/mediatek/mt8186-mmsys.h    | 1 +
>   drivers/soc/mediatek/mtk-mmsys.c       | 8 ++++++++
>   include/linux/soc/mediatek/mtk-mmsys.h | 2 ++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
> index eb1ad9c37a9c..0b450b00b829 100644
> --- a/drivers/soc/mediatek/mt8186-mmsys.h
> +++ b/drivers/soc/mediatek/mt8186-mmsys.h
> @@ -3,6 +3,7 @@
>   #ifndef __SOC_MEDIATEK_MT8186_MMSYS_H
>   #define __SOC_MEDIATEK_MT8186_MMSYS_H
>   
> +#define MT8186_MMSYS_DUMMY0			0X400

I don't have access to the datasheet, but I really wonder if it's really called 
dummy0. If so, you would need to explain in more detail in the commit message.

Regards,
Matthias

>   #define MT8186_MMSYS_OVL_CON			0xF04
>   #define MT8186_MMSYS_OVL0_CON_MASK			0x3
>   #define MT8186_MMSYS_OVL0_2L_CON_MASK			0xC
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 2b0b805c65dd..de3f11cb931f 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -252,6 +252,14 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
>   
> +void mtk_mmsys_ddp_dpi_confing(struct device *dev, u32 mask, u32 val,
> +			       struct cmdq_pkt *cmdq_pkt)
> +{
> +	mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DUMMY0, mask,
> +			      val, cmdq_pkt);
> +}
> +EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_dpi_confing);
> +
>   void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width, int height,
>   				  struct cmdq_pkt *cmdq_pkt)
>   {
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index 343e093f0fc3..40c538c0664b 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -90,4 +90,6 @@ void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16
>   void mtk_mmsys_mixer_in_channel_swap(struct device *dev, int idx, bool channel_swap,
>   				     struct cmdq_pkt *cmdq_pkt);
>   
> +void mtk_mmsys_ddp_dpi_confing(struct device *dev, u32 mask, u32 val,
> +			       struct cmdq_pkt *cmdq_pkt);
>   #endif /* __MTK_MMSYS_H */
