Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA784EE33D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbiCaVVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiCaVV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:21:29 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C4415280C;
        Thu, 31 Mar 2022 14:19:41 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so749557otq.13;
        Thu, 31 Mar 2022 14:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fm9j31QnqpewsYtYm5Zm4wpxz1kydRGT8NHr0rzkZyA=;
        b=MbggHcuyUeMNmANmZY2JmfujBIz9ndaZ0Q8BtKy3NMtiCR+PJVQtZ+G5xDL0j/Px8H
         63KCvz2+cdFHgGJ72zxvT7hXq7IZCiiOKhJkNaAMesMStGhzprdDg+Qxr7ND7tZoPsJH
         pgyXQaUkbOa9O1hawYObxaLliZPrsmNq7GOe0t2VLG4P/wxR4fNgItkRDcJp+LfjdY7e
         reYb9Y8TJ28OcltDeX8feyqY3DsMz1rfRka9WM6eXiyhOSnXnSqQF6bk/kXojuNjN0V7
         B+3gzjDFGc9RFHI/iFbpaVo3h7wM0ITTMoNVWA6gCaiDgUeUD5UMRwlFwcPemU+h1Mb5
         e6Gw==
X-Gm-Message-State: AOAM532kHVAF0CEAudrLRBjfPAXR7/Zx3P3aeHlq6bR4eZkfoWd/+L++
        hE1Cw2IoHjG2isdHXMLlxg==
X-Google-Smtp-Source: ABdhPJw397a5OlH1Ki1AhiF2YtXSsu6dIfoUVKBLabv0jHczHCK4LuX47bWk2u/CovcpFMxoDFhDMg==
X-Received: by 2002:a9d:69:0:b0:5c9:3456:f02f with SMTP id 96-20020a9d0069000000b005c93456f02fmr6544088ota.25.1648761580467;
        Thu, 31 Mar 2022 14:19:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h83-20020aca3a56000000b002ece47dce52sm248016oia.26.2022.03.31.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:19:40 -0700 (PDT)
Received: (nullmailer pid 1517924 invoked by uid 1000);
        Thu, 31 Mar 2022 21:19:38 -0000
Date:   Thu, 31 Mar 2022 16:19:38 -0500
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
        river.cheng@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v12 1/3] dt-binding: mt8183: add Mediatek MDP3 dt-bindings
Message-ID: <YkYa6vyucOrwPNcX@robh.at.kernel.org>
References: <20220317145605.25782-1-moudy.ho@mediatek.com>
 <20220317145605.25782-2-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317145605.25782-2-moudy.ho@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 10:56:03PM +0800, Moudy Ho wrote:
> This patch adds DT binding documents for Media Data Path 3 (MDP3)
> a unit in multimedia system combined with several components and
> used for scaling and color format convert.
> 
> It can create multiple paths with different functions by assigning
> different components, a simple diagram is as follows:
> 
>   +------------+          +------------+
>   |    RDMA    |          |   ISP[*1]  |
>   +---+--+--+--+          +-----+--+---+
>       A  B  C                   2  1
>       v  v  v                   v  v
>       |  |  |                   |  |
>       |  |  +---------+         |  |
>       |  |            |         |  |
>       |  +-------+    |         |  |
>       |          |    |         |  |
>       |  +-------+----+---------+  |
>       |  |       |    |            |
>       |  |       |    +---------+  |
>       v  v       |              |  |
>       A  2       |              |  |
>     ********     |              |  |
>   **        **   |              |  |
>  *   PQ[*2]   *  |              |  |
>   **        **   |              |  |
>     ********     |              |  |
>       |  |       |              |  |
>       v  v       |              v  v
>       A  2       |              C  1
>   +---+--+---+   |        +-----+--+--+
>   |    RSZ   |   |        |    RSZ    |
>   +---+------+   |        +-----+--+--+
>       D          |              3  4
>       v          |              v  v
>       |          |              |  |
>       |  +-------+              |  |
>       |  |                      |  |
>       |  |  +-------------------+  |
>       |  |  |                      |
>       v  v  v                      v
>       D  B  3                      4
>   +---+--+--+--+         +---------+--+
>   |    WROT    |         |    WDMA    |
>   +------------+         +------------+

Sure seems like you should be using the OF graph binding to describe 
these connections unless all the sub-blocks and their connections are 
fixed across different SoCs.

