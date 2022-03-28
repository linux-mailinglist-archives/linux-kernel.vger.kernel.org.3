Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA36F4E8D88
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 07:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiC1FmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 01:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiC1FmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 01:42:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D9C2E09F;
        Sun, 27 Mar 2022 22:40:25 -0700 (PDT)
X-UUID: 8c4a81a21ad64d209aa46e820eadc924-20220328
X-UUID: 8c4a81a21ad64d209aa46e820eadc924-20220328
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1464454364; Mon, 28 Mar 2022 13:39:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Mar 2022 13:39:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Mar 2022 13:39:55 +0800
Message-ID: <b9ed8c1511ea26c070dd3fb61f4370e5f858058c.camel@mediatek.com>
Subject: Re: [PATCH v16 4/8] soc: mediatek: add mtk-mmsys support for mt8195
 vdosys0
From:   CK Hu <ck.hu@mediatek.com>
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
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
Date:   Mon, 28 Mar 2022 13:39:55 +0800
In-Reply-To: <a068f2c9b2111f3a7a20da19073ef5fdb7f4a91f.camel@mediatek.com>
References: <20220307032859.3275-1-jason-jh.lin@mediatek.com>
         <20220307032859.3275-5-jason-jh.lin@mediatek.com>
         <a068f2c9b2111f3a7a20da19073ef5fdb7f4a91f.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

On Mon, 2022-03-28 at 13:03 +0800, Jason-JH Lin wrote:
> Hi CK,
> 
> Thanks for the reviews.
> 
> On Mon, 2022-03-07 at 11:28 +0800, jason-jh.lin wrote:
> > Add mt8195 vdosys0 clock driver name and routing table to
> > the driver data of mtk-mmsys.
> > 
> > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > Acked-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> > Impelmentation patch of vdosys1 can be refered to [1]
> > 
> > [1] soc: mediatek: add mtk-mmsys support for mt8195 vdosys1
> > ---
> >  drivers/soc/mediatek/mt8195-mmsys.h    | 130
> > +++++++++++++++++++++++++
> >  drivers/soc/mediatek/mtk-mmsys.c       |  11 +++
> >  include/linux/soc/mediatek/mtk-mmsys.h |   9 ++
> >  3 files changed, 150 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
> > 
> > diff --git a/drivers/soc/mediatek/mt8195-mmsys.h
> > b/drivers/soc/mediatek/mt8195-mmsys.h
> > new file mode 100644
> > index 000000000000..24a3afe23bc8
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mt8195-mmsys.h
> > @@ -0,0 +1,130 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __SOC_MEDIATEK_MT8195_MMSYS_H
> > +#define __SOC_MEDIATEK_MT8195_MMSYS_H
> > +
> > +#define MT8195_VDO0_OVL_MOUT_EN					
> > 0xf14
> > +#define MT8195_MOUT_DISP_OVL0_TO_DISP_RDMA0			
> > BIT(0)
> > +#define MT8195_MOUT_DISP_OVL0_TO_DISP_WDMA0			
> > BIT(1)
> >  
> > Useless, so remove.
> > 
> > +#define MT8195_MOUT_DISP_OVL0_TO_DISP_OVL1			BIT(2)
> > Ditto.Useless, so remove.
> > Regards,
> > CK
> 
> Although these definitions are not used, they represent the
> functionality provided by this register.
> 
> I think we can show that we have these capabilities by defining them.
> 
> Can we keep these definitions?

It's better that we know how to use it. Even though the symbol name
show some information, but I would like to add it to
mmsys_mt8195_routing_table[].

Regards,
CK

> 
> Regards,
> Jason-JH.Lin
> 
> > +#define MT8195_MOUT_DISP_OVL1_TO_DISP_RDMA1			
> > BIT(4)
> > +#define MT8195_MOUT_DISP_OVL1_TO_DISP_WDMA1			
> > BIT(5)
> > +#define MT8195_MOUT_DISP_OVL1_TO_DISP_OVL0			BIT(6)
> 
> 
> [snip]
> 

