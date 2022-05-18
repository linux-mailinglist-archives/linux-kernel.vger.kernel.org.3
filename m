Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8CD52B73E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiERKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiERKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DAF15A3C9;
        Wed, 18 May 2022 03:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9892617F5;
        Wed, 18 May 2022 10:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB1BC385A5;
        Wed, 18 May 2022 10:09:06 +0000 (UTC)
Message-ID: <59137538-bf77-5ea2-3375-c4d3f8c6ff27@xs4all.nl>
Date:   Wed, 18 May 2022 12:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v15 1/3] dt-binding: mediatek: add bindings for MediaTek
 MDP3 components
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        cellopoint.kai@gmail.com
References: <20220512092306.6895-1-moudy.ho@mediatek.com>
 <20220512092306.6895-2-moudy.ho@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220512092306.6895-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moudy,

On 5/12/22 11:23, Moudy Ho wrote:
> This patch adds DT binding documents for Media Data Path 3 (MDP3)
> a unit in multimedia system combined with several components and
> used for scaling and color format convert.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 85 +++++++++++++++++++
>  .../bindings/media/mediatek,mdp3-rsz.yaml     | 65 ++++++++++++++
>  .../bindings/media/mediatek,mdp3-wrot.yaml    | 70 +++++++++++++++
>  .../bindings/soc/mediatek/mediatek,ccorr.yaml | 58 +++++++++++++
>  .../bindings/soc/mediatek/mediatek,wdma.yaml  | 71 ++++++++++++++++

This changes bindings in two subsystems in a single patch. I would recommend splitting
this up. Besides, the subject specifically says "MDP3 components", so having other
components in this patch is confusing.

The soc bindings can either go through the soc subsystem or through the media
subsystem, but then I need Acked-by from the maintainer.

>  5 files changed, 349 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml

Why is this part of soc/mediatek instead of media? CSC is typically a media operation.

I'm not saying it is wrong, but it's a bit odd. Apologies if this was asked before.

Regards,

	Hans

>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> new file mode 100644
> index 000000000000..4fe704e476dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Read Direct Memory Access
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> +
> +description: |
> +  Mediatek Read Direct Memory Access(RDMA) component used to do read DMA.
> +  It contains one line buffer to store the sufficient pixel data, and
> +  must be siblings to the central MMSYS_CONFIG node.
> +  For a description of the MMSYS_CONFIG binding, see
> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +  for details.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8183-mdp3-rdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property. Each GCE subsys id is mapping to
> +      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: RDMA clock
> +      - description: RSZ clock
> +
> +  iommus:
> +    maxItems: 1
> +
> +  mboxes:
> +    items:
> +      - description: used for 1st data pipe from RDMA
> +      - description: used for 2nd data pipe from RDMA
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - power-domains
> +  - clocks
> +  - iommus
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/gce/mt8183-gce.h>
> +    #include <dt-bindings/power/mt8183-power.h>
> +    #include <dt-bindings/memory/mt8183-larb-port.h>
> +
> +    mdp3_rdma0: mdp3-rdma0@14001000 {
> +      compatible = "mediatek,mt8183-mdp3-rdma";
> +      reg = <0x14001000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
> +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +      clocks = <&mmsys CLK_MM_MDP_RDMA0>,
> +               <&mmsys CLK_MM_MDP_RSZ1>;
> +      iommus = <&iommu>;
> +      mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
> +               <&gce 21 CMDQ_THR_PRIO_LOWEST>;
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> new file mode 100644
> index 000000000000..7b566fbec3c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-rsz.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Resizer
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> +
> +description: |
> +  One of Media Data Path 3 (MDP3) components used to do frame resizing.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8183-mdp3-rsz
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property. Each GCE subsys id is mapping to
> +      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +
> +  clocks:
> +    minItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/gce/mt8183-gce.h>
> +
> +    mdp3_rsz0: mdp3-rsz0@14003000 {
> +      compatible = "mediatek,mt8183-mdp3-rsz";
> +      reg = <0x14003000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>;
> +      clocks = <&mmsys CLK_MM_MDP_RSZ0>;
> +    };
> +
> +    mdp3_rsz1: mdp3-rsz1@14004000 {
> +      compatible = "mediatek,mt8183-mdp3-rsz";
> +      reg = <0x14004000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x4000 0x1000>;
> +      clocks = <&mmsys CLK_MM_MDP_RSZ1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
> new file mode 100644
> index 000000000000..5481d4e43315
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-wrot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Write DMA with Rotation
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> +
> +description: |
> +  One of Media Data Path 3 (MDP3) components used to write DMA with frame rotation.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8183-mdp3-wrot
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property. Each GCE subsys id is mapping to
> +      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - power-domains
> +  - clocks
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/gce/mt8183-gce.h>
> +    #include <dt-bindings/power/mt8183-power.h>
> +    #include <dt-bindings/memory/mt8183-larb-port.h>
> +
> +    mdp3_wrot0: mdp3-wrot0@14005000 {
> +      compatible = "mediatek,mt8183-mdp3-wrot";
> +      reg = <0x14005000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
> +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +      clocks = <&mmsys CLK_MM_MDP_WROT0>;
> +      iommus = <&iommu>;
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
> new file mode 100644
> index 000000000000..20d02cb4ad0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,ccorr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek color correction
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> +
> +description: |
> +  Mediatek color correction with 3X3 matrix.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8183-mdp3-ccorr
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property. Each GCE subsys id is mapping to
> +      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +
> +  clocks:
> +    minItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/gce/mt8183-gce.h>
> +
> +    mdp3_ccorr: mdp3-ccorr@1401c000 {
> +      compatible = "mediatek,mt8183-mdp3-ccorr";
> +      reg = <0x1401c000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xc000 0x1000>;
> +      clocks = <&mmsys CLK_MM_MDP_CCORR>;
> +    };
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> new file mode 100644
> index 000000000000..102d9e163139
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,wdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Write Direct Memory Access
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> +
> +description: |
> +  Mediatek Write Direct Memory Access(WDMA) component used to write
> +  the data into DMA.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8183-mdp3-wdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle of GCE
> +        - description: GCE subsys id
> +        - description: register offset
> +        - description: register size
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property. Each GCE subsys id is mapping to
> +      a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - power-domains
> +  - clocks
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/gce/mt8183-gce.h>
> +    #include <dt-bindings/power/mt8183-power.h>
> +    #include <dt-bindings/memory/mt8183-larb-port.h>
> +
> +    mdp3_wdma: mdp3-wdma@14006000 {
> +      compatible = "mediatek,mt8183-mdp3-wdma";
> +      reg = <0x14006000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
> +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +      clocks = <&mmsys CLK_MM_MDP_WDMA0>;
> +      iommus = <&iommu>;
> +    };
