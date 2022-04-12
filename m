Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC684FCF98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349011AbiDLGfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348935AbiDLGf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:35:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F9135857;
        Mon, 11 Apr 2022 23:33:06 -0700 (PDT)
X-UUID: 59ca3f62dd774853b46ce00bbf8b60e4-20220412
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:90f094df-27e4-4228-a006-e5dd11ed172f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:51
X-CID-INFO: VERSION:1.1.4,REQID:90f094df-27e4-4228-a006-e5dd11ed172f,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:51
X-CID-META: VersionHash:faefae9,CLOUDID:523bdba8-d103-4e36-82b9-b0e86991b3df,C
        OID:e37b7fabc8cf,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 59ca3f62dd774853b46ce00bbf8b60e4-20220412
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2129992685; Tue, 12 Apr 2022 14:33:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 12 Apr 2022 14:33:02 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Apr 2022 14:33:02 +0800
Message-ID: <d08e121848788fee9898e1898ee756b10c99fa08.camel@mediatek.com>
Subject: Re: [RESEND v17 3/7] soc: mediatek: add mtk-mmsys support for
 mt8195 vdosys0
From:   CK Hu <ck.hu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     David Airlie <airlied@linux.ie>, <singo.chang@mediatek.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        <postmaster@vger.kernel.org>,
        "Fabien Parent" <fparent@baylibre.com>,
        John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <roy-cw.yeh@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        <nancy.lin@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <hsinyi@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <moudy.ho@mediatek.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Date:   Tue, 12 Apr 2022 14:33:02 +0800
In-Reply-To: <a48df6bb-6be8-6cb9-51d0-9044e706e834@collabora.com>
References: <20220407030409.9664-1-jason-jh.lin@mediatek.com>
         <20220407030409.9664-4-jason-jh.lin@mediatek.com>
         <67b3e42d6a094108f724ed9b8c73f5cd6b2ce219.camel@mediatek.com>
         <d8711b8e4d233240eda73db54a625e88b9b3970b.camel@mediatek.com>
         <1f1692b6d14280fed40e53f464145ed70b67135f.camel@mediatek.com>
         <a48df6bb-6be8-6cb9-51d0-9044e706e834@collabora.com>
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

Hi, Angelo:

On Fri, 2022-04-08 at 10:49 +0200, AngeloGioacchino Del Regno wrote:
> Il 08/04/22 03:28, CK Hu ha scritto:
> > Hi, Jason:
> > 
> > On Thu, 2022-04-07 at 14:27 +0800, Jason-JH Lin wrote:
> > > Hi CK,
> > > 
> > > Thanks for the reviews.
> > > 
> > > On Thu, 2022-04-07 at 13:45 +0800, CK Hu wrote:
> > > > Hi, Jason:
> > > > 
> > > > On Thu, 2022-04-07 at 11:04 +0800, jason-jh.lin wrote:
> > > > > 1. Add mt8195 mmsys compatible for vdosys0.
> > > > > 2. Add mt8195 routing table settings and fix build fail.
> > > > > 3. Add clock name, clock driver name and routing table into
> > > > > the
> > > > > driver data
> > > > >     of mt8195 vdosys0.
> > > > > 4. Add get match data by clock name function and clock
> > > > > platform
> > > > > labels
> > > > >     to identify which mmsys node is corresponding to vdosys0.
> > > > > 
> > > > > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > > > > ---
> > > > >   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   2 +-
> > > > >   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   6 +-
> > > > >   drivers/soc/mediatek/mt8167-mmsys.h         |   2 +-
> > > > >   drivers/soc/mediatek/mt8183-mmsys.h         |   2 +-
> > > > >   drivers/soc/mediatek/mt8186-mmsys.h         |   4 +-
> > > > >   drivers/soc/mediatek/mt8192-mmsys.h         |   4 +-
> > > > >   drivers/soc/mediatek/mt8195-mmsys.h         | 370
> > > > > ++++++++++++++++++++
> > > > >   drivers/soc/mediatek/mt8365-mmsys.h         |   4 +-
> > > > >   drivers/soc/mediatek/mtk-mmsys.c            |  62 ++++
> > > > >   drivers/soc/mediatek/mtk-mmsys.h            |   1 +
> > > > >   drivers/soc/mediatek/mtk-mutex.c            |   8 +-
> > > > >   include/linux/soc/mediatek/mtk-mmsys.h      |  13 +-
> > > > >   12 files changed, 461 insertions(+), 17 deletions(-)
> > > > >   create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
> > > > > 
> > > > 
> > > > [snip]
> > > > 
> > > > > diff --git a/drivers/soc/mediatek/mtk-mmsys.c
> > > > > b/drivers/soc/mediatek/mtk-mmsys.c
> > > > > index 4fc4c2c9ea20..b2fa239c5f5f 100644
> > > > > --- a/drivers/soc/mediatek/mtk-mmsys.c
> > > > > +++ b/drivers/soc/mediatek/mtk-mmsys.c
> > > > > @@ -4,6 +4,8 @@
> > > > >    * Author: James Liao <jamesjj.liao@mediatek.com>
> > > > >    */
> > > > >   
> 
> ..snip..
> 
> > > 
> > > I think there might be another chip that needs to get driver data
> > > by
> > > clk_name .
> > > So I use "clk-mt8195" in clk_driver to identify the corresponding
> > > platform whose clk_name of mmsys is also "cfg_vod0".
> > 
> > We usually don't care the future because the future may not happen.
> > If
> 
> Hello CK,
> 
> I'm sorry, but I really have to disagree here.
> Sure, the future may not happen, but from what I can see, MediaTek's
> commitment
> on upstreaming their SoCs is continuative and they care about the
> future.
> 
> Let's also not forget that these drivers are not on a downstream
> tree, where
> you don't care about the past or the future, but on upstream, where
> you:
> - Definitely care about the past
> - Should care about the future, if you want to avoid commit noise and
>    making big changes to your drivers everytime, which would slow
> down
>    your upstreaming due to reviewers having to put 3x efforts on each
>    iteration.
> 
> And let's also not forget that this being upstream means that these
> drivers
> may (or may not) be extended even by passionate community developers,
> for
> which, having such mechanisms there for other SoCs that MediaTek
> didn't try
> to upstream yet can only be good - and when these are engineered with
> a
> certain flexibility, while keeping the codebase solid, that can only
> be good.
> 
> Besides, if I've misunderstood your "don't care the future"
> statement,
> pretend that I've never replied.

OK, let's break this patch into two patches. The first is to support
mt8195 only with clock name identification. The second patch is to
identify SoC. In this series, we just need the first patch, so move the
second patch to the series of another SoC with multiple mmsys device.
Maybe another SoC with multiple mmsys device has new property which
could be used to identify SoC, so we have no information about what is
the better implementation of second patch. I do really care the future,
but I have no information about the future. Please public any hidden
information so we could have better decision.

Regards,
CK

> 
> 
> > it's sure that would happen, I think clk_driver is not a good
> > choice.
> > For now, the clk_driver name is different for each SoC, but it
> > could be
> > the same for each SoC because only one clock driver would be
> > compiled.
> > I think "compatible" would be different for each SoC.
> > 
> 
> ...but I agree on that one (and I gave my own review and suggestions
> on
> how to improve that situation).
> 
> Regards,
> Angelo

