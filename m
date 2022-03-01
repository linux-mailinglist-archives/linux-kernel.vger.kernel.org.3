Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885864C8071
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiCABrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiCABrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:47:40 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B51184
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:46:58 -0800 (PST)
X-UUID: 6f33e31bd00749f998d87b09d184cfc6-20220301
X-UUID: 6f33e31bd00749f998d87b09d184cfc6-20220301
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1245295757; Tue, 01 Mar 2022 09:46:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 1 Mar 2022 09:46:42 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 09:46:42 +0800
Message-ID: <fa9a04263ed0b1aa54a140e7eec47e838d3e5587.camel@mediatek.com>
Subject: Re: [PATCH v4 2/2] drm/mediatek: add devlink to cmdq dev
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <tzungbi@google.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fei Shao" <fshao@chromium.org>,
        Nancy Lin <nancy.lin@mediatek.com>, <singo.chang@mediatek.com>
Date:   Tue, 1 Mar 2022 09:46:42 +0800
In-Reply-To: <CAAOTY__rnVMRB=OhkTm4Ojh31yAcYwCQTBGozpGsnC_oC_jqvQ@mail.gmail.com>
References: <20211202064039.20797-1-jason-jh.lin@mediatek.com>
         <20211202064039.20797-3-jason-jh.lin@mediatek.com>
         <CAAOTY__rnVMRB=OhkTm4Ojh31yAcYwCQTBGozpGsnC_oC_jqvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Thanks for the reviews.

I forgot to add the comment that the patch should be based on [1].
We can only apply it after applying [1].

So please apply it after that. Thank you very much!

Regards,
Jason-JH.Lin
---
[1] drm/mediatek: modify mediatek-drm for mt8195 multi mmsys support

https://patchwork.kernel.org/project/linux-mediatek/patch/20220222100741.30138-21-nancy.lin@mediatek.com/
---

On Sun, 2022-02-27 at 11:33 +0800, Chun-Kuang Hu wrote:
> Hi, Jason:
> 
> Build error:
> 
> ../drivers/gpu/drm/mediatek/mtk_drm_crtc.c: In function
> ‘mtk_drm_crtc_create’:
> ../drivers/gpu/drm/mediatek/mtk_drm_crtc.c:902:26: error: ‘struct
> mtk_drm_private’ has no member named ‘dev’
>   mtk_crtc->drm_dev = priv->dev;
>                           ^
> ../drivers/gpu/drm/mediatek/mtk_drm_crtc.c:974:30: error: ‘struct
> mtk_drm_private’ has no member named ‘dev’
>    link = device_link_add(priv->dev, mtk_crtc->cmdq_client.chan-
> >mbox->dev,
>                               ^
> In file included from ../include/linux/device.h:15:0,
>                  from ../include/linux/dma-mapping.h:7,
>                  from ../drivers/gpu/drm/mediatek/mtk_drm_crtc.c:7:
> ../drivers/gpu/drm/mediatek/mtk_drm_crtc.c:977:16: error: ‘struct
> mtk_drm_private’ has no member named ‘dev’
>     dev_err(priv->dev, "Unable to link dev=%s\n",
>                 ^
> Regards,
> Chun-Kuang.


