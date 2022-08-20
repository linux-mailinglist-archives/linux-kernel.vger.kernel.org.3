Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D259AB63
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 06:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbiHTEds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 00:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiHTEdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 00:33:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E219C5C97D;
        Fri, 19 Aug 2022 21:33:38 -0700 (PDT)
X-UUID: 105e9bd2909b46798526f09b668b66e5-20220820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ECAyJs3Ash9rLQKi8udUycepkroxO08HjjjdDql2x/E=;
        b=Ea3cDgAcbgNhg3jCFX3FDABYUInUufnc0BJ3KECdtE9KObhBmj/2troEElUUNAcmPEmmNx/+z8QV9OaqjVUfrdZp9Gyu8LADNve4eB/vy/CAztGXehOTXmvmI+pjtfdygbxlhw5di1LMliB6gSbyJlRY1shMDpopky7qj6vrhEY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:f7b26673-523c-4ccd-bfdc-7f383ab7bd3b,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:130411cf-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 105e9bd2909b46798526f09b668b66e5-20220820
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 845400877; Sat, 20 Aug 2022 12:33:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 20 Aug 2022 12:33:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 20 Aug 2022 12:33:31 +0800
Message-ID: <8d551e1f51fe53b7c84afdf476de95b268205923.camel@mediatek.com>
Subject: Re: [PATCH v26 4/4] media: platform: mtk-mdp3: add MediaTek MDP3
 driver
From:   20181221122106 created <moudy.ho@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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
        <cellopoint.kai@gmail.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>
Date:   Sat, 20 Aug 2022 12:33:31 +0800
In-Reply-To: <46436973-0de0-f810-5851-6f26bdf460aa@xs4all.nl>
References: <20220819085423.17023-1-moudy.ho@mediatek.com>
         <20220819085423.17023-5-moudy.ho@mediatek.com>
         <46436973-0de0-f810-5851-6f26bdf460aa@xs4all.nl>
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

Hi Hans,


