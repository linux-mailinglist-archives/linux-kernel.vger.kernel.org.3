Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8145780D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiGRLcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiGRLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:32:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251C81FCF7;
        Mon, 18 Jul 2022 04:32:42 -0700 (PDT)
X-UUID: 1245dade2e1a4e03be53d1d3bfe3c4e7-20220718
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:a56d88bc-9de3-4a0b-ad74-987de75fea68,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:56
X-CID-INFO: VERSION:1.1.8,REQID:a56d88bc-9de3-4a0b-ad74-987de75fea68,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:56
X-CID-META: VersionHash:0f94e32,CLOUDID:b4184833-b9e4-42b8-b28a-6364427c76bb,C
        OID:2313f3a8e098,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1245dade2e1a4e03be53d1d3bfe3c4e7-20220718
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 327461093; Mon, 18 Jul 2022 19:32:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 18 Jul 2022 19:32:35 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 18 Jul 2022 19:32:35 +0800
Message-ID: <bc6d59fcaa117b2058e2ce394a839e8ad3a51f93.camel@mediatek.com>
Subject: Re: [PATCH 2/5] dt-bindings: media: mediatek: vcodec: Add encoder
 dt-bindings for mt8188
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 18 Jul 2022 19:32:34 +0800
In-Reply-To: <9e1b51df-6d4e-5767-3111-dd1232ad22ad@collabora.com>
References: <20220716093808.29894-1-irui.wang@mediatek.com>
         <20220716093808.29894-3-irui.wang@mediatek.com>
         <9e1b51df-6d4e-5767-3111-dd1232ad22ad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 11:51 +0200, AngeloGioacchino Del Regno wrote:
> Il 16/07/22 11:38, Irui Wang ha scritto:
> > Add encoder dt-bindings for mt8188.
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >   .../devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml       | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > index d36fcca04cbc..66901118d346 100644
> > --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > @@ -22,6 +22,7 @@ properties:
> >         - mediatek,mt8183-vcodec-enc
> 
> Please keep alphabetical order.
> Add it here instead.
Fix it in next version.

Thanks
Best Regards
> 
> >         - mediatek,mt8192-vcodec-enc
> >         - mediatek,mt8195-vcodec-enc
> > +      - mediatek,mt8188-vcodec-enc
> >   
> >     reg:
> >       maxItems: 1

