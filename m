Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCD55005F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383266AbiFQXIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377857AbiFQXIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:08:13 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2350322518;
        Fri, 17 Jun 2022 16:08:11 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id c4so403106ilj.7;
        Fri, 17 Jun 2022 16:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=boBsEYeSmkjb+BOCaUDQtsmmY5mPhlPnMP5EgdS/R1I=;
        b=XCboexXKqf0oZfGfLRH13Iaz4TxS8T8ZL5VnJr8yF1Nv/g9Pg3B5Cb7Gb2dZE9KbhB
         Q3E26ozz4BuPBfOuz1+0lnSMb/HD420AZCtHNcFClZezQdKecrVonj7AZbVnVLjuDNLi
         vm8uWQ4svZwKJrIbouvZXz2KrqD+/EvFVI+GKS0bh10xCFq6rKvxoLjt7fqfb9P0q7Ld
         qzK6q8S3h4G+Tc+xPnzVpL4KP9iT7lPSqWXsH12Q680WlRw2wtH9rHKlCd025XN2uwu7
         X9Qb4pkgZO5WAeOHtgsTMZ9rBserrxStrgCmSX7MfpmegPQ/ZaYQ/k/+I4cml3H6oCqM
         wXgg==
X-Gm-Message-State: AJIora/TRVVj7M5KZ7UiFa6gyzoM+Skp+hO6b9IrnnO+W+Q+wuW05O6+
        RIJVgdRrNM/R+W0gyTy0qA==
X-Google-Smtp-Source: AGRyM1uXiG8Xggf+u/lRmTS4EnGutEnUuUzhwGjsExceUCQKBvQOrA5/yQzEqlo4Qn7q5VQa0INI7Q==
X-Received: by 2002:a92:dc91:0:b0:2d8:ecc3:ffb5 with SMTP id c17-20020a92dc91000000b002d8ecc3ffb5mr1765920iln.170.1655507290320;
        Fri, 17 Jun 2022 16:08:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id h18-20020a02c732000000b0032e3b0933c6sm2730805jao.162.2022.06.17.16.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:08:09 -0700 (PDT)
Received: (nullmailer pid 2608063 invoked by uid 1000);
        Fri, 17 Jun 2022 23:08:08 -0000
Date:   Fri, 17 Jun 2022 17:08:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
Subject: Re: [RESEND V3,1/8] dt-bindings: mediatek: Add
 mediatek,mt8195-jpgdec compatible
Message-ID: <20220617230808.GA2594727-robh@kernel.org>
References: <20220614121004.31616-1-irui.wang@mediatek.com>
 <20220614121004.31616-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614121004.31616-2-irui.wang@mediatek.com>
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

On Tue, Jun 14, 2022 at 08:09:57PM +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgdec compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  .../media/mediatek,mt8195-jpegdec.yaml        | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> new file mode 100644
> index 000000000000..7b3df7c714aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> @@ -0,0 +1,175 @@
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
> +description: |-
> +  MediaTek JPEG Decoder is the JPEG decode hardware present in MediaTek SoCs
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8195-jpgdec
> +
> +  mediatek,jpegdec-multi-core:
> +    type: boolean
> +    description: |
> +      Indicates whether the jpeg encoder has multiple cores or not.
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 6
> +    description: |
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
> +    description: |
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
> +      hw_id:
> +        description: |
> +          Current jpegdec hw id.

What's this for and how is it used? We generally don't do indexes in DT.

> +
> +      iommus:
> +        minItems: 1
> +        maxItems: 32
> +        description: |
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
> +      - hw_id
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
> +                mediatek,jpegdec-multi-core;
> +                power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
> +                iommus = <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA0>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA0>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA1>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA1>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
> +                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges;
> +
> +                jpgdec@1a040000 {
> +                    compatible = "mediatek,mt8195-jpgdec-hw";
> +                    reg = <0 0x1a040000 0 0x10000>;/* JPGDEC_C0 */
> +                    hw_id = <0>;
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
> +                    hw_id = <1>;
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
> +                    hw_id = <2>;
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
