Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7CC56FFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiGKLMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiGKLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:12:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E3B4C63F;
        Mon, 11 Jul 2022 03:22:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B37F66016BD;
        Mon, 11 Jul 2022 11:22:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657534937;
        bh=bV1U1DKxcTKTqjYlyMTELSAITeuujTusjiLSnU/9yrk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A3Ctq1Zv7iQhRS2oUxLijFF7IVoJOUbMbnxuZHcVXamHBLfWA5JfUvbCkS3uMeQ2F
         WjopG6tuVqOuQ4uMP717PNpVIJfYhmGOMgvohPGXZNAwIdJO6j4mXfF1tmNoz2swe3
         MKiBG1tn6+qIht/QdjN5UiSk8XOwC1ZLmFgnFa0wanPNy3RsdKYfazh8L+cafylqCV
         BInt4sdtrFy0K8EmrMmwCo/NkZPNvo4uANvcAFUT38ApezenUQ1RkTWVFg6WUmbbpM
         VkAsRiUguleEZqvQ57aLU8q4kJyT/rGuXwxJqedDYOFYBfBS/hBouoHEltUrhOj/aM
         BoVke4fYmuKEA==
Message-ID: <4f6fbc6e-fb9f-588a-41f9-30a0e0107526@collabora.com>
Date:   Mon, 11 Jul 2022 12:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 2/2] dt-bindings: mediatek: Add axi clock in mt8173 dts
 example
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bin.zhang@mediatek.com,
        benliang.zhao@mediatek.com, linux-mediatek@lists.infradead.org
References: <20220708021548.21453-1-xiangsheng.hou@mediatek.com>
 <20220708021548.21453-3-xiangsheng.hou@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220708021548.21453-3-xiangsheng.hou@mediatek.com>
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

Il 08/07/22 04:15, Xiangsheng Hou ha scritto:
> For mt8173, it is needed to add the axi clock for dma mode.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>   .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml         | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> index 41e60fe4b09f..413b907eecf5 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
> @@ -82,8 +82,8 @@ examples:
>           compatible = "mediatek,mt8173-nor";
>           reg = <0 0x1100d000 0 0xe0>;
>           interrupts = <1>;
> -        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> -        clock-names = "spi", "sf";
> +        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>, <&pericfg CLK_PERI_NFI>;

This is going over 100 columns, which is too many.
Please fix.

> +        clock-names = "spi", "sf", "axi";
>           #address-cells = <1>;
>           #size-cells = <0>;
>   
> 

