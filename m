Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D455402C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355680AbiFVBnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiFVBnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:43:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD9B1ADB9;
        Tue, 21 Jun 2022 18:42:55 -0700 (PDT)
X-UUID: 904bb9f843774432bbf8b5efd98b3e47-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:bfd57a8b-c40b-4042-b20b-bf8940967f12,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:bfd57a8b-c40b-4042-b20b-bf8940967f12,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:2377b02d-1756-4fa3-be7f-474a6e4be921,C
        OID:05c0f3f8a543,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 904bb9f843774432bbf8b5efd98b3e47-20220622
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 695938187; Wed, 22 Jun 2022 09:42:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 09:42:49 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 22 Jun 2022 09:42:47 +0800
Message-ID: <6ad2fd7b3fc961f7018e189e2f11219bf7216757.camel@mediatek.com>
Subject: Re: [PATCH v4, 0/3] add h264 decoder driver for mt8186
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Tomasz Figa" <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fritz Koenig" <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 22 Jun 2022 09:42:47 +0800
In-Reply-To: <5316234cef174e49110f949991ef71c578a3478e.camel@ndufresne.ca>
References: <20220512034620.30500-1-yunfei.dong@mediatek.com>
         <edbb4605c9e30329d2f5a4ff738571acb6b91f1f.camel@ndufresne.ca>
         <5316234cef174e49110f949991ef71c578a3478e.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks for your comments.
On Tue, 2022-06-14 at 13:46 -0400, Nicolas Dufresne wrote:
> Le lundi 13 juin 2022 à 16:10 -0400, Nicolas Dufresne a écrit :
> > Le jeudi 12 mai 2022 à 11:46 +0800, Yunfei Dong a écrit :
> > > Firstly, add mt8186 compatible and private data, then add
> > > document for
> > > compatible "mediatek,mt8186-vcodec-dec". For mt8186 is single
> > > core
> > > architecture, need to add new interface for h264 hardware
> > > decoder.
> > 
> > Would be nice to take the habit of sharing fluster score for this
> > new HW, I
> > would expect no less then what the numbers you'd get from running
> > over MT8195 or
> > 92, remains nice to demonstrate that this was tested and document
> > any oops along
> > the way.
> > > 
> > > Patche 1 add mt8186 compatible and private data.
> > > Patche 2 add mt8186 compatible document.
> > > Patche 3 add h264 single core driver.
> > > ---
> > > This patch depends on "support for MT8192 decoder"[1]
> > > 
> > > [1]  
> > > https://patchwork.kernel.org/project/linux-mediatek/cover/20220512021950.29087-1-yunfei.dong@mediatek.com/
> 
> I forgot earlier, but I suppose this will also depends on an scp.img
> firmware ?
> If so, any linux-firmware submission to link to ?
> 
Yes, need scp.img to test mt8186.
But not all patches are merged now, we are testing the driver, will
send scp.img in the middle of july.

Best Regards,
Yunfei Dong
> > > ---
> > > changed with v3:
> > > - fix __iomem not reasonable, align share memory to dram.
> > > changed with v2:
> > > - fix sparse and smatch check fail for patch 3
> > > changed with v1:
> > > - rebase driver to the latest media_stage.
> > > ---
> > > Yunfei Dong (3):
> > >   dt-bindings: media: mediatek: vcodec: Adds decoder dt-bindings
> > > for
> > >     mt8186
> > >   media: mediatek: vcodec: Support MT8186
> > >   media: mediatek: vcodec: add h264 decoder driver for mt8186
> > > 
> > >  .../media/mediatek,vcodec-subdev-decoder.yaml |   4 +-
> > >  .../platform/mediatek/vcodec/mtk_vcodec_dec.h |   1 +
> > >  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   4 +
> > >  .../vcodec/mtk_vcodec_dec_stateless.c         |  19 ++
> > >  .../vcodec/vdec/vdec_h264_req_multi_if.c      | 177
> > > +++++++++++++++++-
> > >  5 files changed, 203 insertions(+), 2 deletions(-)
> > > 
> 
> 

