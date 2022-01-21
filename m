Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33950496730
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiAUVQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:16:52 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35662 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiAUVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:16:52 -0500
Received: by mail-oi1-f173.google.com with SMTP id s127so15393697oig.2;
        Fri, 21 Jan 2022 13:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UkKQ+uvaFRCpFhQDtOTqlolW1EA9Wz1GB/WpekfepzU=;
        b=ekmuPPEP06xMaonVzU4LIUVzS4Lcc33kgIRVlj5TiJ+nxfM+EUXI+5+LhB/X/0dItk
         ZaPANT+/9X2Cwk/kxdJ9gXKTi2U3kGCdzaC8QLkQorSle6tbOoUy4VdtUxXb3SxhUtu7
         9dHvxYzEhGS+8VGOCT+CQOEjD5iRoptO19CDf6sKUmUgS9GwpVc+TwZ7tftmftLXyurv
         3mNQb8liwdmXVLfsvSfI/jfcOcW3vkEpnFM+WwC2aH6q7g+SyllZWGzXSM3U1jlyD6K8
         +A/E+l1yfTDqiOH1Y1XMnpOA0x+sSl3ZA2ph+/jwB5H6M7FTBXvvsJb8SiZmLE4ebd0O
         Ewaw==
X-Gm-Message-State: AOAM533O5SuNO2k7AvI3M+Hip8aQ1za3FrBy+IUg0J1rAgxSrpz1X5Nq
        4LuumSVOqs3MbOXuv4/P1g==
X-Google-Smtp-Source: ABdhPJySWOEM64BEXqzyb8qGKsCjLH/03NMbnor1U5lQcIhESJKxnYEWlDkS6GjjmVnlm4i2bDOa4Q==
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr2100209oij.25.1642799811386;
        Fri, 21 Jan 2022 13:16:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c9sm1442652oog.43.2022.01.21.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:16:50 -0800 (PST)
Received: (nullmailer pid 1597994 invoked by uid 1000);
        Fri, 21 Jan 2022 21:16:49 -0000
Date:   Fri, 21 Jan 2022 15:16:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        menghui.lin@mediatek.com, sj.huang@mediatek.com,
        allen-kh.cheng@mediatek.com, randy.wu@mediatek.com,
        jason-jh.lin@mediatek.com, roy-cw.yeh@mediatek.com,
        river.cheng@mediatek.com, srv_heupstream@mediatek.com
Subject: Re: [PATCH v11 1/3] dt-binding: mt8183: add Mediatek MDP3 dt-bindings
Message-ID: <YesiwTSxa9HJ1lxG@robh.at.kernel.org>
References: <20220105093758.6850-1-moudy.ho@mediatek.com>
 <20220105093758.6850-2-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105093758.6850-2-moudy.ho@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 05:37:56PM +0800, Moudy Ho wrote:
> This patch adds DT binding document for Media Data Path 3 (MDP3)
> a unit in multimedia system used for scaling and color format convert.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 193 ++++++++++++++++++
>  .../bindings/media/mediatek,mdp3-rsz.yaml     |  55 +++++
>  .../bindings/media/mediatek,mdp3-wrot.yaml    |  57 ++++++
>  .../bindings/soc/mediatek/mediatek,ccorr.yaml |  47 +++++
>  .../bindings/soc/mediatek/mediatek,wdma.yaml  |  58 ++++++
>  5 files changed, 410 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> new file mode 100644
> index 000000000000..002503383934
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -0,0 +1,193 @@
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
> +
> +description: |
> +  Mediatek Read Direct Memory Access(RDMA) component used to do read DMA.
> +  It contains one line buffer to store the sufficient pixel data, and
> +  must be siblings to the central MMSYS_CONFIG node.
> +  For a description of the MMSYS_CONFIG binding, see
> +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +  for details.
> +  The 1st RDMA is also used to be a controller node in Media Data Path 3(MDP3)
> +  that containing MMSYS, MUTEX, GCE and SCP settings.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          # MDP3 controller node
> +          - const: mediatek,mt8183-mdp3

How is this more specific than this:

> +          - const: mediatek,mt8183-mdp3-rdma0

> +      - items:
> +          # normal RDMA conponent
> +          - const: mediatek,mt8183-mdp3-rdma0
> +
> +  mediatek,scp:
> +    description: The node of system control processor (SCP), using
> +      the remoteproc & rpmsg framework.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
> +
> +  mediatek,mdp3-comps:
> +    description: MTK sub-system of direct-link or DIP

This needs a better description. What is DIP? What is direct-link?

> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    items:
> +      - enum:
> +          # MDP direct-link input path selection, create a
> +          # component for path connectedness of HW pipe control
> +          - mediatek,mt8183-mdp3-dl1
> +      - enum:
> +          - mediatek,mt8183-mdp3-dl2
> +      - enum:
> +          # MDP direct-link output path selection, create a
> +          # component for path connectedness of HW pipe control
> +          - mediatek,mt8183-mdp3-path1
> +      - enum:
> +          - mediatek,mt8183-mdp3-path2
> +      - enum:
> +          # Input DMA of ISP PASS2 (DIP) module for raw image input
> +          - mediatek,mt8183-mdp3-imgi
> +      - enum:
> +          # Output DMA of ISP PASS2 (DIP) module for YUV image output
> +          - mediatek,mt8183-mdp3-exto

