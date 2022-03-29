Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8B4EA496
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiC2B2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiC2B2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:28:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A001D65FB;
        Mon, 28 Mar 2022 18:26:43 -0700 (PDT)
X-UUID: 4ca7773ddab04d6b921383b775c93caf-20220329
X-UUID: 4ca7773ddab04d6b921383b775c93caf-20220329
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 604441078; Tue, 29 Mar 2022 09:26:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 29 Mar 2022 09:26:38 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Mar 2022 09:26:37 +0800
Message-ID: <e41e909f85e3891edb6b66d7d5a810af103113c8.camel@mediatek.com>
Subject: Re: [PATCH v3, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder
 cores dt-bindings for mt8195
From:   Irui Wang <irui.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Maoguang Meng" <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 29 Mar 2022 09:26:37 +0800
In-Reply-To: <YkG8ka1xY2k+HWi1@robh.at.kernel.org>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
         <20220317082230.23622-4-irui.wang@mediatek.com>
         <Yj4s0zcHxz3U3wlc@robh.at.kernel.org>
         <ab2b24eeb51048227ad7b2ac659617a7da5b2e45.camel@mediatek.com>
         <YkG8ka1xY2k+HWi1@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob,

Many thanks for your attention.

On Mon, 2022-03-28 at 08:48 -0500, Rob Herring wrote:
> On Sat, Mar 26, 2022 at 10:00:55AM +0800, Irui Wang wrote:
> > Dear Rob,
> > 
> > Thanks for your review and comments.
> > 
> > On Fri, 2022-03-25 at 15:57 -0500, Rob Herring wrote:
> > > On Thu, Mar 17, 2022 at 04:22:23PM +0800, Irui Wang wrote:
> > > > Adds encoder cores dt-bindings for mt8195.
> > > 
> > > Why?
> > 
> > mt8195 has two h264 encoder cores and we want to enable both of
> > them.
> > the original encoder bindings file is for single core which may can
> > not
> > handle it, so we new a core dt-bindings. We will think about it
> > again
> > about this dt-bindings.
> > > 
> > > > 
> > > > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > > > ---
> > > >  .../media/mediatek,vcodec-encoder-core.yaml   | 181
> > > > ++++++++++++++++++
> > > >  .../media/mediatek,vcodec-encoder.yaml        |   1 -
> > > >  2 files changed, 181 insertions(+), 1 deletion(-)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/media/mediatek,vcodec-
> > > > encoder-
> > > > core.yaml
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > > > encoder-
> > > > core.yaml
> > > > b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > > > encoder-
> > > > core.yaml
> > > > new file mode 100644
> > > > index 000000000000..fcfb48900c76
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > > > encoder-core.yaml
> > > > @@ -0,0 +1,181 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: "
> > > > 
http://devicetree.org/schemas/media/mediatek,vcodec-encoder-core.yaml#
> > > > "
> > > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > > +
> > > > +title: Mediatek Video Encoder Accelerator With Multi Core
> > > > +
> > > > +maintainers:
> > > > +  - Irui Wang <irui.wang@mediatek.com>
> > > > +
> > > > +description: |
> > > > +  Mediatek Video Encode is the video encode hardware present
> > > > in
> > > > Mediatek
> > > > +  SoCs which supports high resolution encoding
> > > > functionalities.
> > > > Required
> > > > +  parent and child device node.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
> > > > +          - mediatek,mt8195-vcodec-enc
> > > > +
> > > > +  mediatek,scp:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description: |
> > > > +      The node of system control processor (SCP), using
> > > > +      the remoteproc & rpmsg framework.
> > > > +
> > > > +  mediatek,venc-multi-core:
> > > > +    type: boolean
> > > > +    description: |
> > > > +      Indicates whether the encoder has multiple cores or not.
> > > 
> > > Isn't this implied by how many child nodes you have?
> > 
> > It implies that we have child nodes, distinguish with single
> > core,  
> 
> Just check if you have a child node or not.
Yes.
> 
> 
> > > > +  iommus:
> > > > +    minItems: 1
> > > > +    maxItems: 32
> > > 
> > > You really have up to 32 IOMMUs?
> > 
> > Currently, totally 27 IOMMUs and used 9 of them.
> > > 
> > > > +    description: |
> > > > +      List of the hardware port in respective IOMMU block for
> > > > current Socs.
> > > > +      Refer to bindings/iommu/mediatek,iommu.yaml.
> > > > +
> > > > +  dma-ranges:
> > > > +    maxItems: 1
> > > > +    description: |
> > > > +      Describes the physical address space of IOMMU maps to
> > > > memory.
> > > > +
> > > > +  "#address-cells":
> > > > +    const: 2
> > > > +
> > > > +  "#size-cells":
> > > > +    const: 2
> > > > +
> > > > +  ranges: true
> > > > +
> > > > +# Required child node:
> > > > +patternProperties:
> > > > +  "^venc-core@[0-9a-f]+$":
> > > > +    type: object
> > > > +    description: |
> > > > +      The video encoder core device node which should be added
> > > > as
> > > > subnodes to
> > > > +      the main venc node.
> > > > +
> > > > +    properties:
> > > > +      compatible:
> > > > +        items:
> > > > +         - const: mediatek,mtk-venc-core
> > > > +
> > > > +      reg:
> > > > +        maxItems: 1
> > > > +
> > > > +      mediatek,core-id:
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        description: |
> > > > +          Current encoder core id.
> > > 
> > > What is this for and what does its value correspond to in the
> > > h/w.
> > > We 
> > > generally don't do made up indices in DT.
> > 
> > It's for encoder core id, core@1a020000 must be core-0, 
> > core@1b020000
> > must be core-1, we add this property in each child node, so we can 
> > get core-id in drivers. If it can't ref "uint32" types yaml, would 
> > you mind giving some more suggestions ?
> 
> I still don't understand why it is needed. What is 'core-0'?
> 
> Is there some functional difference between the cores? If so,
> describe 
> that difference.
> 
> Rob

They are two different pieces of hardware, it's our encoder hardware
design. There are two encoder hardware cores inside MT8195, named core0
and core1(we can rename it, but core id should be declared),
for core0, its module base address is 0x1A02_0000, uses IOMMU
"vdo0_iommu" and power domain "POWER_DOMAIN_VENC",
for core1, its module base address is 0x1B02_0000, uses IOMMU
"vpp_iommu" and power domain "POWER_DOMAIN_VENC_CORE1".
So the two encoder cores have their own base, IRQ, clock, power, etc.
Each core can encode independently, moreover, they can work together
for higher performance. 
We will describe more details in YAML about it if it's OK for you.

Thanks
Best Regards.

