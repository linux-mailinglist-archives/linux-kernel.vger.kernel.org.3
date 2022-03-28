Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812874E98A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbiC1Ntq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiC1Nto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:49:44 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023564D9CC;
        Mon, 28 Mar 2022 06:48:04 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso10733953otj.0;
        Mon, 28 Mar 2022 06:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q+/z8pUUWBfLzzFWh3TN26NfhrvM6nyqxbuLLyu+aLM=;
        b=XcO5P1paW4ACcwCmIOlDpP94HZhIrb0biLIEp9PkoVOneEl/QcmCOJAkJkGn24mYYC
         94HxBxcvihvoWqie8Vm0C1gb6rQJRJPkb8kskyvKaiM58k/87ZuXaYx4beaAs8sfhYYl
         vr/EnEXS7DKuxxgQz7D2/OZyyBLyIcwz4xWeE6s1Qv9wU/4+pfUYVVvEH4+cu7YufMTY
         bv3nr+s1AlGcUazPpIqybe4yXwMv9vdsPmQd1DjCWX7eHbcHiSMIK5GainLTyoGWK1IP
         tYxXwUN592G+GeSNamPHuzfyutdbht8nn3pNXZsPETh4HCIJQ5yvluAD9dbfQdywWct/
         IGEg==
X-Gm-Message-State: AOAM531VihfSvo1CIp0/d10Z/C7957HgdB0nxuz3wgAx8En/hGbwJ22Q
        rWd7gQqHNVYjaKM0w6pc4BcXwYXM6g==
X-Google-Smtp-Source: ABdhPJzFImlqCXW1K8qUgADwrPbF+W8G33anvBPZNSZSnbvRxRupoA5RTvOjiP0UzvVLR7VCWkaWhg==
X-Received: by 2002:a9d:454c:0:b0:5b2:3757:9fc6 with SMTP id p12-20020a9d454c000000b005b237579fc6mr10004371oti.314.1648475283257;
        Mon, 28 Mar 2022 06:48:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u14-20020a4ad0ce000000b0032174de7c2csm6804223oor.8.2022.03.28.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:48:02 -0700 (PDT)
Received: (nullmailer pid 2248085 invoked by uid 1000);
        Mon, 28 Mar 2022 13:48:01 -0000
Date:   Mon, 28 Mar 2022 08:48:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        angelogioacchino.delregno@collabora.com,
        Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder
 cores dt-bindings for mt8195
Message-ID: <YkG8ka1xY2k+HWi1@robh.at.kernel.org>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
 <20220317082230.23622-4-irui.wang@mediatek.com>
 <Yj4s0zcHxz3U3wlc@robh.at.kernel.org>
 <ab2b24eeb51048227ad7b2ac659617a7da5b2e45.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2b24eeb51048227ad7b2ac659617a7da5b2e45.camel@mediatek.com>
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

On Sat, Mar 26, 2022 at 10:00:55AM +0800, Irui Wang wrote:
> Dear Rob,
> 
> Thanks for your review and comments.
> 
> On Fri, 2022-03-25 at 15:57 -0500, Rob Herring wrote:
> > On Thu, Mar 17, 2022 at 04:22:23PM +0800, Irui Wang wrote:
> > > Adds encoder cores dt-bindings for mt8195.
> > 
> > Why?
> mt8195 has two h264 encoder cores and we want to enable both of them.
> the original encoder bindings file is for single core which may can not
> handle it, so we new a core dt-bindings. We will think about it again
> about this dt-bindings.
> > 
> > > 
> > > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > > ---
> > >  .../media/mediatek,vcodec-encoder-core.yaml   | 181
> > > ++++++++++++++++++
> > >  .../media/mediatek,vcodec-encoder.yaml        |   1 -
> > >  2 files changed, 181 insertions(+), 1 deletion(-)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> > > core.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> > > core.yaml
> > > b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> > > core.yaml
> > > new file mode 100644
> > > index 000000000000..fcfb48900c76
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > > encoder-core.yaml
> > > @@ -0,0 +1,181 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +
> > > +%YAML 1.2
> > > +---
> > > +$id: "
> > > http://devicetree.org/schemas/media/mediatek,vcodec-encoder-core.yaml#
> > > "
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Mediatek Video Encoder Accelerator With Multi Core
> > > +
> > > +maintainers:
> > > +  - Irui Wang <irui.wang@mediatek.com>
> > > +
> > > +description: |
> > > +  Mediatek Video Encode is the video encode hardware present in
> > > Mediatek
> > > +  SoCs which supports high resolution encoding functionalities.
> > > Required
> > > +  parent and child device node.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - mediatek,mt8195-vcodec-enc
> > > +
> > > +  mediatek,scp:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: |
> > > +      The node of system control processor (SCP), using
> > > +      the remoteproc & rpmsg framework.
> > > +
> > > +  mediatek,venc-multi-core:
> > > +    type: boolean
> > > +    description: |
> > > +      Indicates whether the encoder has multiple cores or not.
> > 
> > Isn't this implied by how many child nodes you have?
> It implies that we have child nodes, distinguish with single core,  

Just check if you have a child node or not.


> > > +  iommus:
> > > +    minItems: 1
> > > +    maxItems: 32
> > 
> > You really have up to 32 IOMMUs?
> Currently, totally 27 IOMMUs and used 9 of them.
> > 
> > > +    description: |
> > > +      List of the hardware port in respective IOMMU block for
> > > current Socs.
> > > +      Refer to bindings/iommu/mediatek,iommu.yaml.
> > > +
> > > +  dma-ranges:
> > > +    maxItems: 1
> > > +    description: |
> > > +      Describes the physical address space of IOMMU maps to
> > > memory.
> > > +
> > > +  "#address-cells":
> > > +    const: 2
> > > +
> > > +  "#size-cells":
> > > +    const: 2
> > > +
> > > +  ranges: true
> > > +
> > > +# Required child node:
> > > +patternProperties:
> > > +  "^venc-core@[0-9a-f]+$":
> > > +    type: object
> > > +    description: |
> > > +      The video encoder core device node which should be added as
> > > subnodes to
> > > +      the main venc node.
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        items:
> > > +         - const: mediatek,mtk-venc-core
> > > +
> > > +      reg:
> > > +        maxItems: 1
> > > +
> > > +      mediatek,core-id:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description: |
> > > +          Current encoder core id.
> > 
> > What is this for and what does its value correspond to in the h/w.
> > We 
> > generally don't do made up indices in DT.
> It's for encoder core id, core@1a020000 must be core-0, core@1b020000
> must be core-1, we add this property in each child node, so we can 
> get core-id in drivers. If it can't ref "uint32" types yaml, would 
> you mind giving some more suggestions ?

I still don't understand why it is needed. What is 'core-0'?

Is there some functional difference between the cores? If so, describe 
that difference.

Rob
