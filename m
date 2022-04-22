Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666C950B905
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448176AbiDVNu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377540AbiDVNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:50:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406C958E66;
        Fri, 22 Apr 2022 06:47:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so4971920wmb.1;
        Fri, 22 Apr 2022 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dZT9d6RauuQU8OC2AaH9n9Wn7bUZdwOkzeuUvog/EI8=;
        b=UV4FW6Z65JSNumepoTaoZtdissD/RhjoJ+RaHPgfiVTeLGVLHqVLYdAH43GktRU6FW
         smal8DQwhuR9q49uB9H6em4MqfW/Eh1pzNabqgH25bIQ/79JHnjmUiT6D/CRbkNQ5uBK
         cZ/+hGWSiE8qc7DZuh3MdFQv6uG91CnVuFQ09sOyutRRCRbgdmjtuzi3n0gPcyN5JUxL
         g6FnBsGjWACLuL4v+UA5QXdigusKBG3vMQftg67DzMoOm61ImqbGZqurHkvDH+Ndus46
         LAfG+lq/Pip6cK3AsHGAJTz2E60SdSv8uFGX43GMB/XhkxW2K14mBZVI0SdZafprIAPA
         5SJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dZT9d6RauuQU8OC2AaH9n9Wn7bUZdwOkzeuUvog/EI8=;
        b=NRff0dKcpYU9dcR9XEsM0wK8/22EJ40XtgD0pAZW8aqbHeoNqFcbAtwIeYinHv/XSA
         z5uLWmPwpbu84cGnenFwi3Ec8DxgC+IwPHNotNcIUHju9VRc8n2YghaynFvWiTqcj927
         4jvUy0IJPDRxhiCPYWR+E+AYEwYQGaK8TQ71wLK1Sfjh+0sa+vT99sKfIJF09VidNkgx
         fRn4Oxop8v9ERuxaBIa00P8ErlOX8P1vVPY+7SwLMjUAsHMyClXiHDsLIJ6RZOn4g1mr
         cluDPLWnKzW0cdN1kClTY4ek9m4K97wCe6N/jZwx0eXGXxWCjzJACGsm1QUH5S63nZuy
         pJTA==
X-Gm-Message-State: AOAM533QA+ORvogd0WZjnXlCf9fVF+BGk6RW02ZSyu1y2Z8nqdEeZb7M
        w4Zjm+JxnP6KjJyv+SZ1b6E=
X-Google-Smtp-Source: ABdhPJzuejfEwWDWhPoDL3axXouRXkPSERJInAHBaND+APz5Svxkas8Ce8anQuWTB0GwWz0/PP96Jw==
X-Received: by 2002:a1c:7416:0:b0:38e:b8b7:e271 with SMTP id p22-20020a1c7416000000b0038eb8b7e271mr13118777wmc.7.1650635248803;
        Fri, 22 Apr 2022 06:47:28 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm4977707wms.35.2022.04.22.06.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 06:47:28 -0700 (PDT)
Message-ID: <ef917fb9-ded2-6e4e-d3ca-f992fc6ae159@gmail.com>
Date:   Fri, 22 Apr 2022 15:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] dt-bindings: media: mtk-vcodec: Add encoder power
 domain property
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
References: <20220421035111.7267-1-allen-kh.cheng@mediatek.com>
 <20220421035111.7267-5-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220421035111.7267-5-allen-kh.cheng@mediatek.com>
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



On 21/04/2022 05:51, Allen-KH Cheng wrote:
> From: Irui Wang <irui.wang@mediatek.com>
> 
> Add encoder power domain property
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index e7b65a91c92c..de2df6c6352c 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -41,6 +41,9 @@ properties:
>   
>     assigned-clock-parents: true
>   
> +  power-domains:
> +    maxItems: 1
> +
>     iommus:
>       minItems: 1
>       maxItems: 32
> @@ -74,6 +77,7 @@ required:
>     - iommus
>     - assigned-clocks
>     - assigned-clock-parents
> +  - power-domains
>   
>   allOf:
>     - if:
> @@ -135,6 +139,7 @@ examples:
>       #include <dt-bindings/clock/mt8173-clk.h>
>       #include <dt-bindings/memory/mt8173-larb-port.h>
>       #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt8173-power.h>
>   
>       vcodec_enc_avc: vcodec@18002000 {
>         compatible = "mediatek,mt8173-vcodec-enc";
> @@ -156,6 +161,7 @@ examples:
>         clock-names = "venc_sel";
>         assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
>         assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
> +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
>       };
>   
>       vcodec_enc_vp8: vcodec@19002000 {
> @@ -176,4 +182,5 @@ examples:
>         clock-names = "venc_lt_sel";
>         assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
>         assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>;
> +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
>       };
