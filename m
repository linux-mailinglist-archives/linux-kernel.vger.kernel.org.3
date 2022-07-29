Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB92584D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiG2Ie5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiG2Ie4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:34:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29C17D1CC;
        Fri, 29 Jul 2022 01:34:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63FF36601B38;
        Fri, 29 Jul 2022 09:34:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659083694;
        bh=JZHyz/nv/3f5KWb0VPaswGYeWHtAmTjncnJD7Dy6ybw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F2dfqoJV3UzCqw3OHj+c25OHr/eYsuxNUkpukVM8d6eqScVGjz2mAssU3L3Rc8CGh
         j/9l/QPEMNq+Dya4C9Z/xsjj9aEJn/6R2vPrb1QSC3aF0ld+j/ffCHH0lFJH17p8qq
         0bRUcggIus0xNMkK3TwqI04/wPlkr2ZWta7h1k5Glk71DOhNdwlXJaN8FuRnVIT+a8
         9499D3e2058va4Bg5D+QitWUMwtBUvKcKipFc74Rys9YJodBI48YAx0KF323Sa0gfj
         AO/x2Mm8qAKVH5VMsEyK+1+05MZOWcAeQtZ0+XTGtuJ19rCrYgH1chsA5Z9Lm2JKwC
         FpT+Da0lFNHGw==
Message-ID: <44dde534-769c-c456-c869-4e29213b3d56@collabora.com>
Date:   Fri, 29 Jul 2022 10:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [V12,1/7] dt-bindings: mediatek: Add mediatek, mt8195-jpgenc
 compatible
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        kyrie wu <kyrie.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20220729062630.5592-1-irui.wang@mediatek.com>
 <20220729062630.5592-2-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220729062630.5592-2-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/07/22 08:26, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgenc compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> ---
>   .../media/mediatek,mt8195-jpegenc.yaml        | 139 ++++++++++++++++++
>   1 file changed, 139 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> new file mode 100644
> index 000000000000..d9133e6a92f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> @@ -0,0 +1,139 @@

..snip..

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

What about using ranges here? The binding would look way cleaner, like:

         jpeg-encoder@1a030000 {
                .... properties ....
                ranges = <0x30000   0 0x1a030000 0x10000>, /* P.S.: Not tested! */
                         <0x1030000 0 0x1b030000 0x10000>;

                encoder-core@30000 {
                         compatible = "mediatek,mt8195-jpgenc-hw";
                         reg = <0 0x30000 0 0x10000>;
                         .... properties ....
                };

                encoder-core@1030000 {
                         compatible = "mediatek,mt8195-jpgenc-hw";
                         reg = <0 0x1030000 0 0x10000>;
                         .... properties ....
                };
         };

P.S.: Added Krzysztof to the loop.

Krzysztof, can you please give an opinion on that?

Thanks,
Angelo

> +                compatible = "mediatek,mt8195-jpgenc";
> +                power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
> +                iommus = <&iommu_vpp M4U_PORT_L20_JPGENC_Y_RDMA>,
> +                <&iommu_vpp M4U_PORT_L20_JPGENC_C_RDMA>,
> +                <&iommu_vpp M4U_PORT_L20_JPGENC_Q_TABLE>,
> +                <&iommu_vpp M4U_PORT_L20_JPGENC_BSDMA>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +
> +                jpgenc@1a030000 {
> +                        compatible = "mediatek,mt8195-jpgenc-hw";
> +                        reg = <0 0x1a030000 0 0x10000>;
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


