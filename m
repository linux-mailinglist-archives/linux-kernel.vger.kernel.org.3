Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33EA50DE1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiDYKtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDYKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:49:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82EF674D9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:46:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso12239843wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/kUZ7qeC4kUAsBno+tq5DgewTJsOtJlIzPTE4j6RoSo=;
        b=UP73freZ4aCTAWK/QJdepyUvg0C0eZWnAXzxRrxeid9YclAvTvsL/oj9YnUSwuu3M6
         AjXgujd1v9oUxIsBarWNq2nPUIA+2Z0XcJ2aLMLEp4S137aMAYypY4GjnnC2Xl6Wk5oe
         98Tp4/tYSKURtgBs7uv1hO5D2V9LLTA/6OZX41IWJEU1lhYiqnBIwMXyoOqsuAPWsf0a
         7tYGLHw2mRHkLAZA97nStFbAOYP3zIh+xmPHcrPKOrdAhcVrGr64Eq4Mm3aMYDxh2e3o
         wDBh+oAs3ztOr2v4LAcRKGY750hMLfTI7c+FZzZA+afGjG8Qdvl0SNAiBdQ3NQb0ggJf
         whpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/kUZ7qeC4kUAsBno+tq5DgewTJsOtJlIzPTE4j6RoSo=;
        b=B6Ey4nYdzO+7IRpsZ4h1zGGByi6TsYjNu6oYf4KCCueLz5Fc0TuNAjX5SfqTvsBwUw
         a90fDSq3AdtZNMWic4Z6dfmVjkm2hbswpNZVPmHf0/+ZVrQ+S3jkQoYYANBwpfZPhvQT
         SaK4L8Fz2T8aomX6PgNng+MYu8cU/BeWHEW7lR59rjrs94jRseRaibSCacyfhhsetYUj
         zoatrV0TAOmsv/OBjJp8rU+ZKueoZbuE5Ng4yrihfE9eA02a47RSkzifrDNb05IEb8Rv
         sL9oIHaE9s2oNej00h+NdUmzrkd3gaTlI6o0s9nGnvzVYau9Y4B3PCgA8RTcjQMgavTU
         2r/A==
X-Gm-Message-State: AOAM533I88b1OZhj1fBA2ggB9GAJqD2s8UQllVcisNmoupezGbM1Y1AK
        BBcYi686PAVYzv+730AtM8VQenjFHq2kTw==
X-Google-Smtp-Source: ABdhPJwM7nl5KqGKF/zvs130PVYxl6YBC4SD36zeLuzvXryZ2KrnVyVTgZJ0ZGlwJGxS0Yo9szSSdQ==
X-Received: by 2002:a7b:c8cd:0:b0:38e:c2c1:5219 with SMTP id f13-20020a7bc8cd000000b0038ec2c15219mr24699413wml.151.1650883595368;
        Mon, 25 Apr 2022 03:46:35 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id v28-20020adf8b5c000000b0020ad668407bsm4920826wra.115.2022.04.25.03.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 03:46:34 -0700 (PDT)
Message-ID: <f155664a-b612-0293-49d3-3ecbcb154f84@gmail.com>
Date:   Mon, 25 Apr 2022 12:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] soc: mediatek: mutex: remove mt8195 MOD0 and SOF0
 definition
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220425034537.28989-1-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220425034537.28989-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2022 05:45, jason-jh.lin wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> Using mt8183 MDO0 and SOF0 definition instead of creating new one for
> mt8195.
> 
> Fixes: 8fdb61f1933a ("soc: mediatek: add mtk-mutex support for mt8195 vdosys0")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Applied thanks!

> ---
>   drivers/soc/mediatek/mtk-mutex.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index 9184684baf1d..981d56967e7a 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -17,9 +17,6 @@
>   #define MT8183_MUTEX0_MOD0			0x30
>   #define MT8183_MUTEX0_SOF0			0x2c
>   
> -#define MT8195_DISP_MUTEX0_MOD0			0x30
> -#define MT8195_DISP_MUTEX0_SOF			0x2c
> -
>   #define DISP_REG_MUTEX_EN(n)			(0x20 + 0x20 * (n))
>   #define DISP_REG_MUTEX(n)			(0x24 + 0x20 * (n))
>   #define DISP_REG_MUTEX_RST(n)			(0x28 + 0x20 * (n))
> @@ -422,8 +419,8 @@ static const struct mtk_mutex_data mt8192_mutex_driver_data = {
>   static const struct mtk_mutex_data mt8195_mutex_driver_data = {
>   	.mutex_mod = mt8195_mutex_mod,
>   	.mutex_sof = mt8195_mutex_sof,
> -	.mutex_mod_reg = MT8195_DISP_MUTEX0_MOD0,
> -	.mutex_sof_reg = MT8195_DISP_MUTEX0_SOF,
> +	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
> +	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
>   };
>   
>   struct mtk_mutex *mtk_mutex_get(struct device *dev)
