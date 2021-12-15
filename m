Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D099475A08
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbhLON4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhLON4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:56:48 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA99C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:56:47 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso25016876otj.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=M6j9hwTZmADnSfWaurTAQggHTqHGDGAa0M5rDiFAOho=;
        b=vU8K7qkTSSZ06CE/fefEWyKnsRXiJLlkp7YM5DiBN3h885TMUwRU64eceuisXus8DC
         IvN+bZn6DKihhsf8twYGvrDXkoqlcKrYqtCi7YiWEMbKZ8omTlfuI2rmhXjbCJ67tKol
         5W4KjvFqtQvbFXyizzshpEnvg3A+9shfiBFO9JMtqbNeh7JqvHk0V4l/nJ1blHTe04H6
         pnlOoSlqClNTyiVRu/FB2ENduxZSRY5IiUCeAdETG1JH9WvsXzHOO2snbahquGr2dGD/
         1wdu+osd202SSm9a1zPYo3zBhtCntFybwBv6qqGZpUjlpvbXWpVLQ0dM1EjVn4thKxR8
         Zp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=M6j9hwTZmADnSfWaurTAQggHTqHGDGAa0M5rDiFAOho=;
        b=dq4291aPoB+Bn1lL46yzqlyDt7cQdKlTuQT/GhftFBrsXPxfgQn8hP4Io8TZi0mKwZ
         xsVI4vLsbBCaAgrZJD6klohtGUORIi9gXP/MbdXjlxumvQj8XIPaebZlznBCAL2z8NGn
         IIdKemOkK1EVkVZ6vg/yJkfx9YsDeB2cKJ7QVQw9D3SXcCfODs6MaJFzY5UVK/EKpsfD
         7iaIEP6kwR6gUb7gNhlVYfqu7rVgzWW+AbRRImicrgL9g/ASKyNoTV4VfXgeua24NDRW
         /aZ+EUr27Ov7sOIixfdy9IqX/B3GXh7TFdh7o+zEn9lEJXRqi+RHE0SU8xGRuU78LsW/
         PjUw==
X-Gm-Message-State: AOAM533Z4fatprisxdl9bxAMJytJakS7PaMey+vrOq7jmdW+kJzsK0l2
        ggQmKawbkYqUeysSj56Haj0dff0OySczVNRkA6P3/g==
X-Google-Smtp-Source: ABdhPJz6k/y1XdmARoYBhmoL4faqs4b6EkaRNTG2VXEP5cLBplgJmHpeQGBuN65kQTb4Ae2ykOvi1JN8NvW5Yd0+nyo=
X-Received: by 2002:a05:6830:200d:: with SMTP id e13mr9174519otp.109.1639576607244;
 Wed, 15 Dec 2021 05:56:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 07:56:43 -0600
MIME-Version: 1.0
In-Reply-To: <b307d567-774b-ca9e-d7d7-09846782c988@collabora.com>
References: <20211110130623.20553-1-granquet@baylibre.com> <20211110130623.20553-8-granquet@baylibre.com>
 <b307d567-774b-ca9e-d7d7-09846782c988@collabora.com>
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: alot/0.10
Date:   Wed, 15 Dec 2021 07:56:43 -0600
Message-ID: <CABnWg9sNOWJ_RgnvSdEtAVQrfELzJr8aj-FTB=oj6hQJScFCVA@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] drm/mediatek: Add mt8195 DisplayPort driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

Quoting AngeloGioacchino Del Regno (2021-12-10 11:17:44)
> Il 10/11/21 14:06, Guillaume Ranquet ha scritto:
> > From: Markus Schneider-Pargmann <msp@baylibre.com>
> >
> > This patch adds a DisplayPort driver for the Mediatek mt8195 SoC and a
> > according phy driver mediatek-dp-phy.
> >
> > It supports both functional units on the mt8195, the embedded
> > DisplayPort as well as the external DisplayPort units. It offers
> > hot-plug-detection, audio up to 8 channels, and DisplayPort 1.4 with up
> > to 4 lanes.
> >
> > The driver creates a child device for the phy. The child device will
> > never exist without the parent being active. As they are sharing a
> > register range, the parent passes a regmap pointer to the child so that
> > both can work with the same register range. The phy driver sets device
> > data that is read by the parent to get the phy device that can be used
> > to control the phy properties.
> >
> > This driver is based on an initial version by
> > Jason-JH.Lin <jason-jh.lin@mediatek.com>.
> >
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > Reported-by: kernel test robot <lkp@intel.com>
>
> Hello Markus, Guillaume,
>
> there is a critical issue with this patch. Please check below.
>
> > ---
> >   drivers/gpu/drm/drm_edid.c              |    2 +-
> >   drivers/gpu/drm/mediatek/Kconfig        |    7 +
> >   drivers/gpu/drm/mediatek/Makefile       |    2 +
> >   drivers/gpu/drm/mediatek/mtk_dp.c       | 3094 +++++++++++++++++++++++
> >   drivers/gpu/drm/mediatek/mtk_dp_reg.h   |  568 +++++
> >   drivers/gpu/drm/mediatek/mtk_dpi.c      |  111 +-
> >   drivers/gpu/drm/mediatek/mtk_dpi_regs.h |   26 +
> >   drivers/gpu/drm/mediatek/mtk_drm_drv.c  |    1 +
> >   drivers/gpu/drm/mediatek/mtk_drm_drv.h  |    1 +
> >   9 files changed, 3799 insertions(+), 13 deletions(-)
> >   create mode 100644 drivers/gpu/drm/mediatek/mtk_dp.c
> >   create mode 100644 drivers/gpu/drm/mediatek/mtk_dp_reg.h
> >
>
> <snip>
>
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 384074f69111b..e6e88e3cd811d 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
>
> <snip>
>
> > @@ -979,6 +1051,16 @@ static int mtk_dpi_probe(struct platform_device *pdev)
> >               return ret;
> >       }
> >
> > +     dpi->dpi_ck_cg = devm_clk_get(dev, "ck_cg");
>
> mtk_dpi is used on MT2701, MT7183, MT8183, MT8192, but these platforms haven't
> got any "ck_cg" clock defined in their device-trees (regardless of whether these
> can support adding this clock or not, any code change shall be retro-compatible
> hence not breaking compatibility/functionality with older device-trees).
>
> Reminding that:
> - mediatek-drm uses the component framework
> - mtk_drm_drv is the component master
> - mtk_drm_drv bind() won't be called unless all of the components added with
>    match aren't calling component_add()
>
> ... this change not only breaks DisplayPort support for *all* of the
> aforementioned SoCs, but also makes the entire mediatek-drm to not finish
> probing, producing a global breakage that also includes DSI and the entire
> stack of components of that master (so, no display on all of them).
>
> To avoid breaking any SoC that's not MT8195, please use devm_clk_get_optional()
> here in the next version.
>
> Thanks,
> - Angelo
>

This is a good catch, I will update for v7.

Thank you very much for your review.

Thx,
Guillaume.
