Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5E50B78B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447622AbiDVMpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447618AbiDVMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:45:00 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8705956C37;
        Fri, 22 Apr 2022 05:42:06 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k29-20020a056830243d00b006040caa0988so5385233ots.6;
        Fri, 22 Apr 2022 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=vGqa3JNO0ZwDV+RYD0ECVU5s6pbxZ+ZuFhh+nnOh86A=;
        b=LBfCLg8ASGYezRMGA+VVf0PNoUuLIfF3Vvw5f8bQ+GqlBc2CwIm8uQ1ds5TTIBOwsy
         o81TJbXpFiwrdwr7qZJBqBZ9/zhawNI3QVMYI6N9fuaYkzG4RMZEKAb+M/yckNnTIqLN
         ijz4G3Dhcgx2G13G9XkTs9PZsE2re2LyaFNeqkYRHL9lw/lmxsCd2KevtLWN1RF9Hlyg
         0VgEscO0yiLd8462X9qJfYmdMwEKw7MmWS9aHl6AgGTz40V2OuSV11rstDwb+V8WGySh
         8rX7SE+M8lmEnZnzfiihQ5b6inDHL9MoABvcUIJVx0S7aVj5CfXij1efPBGUHU26pxAJ
         zEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=vGqa3JNO0ZwDV+RYD0ECVU5s6pbxZ+ZuFhh+nnOh86A=;
        b=Bm/UfWUb7bakK2/XySOvZ95Spbe/pqquiPLRjlrlWT9XZzGfbF1pL0O85/UnW2jR5W
         WL4Q0ZKapabQa+5z6qkk800gMa0K+JBVlruJxRamN5avzIrPtNUGGPGCPX2d8m4+u4Mt
         TqvDiUfIdPO7VzdKNrJJSKlS3eT57gFKDKRk33iTVY9sdDuqCS0rBkX9watLH2RUDxHh
         WnfQGmy4p1Deaf+S+tFv+rTHlLM65t1JnCu0HPfRTeF/oFkd7xEkPHwIJksUM4Q3rCCw
         8vNdNLYiwjY0Sqpa1ZsLToEXaXRfwm3tf46bC9KoRYxM9hwPnMpzUwx4/8ghq6Y40rcS
         dTpQ==
X-Gm-Message-State: AOAM533H9cUhDvvgr5CAc+G2D1oxF028ymmReL2aR9F7Pn70/XJNiQHm
        LpG9MHhPpJS0uRPqONvO4XEqq+/qOavBCw==
X-Google-Smtp-Source: ABdhPJyejOc9C14qomTmt6coqql+HtHeKAtOwbV0316n4wsRsfn/lGoPXXV4DndOzUHF3JDGh/WTgQ==
X-Received: by 2002:a05:6830:18f:b0:605:433b:c568 with SMTP id q15-20020a056830018f00b00605433bc568mr1632888ota.46.1650631325731;
        Fri, 22 Apr 2022 05:42:05 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w11-20020a056830144b00b006054888b7a3sm673378otp.1.2022.04.22.05.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 05:42:04 -0700 (PDT)
Message-ID: <402f0e60-8d3c-850d-84ff-af5424b72b73@gmail.com>
Date:   Fri, 22 Apr 2022 14:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220419094143.9561-1-jason-jh.lin@mediatek.com>
 <20220419094143.9561-9-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v20 8/8] soc: mediatek: remove DDP_DOMPONENT_DITHER from
 enum
In-Reply-To: <20220419094143.9561-9-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 11:41, jason-jh.lin wrote:
> After mmsys and drm change DITHER enum to DDP_COMPONENT_DITHER0,
> mmsys header can remove the useless DDP_COMPONENT_DITHER enum.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Chun-Kuang, I think it would make sense to take that through your tree as it 
depends on the previous patches.

I provide you a stable tag so that you can take it:
v5.18-next-vdso0-stable-tag

Regards,
Matthias

> ---
>   include/linux/soc/mediatek/mtk-mmsys.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index 59117d970daf..fb719fd1281c 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -16,8 +16,7 @@ enum mtk_ddp_comp_id {
>   	DDP_COMPONENT_CCORR,
>   	DDP_COMPONENT_COLOR0,
>   	DDP_COMPONENT_COLOR1,
> -	DDP_COMPONENT_DITHER,
> -	DDP_COMPONENT_DITHER0 = DDP_COMPONENT_DITHER,
> +	DDP_COMPONENT_DITHER0,
>   	DDP_COMPONENT_DITHER1,
>   	DDP_COMPONENT_DP_INTF0,
>   	DDP_COMPONENT_DP_INTF1,
