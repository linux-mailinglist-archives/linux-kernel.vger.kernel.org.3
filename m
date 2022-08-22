Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B22559C27B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiHVPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbiHVPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:16:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C13F313;
        Mon, 22 Aug 2022 08:10:52 -0700 (PDT)
X-UUID: 7a3571c111bf40d382b76ada2f0410c0-20220822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2TI0JI+udncYDUlOYbvuhZ2qigLaWy/CUALMeyT9d+c=;
        b=qin+5hCLkSvv2ztL7ZWzELKosQcRdyE2mcBROfSOyIcQU6iYmsUW8EFm12DjpOifVrlriF0dsXw5FJFSDiv/z3JGrcgzQORb3pSRlpXqQ2rPVe8S3VIKyq4er9pfZ8ARHsXfYHv5SYMg52DNhnolm6Hb5zzafT/RcTfCtbX6vt0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:0deb0c2a-2d03-4b1b-91f5-38b96aba5807,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:559ef167-a9d9-4672-a3c8-12721739a220,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7a3571c111bf40d382b76ada2f0410c0-20220822
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1891288166; Mon, 22 Aug 2022 23:10:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 22 Aug 2022 23:10:43 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Aug 2022 23:10:43 +0800
Message-ID: <f723e962fdea4874078a920efba53ef45b4a3bbc.camel@mediatek.com>
Subject: Re: [PATCH v25 1/4] dt-binding: mediatek: add bindings for MediaTek
 MDP3 components
From:   moudy ho <moudy.ho@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <cellopoint.kai@gmail.com>
Date:   Mon, 22 Aug 2022 23:10:38 +0800
In-Reply-To: <2e71f901-98da-9a40-780c-5e95c251d78a@gmail.com>
References: <20220817095629.29911-1-moudy.ho@mediatek.com>
         <20220817095629.29911-2-moudy.ho@mediatek.com>
         <2e71f901-98da-9a40-780c-5e95c251d78a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Mon, 2022-08-22 at 16:31 +0200, Matthias Brugger wrote:
> 
> On 17/08/2022 11:56, Moudy Ho wrote:
> > This patch adds DT binding documents for Media Data Path 3 (MDP3)
> > a unit in multimedia system combined with several components and
> > used for scaling and color format convert.
> > 
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >   .../bindings/media/mediatek,mdp3-rdma.yaml    | 95
> > +++++++++++++++++++
> >   .../bindings/media/mediatek,mdp3-rsz.yaml     | 77
> > +++++++++++++++
> >   .../bindings/media/mediatek,mdp3-wrot.yaml    | 80
> > ++++++++++++++++
> >   3 files changed, 252 insertions(+)
> >   create mode 100644
> > Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> >   create mode 100644
> > Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> >   create mode 100644
> > Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > rdma.yaml
> > new file mode 100644
> > index 000000000000..94ff74d9c04a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > rdma.yaml
> > @@ -0,0 +1,95 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml*__;Iw!!CTRNKA9wMg0ARbw!yGA_w2I4HGhwI-nLMb62fFdTf--h1GdolE2RQhH3DW1AWh0WR0AX4klb8Q2Znasv$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!yGA_w2I4HGhwI-nLMb62fFdTf--h1GdolE2RQhH3DW1AWh0WR0AX4klb8RCccQrB$
> >  
> > +
> > +title: MediaTek Read Direct Memory Access
> > +
> > +maintainers:
> > +  - Matthias Brugger <matthias.bgg@gmail.com>
> > +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> 
> Ping-Hsun Wu isn't even CCed on this mail. Why aren't you the
> maintainer if you 
> submit the patch?
> 
> Regards,
> Matthias
> 

Thank you for your attention to this matter and apologies for the wrong
candidate. I'll relist the correct maintainers and release a new
version for it.


Regards,
Moudy