On Fri, 2022-08-19 at 17:37 +0200, Hans Verkuil wrote:
> Hi Moudy,
> 
> On 19/08/2022 10:54, Moudy Ho wrote:
> > This patch adds driver for MediaTek's Media Data Path ver.3 (MDP3).
> > It provides the following functions:
> >   color transform, format conversion, resize, crop, rotate, flip
> >   and additional image quality enhancement.
> > 
> > The MDP3 driver is mainly used for Google Chromebook products to
> > import the new architecture to set the HW settings as shown below:
> >   User -> V4L2 framework
> >     -> MDP3 driver -> SCP (setting calculations)
> >       -> MDP3 driver -> CMDQ (GCE driver) -> HW
> > 
> > Each modules' related operation control is sited in mtk-mdp3-comp.c
> > Each modules' register table is defined in file with "mdp_reg_"
> > prefix
> > GCE related API, operation control  sited in mtk-mdp3-cmdq.c
> > V4L2 m2m device functions are implemented in mtk-mdp3-m2m.c
> > Probe, power, suspend/resume, system level functions are defined in
> > mtk-mdp3-core.c
> > 
> > Signed-off-by: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> > Signed-off-by: daoyuan huang <daoyuan.huang@mediatek.com>
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > Tested-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/media/platform/mediatek/Kconfig       |    1 +
> >  drivers/media/platform/mediatek/Makefile      |    1 +
> >  drivers/media/platform/mediatek/mdp3/Kconfig  |   20 +
> >  drivers/media/platform/mediatek/mdp3/Makefile |    6 +
> >  .../platform/mediatek/mdp3/mdp_reg_ccorr.h    |   19 +
> >  .../platform/mediatek/mdp3/mdp_reg_rdma.h     |   65 ++
> >  .../platform/mediatek/mdp3/mdp_reg_rsz.h      |   39 +
> >  .../platform/mediatek/mdp3/mdp_reg_wdma.h     |   47 +
> >  .../platform/mediatek/mdp3/mdp_reg_wrot.h     |   55 +
> >  .../platform/mediatek/mdp3/mtk-img-ipi.h      |  290 +++++
> >  .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    |  466 ++++++++
> >  .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   43 +
> >  .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 1031
> > +++++++++++++++++
> >  .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  186 +++
> >  .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  357 ++++++
> >  .../platform/mediatek/mdp3/mtk-mdp3-core.h    |   94 ++
> >  .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  724 ++++++++++++
> >  .../platform/mediatek/mdp3/mtk-mdp3-m2m.h     |   48 +
> >  .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  733 ++++++++++++
> >  .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |  373 ++++++
> >  .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |  313 +++++
> >  .../platform/mediatek/mdp3/mtk-mdp3-vpu.h     |   78 ++
> >  22 files changed, 4989 insertions(+)
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/Kconfig
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/Makefile
> >  create mode 100644
> > drivers/media/platform/mediatek/mdp3/mdp_reg_ccorr.h
> >  create mode 100644
> > drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h
> >  create mode 100644
> > drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h
> >  create mode 100644
> > drivers/media/platform/mediatek/mdp3/mdp_reg_wdma.h
> >  create mode 100644
> > drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-img-
> > ipi.h
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > cmdq.c
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > cmdq.h
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > comp.c
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > comp.h
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > core.c
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > core.h
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > m2m.c
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > m2m.h
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > regs.c
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > regs.h
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > vpu.c
> >  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-
> > vpu.h
> > 
> > diff --git a/drivers/media/platform/mediatek/Kconfig
> > b/drivers/media/platform/mediatek/Kconfig
> > index af47d9888552..84104e2cd024 100644
> > --- a/drivers/media/platform/mediatek/Kconfig
> > +++ b/drivers/media/platform/mediatek/Kconfig
> > @@ -6,3 +6,4 @@ source
> > "drivers/media/platform/mediatek/jpeg/Kconfig"
> >  source "drivers/media/platform/mediatek/mdp/Kconfig"
> >  source "drivers/media/platform/mediatek/vcodec/Kconfig"
> >  source "drivers/media/platform/mediatek/vpu/Kconfig"
> > +source "drivers/media/platform/mediatek/mdp3/Kconfig"
> > diff --git a/drivers/media/platform/mediatek/Makefile
> > b/drivers/media/platform/mediatek/Makefile
> > index d3850a13f128..38e6ba917fe5 100644
> > --- a/drivers/media/platform/mediatek/Makefile
> > +++ b/drivers/media/platform/mediatek/Makefile
> > @@ -3,3 +3,4 @@ obj-y += jpeg/
> >  obj-y += mdp/
> >  obj-y += vcodec/
> >  obj-y += vpu/
> > +obj-y += mdp3/
> > diff --git a/drivers/media/platform/mediatek/mdp3/Kconfig
> > b/drivers/media/platform/mediatek/mdp3/Kconfig
> > new file mode 100644
> > index 000000000000..8c8e59687417
> > --- /dev/null
> > +++ b/drivers/media/platform/mediatek/mdp3/Kconfig
> > @@ -0,0 +1,20 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config VIDEO_MEDIATEK_MDP3
> > +	tristate "MediaTek MDP v3 driver"
> > +	depends on MTK_IOMMU || COMPILE_TEST
> > +	depends on VIDEO_DEV
> > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	depends on MTK_MMSYS || COMPILE_TEST
> 
> It turned out that this will cause link errors if MTK_MMSYS is not
> set:
> 
> ERROR: modpost: "mtk_mutex_write_sof"
> [drivers/media/platform/mediatek/mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_enable_by_cmdq"
> [drivers/media/platform/mediatek/mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_put"
> [drivers/media/platform/mediatek/mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_write_mod"
> [drivers/media/platform/mediatek/mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_unprepare"
> [drivers/media/platform/mediatek/mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_get"
> [drivers/media/platform/mediatek/mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_prepare"
> [drivers/media/platform/mediatek/mdp3/mtk-mdp3.ko] undefined!
> 
> I wonder if it isn't better to do 'select MTK_MMSYS': that seems to
> work fine.
> 
> What do you think?
> 
> Regards,
> 
> 	Hans
> 

Thank you for bringing this up for discussion, this was added on v10 at
Geert's suggestion.
But I didn't take into account all the conditions to avoid the issue
you mentioned, and replacing "depend on" with "select" would be a
better option to avoid compilation errors in various combinations.
Please allow me to release a new version that fixes this problem.

Thanks,
Moudy Ho

> > +	depends on HAS_DMA
> > +	select VIDEOBUF2_DMA_CONTIG
> > +	select V4L2_MEM2MEM_DEV
> > +	select VIDEO_MEDIATEK_VPU
> > +	select MTK_CMDQ
> > +	select MTK_SCP
> > +	default n
> > +	help
> > +	    It is a v4l2 driver and present in MediaTek MT8183 SoC.
> > +	    The driver supports scaling and color space conversion.
> > +
> > +	    To compile this driver as a module, choose M here: the
> > +	    module will be called mtk-mdp3.

