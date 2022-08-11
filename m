Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA458F7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiHKGcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiHKGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:32:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA0C89930
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:32:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so24323342lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=pwaxxtmZ04egN1JXyx5JOzRQUW94lUiaaZz7L2gKjJQ=;
        b=cPzYEHALljaH9F8T4jjeyjWlcKZbOwD0URRq5zJ5FJHrQWpOXIqG/lrZ8wVNXJkden
         DEsvc7CG7XhY5l+kWtJBdBEMyBsn3YTtIpI9pCMdCuLAjXZuv2oM26irv64MFLRZRQNF
         7KKYeTSrbMfV/tYBScrmjdZIABN4q7ENBp3ElyCHqcraC3fRz2c4Q1j8eD6n3EDh8FWx
         +R/trrK0Oi72ZKPc9e+mmImo03+KU/Uv1GmNRijNvI0jl5WddB6n9HRPMuKYiJGgo3zc
         u+6AneFPp2o1l0wRVjfoIexcUqAJKltPBVYWilGRu+eLcdM5DnuXgtOPm9kVAMObh+8r
         myCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pwaxxtmZ04egN1JXyx5JOzRQUW94lUiaaZz7L2gKjJQ=;
        b=04v+hVvG7mAZfj7T3fOlzM113SSCKWWtHf2TFmQKsZqCV78bIFWWUCV6QZhnkPtcMH
         gXWKAzzJCaS3LgkRwL+YEWxstmG6Q2W9myWos/b1ALme27COQmbkPccy3vMMsdt39bDA
         8fs1U3IDvYMe2xun0FhVANiwWjEzUKQ4LgPaljSY8S/TinRAD6shTe6XL2ibwGH85N8j
         ABTvcy/INtwBPB0em93M++UryLIikJp/4ijNKGj+cDe/s2G3ZNs3YUfmIJtmOQ46chpU
         mt2RBL8c4htoHdkLGWh3dSsOZpNoQ7+xBmwFJlOXMo8+nzvNBEyvqwykxM2/wEFWHbZY
         g/hA==
X-Gm-Message-State: ACgBeo2ZEQrjEzHMcf3Eba6z2GwHo7dbwDmq4ICpobsSbrvvfl2FopQX
        S18Hxqu/hsDrGfeHRS9q4lPbLY9GmNmog2oh
X-Google-Smtp-Source: AA6agR40tKSBae58qY+7RDCU5j0znPzMxsb7C2ha9lePvz2LVKF+1cqVJCSK8oZ/Qb/kmGsrWR3+1Q==
X-Received: by 2002:a05:6512:3e07:b0:48b:131:616 with SMTP id i7-20020a0565123e0700b0048b01310616mr12048174lfv.475.1660199521869;
        Wed, 10 Aug 2022 23:32:01 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id y6-20020ac24e66000000b0048a9a756763sm597726lfs.19.2022.08.10.23.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 23:32:01 -0700 (PDT)
Message-ID: <12a16d64-45e0-620e-34ad-1d671eff5c2e@linaro.org>
Date:   Thu, 11 Aug 2022 09:31:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 02/20] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220811025813.21492-1-tinghan.shen@mediatek.com>
 <20220811025813.21492-3-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220811025813.21492-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2022 05:57, Tinghan Shen wrote:
> The max clock items for the dts node with compatible
> 'mediatek,mt8195-smi-sub-common' should be 3.
> 
> However, the dtbs_check of such node will get following message,
> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>          From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> 
> It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
> matches the 'else' conditions for gen2 HW without gals.
> 
> Rewrite the 'else' condition to specifically identify the compatibles
> that utilizing gen2 HW without gals.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../memory-controllers/mediatek,smi-common.yaml       | 11 ++++++++++-

I see there are no dependencies, so I will take it via memory-controller
tree after the merge window.

Best regards,
Krzysztof
