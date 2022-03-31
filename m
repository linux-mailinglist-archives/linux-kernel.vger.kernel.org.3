Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DFE4EDDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiCaPqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbiCaPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:45:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DBD1E5232;
        Thu, 31 Mar 2022 08:40:33 -0700 (PDT)
X-UUID: ab6246be6d714f2d8d6c7ef929e3e8a3-20220331
X-UUID: ab6246be6d714f2d8d6c7ef929e3e8a3-20220331
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1623740777; Thu, 31 Mar 2022 23:40:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 31 Mar 2022 23:40:02 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 31 Mar 2022 23:40:02 +0800
Message-ID: <56ca6920f036b74b28c5858d8b28c3f3046c4758.camel@mediatek.com>
Subject: Re: [PATCH v16 4/8] soc: mediatek: add mtk-mmsys support for mt8195
 vdosys0
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, "Rob Herring" <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <hsinyi@chromium.org>, <fshao@chromium.org>,
        <moudy.ho@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 31 Mar 2022 23:40:02 +0800
In-Reply-To: <01e57ed9-222c-5b74-fe2b-4d22fe802c98@gmail.com>
References: <20220307032859.3275-1-jason-jh.lin@mediatek.com>
         <20220307032859.3275-5-jason-jh.lin@mediatek.com>
         <a068f2c9b2111f3a7a20da19073ef5fdb7f4a91f.camel@mediatek.com>
         <b9ed8c1511ea26c070dd3fb61f4370e5f858058c.camel@mediatek.com>
         <97bc1358813a2449d6e62653eb7af9906dfb190e.camel@mediatek.com>
         <01e57ed9-222c-5b74-fe2b-4d22fe802c98@gmail.com>
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

Hi Matthias,

 * Thanks for the reviews.

On Thu, 2022-03-31 at 13:01 +0200, Matthias Brugger wrote:
> 
> On 30/03/2022 12:04, Jason-JH Lin wrote:
> > Hi CK,
> > 
> > Thanks for the review.
> > 
> > On Mon, 2022-03-28 at 13:39 +0800, CK Hu wrote:
> > > Hi, Jason:
> > > 
> > > On Mon, 2022-03-28 at 13:03 +0800, Jason-JH Lin wrote:
> > > > Hi CK,
> > > > 
> > > > Thanks for the reviews.
> > > > 
> > > > On Mon, 2022-03-07 at 11:28 +0800, jason-jh.lin wrote:
> > > > > Add mt8195 vdosys0 clock driver name and routing table to
> > > > > the driver data of mtk-mmsys.
> > > > > 
> > > > > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > > > > Acked-by: AngeloGioacchino Del Regno <
> > > > > angelogioacchino.delregno@collabora.com>
> > > > > ---
> > > > > Impelmentation patch of vdosys1 can be refered to [1]
> > > > > 
> > > > > [1] soc: mediatek: add mtk-mmsys support for mt8195 vdosys1
> > > > > ---
> > > > >   drivers/soc/mediatek/mt8195-mmsys.h    | 130
> > > > > +++++++++++++++++++++++++
> > > > >   drivers/soc/mediatek/mtk-mmsys.c       |  11 +++
> > > > >   include/linux/soc/mediatek/mtk-mmsys.h |   9 ++
> > > > >   3 files changed, 150 insertions(+)
> > > > >   create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
> > > > > 
> > > > > diff --git a/drivers/soc/mediatek/mt8195-mmsys.h
> > > > > b/drivers/soc/mediatek/mt8195-mmsys.h
> > > > > new file mode 100644
> > > > > index 000000000000..24a3afe23bc8
> > > > > --- /dev/null
> > > > > +++ b/drivers/soc/mediatek/mt8195-mmsys.h
> > > > > @@ -0,0 +1,130 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > > +
> > > > > +#ifndef __SOC_MEDIATEK_MT8195_MMSYS_H
> > > > > +#define __SOC_MEDIATEK_MT8195_MMSYS_H
> > > > > +
> > > > > +#define MT8195_VDO0_OVL_MOUT_EN				
> > > > > 	
> > > > > 0xf14
> > > > > +#define MT8195_MOUT_DISP_OVL0_TO_DISP_RDMA0			
> > > > > BIT(0)
> > > > > +#define MT8195_MOUT_DISP_OVL0_TO_DISP_WDMA0			
> > > > > BIT(1)
> > > > >   
> > > > > Useless, so remove.
> > > > > 
> > > > > +#define MT8195_MOUT_DISP_OVL0_TO_DISP_OVL1			
> > > > > BIT(2)
> > > > > Ditto.Useless, so remove.
> > > > > Regards,
> > > > > CK
> > > > 
> > > > Although these definitions are not used, they represent the
> > > > functionality provided by this register.
> > > > 
> > > > I think we can show that we have these capabilities by defining
> > > > them.
> > > > 
> > > > Can we keep these definitions?
> > > 
> > > It's better that we know how to use it. Even though the symbol
> > > name
> > > show some information, but I would like to add it to
> > > mmsys_mt8195_routing_table[].
> > > 
> > > Regards,
> > > CK
> > > 
> > 
> > OK, I think I just remove the useless define.
> 
> Actually I would prefer to add it to the routing table to describe
> all the 
> capabilities of the HW.
> 
> Is there any technical problem with that?
> 
> Regards,
> Matthias
> 
OK, I'll add keep these definitions and add them to the routing table.

Regards,
Jason-JH.Lin

> > Thanks.
> > 
> > Regards,
> > Jason-JH.Lin
> > > > 
> > > > Regards,
> > > > Jason-JH.Lin
> > > > 
> > > > > +#define MT8195_MOUT_DISP_OVL1_TO_DISP_RDMA1			
> > > > > BIT(4)
> > > > > +#define MT8195_MOUT_DISP_OVL1_TO_DISP_WDMA1			
> > > > > BIT(5)
> > > > > +#define MT8195_MOUT_DISP_OVL1_TO_DISP_OVL0			
> > > > > BIT(6)
> > > > 
> > > > 
> > > > [snip]
> > > > 
> > > 
> > > 
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

