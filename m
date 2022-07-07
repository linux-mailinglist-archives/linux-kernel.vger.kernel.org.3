Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10B2569ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiGGJvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiGGJvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:51:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9E4D4EF;
        Thu,  7 Jul 2022 02:51:39 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9BC2666019AA;
        Thu,  7 Jul 2022 10:51:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657187498;
        bh=9cJkFbeGAUaiuZQ1tk/q71MLcCqv08gXnUsskyh+OSU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iklc8JelOW6VhhEVCPvFwprlF/PtO1UiLbHjv1p8qAO+07GEsSfkqhh82UATV+2yR
         vZ6W6oQ+tUvgQY5mdEh0FvE/gIPW94z2dcz9ukkiOyPbO7UmNnW3RgZgXkc6BCCo7r
         s5tIDcPkIzF4nyW5SM19RQtEzF52PpcOe3U3gGmTLnmmF/hAxn3Lnt1FKMpfUWw3xq
         tVS1FvQlWqcUFeyONlRidVYyQwfP524W2AFBQSBsbqimnIimNlTt4R0FVMdozDK3gL
         SYDJjrJqH7NtrCgD/3Dru5zEKWXq67riOPJ1+ySr0EKY9dQQVnRtuFUb6PxCfMqIZy
         Wil+TudE8xb+A==
Message-ID: <e0452b8a-0544-5647-5d3c-ce6a208f2b69@collabora.com>
Date:   Thu, 7 Jul 2022 11:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: mmc: Add compatible for MediaTek MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220707054710.1396-1-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220707054710.1396-1-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/07/22 07:47, Johnson Wang ha scritto:
> This commit adds dt-binding documentation of mmc for MediaTek MT8188 SoC
> platform.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 2a2e9fa8c188..3fbf33ad4f7c 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -32,6 +32,9 @@ properties:
>         - items:
>             - const: mediatek,mt8186-mmc
>             - const: mediatek,mt8183-mmc
> +      - items:
> +          - const: mediatek,mt8188-mmc
> +          - const: mediatek,mt8183-mmc
>         - items:
>             - const: mediatek,mt8192-mmc
>             - const: mediatek,mt8183-mmc
> 

Hello Johnson,

if I'm not wrong, this should be...
(check with dt_binding_check!)

properties:
   compatible:
     oneOf:
       - enum:
         - mediatek,mt2701-mmc
         - .... everything else ....
       - items:
         - enum:
             - mediatek,mt8186-mmc
             - ... the others ...
         - const: mediatek.mt8183-mmc

Cheers,
Angelo
