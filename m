Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8263A56558A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiGDMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiGDMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:36:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104FFDED2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:36:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bx13so10934689ljb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iPKFsn5fgFC3dh7g4FEmoTkg1BmyHxMILE2vHE8EovU=;
        b=kakAYzAv3NzfFeDUN+1/0H8cOwRS5NqlQ27nFKj7WIejGwKhWzq7PYg92rhzNELiok
         ows4QwIkoF9T/PEjYcacupijYOGztmIJZX5YdHTCt3hjFdawbgKTdqTaV6X7nBRw7S3T
         AXH0gKwluMjUJWlDwI5dk9h305balLQvjZXjNgfj8QNQkyOv5iSvci8Ht5scpAM7Igho
         DCubFtKdQXghwAMldj0MDUQ4tO1CpDbwAuKH8DBDDNe3zPp6iys8MQwWuh+1QlJ5iG3q
         07cYHofieHH6/bTNQXBanUdfaKrMjdJKOLNvLTNTQg2AN2MO4crHODHokwL2rzBMdm9t
         fT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iPKFsn5fgFC3dh7g4FEmoTkg1BmyHxMILE2vHE8EovU=;
        b=ityXn4A6Ubs72Cf8goA2Nh645rA/cJ9LURPC6SYUjE7Ao+m3+VseZf5lLtLI/sjdRq
         VEqvbpNk+SzNXL8f26PBj5oDTUQHLVEW7NQ709H1PYNxtw+8JbDTdzBRgLjcMK4fbo1W
         /ai6RfbHc2MTg4WkaFb+T0fVjGmpEvIN5DTAtpb779NyhLabvl9kn5OplTizHwDdTwjv
         TF22G1vwkCSMG9ki/cLx3P7hKiizuKm6TveT3C/YPTxRikaor7dQx9kMV7z4ZDRR1RcE
         h5A0SijQsH76P16uXGybpGMdY1YikjAOgN1kBPKn25JY/mO/bEO7Z6Ln0F3d7HgmF+x4
         sxwQ==
X-Gm-Message-State: AJIora9wZl1ERRmj35THRn+Hyu8oFz1nRM3wt0qwJgc7qAwzGueiWecy
        GzwxhAKI9BqOHWXRKsbjvx4G3g==
X-Google-Smtp-Source: AGRyM1tXWRrB0b5dEJCLzGc/R5uafVj4v54jWmEi9eVLKfsI4Srl/ADg1V4X5sgKVHCa6i63d9K/IA==
X-Received: by 2002:a2e:b713:0:b0:25a:90bd:cb6b with SMTP id j19-20020a2eb713000000b0025a90bdcb6bmr16083013ljo.380.1656938166435;
        Mon, 04 Jul 2022 05:36:06 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id f10-20020a056512360a00b0047255d211c2sm1727143lfs.241.2022.07.04.05.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:36:05 -0700 (PDT)
Message-ID: <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
Date:   Mon, 4 Jul 2022 14:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 02/16] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-3-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704100028.19932-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 12:00, Tinghan Shen wrote:
> The max clock items for the dts node with compatible
> 'mediatek,mt8195-smi-sub-common' should be 3.
> 
> However, the dtbs_check of such node will get following message,
> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>          From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> 
> Remove the last 'else' checking to fix this error.

Missing fixes tag.

> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../memory-controllers/mediatek,smi-common.yaml        | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index a98b359bf909..e5f553e2e12a 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -143,7 +143,15 @@ allOf:
>              - const: gals0
>              - const: gals1
>  
> -    else:  # for gen2 HW that don't have gals
> +  - if:  # for gen2 HW that don't have gals
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt2712-smi-common
> +            - mediatek,mt8167-smi-common
> +            - mediatek,mt8173-smi-common
> +

Without looking at the code, it's impossible to understand what you are
doing here. The commit msg says one, but you are doing something else.

Write commit msg explaining what you want to achieve and what you are doing.


Best regards,
Krzysztof
