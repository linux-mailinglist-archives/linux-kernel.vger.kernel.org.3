Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD2578423
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiGRNpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiGRNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:45:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075624963;
        Mon, 18 Jul 2022 06:45:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4FAC46601A60;
        Mon, 18 Jul 2022 14:45:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658151936;
        bh=EXKnw2OAVh4UgVY6zw8D6FiE6rIcc5hXLWhj8edCwEQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b7IVnsGHPMh5g88WN/m/HeqRFgQ7jYT5LBJjdDNG5gehWg8aValkTW6urTd3VMSVD
         RNsQuIWp7FLWTitkrc9L6toHnrb0Y3MXddAwe1GPuqxN80ybV9uKrZyck+6jG83cj4
         sMjRoukjzfpVhrMF6glrxJrBe00cyb7wPdYxLnpc//4lsFosF5T8bCTDbnJEiG+Bcr
         J1SQMhz1ZwbABKqvIlAhlZDMbZo1cx18XuWsJVrxBwvPLODfj3yWLLQ0Ta3NvKGMRy
         VClcdoIA3/H/wNzZu1gCe2blZCzc8sP7DldFzpOIrO4TSM9mx1Fm8ZFIbI70cCPGLX
         ZGiNNM1nI8f/A==
Message-ID: <512118d1-c571-94fd-4fdf-16fe3995f592@collabora.com>
Date:   Mon, 18 Jul 2022 15:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: add compatible for mt8188
Content-Language: en-US
To:     Hui Liu <hui.liu@mediatek.com>, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     srv_heupstream@mediatek.com, zhiyong.tao@mediatek.com,
        guodong.liu@mediatek.com, johnson.wang@mediatek.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220718123930.24373-1-hui.liu@mediatek.com>
 <20220718123930.24373-2-hui.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220718123930.24373-2-hui.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/07/22 14:39, Hui Liu ha scritto:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> This commit adds MediaTek mt8188 auxadc in dt-binding documentation.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> index 65581ad4b816..7f79a06e76f5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> @@ -35,6 +35,7 @@ properties:
>             - enum:
>                 - mediatek,mt8183-auxadc
>                 - mediatek,mt8186-auxadc
> +              - mediatek,mt8188-auxadc
>                 - mediatek,mt8195-auxadc
>                 - mediatek,mt8516-auxadc
>             - const: mediatek,mt8173-auxadc