> 
> [*1] Direct-link path for camera input
> [*2] A series of picture quality adjustment
>      engines, composed of AAL, CCORR, TDSHP
>      and COLOR
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 214 ++++++++++++++++++
>  .../bindings/media/mediatek,mdp3-rsz.yaml     |  54 +++++
>  .../bindings/media/mediatek,mdp3-wrot.yaml    |  57 +++++
>  .../bindings/soc/mediatek/mediatek,ccorr.yaml |  47 ++++
>  .../bindings/soc/mediatek/mediatek,wdma.yaml  |  58 +++++
>  5 files changed, 430 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> new file mode 100644
> index 000000000000..3bf59c3f521f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -0,0 +1,214 @@
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
> +          - const: mediatek,mt8183-mdp3-rdma

This does not make sense as a compatible entry. The first string should 
be more specific than the 2nd string. The controller node is a different 
instance of the RDMA block or some s/w designation? Looks like the 
latter to me...


> +      - items:
> +          # normal RDMA conponent
> +          - const: mediatek,mt8183-mdp3-rdma
> +
> +  mediatek,scp:
> +    description: |
> +      The node of system control processor (SCP), using
> +      the remoteproc & rpmsg framework.
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    maxItems: 1
> +
> +  mediatek,mdp3-comps:
> +    description: |
> +      MDP subsystem which has direct-link from Image Signal Processor(ISP).
> +      When using the camera, the DMA of ISP PASS (DIP) module will directly
> +      trigger MDP3 without other control (such as V4L2 M2M) to create
> +      corresponding HW path.
> +      The MDP3 controller must set up a series of registers at the beginning of
> +      path creation which covering MMSYS, IMGSYS, and MDP3's components,
> +      so that data flow can pass through MDP3.
> +      The entire path is briefly described as follows
> +      ISP --+
> +            |
> +            +-> DIP --+
> +      ................|..............................................
> +      (MDP3)          +->IMGI -+-> DL1 ->  RSZ -+-> PATH1 -> WROT
> +                               |            ^   |
> +                               |            |   |
> +                               +-> DL2 -----+   +-> PATH2 -> WDMA
> +                               |
> +                               +---------------------------> EXTO
> +    $ref: '/schemas/types.yaml#/definitions/string-array'
> +    items:
> +      enum:
> +        # MDP direct-link input path selection, create a
> +        # component for path connectedness of HW pipe control
> +        - mediatek,mt8183-mdp3-dl1
> +        - mediatek,mt8183-mdp3-dl2
> +        # MDP direct-link output path selection, create a
> +        # component for path connectedness of HW pipe control
> +        - mediatek,mt8183-mdp3-path1
> +        - mediatek,mt8183-mdp3-path2
> +        # Input DMA of ISP PASS2 (DIP) module for raw image input
> +        - mediatek,mt8183-mdp3-imgi
> +        # Output DMA of ISP PASS2 (DIP) module for YUV image output
> +        - mediatek,mt8183-mdp3-exto
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
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    minItems: 1
> +    items:
> +      - description: GCE client for RDMA
> +      - description: GCE client for dl1 and dl2
> +      - description: GCE client for path1
> +      - description: GCE client for path2
> +      - description: GCE client for imgi and exto
> +    description: |
> +      The register of client driver can be configured by gce with
> +      4 arguments defined in this property, such as phandle of gce, subsys id,
> +      register offset and size. Each GCE subsys id is mapping to a client
> +      defined in the header include/dt-bindings/gce/<chip>-gce.h.
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
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +
> +  mediatek,mm-mutex:
> +    description: |
> +      Mediatek mutex, namely MUTEX, is used to send the triggers signals called
> +      Start Of Frame(SOF) / End Of Frame(EOF) to each sub-modules on the data path.
> +      In some SoC, such as mt2701, MUTEX could be a hardware mutex which protects
> +      the shadow register.
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +
> +  mediatek,mailbox-gce:
> +    description: |
> +      The node of global command engine (GCE), used to read/write
> +      registers with critical time limitation.
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +
> +  mboxes:
> +    items:
> +      - description: used for 1st data pipe from RDMA
> +      - description: used for 2nd data pipe from RDMA
> +      - description: used for 3rd data pipe from Direct-Link
> +      - description: used for 4th data pipe from Direct-Link
> +
> +  gce-subsys:

Vendor prefix needed.

> +    description: |
> +      sub-system id corresponding to the global command engine (GCE)
> +      register address.
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
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

Note that if there's only 1 instance of these blocks, you can just find 
them by compatible and don't need a property.

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
> +                   "mediatek,mt8183-mdp3-rdma";
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