> > +
> > +description: |
> > +  MediaTek Read Direct Memory Access(RDMA) component used to do
> > read DMA.
> > +  It contains one line buffer to store the sufficient pixel data,
> > and
> > +  must be siblings to the central MMSYS_CONFIG node.
> > +  For a description of the MMSYS_CONFIG binding, see
> > +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.ya
> > ml
> > +  for details.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: mediatek,mt8183-mdp3-rdma
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  mediatek,gce-client-reg:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > +    items:
> > +      items:
> > +        - description: phandle of GCE
> > +        - description: GCE subsys id
> > +        - description: register offset
> > +        - description: register size
> > +    description: The register of client driver can be configured
> > by gce with
> > +      4 arguments defined in this property. Each GCE subsys id is
> > mapping to
> > +      a client defined in the header include/dt-
> > bindings/gce/<chip>-gce.h.
> > +
> > +  mediatek,gce-events:
> > +    description:
> > +      The event id which is mapping to the specific hardware event
> > signal
> > +      to gce. The event id is defined in the gce header
> > +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: RDMA clock
> > +      - description: RSZ clock
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  mboxes:
> > +    items:
> > +      - description: used for 1st data pipe from RDMA
> > +      - description: used for 2nd data pipe from RDMA
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - mediatek,gce-client-reg
> > +  - mediatek,gce-events
> > +  - power-domains
> > +  - clocks
> > +  - iommus
> > +  - mboxes
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8183-clk.h>
> > +    #include <dt-bindings/gce/mt8183-gce.h>
> > +    #include <dt-bindings/power/mt8183-power.h>
> > +    #include <dt-bindings/memory/mt8183-larb-port.h>
> > +
> > +    mdp3_rdma0: mdp3-rdma0@14001000 {
> > +      compatible = "mediatek,mt8183-mdp3-rdma";
> > +      reg = <0x14001000 0x1000>;
> > +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000
> > 0x1000>;
> > +      mediatek,gce-events = <CMDQ_EVENT_MDP_RDMA0_SOF>,
> > +                            <CMDQ_EVENT_MDP_RDMA0_EOF>;
> > +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> > +      clocks = <&mmsys CLK_MM_MDP_RDMA0>,
> > +               <&mmsys CLK_MM_MDP_RSZ1>;
> > +      iommus = <&iommu>;
> > +      mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST>,
> > +               <&gce 21 CMDQ_THR_PRIO_LOWEST>;
> > +    };
> > diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > rsz.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > rsz.yaml
> > new file mode 100644
> > index 000000000000..22c61ed00fdd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > rsz.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/media/mediatek,mdp3-rsz.yaml*__;Iw!!CTRNKA9wMg0ARbw!yGA_w2I4HGhwI-nLMb62fFdTf--h1GdolE2RQhH3DW1AWh0WR0AX4klb8XW2iViE$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!yGA_w2I4HGhwI-nLMb62fFdTf--h1GdolE2RQhH3DW1AWh0WR0AX4klb8RCccQrB$
> >  
> > +
> > +title: MediaTek Resizer
> > +
> > +maintainers:
> > +  - Matthias Brugger <matthias.bgg@gmail.com>
> > +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> > +
> > +description: |
> > +  One of Media Data Path 3 (MDP3) components used to do frame
> > resizing.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - mediatek,mt8183-mdp3-rsz
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  mediatek,gce-client-reg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      items:
> > +        - description: phandle of GCE
> > +        - description: GCE subsys id
> > +        - description: register offset
> > +        - description: register size
> > +    description: The register of client driver can be configured
> > by gce with
> > +      4 arguments defined in this property. Each GCE subsys id is
> > mapping to
> > +      a client defined in the header include/dt-
> > bindings/gce/<chip>-gce.h.
> > +
> > +  mediatek,gce-events:
> > +    description:
> > +      The event id which is mapping to the specific hardware event
> > signal
> > +      to gce. The event id is defined in the gce header
> > +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  clocks:
> > +    minItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - mediatek,gce-client-reg
> > +  - mediatek,gce-events
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8183-clk.h>
> > +    #include <dt-bindings/gce/mt8183-gce.h>
> > +
> > +    mdp3_rsz0: mdp3-rsz0@14003000 {
> > +      compatible = "mediatek,mt8183-mdp3-rsz";
> > +      reg = <0x14003000 0x1000>;
> > +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000
> > 0x1000>;
> > +      mediatek,gce-events = <CMDQ_EVENT_MDP_RSZ0_SOF>,
> > +                            <CMDQ_EVENT_MDP_RSZ0_EOF>;
> > +      clocks = <&mmsys CLK_MM_MDP_RSZ0>;
> > +    };
> > +
> > +    mdp3_rsz1: mdp3-rsz1@14004000 {
> > +      compatible = "mediatek,mt8183-mdp3-rsz";
> > +      reg = <0x14004000 0x1000>;
> > +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x4000
> > 0x1000>;
> > +      mediatek,gce-events = <CMDQ_EVENT_MDP_RSZ1_SOF>,
> > +                            <CMDQ_EVENT_MDP_RSZ1_EOF>;
> > +      clocks = <&mmsys CLK_MM_MDP_RSZ1>;
> > +    };
> > diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > wrot.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > wrot.yaml
> > new file mode 100644
> > index 000000000000..76c010720d43
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > wrot.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/media/mediatek,mdp3-wrot.yaml*__;Iw!!CTRNKA9wMg0ARbw!yGA_w2I4HGhwI-nLMb62fFdTf--h1GdolE2RQhH3DW1AWh0WR0AX4klb8Til05HT$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!yGA_w2I4HGhwI-nLMb62fFdTf--h1GdolE2RQhH3DW1AWh0WR0AX4klb8RCccQrB$
> >  
> > +
> > +title: MediaTek Write DMA with Rotation
> > +
> > +maintainers:
> > +  - Matthias Brugger <matthias.bgg@gmail.com>
> > +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> > +
> > +description: |
> > +  One of Media Data Path 3 (MDP3) components used to write DMA
> > with frame rotation.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - mediatek,mt8183-mdp3-wrot
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  mediatek,gce-client-reg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      items:
> > +        - description: phandle of GCE
> > +        - description: GCE subsys id
> > +        - description: register offset
> > +        - description: register size
> > +    description: The register of client driver can be configured
> > by gce with
> > +      4 arguments defined in this property. Each GCE subsys id is
> > mapping to
> > +      a client defined in the header include/dt-
> > bindings/gce/<chip>-gce.h.
> > +
> > +  mediatek,gce-events:
> > +    description:
> > +      The event id which is mapping to the specific hardware event
> > signal
> > +      to gce. The event id is defined in the gce header
> > +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - mediatek,gce-client-reg
> > +  - mediatek,gce-events
> > +  - power-domains
> > +  - clocks
> > +  - iommus
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8183-clk.h>
> > +    #include <dt-bindings/gce/mt8183-gce.h>
> > +    #include <dt-bindings/power/mt8183-power.h>
> > +    #include <dt-bindings/memory/mt8183-larb-port.h>
> > +
> > +    mdp3_wrot0: mdp3-wrot0@14005000 {
> > +      compatible = "mediatek,mt8183-mdp3-wrot";
> > +      reg = <0x14005000 0x1000>;
> > +      mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000
> > 0x1000>;
> > +      mediatek,gce-events = <CMDQ_EVENT_MDP_WROT0_SOF>,
> > +                            <CMDQ_EVENT_MDP_WROT0_EOF>;
> > +      power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> > +      clocks = <&mmsys CLK_MM_MDP_WROT0>;
> > +      iommus = <&iommu>;
> > +    };

