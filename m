Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1C4DD8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiCRLN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiCRLNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:13:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7955204A9C;
        Fri, 18 Mar 2022 04:12:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EC5731F45E88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647601924;
        bh=AHxx3HJHAKwRLhKmfPdNJCDcWqUZd1j6fsxx13RQRng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HEExNe5UWQ76Ygt60cSdS31pkD7ajX866F5AmAGrVnXXYwyjwxbMfT44MRwUDQ1Bh
         xbVwZaokRZeURHfPgYLH6bIrSRTNw6NSq1JOLFsk5osbSZ1bucY39Fo4fp7jzM9WPx
         vRswXbqTWG16/gjhA+6B4J5tQih8IRBlY6Aw4PhHUHB0OlfXhihT8GrZpbuAahao9E
         2Naiv2CG+nxtokyODO4iMenBTdtpyciTJE40g9VJk3QxiaVdpOf74ViuS0xyKY0SvL
         Kn4SpwR8QQhZhnUsXBsB0rjg00ahdRJqOTpuKOdxfjsOdV4eqpKi+HYBwVS2nXrlz9
         RQfP3nB6NEi2w==
Message-ID: <2e0989c3-7132-6091-5c9e-5dc8d9af22e8@collabora.com>
Date:   Fri, 18 Mar 2022 12:12:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
References: <20220318095417.2016-1-jianjun.wang@mediatek.com>
 <20220318095417.2016-2-jianjun.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318095417.2016-2-jianjun.wang@mediatek.com>
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

Il 18/03/22 10:54, Jianjun Wang ha scritto:
> Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>   .../bindings/phy/mediatek,pcie-phy.yaml       | 75 +++++++++++++++++++
>   1 file changed, 75 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> new file mode 100644
> index 000000000000..868bf976568b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek PCIe PHY
> +
> +maintainers:
> +  - Jianjun Wang <jianjun.wang@mediatek.com>
> +
> +description: |
> +  The PCIe PHY supports physical layer functionality for PCIe Gen3 port.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8195-pcie-phy

Since I don't expect this driver to be only for MT8195, but to be extended to
support some more future MediaTek SoCs and, depending on the number of differences
in the possible future Gen4 PHYs, even different gen's, I propose to add a generic
compatible as const.

So you'll have something like:

- enum:
     - mediatek,mt8195-pcie-phy
- const: mediatek,pcie-gen3-phy

> +
> +  reg:
> +    maxItems: 1
> +

..snip..

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@11e80000 {
> +        compatible = "mediatek,mt8195-pcie-phy";

... which would reflect here as

compatible = "mediatek,mt8195-pcie-phy", "mediatek,pcie-gen3-phy"

> +        #phy-cells = <0>;
> +        reg = <0x11e80000 0x10000>;
> +        reg-names = "sif";
> +        nvmem-cells = <&pciephy_glb_intr>,
> +                      <&pciephy_tx_ln0_pmos>,
> +                      <&pciephy_tx_ln0_nmos>,
> +                      <&pciephy_rx_ln0>,
> +                      <&pciephy_tx_ln1_pmos>,
> +                      <&pciephy_tx_ln1_nmos>,
> +                      <&pciephy_rx_ln1>;
> +        nvmem-cell-names = "glb_intr", "tx_ln0_pmos",
> +                           "tx_ln0_nmos", "rx_ln0",
> +                           "tx_ln1_pmos", "tx_ln1_nmos",
> +                           "rx_ln1";
> +        power-domains = <&spm 2>;
> +    };


Regards,
Angelo
