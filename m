Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB764B8EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiBPRNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:13:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiBPRNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:13:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D798929B9EE;
        Wed, 16 Feb 2022 09:13:34 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:fdd4:c171:8e0a:65c9] (unknown [IPv6:2a01:e0a:120:3210:fdd4:c171:8e0a:65c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 126F51F44E79;
        Wed, 16 Feb 2022 17:13:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645031613;
        bh=/H1LFKsShTXR9iW+cvI+b+8z6X2JCQHGvnEY62zYF/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=falkA50lQxXzkxZ33NeEnvMQYhFtU1AYNOdCLg/HDR5+OooJ4zkkQ9yhCwhaQk878
         7AGxV7uG3rvP0dQ6Ii9q/kBlwwNADwD6SxrAtKJgPh2JkznOCudI8KSQlcPnpWRgj/
         MQVG2rM8eT0OLJ//Ro2M8VV0qL/LnopEbnOTjNLsBwZBRIc0BiRmZQROU7ZX9UqSuX
         hvKnjn+W1X/LilH4pXdBeIc/xzKuX7s1KJ3K1IZ8qKdGf+zuUVgZI3Data9+BhIEDj
         Z+JnyhML3s6/2wsrg2aemPzcyC1bmR9T1kla1CQk98sK/3ArL4MVX+B3/lni3gh+3u
         NuIe8aapK6xZQ==
Message-ID: <0f3825a1-80e4-2482-a97a-b13ea9bbf76f@collabora.com>
Date:   Wed, 16 Feb 2022 18:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v6 1/3] dt-bindings: mediatek: convert mtk jpeg decoder/encoder
 to yaml
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
References: <20211206130425.184420-1-hsinyi@chromium.org>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20211206130425.184420-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 06/12/2021 à 14:04, Hsin-Yi Wang a écrit :
> Convert mediatek jpeg decoder and encoder bindings to yaml.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

I have been able to encode jpeg files with command like:
gst-launch-1.0 videotestsrc num-buffers=1 ! v4l2jpegenc ! filesink location=test.jpeg

So, for the series:
Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
> v5->v6: no change, rebase to latest linux-next
> ---
>   .../bindings/media/mediatek-jpeg-decoder.txt  | 38 --------
>   .../bindings/media/mediatek-jpeg-decoder.yaml | 89 +++++++++++++++++++
>   .../bindings/media/mediatek-jpeg-encoder.txt  | 35 --------
>   .../bindings/media/mediatek-jpeg-encoder.yaml | 80 +++++++++++++++++
>   4 files changed, 169 insertions(+), 73 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
>   delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
>
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
> deleted file mode 100644
> index 39c1028b2dfb49..00000000000000
> --- a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -* Mediatek JPEG Decoder
> -
> -Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
> -
> -Required properties:
> -- compatible : must be one of the following string:
> -	"mediatek,mt8173-jpgdec"
> -	"mediatek,mt7623-jpgdec", "mediatek,mt2701-jpgdec"
> -	"mediatek,mt2701-jpgdec"
> -- reg : physical base address of the jpeg decoder registers and length of
> -  memory mapped region.
> -- interrupts : interrupt number to the interrupt controller.
> -- clocks: device clocks, see
> -  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
> -- clock-names: must contain "jpgdec-smi" and "jpgdec".
> -- power-domains: a phandle to the power domain, see
> -  Documentation/devicetree/bindings/power/power_domain.txt for details.
> -- mediatek,larb: must contain the local arbiters in the current Socs, see
> -  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> -  for details.
> -- iommus: should point to the respective IOMMU block with master port as
> -  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> -  for details.
> -
> -Example:
> -	jpegdec: jpegdec@15004000 {
> -		compatible = "mediatek,mt2701-jpgdec";
> -		reg = <0 0x15004000 0 0x1000>;
> -		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
> -		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
> -			  <&imgsys CLK_IMG_JPGDEC>;
> -		clock-names = "jpgdec-smi",
> -			      "jpgdec";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> -		mediatek,larb = <&larb2>;
> -		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
> -			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
> -	};
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
> new file mode 100644
> index 00000000000000..9b87f036f1785b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Decoder Device Tree Bindings
> +
> +maintainers:
> +  - Xia Jiang <xia.jiang@mediatek.com>
> +
> +description: |-
> +  Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt8173-jpgdec
> +              - mediatek,mt2701-jpgdec
> +      - items:
> +          - enum:
> +              - mediatek,mt7623-jpgdec
> +          - const: mediatek,mt2701-jpgdec
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: jpgdec-smi
> +      - const: jpgdec
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mediatek,larb:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Must contain the local arbiters in the current Socs, see
> +      Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +      for details.
> +
> +  iommus:
> +    maxItems: 2
> +    description: |
> +      Points to the respective IOMMU block with master port as argument, see
> +      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
> +      Ports are according to the HW.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - mediatek,larb
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt2701-larb-port.h>
> +    #include <dt-bindings/power/mt2701-power.h>
> +    jpegdec: jpegdec@15004000 {
> +      compatible = "mediatek,mt2701-jpgdec";
> +      reg = <0x15004000 0x1000>;
> +      interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
> +      clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
> +                <&imgsys CLK_IMG_JPGDEC>;
> +      clock-names = "jpgdec-smi",
> +                    "jpgdec";
> +      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> +      mediatek,larb = <&larb2>;
> +      iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
> +               <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
> deleted file mode 100644
> index 5e53c6ab52d011..00000000000000
> --- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -* MediaTek JPEG Encoder
> -
> -MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
> -
> -Required properties:
> -- compatible : "mediatek,mt2701-jpgenc"
> -  followed by "mediatek,mtk-jpgenc"
> -- reg : physical base address of the JPEG encoder registers and length of
> -  memory mapped region.
> -- interrupts : interrupt number to the interrupt controller.
> -- clocks: device clocks, see
> -  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
> -- clock-names: must contain "jpgenc". It is the clock of JPEG encoder.
> -- power-domains: a phandle to the power domain, see
> -  Documentation/devicetree/bindings/power/power_domain.txt for details.
> -- mediatek,larb: must contain the local arbiters in the current SoCs, see
> -  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> -  for details.
> -- iommus: should point to the respective IOMMU block with master port as
> -  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> -  for details.
> -
> -Example:
> -	jpegenc: jpegenc@1500a000 {
> -		compatible = "mediatek,mt2701-jpgenc",
> -			     "mediatek,mtk-jpgenc";
> -		reg = <0 0x1500a000 0 0x1000>;
> -		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
> -		clocks =  <&imgsys CLK_IMG_VENC>;
> -		clock-names = "jpgenc";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> -		mediatek,larb = <&larb2>;
> -		iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
> -			 <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
> -	};
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> new file mode 100644
> index 00000000000000..5e35ecfd21f1b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek-jpeg-encoder.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Encoder Device Tree Bindings
> +
> +maintainers:
> +  - Xia Jiang <xia.jiang@mediatek.com>
> +
> +description: |-
> +  MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt2701-jpgenc
> +      - const: mediatek,mtk-jpgenc
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: jpgenc
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mediatek,larb:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Must contain the local arbiters in the current Socs, see
> +      Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +      for details.
> +
> +  iommus:
> +    maxItems: 2
> +    description: |
> +      Points to the respective IOMMU block with master port as argument, see
> +      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
> +      Ports are according to the HW.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - mediatek,larb
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt2701-larb-port.h>
> +    #include <dt-bindings/power/mt2701-power.h>
> +    jpegenc: jpegenc@1500a000 {
> +      compatible = "mediatek,mt2701-jpgenc",
> +                   "mediatek,mtk-jpgenc";
> +      reg = <0x1500a000 0x1000>;
> +      interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
> +      clocks =  <&imgsys CLK_IMG_VENC>;
> +      clock-names = "jpgenc";
> +      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> +      mediatek,larb = <&larb2>;
> +      iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
> +               <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
> +    };
