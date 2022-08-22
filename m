Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEECA59C1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiHVOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiHVOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:31:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702F42E6A1;
        Mon, 22 Aug 2022 07:31:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n4so13442684wrp.10;
        Mon, 22 Aug 2022 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=e8rp45GCMeCz0OMnywxQPCUJjJPUfEFDilX4Y8pEpZI=;
        b=MMmcWfq/cL54YCfYi+QRrMezlys3RuKILMv0NhI7kuz5I02Ue9qmQmAWRs75ABwrOQ
         NzgXznxWFSZ8UrinTlq1oRipNyVfHptGlbXSbYTMvgQJtbvVKZjwONe/g5oc/7TIcwxN
         BTs6WywE/RqKj4W4SB5N80HNtfgsxV8N+3UN+rzIzdvhLHkKhqKVpJJzDmo0aeHpZA8f
         4V9bxZ00Jy1UmBjO/XzqkIuNa/qrEXKNGiVpqiwui9VfN6R9nJlbq7q88Rtnoef88AMa
         QTYOGQdpZG8ID8v1gGTNF4ADrQl/OwAK1Qw8mU+vuazIFnIq4M8mxHI8BPxgicmon6xL
         XouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=e8rp45GCMeCz0OMnywxQPCUJjJPUfEFDilX4Y8pEpZI=;
        b=OjdzHZNhelKjGl6iwCOj9DaxK/m9wUpdR8+qZN1K8Q6qyQeJNEBIVa1cp3dZ67Fgud
         VjA56iEOn7ckQkRE0qvPjTE5Y6dQS3ltRGORw2RvzodJr7J/C/+pZ8FJQk9frtXN1lZY
         xDXo1davRbUF62efUnnCXl/xVXxYB5fF5575mb+CqkbHx6rzi8mUekC0fY80I8XdUxzC
         bUFrLpkxCSWIDo2tr3Svhzj0HDDO7/BmivG5HwC++rxT9I1ASYDsC+dItwmVFXCB3k00
         sg+FGAFB/TnRcrcXKdFwfgXfw9lhd8eV82D87HZsEqVHnC1CWHDwVxSxcfwKzrMzyZPI
         vaIQ==
X-Gm-Message-State: ACgBeo3XMgpEuUVIqJhDauBCLAog3eiqTEDiZ7zvA1LwDT/6K2LvjYmy
        X05rsi41Sah2REiDUkfl4pY=
X-Google-Smtp-Source: AA6agR7V2xlMA1x2MOGtaJffxWJTddD22Tpk+8uk6FO/HmgUscNGWvV/0bH34ZDI2j5RtVTO1jL4EQ==
X-Received: by 2002:adf:f74b:0:b0:225:1fdb:a787 with SMTP id z11-20020adff74b000000b002251fdba787mr11319386wrp.33.1661178714778;
        Mon, 22 Aug 2022 07:31:54 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003a342933727sm6098056wmq.3.2022.08.22.07.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 07:31:52 -0700 (PDT)
Message-ID: <2e71f901-98da-9a40-780c-5e95c251d78a@gmail.com>
Date:   Mon, 22 Aug 2022 16:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v25 1/4] dt-binding: mediatek: add bindings for MediaTek
 MDP3 components
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
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
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        cellopoint.kai@gmail.com
References: <20220817095629.29911-1-moudy.ho@mediatek.com>
 <20220817095629.29911-2-moudy.ho@mediatek.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220817095629.29911-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2022 11:56, Moudy Ho wrote:
> This patch adds DT binding documents for Media Data Path 3 (MDP3)
> a unit in multimedia system combined with several components and
> used for scaling and color format convert.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../bindings/media/mediatek,mdp3-rdma.yaml    | 95 +++++++++++++++++++
>   .../bindings/media/mediatek,mdp3-rsz.yaml     | 77 +++++++++++++++
>   .../bindings/media/mediatek,mdp3-wrot.yaml    | 80 ++++++++++++++++
>   3 files changed, 252 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> new file mode 100644
> index 000000000000..94ff74d9c04a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Read Direct Memory Access
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>

Ping-Hsun Wu isn't even CCed on this mail. Why aren't you the maintainer if you 
submit the patch?

Regards,
Matthias

> +
> +description: |
> +  MediaTek Read Direct Memory Access(RDMA) component used to do read DMA.
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
> +  mediatek,gce-events:
> +    description:
> +      The event id which is mapping to the specific hardware event signal
> +      to gce. The event id is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
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
> +  - mediatek,gce-events
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
> +      mediatek,gce-events = <CMDQ_EVENT_MDP_RDMA0_SOF>,
> +                            <CMDQ_EVENT_MDP_RDMA0_EOF>;
> +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +      clocks = <&mmsys CLK_MM_MDP_RDMA0>,
> +               <&mmsys CLK_MM_MDP_RSZ1>;
> +      iommus = <&iommu>;
> +      mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
> +               <&gce 21 CMDQ_THR_PRIO_LOWEST>;
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> new file mode 100644
> index 000000000000..22c61ed00fdd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-rsz.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Resizer
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
> +  mediatek,gce-events:
> +    description:
> +      The event id which is mapping to the specific hardware event signal
> +      to gce. The event id is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  clocks:
> +    minItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - mediatek,gce-client-reg
> +  - mediatek,gce-events
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
> +      mediatek,gce-events = <CMDQ_EVENT_MDP_RSZ0_SOF>,
> +                            <CMDQ_EVENT_MDP_RSZ0_EOF>;
> +      clocks = <&mmsys CLK_MM_MDP_RSZ0>;
> +    };
> +
> +    mdp3_rsz1: mdp3-rsz1@14004000 {
> +      compatible = "mediatek,mt8183-mdp3-rsz";
> +      reg = <0x14004000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x4000 0x1000>;
> +      mediatek,gce-events = <CMDQ_EVENT_MDP_RSZ1_SOF>,
> +                            <CMDQ_EVENT_MDP_RSZ1_EOF>;
> +      clocks = <&mmsys CLK_MM_MDP_RSZ1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
> new file mode 100644
> index 000000000000..76c010720d43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-wrot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Write DMA with Rotation
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
> +  mediatek,gce-events:
> +    description:
> +      The event id which is mapping to the specific hardware event signal
> +      to gce. The event id is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
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
> +  - mediatek,gce-events
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
> +      mediatek,gce-events = <CMDQ_EVENT_MDP_WROT0_SOF>,
> +                            <CMDQ_EVENT_MDP_WROT0_EOF>;
> +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +      clocks = <&mmsys CLK_MM_MDP_WROT0>;
> +      iommus = <&iommu>;
> +    };