There's only 1 possible value for mediatek,mdp3-comps, so why does it 
need to be in DT? 

> +
> +  reg:
> +    items:
> +      - description: basic RDMA HW address
> +      - description: MDP direct-link 1st and 2nd input
> +      - description: MDP direct-link 1st output
> +      - description: MDP direct-link 2nd output
> +      - description: ISP input and output
> +
> +  mediatek,gce-client-reg:
> +    description: The register of client driver can be configured by gce with
> +      4 arguments defined in this property, such as phandle of gce, subsys id,
> +      register offset and size. Each GCE subsys id is mapping to a client
> +      defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - description: GCE client for RDMA
> +      - description: GCR client for MDP direct-link 1st and 2nd input
> +      - description: GCR client for MDP direct-link 1st output
> +      - description: GCR client for MDP direct-link 2nd output
> +      - description: GCR client for ISP input and output
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: RDMA clock
> +      - description: RSZ clock
> +      - description: direck-link TX clock in MDP side
> +      - description: direck-link RX clock in MDP side
> +      - description: direck-link TX clock in ISP side
> +      - description: direck-link RX clock in ISP side
> +
> +  iommus:
> +    maxItems: 1
> +
> +  mediatek,mmsys:
> +    description: The node of mux(multiplexer) controller for HW connections.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  mediatek,mm-mutex:

Is this some sort of h/w lock? We have a standard binding for that.

> +    description: The node of sof(start of frame) signal controller.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
> +
> +  mediatek,mailbox-gce:
> +    description: The node of global command engine (GCE), used to read/write
> +      registers with critical time limitation.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  mboxes:
> +    items:
> +      - description: used for 1st data pipe from RDMA
> +      - description: used for 2nd data pipe from RDMA
> +      - description: used for 3rd data pipe from Direct-Link
> +      - description: used for 4th data pipe from Direct-Link
> +
> +  gce-subsys:
> +    description: sub-system id corresponding to the global command engine (GCE)
> +      register address.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: mediatek,mt8183-mdp3
> +
> +then:
> +  required:
> +    - mediatek,scp
> +    - mediatek,mmsys
> +    - mediatek,mm-mutex
> +    - mediatek,mailbox-gce
> +    - mboxes
> +    - gce-subsys
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - mediatek,gce-client-reg
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
> +    mdp3_rdma0: mdp3_rdma0@14001000 {
> +      compatible = "mediatek,mt8183-mdp3",
> +                   "mediatek,mt8183-mdp3-rdma0";
> +      mediatek,scp = <&scp>;
> +      mediatek,mdp3-comps = "mediatek,mt8183-mdp3-dl1",
> +                            "mediatek,mt8183-mdp3-dl2",
> +                            "mediatek,mt8183-mdp3-path1",
> +                            "mediatek,mt8183-mdp3-path2",
> +                            "mediatek,mt8183-mdp3-imgi",
> +                            "mediatek,mt8183-mdp3-exto";
> +      reg = <0x14001000 0x1000>,
> +            <0x14000000 0x1000>,
> +            <0x14005000 0x1000>,
> +            <0x14006000 0x1000>,
> +            <0x15020000 0x1000>;
> +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>,
> +                                <&gce SUBSYS_1400XXXX 0 0x1000>,
> +                                <&gce SUBSYS_1400XXXX 0x5000 0x1000>,
> +                                <&gce SUBSYS_1400XXXX 0x6000 0x1000>,
> +                                <&gce SUBSYS_1502XXXX 0 0x1000>;
> +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +      clocks = <&mmsys CLK_MM_MDP_RDMA0>,
> +               <&mmsys CLK_MM_MDP_RSZ1>,
> +               <&mmsys CLK_MM_MDP_DL_TXCK>,
> +               <&mmsys CLK_MM_MDP_DL_RX>,
> +               <&mmsys CLK_MM_IPU_DL_TXCK>,
> +               <&mmsys CLK_MM_IPU_DL_RX>;
> +      iommus = <&iommu>;
> +      mediatek,mmsys = <&mmsys>;
> +      mediatek,mm-mutex = <&mutex>;
> +      mediatek,mailbox-gce = <&gce>;
> +      mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
> +               <&gce 21 CMDQ_THR_PRIO_LOWEST>,
> +               <&gce 22 CMDQ_THR_PRIO_LOWEST>,
> +               <&gce 23 CMDQ_THR_PRIO_LOWEST>;
> +      gce-subsys = <&gce 0x14000000 SUBSYS_1400XXXX>,
> +                   <&gce 0x14010000 SUBSYS_1401XXXX>,
> +                   <&gce 0x14020000 SUBSYS_1402XXXX>,
> +                   <&gce 0x15020000 SUBSYS_1502XXXX>;
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> new file mode 100644
> index 000000000000..cd4cf1531535
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> @@ -0,0 +1,55 @@
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
> +
> +description: |
> +  One of Media Data Path 3 (MDP3) components used to do frame resizing.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8183-mdp3-rsz0
> +          - mediatek,mt8183-mdp3-rsz1

Again, what's the difference between 0 and 1?

I've probably asked that before, but without a sufficient reasoning 
here in the schema I'm just going to keep asking the same question.

Rob
