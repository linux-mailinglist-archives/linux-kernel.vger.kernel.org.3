Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F06550066
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356425AbiFQXLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiFQXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:11:43 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2777F62BE9;
        Fri, 17 Jun 2022 16:11:42 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id n11so5955838iod.4;
        Fri, 17 Jun 2022 16:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ocSDv0KbLxR8Foonu4dTQCyLR9CdgrTx1ewUehoAImk=;
        b=f9q3BaDPLCCaTCMvb4nFWKQTsHYZmeakXN8C0fTJ052ckWBpxsxBZp8AlB69yxBGAF
         YL1GsrMrqaMVZchBZpVNcSg2i3ZPyoyYrLdgtEc3B78X+zxzJ7KwZO45mTqKtlkMoFW1
         9aji31+AZDT+zLL+06KvFnHpkVjTkZ33f9EYlRAo9cHFgy9/nEtPOQyYZZJvb/UdYN3f
         5467il9KkhTJttnNommsNM9ls3RfGiePsmw60e/UzO/dLq0hPkz+MQLgj4hkVtCLrDdS
         0zbm6MVjhjzWXN+VWI99BYbfKWChVB0wzFf/oGSV/suY4GbGvsmV9m3wu/XSPw5zI1mL
         aTkQ==
X-Gm-Message-State: AJIora/6B6rV+YY0MLSJqTUeSLBhgrCnjLMYLmccsvzhIssrO+BBACvZ
        4pmPCR3Bt1Q8wyCS8+pg2ZkLn/dOqQ==
X-Google-Smtp-Source: AGRyM1u/VBMhTIF5VYeYK/B6h2IXUlXNo6UGJ2e9kLLlnK2XJcQKAGLVeLDCBOfHHOTs2DPhDBiHvg==
X-Received: by 2002:a05:6638:3389:b0:331:f5e7:7dda with SMTP id h9-20020a056638338900b00331f5e77ddamr6686415jav.93.1655507501367;
        Fri, 17 Jun 2022 16:11:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z25-20020a05663803b900b00335d838f40bsm2402913jap.138.2022.06.17.16.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:11:41 -0700 (PDT)
Received: (nullmailer pid 2613068 invoked by uid 1000);
        Fri, 17 Jun 2022 23:11:39 -0000
Date:   Fri, 17 Jun 2022 17:11:39 -0600
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
Subject: Re: [RESEND V9,1/7] dt-bindings: mediatek: Add mediatek,
 mt8195-jpgenc compatible
Message-ID: <20220617231139.GA2610098-robh@kernel.org>
References: <20220614121024.31667-1-irui.wang@mediatek.com>
 <20220614121024.31667-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614121024.31667-2-irui.wang@mediatek.com>
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

On Tue, Jun 14, 2022 at 08:10:18PM +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgenc compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  .../media/mediatek,mt8195-jpegenc.yaml        | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> new file mode 100644
> index 000000000000..a7f9f723d5db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt8195-jpegenc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Encoder Device Tree Bindings
> +
> +maintainers:
> +  - kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
> +
> +description: |-
> +  MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8195-jpgenc
> +
> +  mediatek,jpegenc-multi-core:
> +    type: boolean
> +    description: |
> +      Indicates whether the jpeg encoder has multiple cores or not.
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 4
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
> +  "^jpgenc@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      The jpeg encoder hardware device node which should be added as subnodes to
> +      the main jpeg node.
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mt8195-jpgenc-hw
> +
> +      reg:
> +        maxItems: 1
> +
> +      hw_id:
> +        description: |
> +          Current jpegenc hw id.

Same question here. Surely, I asked sometime in the last 8 versions, but 
no explanation here and I'm not going to go look for it.

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
> +          - const: jpgenc
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
> +        jpgenc_master {
> +                compatible = "mediatek,mt8195-jpgenc";
> +                mediatek,jpegenc-multi-core;
> +                power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
> +                iommus = <&iommu_vpp M4U_PORT_L20_JPGENC_Y_RDMA>,
> +                <&iommu_vpp M4U_PORT_L20_JPGENC_C_RDMA>,
> +                <&iommu_vpp M4U_PORT_L20_JPGENC_Q_TABLE>,
> +                <&iommu_vpp M4U_PORT_L20_JPGENC_BSDMA>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges;
> +
> +                jpgenc@1a030000 {
> +                        compatible = "mediatek,mt8195-jpgenc-hw";
> +                        reg = <0 0x1a030000 0 0x10000>;
> +                        hw_id = <0>;
> +                        iommus = <&iommu_vdo M4U_PORT_L19_JPGENC_Y_RDMA>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGENC_C_RDMA>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGENC_Q_TABLE>,
> +                        <&iommu_vdo M4U_PORT_L19_JPGENC_BSDMA>;
> +                        interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH 0>;
> +                        clocks = <&vencsys CLK_VENC_JPGENC>;
> +                        clock-names = "jpgenc";
> +                        power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
> +                };
> +
> +                jpgenc@1b030000 {
> +                        compatible = "mediatek,mt8195-jpgenc-hw";
> +                        reg = <0 0x1b030000 0 0x10000>;
> +                        hw_id = <1>;
> +                        iommus = <&iommu_vpp M4U_PORT_L20_JPGENC_Y_RDMA>,
> +                        <&iommu_vpp M4U_PORT_L20_JPGENC_C_RDMA>,
> +                        <&iommu_vpp M4U_PORT_L20_JPGENC_Q_TABLE>,
> +                        <&iommu_vpp M4U_PORT_L20_JPGENC_BSDMA>;
> +                        interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH 0>;
> +                        clocks = <&vencsys_core1 CLK_VENC_CORE1_JPGENC>;
> +                        clock-names = "jpgenc";
> +                        power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
> +                };
> +        };
> +    };
> -- 
> 2.18.0
> 
> 
