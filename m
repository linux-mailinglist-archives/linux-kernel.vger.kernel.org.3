Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA73459601D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiHPQ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiHPQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:26:10 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1E87B1F5;
        Tue, 16 Aug 2022 09:26:09 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id i77so5105104ioa.7;
        Tue, 16 Aug 2022 09:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wzuSEP+VTXN0cwYkMVQpCqVkuFjEXSOY4lGyaDNFC9M=;
        b=13kWgu/ScnwVWlsbP0olfmZrC8rUiRE7aHaFFfejCXTmbeiO3YGQhIapqU1iTNz+s/
         tuHJtGCAHszQ86zqCw+Er1sF10jA4RKj7LLX/q+Ho7/KLVxj7lITmuAqoE6ha4wxJdaS
         nNjyexCBAJV8ssqAHy6+O/xYXU3WCw+2QaTp7BoZipR2eQuNvVJzjgdiw6qsSwGXtEuW
         wiuZO8/gRId3N/F7LWBesyThZVVoDNNHsi1EdBGs0HKSKYwusB5aOGT4FllbrcY4Lyja
         HAqVcr2bMd9ImG/cyZmKjB4GVz6PptXRQmCu5bazWW7GGpuV4pr+g/QhFnVdzIK723v/
         I05A==
X-Gm-Message-State: ACgBeo1zzcsdhGYMBEvlUNpmlv9y/On8tvwf52/iPNOhVHOvoPPf/KX8
        Tzu7GvIU0oR2UrV8xDuCGg==
X-Google-Smtp-Source: AA6agR4BJn8XnmIhH71UkTnsF8ILLBsb4m6dSK+gjIs1F7/P+tvqRmNZfK+X772OtSGpaT0GTD4NQA==
X-Received: by 2002:a6b:c343:0:b0:67c:6033:a682 with SMTP id t64-20020a6bc343000000b0067c6033a682mr8999898iof.148.1660667168262;
        Tue, 16 Aug 2022 09:26:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y92-20020a029565000000b003433f35eb40sm4509919jah.80.2022.08.16.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:26:07 -0700 (PDT)
Received: (nullmailer pid 2325302 invoked by uid 1000);
        Tue, 16 Aug 2022 16:26:05 -0000
Date:   Tue, 16 Aug 2022 10:26:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        kyrie wu <kyrie.wu@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
Subject: Re: [V6,1/8] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec
 compatible
Message-ID: <20220816162605.GA2315090-robh@kernel.org>
References: <20220729062603.5533-1-irui.wang@mediatek.com>
 <20220729062603.5533-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729062603.5533-2-irui.wang@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 02:25:56PM +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgdec compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> ---
>  .../media/mediatek,mt8195-jpegdec.yaml        | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> new file mode 100644
> index 000000000000..ebda0ade8153
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt8195-jpegdec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Encoder Device Tree Bindings
> +
> +maintainers:
> +  - kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
> +
> +description:
> +  MediaTek JPEG Decoder is the JPEG decode hardware present in MediaTek SoCs
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8195-jpgdec
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 6
> +    description:
> +      Points to the respective IOMMU block with master port as argument, see
> +      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
> +      Ports are according to the HW.
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +# Required child node:
> +patternProperties:
> +  "^jpgdec@[0-9a-f]+$":
> +    type: object
> +    description:
> +      The jpeg decoder hardware device node which should be added as subnodes to
> +      the main jpeg node.
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mt8195-jpgdec-hw
> +
> +      reg:
> +        maxItems: 1
> +
> +      iommus:
> +        minItems: 1
> +        maxItems: 32
> +        description:
> +          List of the hardware port in respective IOMMU block for current Socs.
> +          Refer to bindings/iommu/mediatek,iommu.yaml.
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        items:
> +          - const: jpgdec
> +
> +      power-domains:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - iommus
> +      - interrupts
> +      - clocks
> +      - clock-names
> +      - power-domains
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - power-domains
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt8195-memory-port.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        jpgdec_master {
> +                compatible = "mediatek,mt8195-jpgdec";
> +                power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
> +                iommus = <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA0>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA0>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA1>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA1>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +

Missing ranges.

Presumably at least 1 child node is required because there's no 'reg' 
property in the parent to access the h/w. So 'ranges', "#address-cells', 
and '#size-cells' should all be required.

> +                jpgdec@1a040000 {
> +                    compatible = "mediatek,mt8195-jpgdec-hw";
> +                    reg = <0 0x1a040000 0 0x10000>;/* JPGDEC_C0 */
> +                    iommus = <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA0>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA1>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA1>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
> +                    interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH 0>;
> +                    clocks = <&vencsys CLK_VENC_JPGDEC>;
> +                    clock-names = "jpgdec";
> +                    power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
> +                };
> +
> +                jpgdec@1a050000 {
> +                    compatible = "mediatek,mt8195-jpgdec-hw";
> +                    reg = <0 0x1a050000 0 0x10000>;/* JPGDEC_C1 */
> +                    iommus = <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA0>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA1>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA1>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
> +                    interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH 0>;
> +                    clocks = <&vencsys CLK_VENC_JPGDEC_C1>;
> +                    clock-names = "jpgdec";
> +                    power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
> +                };
> +
> +                jpgdec@1b040000 {
> +                    compatible = "mediatek,mt8195-jpgdec-hw";
> +                    reg = <0 0x1b040000 0 0x10000>;/* JPGDEC_C2 */
> +                    iommus = <&iommu_vpp M4U_PORT_L20_JPGDEC_WDMA0>,
> +                        <&iommu_vpp M4U_PORT_L20_JPGDEC_BSDMA0>,
> +                        <&iommu_vpp M4U_PORT_L20_JPGDEC_WDMA1>,
> +                        <&iommu_vpp M4U_PORT_L20_JPGDEC_BSDMA1>,
> +                        <&iommu_vpp M4U_PORT_L20_JPGDEC_BUFF_OFFSET1>,
> +                        <&iommu_vpp M4U_PORT_L20_JPGDEC_BUFF_OFFSET0>;
> +                    interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH 0>;
> +                    clocks = <&vencsys_core1 CLK_VENC_CORE1_JPGDEC>;
> +                    clock-names = "jpgdec";
> +                    power-domains = <&spm MT8195_POWER_DOMAIN_VDEC2>;
> +                };
> +        };
> +    };
> -- 
> 2.18.0
> 
> 
