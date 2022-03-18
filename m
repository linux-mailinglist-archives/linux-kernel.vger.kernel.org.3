Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316124DD8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiCRLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiCRLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:31:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D7E1ED043;
        Fri, 18 Mar 2022 04:29:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C12C91F45BE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647602993;
        bh=hEq5CQBIYDpOSE8rYqrF9Pr2CGQ6yjPai9TP2Z1F2Ww=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ix2SDlHuXaTogi0wYj6ufFFJZqPuqpM1n79MzBo8NDi4SOUeYE4KyPND+KBtoxNmE
         voxSeyzl2PdqfO6XlRk6356TZ+I1h2JCsTCb/QdIhj7JkUfcecDnrAwU5TkLMwVpzE
         GvAG4jN6U8A1zYZTaYmJkbgKyMOjNprrMBh9MnL/t/E583gZWGzzBms0Zu1ekJRBpS
         ieuH0seSPBh48BSLPxrU4d6o/7iXw3UL11WEedd7wEGoTvk9X04i3Ru3C1E0iEKENf
         0GCOFp+98JmOiFyIhYSe1iXg0GVQQhE1TGwOOmA+4FtAAokELo89Cp071lVVAp1Yz4
         EigmWM14xVyXg==
Message-ID: <fc5f0554-dc37-d514-039c-cfacbe407813@collabora.com>
Date:   Fri, 18 Mar 2022 12:29:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V5 2/3] dt-bindings: spi: support hclk
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220318025027.31281-1-leilk.liu@mediatek.com>
 <20220318025027.31281-3-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318025027.31281-3-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/03/22 03:50, Leilk Liu ha scritto:
> this patch support hclk for AHB bus.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml          | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index 7247a177466b..ecb4a5002cc1 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -53,16 +53,20 @@ properties:
>       maxItems: 1
>   
>     clocks:
> +    minItems: 3
>       items:
>         - description: clock used for the parent clock
>         - description: clock used for the muxes clock
>         - description: clock used for the clock gate
> +      - description: clock used for the AHB bus, this clock is optional
>   
>     clock-names:
> +    minItems: 3
>       items:
>         - const: parent-clk
>         - const: sel-clk
>         - const: spi-clk
> +      - const: hclk
>   
>     mediatek,pad-select:
>       $ref: /schemas/types.yaml#/definitions/uint32-array



