Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DA3550A4D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiFSLkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiFSLkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:40:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31211A25;
        Sun, 19 Jun 2022 04:40:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BCC3925E;
        Sun, 19 Jun 2022 13:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655638826;
        bh=F985BgbPk6OEp+5ogkDCv/89Z7ithnzpRugLwEVYEp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUHkgqIQ4eCmyE3s1Ug0PS5cPnbkHC1bVg5u4Kzwc9F7zsf4U4y7zVpSYYhXRdz3D
         W0psvcSnd25rEngNNlURd57Ohq3pRoND2QH76OMOuuaz98Q82wDLZ7w4Q3fiJe8boX
         fxZERRMUkJZzKAfXZlMeBapvfLj/GVg+N0MPpeyk=
Date:   Sun, 19 Jun 2022 14:40:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH] dt-bindings: phy: make phy-cells description a text
Message-ID: <Yq8LHN+WGVpXDwiM@pendragon.ideasonboard.com>
References: <20220619113325.21396-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220619113325.21396-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On Sun, Jun 19, 2022 at 01:33:25PM +0200, Krzysztof Kozlowski wrote:
> The description field is a string, so using YAML inside phy-cells
> description is not actually helpful.

Does it hurt though ? For xlnx,zynqmp-psgtr.yaml I wrote it that way to
prepare for a future where it could be described using a YAML schema
(but such future may never come).

> Make it a proper text.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/mediatek,tphy.yaml           | 14 ++++----
>  .../bindings/phy/mediatek,xsphy.yaml          | 10 +++---
>  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 32 ++++++++-----------
>  3 files changed, 23 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index 4b638c1d4221..bd0e4c4915ed 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -154,14 +154,12 @@ patternProperties:
>        "#phy-cells":
>          const: 1
>          description: |
> -          The cells contain the following arguments.
> -
> -          - description: The PHY type
> -              enum:
> -                - PHY_TYPE_USB2
> -                - PHY_TYPE_USB3
> -                - PHY_TYPE_PCIE
> -                - PHY_TYPE_SATA
> +          The cells contain the following arguments::
> +            - The PHY type::
> +              - PHY_TYPE_USB2
> +              - PHY_TYPE_USB3
> +              - PHY_TYPE_PCIE
> +              - PHY_TYPE_SATA
>  
>        nvmem-cells:
>          items:
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> index 598fd2b95c29..7262b8e184e2 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> @@ -100,12 +100,10 @@ patternProperties:
>        "#phy-cells":
>          const: 1
>          description: |
> -          The cells contain the following arguments.
> -
> -          - description: The PHY type
> -              enum:
> -                - PHY_TYPE_USB2
> -                - PHY_TYPE_USB3
> +          The cells contain the following arguments::
> +            - The PHY type::
> +              - PHY_TYPE_USB2
> +              - PHY_TYPE_USB3
>  
>        # The following optional vendor properties are only for debug or HQA test
>        mediatek,eye-src:
> diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> index 79906519c652..7083eddb467c 100644
> --- a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> +++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> @@ -18,25 +18,19 @@ properties:
>    "#phy-cells":
>      const: 4
>      description: |
> -      The cells contain the following arguments.
> -
> -      - description: The GTR lane
> -        minimum: 0
> -        maximum: 3
> -      - description: The PHY type
> -        enum:
> -          - PHY_TYPE_DP
> -          - PHY_TYPE_PCIE
> -          - PHY_TYPE_SATA
> -          - PHY_TYPE_SGMII
> -          - PHY_TYPE_USB3
> -      - description: The PHY instance
> -        minimum: 0
> -        maximum: 1 # for DP, SATA or USB
> -        maximum: 3 # for PCIE or SGMII
> -      - description: The reference clock number
> -        minimum: 0
> -        maximum: 3
> +      The cells contain the following arguments::
> +        - The GTR lane (minimum:: 0, maximum:: 3)
> +        - The PHY type::
> +            - PHY_TYPE_DP
> +            - PHY_TYPE_PCIE
> +            - PHY_TYPE_SATA
> +            - PHY_TYPE_SGMII
> +            - PHY_TYPE_USB3
> +      - The PHY instance::
> +          minimum:: 0
> +          maximum:: 1 # for DP, SATA or USB
> +          maximum:: 3 # for PCIE or SGMII
> +      - The reference clock number (minimum:: 0, maximum:: 3)
>  
>    compatible:
>      enum:
> -- 
> 2.34.1
> 

-- 
Regards,

Laurent Pinchart
