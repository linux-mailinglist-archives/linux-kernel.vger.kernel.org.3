Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390C4483E64
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiADInj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiADInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:43:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198ABC061761;
        Tue,  4 Jan 2022 00:43:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3F94B1F4249A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641285811;
        bh=6czgHBiRQWjFv98xZ1bJ4pRe2e0hJGJ99fDABVVfRgo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BVEh+dAtAyOl7ZEI1T0JGt8JbXxXQ/wJJ+D6HkThzCHlYBHft7kmA2mXntvdP9ued
         seODqJJ4k30DGs1qDpCjJ0SsmH8Fm/Wng5ma9zmZffAB7qDziLSBCSIgAL9GxTUfWf
         iRfM/mZIkZDVxc+qFzdqChcyFuz4CIB8AasK2GznzNriVb+ABjzjTUB1sBRlrlMHvv
         mY6P3/UODBVMgq6o08BYijWKZQecMesInuTW7AUeh3TeofiOdu2DlCJvqd+LkJD9GT
         IA4LYowgCQvNF3IGnQxl3G2uHByfqwgS1Aw/NH7UtcBdAWv/53ito4hKspb0rWwiR/
         s96LYQbvuxOsg==
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Add binding for
 mt8186 scp
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-remoteproc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220103075854.10438-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1e729a4f-8cc1-7f7f-eddb-fc7ba1df7f32@collabora.com>
Date:   Tue, 4 Jan 2022 09:43:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220103075854.10438-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/01/22 08:58, allen-kh.cheng ha scritto:
> Add mt8186 compatible to binding document.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index d21a25ee96e6..5b693a2d049c 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -17,6 +17,7 @@ properties:
>     compatible:
>       enum:
>         - mediatek,mt8183-scp
> +      - mediatek,mt8186-scp
>         - mediatek,mt8192-scp
>         - mediatek,mt8195-scp
>   
> 

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
