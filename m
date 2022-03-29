Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38514EADA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiC2MuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiC2MsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:48:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF973BD4;
        Tue, 29 Mar 2022 05:43:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1FAC21F43DAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648557791;
        bh=1dMTzWJp1uIWHr4U4R2cLRHX4y9FdQ6mbt6NFWKc5z4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mRe65i24mVzokT7MmNoI9yfi9PIvL4L2m7CveTbo/csEP50NiHEVtgHc/frCoWVK1
         ixqrb1W5uhMjJrZnZEbHsVoIc/cSVvJtHwKx48jO6/YCyEZCCwdwkgk1dIXcLwNnqS
         G9q7iFAe9Io+l4P1ZyZaLoLRZRQCAoKjD+hb1tVIMMW975sBNTmxnVzkjklS/M5ohg
         THyGxelpACJ+nT1n+3GmoFe8FIh6mukc3kzjGxspWZ90MHzlYbJHYu0Lq09FxcCFEg
         SxN+XyJUSrZmjJ4r/a7xaZWIisFhaLAmSniSo++D3XfLkTszB0gxdiYjgvvlMH9G4e
         0zk+YbBQTfsOQ==
Message-ID: <d720a5e9-d078-6c60-f55b-0506c4b4e1fa@collabora.com>
Date:   Tue, 29 Mar 2022 14:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v12 2/3] dt-bindings: mmc: mtk-sd: increase reg maxItems
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220329114540.17140-1-tinghan.shen@mediatek.com>
 <20220329114540.17140-3-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220329114540.17140-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/22 13:45, Tinghan Shen ha scritto:
> Add optional host top register base for the reg binding description.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 7032f7adf3ca..6d41bcec900f 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -40,7 +40,8 @@ properties:
>             - const: mediatek,mt8183-mmc
>   
>     reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

it's just maxItems... adding minItems: 1 is not required.

>   
>     clocks:
>       description:

