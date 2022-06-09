Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C436E5445A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiFIIYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiFIIYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:24:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851210D5F1;
        Thu,  9 Jun 2022 01:24:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D3C256CF;
        Thu,  9 Jun 2022 10:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654763058;
        bh=vMa0MeOb7MuPhJf+SAgT/S3YUwPTfbIyifU6+Lln7ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZfVSv5AxZ6ensen1LEp27w+o8Xvjqj3d2YDyeuuD3fQiE8yAEsubP1ktZZuAx1uF
         cFNUB+a8lzMFtYqdVicHOrE0PqqZR5SBjzbt9pXh3UGdO9fmnUIPJOJ0riN/dLjorU
         S3gWVqTbJcq7ALbN/xoCMSB+YtDqWPeUT8s0XHZ4=
Date:   Thu, 9 Jun 2022 11:24:11 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, lee.jones@linaro.org,
        mchehab@kernel.org, marcel.ziswiler@toradex.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 03/14] dt-bindings: display: bridge: Add i.MX8qm/qxp
 pixel combiner binding
Message-ID: <YqGuK9g0g2XsJV+x@pendragon.ideasonboard.com>
References: <20220609064931.3068601-1-victor.liu@nxp.com>
 <20220609064931.3068601-4-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220609064931.3068601-4-victor.liu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

Thank you for the patch.

On Thu, Jun 09, 2022 at 02:49:20PM +0800, Liu Ying wrote:
> This patch adds bindings for i.MX8qm/qxp pixel combiner.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v7->v8:
> * No change.
> 
> v6->v7:
> * No change.
> 
> v5->v6:
> * No change.
> 
> v4->v5:
> * No change.
> 
> v3->v4:
> * No change.
> 
> v2->v3:
> * Add Rob's R-b tag.
> 
> v1->v2:
> * Use graph schema. (Laurent)
> * Use enum instead of oneOf + const for the reg property of pixel combiner
>   channels. (Rob)
> 
>  .../bridge/fsl,imx8qxp-pixel-combiner.yaml    | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-combiner.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-combiner.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-combiner.yaml
> new file mode 100644
> index 000000000000..50bae2122183
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-combiner.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/fsl,imx8qxp-pixel-combiner.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qm/qxp Pixel Combiner
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  The Freescale i.MX8qm/qxp Pixel Combiner takes two output streams from a
> +  single display controller and manipulates the two streams to support a number
> +  of modes(bypass, pixel combine, YUV444 to YUV422, split_RGB) configured as
> +  either one screen, two screens, or virtual screens.  The pixel combiner is
> +  also responsible for generating some of the control signals for the pixel link
> +  output channel.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qm-pixel-combiner
> +      - fsl,imx8qxp-pixel-combiner
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: apb
> +
> +  power-domains:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^channel@[0-1]$":
> +    type: object
> +    description: Represents a display stream of pixel combiner.
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      reg:
> +        description: The display stream index.
> +        enum: [ 0, 1 ]
> +
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Input endpoint of the display stream.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Output endpoint of the display stream.

When multiple ports are present, they are usually grouped in a "ports"
node. Not doing say may work from a schema point of view but makes
implementation of generic helpers more difficult. Unless Rob thinks
"ports" is really not needed here, I'd add it.

This comment applies to all bindings in this series.

> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +      - reg
> +      - port@0
> +      - port@1
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    pixel-combiner@56020000 {
> +        compatible = "fsl,imx8qxp-pixel-combiner";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <0x56020000 0x10000>;
> +        clocks = <&dc0_pixel_combiner_lpcg IMX_LPCG_CLK_4>;
> +        clock-names = "apb";
> +        power-domains = <&pd IMX_SC_R_DC_0>;
> +
> +        channel@0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                dc0_pixel_combiner_ch0_dc0_dpu_disp0: endpoint {
> +                    remote-endpoint = <&dc0_dpu_disp0_dc0_pixel_combiner_ch0>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +
> +                dc0_pixel_combiner_ch0_dc0_pixel_link0: endpoint {
> +                    remote-endpoint = <&dc0_pixel_link0_dc0_pixel_combiner_ch0>;
> +                };
> +            };
> +        };
> +
> +        channel@1 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <1>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                dc0_pixel_combiner_ch1_dc0_dpu_disp1: endpoint {
> +                    remote-endpoint = <&dc0_dpu_disp1_dc0_pixel_combiner_ch1>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +
> +                dc0_pixel_combiner_ch1_dc0_pixel_link1: endpoint {
> +                    remote-endpoint = <&dc0_pixel_link1_dc0_pixel_combiner_ch1>;
> +                };
> +            };
> +        };
> +    };

-- 
Regards,

Laurent Pinchart
