Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691355199A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbiEDIZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346272AbiEDIZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:25:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F152623BC9;
        Wed,  4 May 2022 01:21:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D09521F44426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651652512;
        bh=wLY3OPe2cPx9sjjXymFeSQ30btBG+lIdXmj7Vs9jaaA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WvOUWCBy881OxEE4xdYZk3bLRUDSJr5QL3FgWhIW/X8GzYC5cdFJydQ1fnFh+N8xv
         IhoRIq5l/L+PjirhfyF7X+u+zaQENLaG1+0RySMzPAz4vUpwNr5JMTgpCqToCAY8d4
         ZsYOUifC9FNl8qzwFaPOlPR2Xug87YGpn7cy/BOlJcYGt7FuRJylGDeOEUvhZ+qzx6
         RYCgaCH3p/ZcEI4piCqTl2nTdmDbbL3IFzWNNbKhs7W+qvcv5SJR0Lj4oUY0S5Qhi1
         cKgjHI9Vy6bzeBMuNypwrwoZvBvlIyxS14E0q1LHNAUJ4lWJ149VNxs74cb4vEGfVk
         2trn26fQwWucA==
Message-ID: <73a52782-ba8b-2ef6-2044-1ceaad17d31c@collabora.com>
Date:   Wed, 4 May 2022 10:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg
 optional for mtk,scp
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220503211114.2656099-1-nfraprado@collabora.com>
 <20220503211114.2656099-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220503211114.2656099-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 23:11, Nícolas F. R. A. Prado ha scritto:
> The SCP has three memory regions: sram, cfg and l1tcm. While the first
> two are required, l1tcm is optional. Fix the dt-binding so that it can
> be omitted and update the description. This gets rid of dtbs_check
> warnings for devicetrees where the l1tcm reg is missing like mt8183.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> ---
> 
> Changes in v3:
> - Made the cfg reg required again. After looking again into the mtk-scp
>    driver, only l1tcm is optional.
> - Added mention that a dtbs_check warning gets fixed by patch in commit
>    message.
> 
>   Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 823a236242de..eeea84379a1e 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -23,11 +23,13 @@ properties:
>   
>     reg:
>       description:
> -      Should contain the address ranges for memory regions SRAM, CFG, and
> -      L1TCM.
> +      Should contain the address ranges for memory regions SRAM, CFG, and,
> +      optionally, L1TCM.
> +    minItems: 2
>       maxItems: 3
>   
>     reg-names:
> +    minItems: 2
>       items:
>         - const: sram
>         - const: cfg



