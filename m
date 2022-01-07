Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E977A48718C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbiAGD6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiAGD6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:58:02 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A02C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 19:58:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u13so10920871lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 19:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKNMJyJbEEL5q9peHIeW1VWZHuVFJtpU7pIceN/pwjU=;
        b=Ct5qh0NnIjgjBBI8xvXdVNKrKFDmuJqDQ6lk+nREa2ajHPDsDrFmIqTCK/ih45n/+i
         MxVvKQX4wxPd/KqFTbXeaMVUspFFe2zOFPIHwD8+X/hDyeWjkxKrw/miIwgpNC8CyAQY
         dWpmeQvSJ9tTMcsSrDml7yTQw1BbaBypeNN3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKNMJyJbEEL5q9peHIeW1VWZHuVFJtpU7pIceN/pwjU=;
        b=5mZoBeCCW2he84XMjopfIqrSSYMtwqwfLLH6A7FKPwnuQoyclYgksdIpqYC/GMysbO
         jKuuWPLOyuIe/3YwQy3ESoH754nhBt6FbajKhOlglJ+u6qEvOBMCXVt3k8DKhVViPDEL
         ff8my0k4YKCsXZx4NnDCsYdBl4Mbt9KGp32nEn9QY4lMPQo1XPrcfBBZgVpRsu1qOPDi
         YmJud45sXGRKVSMe99LYBvAW6go1AsL1OqI7BMyWpFkVC5biH43ttMdnSTjl4TMLmS1I
         FER2Daf4iWwHlflY1evPiwqoXoGNnPz2hhRqkwslG+VNdi+khzeAtGeoX9DmlrFdk9aQ
         fq0w==
X-Gm-Message-State: AOAM530iRv9yqzyvnnMgNXA8UTj1p1BKdOXM/CIUMEt2OYH531TKVvRC
        zJcSIWggg2O1LQBrHPjoTyYJXERHUsUl/jObeJy0yA==
X-Google-Smtp-Source: ABdhPJwB2LOLwXDSwFYbn94VKmzms3kaczzZBBcQQ0Iamv202Lew+ehb6NgWIJQfYAZCzjaWayYDS1PcdtAvATpbHog=
X-Received: by 2002:a2e:b8cd:: with SMTP id s13mr43356738ljp.201.1641527880239;
 Thu, 06 Jan 2022 19:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20220103145324.48008-1-angelogioacchino.delregno@collabora.com>
 <20220103145324.48008-2-angelogioacchino.delregno@collabora.com> <509b82079256ffaa0d844ae5a79a436fced16f3f.camel@mediatek.com>
In-Reply-To: <509b82079256ffaa0d844ae5a79a436fced16f3f.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 7 Jan 2022 11:57:49 +0800
Message-ID: <CAGXv+5EmnGFDnZE01mFfC=WHReOLdbuqCpAmwJNMvm6N93wRew@mail.gmail.com>
Subject: Re: [PATCH 2/3] phy: mediatek: phy-mtk-mipi-dsi: Reorder and stop
 implicit header inclusion
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, kishon@ti.com, vkoul@kernel.org,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:48 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Mon, 2022-01-03 at 15:53 +0100, AngeloGioacchino Del Regno wrote:
> > All the headers for phy-mtk-mipi-{dsi,dsi-mt8173,dsi-mt8183}.c were
> > included from phy-mtk-mipi-dsi.h, but this isn't optimal: in order to
> > increase readability and sensibly reduce build times, the inclusions
> > should be done per-file, also avoiding to include unused headers and
> > should not be implicit.
> >
> > For this reason, move the inclusions to each file and remove unused
> > ones.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c |  4 ++++
> >  drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c |  4 ++++
> >  drivers/phy/mediatek/phy-mtk-mipi-dsi.c        |  7 +++++++
> >  drivers/phy/mediatek/phy-mtk-mipi-dsi.h        | 10 ++--------
> >  4 files changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> > b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> > index 95a0d9a3cca7..59f028da9d3e 100644
> > --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> > +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8173.c
> > @@ -4,7 +4,11 @@
> >   * Author: jitao.shi <jitao.shi@mediatek.com>
> >   */
> >
> > +#include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> >  #include <linux/regmap.h>
> > +#include <linux/phy/phy.h>
> >  #include "phy-mtk-mipi-dsi.h"
> >
> >  #define MIPITX_DSI_CON               0x00
> > diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> > b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> > index 01b59527669e..6c6b192485ba 100644
> > --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> > +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> > @@ -4,7 +4,11 @@
> >   * Author: jitao.shi <jitao.shi@mediatek.com>
> >   */
> >
> > +#include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> >  #include <linux/regmap.h>
> > +#include <linux/phy/phy.h>
> >  #include "phy-mtk-mipi-dsi.h"
> >
> >  #define MIPITX_LANE_CON              0x000c
> > diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> > b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> > index 51b1b1d4ad38..6f7425b0bf5b 100644
> > --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> > +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> > @@ -3,7 +3,14 @@
> >   * Copyright (c) 2015 MediaTek Inc.
> >   */
> >
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > +#include <linux/phy/phy.h>
> >  #include "phy-mtk-mipi-dsi.h"
> >
> >  inline struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw
> > *hw)
> > diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
> > b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
> > index 8d32e9027a15..4eb5fc91e083 100644
> > --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
> > +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
> > @@ -7,16 +7,10 @@
> >  #ifndef _MTK_MIPI_TX_H
> >  #define _MTK_MIPI_TX_H
> >
> > -#include <linux/clk.h>
> >  #include <linux/clk-provider.h>
> > -#include <linux/delay.h>
> > -#include <linux/io.h>
> > -#include <linux/module.h>
> > -#include <linux/nvmem-consumer.h>
> > -#include <linux/of_device.h>
> > -#include <linux/platform_device.h>
> > +#include <linux/types.h>
> > +#include <linux/regmap.h>
> >  #include <linux/phy/phy.h>
> > -#include <linux/slab.h>
> >
> I don't think it's good idea to move the common headers into .c files

Header files should be included directly by the file that uses facilities
provided by said header file. Required ones should not be transitively
included through other header files, as that introduces a subtle dependency.

Also, needlessly including header files in places that aren't using them
increases build time. See the 2000+ patch series from Ingo Molnar [1]
increasing build performance by cleaning up header files.

ChenYu

[1] https://lwn.net/ml/linux-kernel/YdIfz+LMewetSaEB@gmail.com/

> >  struct mtk_mipitx_data {
> >       const u32 mppll_preserve;
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
