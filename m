Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A89515636
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381114AbiD2VB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiD2VB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:01:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3393DD39B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:58:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l18so17566367ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jOyMAEVjtx6EhOn3fhrULMJi53nS+z6dpTQwH2rDZQA=;
        b=ZliiAuYLvhkr6Fth+vQ4kHAabPbJJtoMS9fAAQrt0Xft6BG4b7lvpXf/nkNAYpykjx
         ZLavgDJ5DZmF+mTr22z/98AhZgVMhVF8esjiOY5VLDXvpU1W1z7Cg5o8HDPzxF8R3MBW
         +qVzCe0kh2cGp/nYiBX3doLZheYXjJSYM2AHH1jSNvGyPtniK1lIx+rLgvpRbG74ndm5
         jpc2PiAk9kMTiSBYsIify49J0JKPQ8k3xq9NauAUCWEqeP+/C5buokLDFmiYIXGY9ZBr
         ExBobS6XVmAVuAEEpKsZE+2WxOCnovU7BEeQ2q0QQGyJFHL9GrM0OnkwUI//GAkIZacE
         A+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jOyMAEVjtx6EhOn3fhrULMJi53nS+z6dpTQwH2rDZQA=;
        b=JgcEkaQd4QClGc6MVeKESJvI3Zwhgj8xB3Jr4Uw4/tRu2UvZjwGkgLPdxkviciCXrg
         no+UfK4i2LH3OJmJs98pZABi2rvL0svNMPPTn1IXwge8xaj078XD7efdmDLij4RCQGP5
         WBF4N8f/s3talTbLO1FpAHbbunymDI32H3y9XdG+pJ0cg+yxhvbJ/UbjhuwCe6DhmR2m
         zS90EXyCyrIJB1mD2D3lh2aDFOvSyaDpB838rCA/736t4CxNwaUuBJ7PoALvnoIt5WII
         HGil85qrwI7y6XYh7U27Lkne+Jaspl+BNc8W/pc7Yo0I98RsjbU0XiLy/LVRVlsPSViO
         U/4w==
X-Gm-Message-State: AOAM531g2hAXwqOL0siB8NnD/YhE+ShsmJMphasCJr2z15ijvExDz3Ic
        NM7BmyQV87C3vrwK2W1Jy0n3bw==
X-Google-Smtp-Source: ABdhPJxUD7ft+rExvbzfsYIw+efZxKCeoimffyllGfEpZBqLF8p1xE77k6lwvrParD98yHYmSxMmFA==
X-Received: by 2002:a17:907:7745:b0:6f3:674a:339 with SMTP id kx5-20020a170907774500b006f3674a0339mr1071873ejc.207.1651265885800;
        Fri, 29 Apr 2022 13:58:05 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e25-20020a056402149900b0042617ba63d5sm3329269edv.95.2022.04.29.13.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:58:05 -0700 (PDT)
Message-ID: <c9239316-40af-724b-cace-7da5bf7e8e21@linaro.org>
Date:   Fri, 29 Apr 2022 22:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] dt-bindings: arm: mediatek: mmsys: refine power and
 gce properties
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Cellopoint <cellopoint.kai@gmail.com>
References: <20220429083051.11260-1-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429083051.11260-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 10:30, Jason-JH.Lin wrote:
> Power:
>   Refine description and add item number for power-domains property.
> 
> GCE:
>   Refine description and add item number for mboxes property and
>   mediatek,gce-client-reg property.
> 
> Fixes: 1da90b8a7bae ("dt-bindings: arm: mediatek: mmsys: add power and gce properties")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
> Change in v2:
>   1. Add maxItems: 24 for mboxes property
>   2. Add description and $refs for mediatek,gce-client-reg property
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 6ad023eec193..2b27577f98cc 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -43,17 +43,19 @@ properties:
>      maxItems: 1
>  
>    power-domains:
> +    maxItems: 1
>      description:
> -      A phandle and PM domain specifier as defined by bindings
> -      of the power controller specified by phandle. See
> -      Documentation/devicetree/bindings/power/power-domain.yaml for details.
> +      Each mmsys belongs to a power-domains. If mmsys wants to use PM
> +      interface to control the power controller of mmsys, it should have
> +      this property.
>  
>    mboxes:
> +    minItems: 1
> +    maxItems: 24

Wait, no, I wrote it should be 16 for one device and 24 for other, not
24 for all...

Best regards,
Krzysztof
