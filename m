Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24447519E82
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349084AbiEDLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiEDLxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:53:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC965F91;
        Wed,  4 May 2022 04:49:28 -0700 (PDT)
X-UUID: 03b2502f90ec4a62b4abbce6beff4ddd-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7f5c9cfb-e572-4057-9e20-2dd2e1d5b1f6,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:fac48ab2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 03b2502f90ec4a62b4abbce6beff4ddd-20220504
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 325725063; Wed, 04 May 2022 19:49:22 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 19:49:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 May 2022 19:49:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 4 May 2022 19:49:21 +0800
Message-ID: <7189b0c0c62fe8a8026d2e25e741a29b2f5b01a9.camel@mediatek.com>
Subject: Re: [PATCH v14 1/3] dt-binding: mediatek: add bindings for MediaTek
 MDP3 components
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>, Moudy Ho <moudy.ho@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 4 May 2022 19:49:21 +0800
In-Reply-To: <YnFqnEI16B+xrxdQ@robh.at.kernel.org>
References: <20220427070514.10355-1-moudy.ho@mediatek.com>
         <20220427070514.10355-2-moudy.ho@mediatek.com>
         <YnFqnEI16B+xrxdQ@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 12:47 -0500, Rob Herring wrote:
> On Wed, Apr 27, 2022 at 03:05:12PM +0800, Moudy Ho wrote:
> > This patch adds DT binding documents for Media Data Path 3 (MDP3)
> > a unit in multimedia system combined with several components and
> > used for scaling and color format convert.
> > 
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > ---
> >  .../bindings/media/mediatek,mdp3-rdma.yaml    | 82
> > +++++++++++++++++++
> >  .../bindings/media/mediatek,mdp3-rsz.yaml     | 61 ++++++++++++++
> >  .../bindings/media/mediatek,mdp3-wrot.yaml    | 66 +++++++++++++++
> >  .../bindings/soc/mediatek/mediatek,ccorr.yaml | 54 ++++++++++++
> >  .../bindings/soc/mediatek/mediatek,wdma.yaml  | 67 +++++++++++++++
> >  5 files changed, 330 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > rdma.yaml
> > new file mode 100644
> > index 000000000000..ce24eda14cb6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-
> > rdma.yaml
> > @@ -0,0 +1,82 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml*__;Iw!!CTRNKA9wMg0ARbw!zzzJB6GFgAbOaMvOMeEANc2UnatoXvcdzZ3UGx6024oxx1okemuH9vCeCSpaGUuD8dSrlYueRf2HFVdfFu6CVB7LUQ$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!zzzJB6GFgAbOaMvOMeEANc2UnatoXvcdzZ3UGx6024oxx1okemuH9vCeCSpaGUuD8dSrlYueRf2HFVdfFu5BwY-loQ$
> >  
> > +
> > +title: Mediatek Read Direct Memory Access
> > +
> > +maintainers:
> > +  - Matthias Brugger <matthias.bgg@gmail.com>
> > +  - Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> > +
> > +description: |
> > +  Mediatek Read Direct Memory Access(RDMA) component used to do
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
> > +    maxItems: 1
> 
> Like your other patches this needs 'items' describing each cell.
> 
> > +    description: |
> > +      The register of client driver can be configured by gce with
> > +      4 arguments defined in this property, such as phandle of
> > gce, subsys id,
> > +      register offset and size. Each GCE subsys id is mapping to a
> > client
> > +      defined in the header include/dt-bindings/gce/<chip>-gce.h.
> 
> Other than other cases of this property, the rest looks fine.
> 
> Rob

Hello Rob,

Thanks for your review and reminder.

Moudy's mail is still not received by devicetree@vger.kernel.org.
We are still under checking this issue.
To prevent you do not receive his response, I help Moudy to mail you
again.

Moudy will sync the description from the patch listed below to this
property and extend to other yaml files in this series.


https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220427064425.30383-5-moudy.ho@mediatek.com/

BRs,
Rex

