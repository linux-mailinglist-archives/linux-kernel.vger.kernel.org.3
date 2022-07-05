Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79DA566F70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiGENjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiGENjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:39:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5988F18;
        Tue,  5 Jul 2022 06:00:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8993F6601638;
        Tue,  5 Jul 2022 14:00:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657026018;
        bh=xFTfBoFvIpfrtf8roOkGSUeJlnpS93yjOxDqqSL95Lg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ku15DI+Ym+ERogIHDpcZnaA9HjaGwsN74TqmvN/9+Hmk7ry3986pmdb+PDOaOjHgO
         yaDSMZ8zcuPOEtzY8BAEtJ23zHHeLRfLsbW2fgldCvVf1uH0FwRL+Urr/Lz7HeQZ8H
         k8aQ/4YLhBAvPzqhKxKCoay+LLtUtYpeb+MK//MeipwIKB8NOp7Jn/iLuCzvtcsttO
         qA/G+/UoPa9lBCDmTpsUBxq03bGPMtWGLPtueTe17P8N7u7A9wXhRTSuyY/DVXKHVZ
         ReDQTCiTTijGbkeeM2k6V/fS2+VwMtSC3xtps3JcICVaqQFj+/qIQptfKgYrTwO12/
         UFy2xKaGnzbSg==
Message-ID: <7d5986ad-40a4-f15b-8d14-aad5248379b3@collabora.com>
Date:   Tue, 5 Jul 2022 15:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V4,1/8] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec
 compatible
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
References: <20220627025540.8901-1-irui.wang@mediatek.com>
 <20220627025540.8901-2-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220627025540.8901-2-irui.wang@mediatek.com>
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

Il 27/06/22 04:55, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgdec compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>   .../media/mediatek,mt8195-jpegdec.yaml        | 176 ++++++++++++++++++
>   1 file changed, 176 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> new file mode 100644
> index 000000000000..8a255e8e2e09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt8195-jpegdec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +

...snip...

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

Additionally to Rob's review, which I of course fully agree on, this example
devicetree does *not* work on MT8195.

[   13.015716] mtk-jpegdec-hw 1a040000.jpgdec: Adding to iommu group 1

[   13.025383] mtk-jpegdec-hw 1a050000.jpgdec: Adding to iommu group 1

[   13.034814] mtk-jpegdec-hw 1b040000.jpgdec: Adding to iommu group 1

[   13.041672] mtk-jpeg soc:jpgdec_master: invalid resource

[   13.049758] mtk-jpeg: probe of soc:jpgdec_master failed with error -22


Regards,
Angelo

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



