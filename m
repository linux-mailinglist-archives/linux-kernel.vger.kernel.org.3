Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A834475A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhLON7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLON7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:59:37 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95EEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:59:36 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso25074836otf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=jzXbIP5FciFwRo+uwKbSYKwE5J1uKZwuclMd+bHXm4Q=;
        b=VW9meFnnbW+6LhQXBCYPKpSaQzDRpNnMKRUZyG7F83OPWZ35MX+n4Qr4fgwTmrF0rT
         6m9gcUNEEMjaYdGTbOnKqtEMFoY5B3WNGnlDW3U0KtLtgyFCfwQx1vmr/m4U05GTZcem
         5UtzSKqy2kFGXp/gUJ7EmPzPtoqMTDqIfQC/YvzVxo/LQ5kHKwkxE3jp5njcEelUv1kT
         OG+iBv9RmWkUa5GARhS9NinLIasDgB8d9//7XMhh28GcjR8UhN7IY/fuvUBNap7Xo/3W
         A+5v1+o116FlmWcud/nkiz8Y/GbQz/SNhtUr8kF1JFXv/F8gm1ythiT2qQn13y9snEdY
         fydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=jzXbIP5FciFwRo+uwKbSYKwE5J1uKZwuclMd+bHXm4Q=;
        b=GMl0m5eZ6XRe0HVavx2m1PhkAMSD8VsDvwU5nER97YUdhzhRoqAhkxftuvNjS8WVeS
         F5v4NAFrmV5FTKSBmfi1A9obgzjzYYzBxI6enRLg035CjNY7CTSed6Orkg7V6Emy9w1K
         5Us21bQjiR4YlQC6QEFMGeUOaU1kK8/WkTM6YC4vZ9f4Y09VpY1QUcFK9x4OjLmusPpa
         6XyVovfYzYi6Hfx7tUvGtvzy2yHcIVNie+m7XmYCVnWKfQL6lpWLv074QRTs94/gZ2J0
         syB5YpcIwjX6vusXhepNxu+IHFCJgEy3rJv2hB6oGzigd6Y+UKPewpDaIk8yV0gScNy6
         BzVw==
X-Gm-Message-State: AOAM533HKE38McfiOmbvV4ku1PQtBg18KiYiLSerji1qUxI3fCfITJRP
        Qbj5ztHzBkPh2i1jfe4wJze6DoxpmyN6Ie+5mX7ozA==
X-Google-Smtp-Source: ABdhPJw9vbo3GtL3umP4JTbk/hUjj33zlRQI9PHcpEYiz1E8UmKBHQI5Lfz+6KJ2nWa6o7LDr4U/YQDOVfofOzqmx08=
X-Received: by 2002:a05:6830:200d:: with SMTP id e13mr9181654otp.109.1639576776133;
 Wed, 15 Dec 2021 05:59:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 07:59:35 -0600
MIME-Version: 1.0
In-Reply-To: <CAJMQK-gGE78qZoR92d8OH6_vTzBR5ry04nKGS22Dw48vAo7+AA@mail.gmail.com>
References: <20211110130623.20553-1-granquet@baylibre.com> <20211110130623.20553-8-granquet@baylibre.com>
 <CAJMQK-gGE78qZoR92d8OH6_vTzBR5ry04nKGS22Dw48vAo7+AA@mail.gmail.com>
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: alot/0.10
Date:   Wed, 15 Dec 2021 07:59:35 -0600
Message-ID: <CABnWg9tAMLWtPK1QjiqKyNgNhdqDDSc2fyAAmS3rzLQBwvT8SA@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] drm/mediatek: Add mt8195 DisplayPort driver
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Quoting Hsin-Yi Wang (2021-12-09 07:29:30)
> On Wed, Nov 10, 2021 at 9:08 PM Guillaume Ranquet <granquet@baylibre.com> wrote:
> >
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
> > ---
>
>
> <snip>
>
> > +static int mtk_dp_probe(struct platform_device *pdev)
> > +{
> > +       struct mtk_dp *mtk_dp;
> > +       struct device *dev = &pdev->dev;
> > +       int ret;
> > +       int irq_num = 0;
> > +       struct drm_panel *panel = NULL;
> > +
> > +       mtk_dp = devm_kzalloc(dev, sizeof(*mtk_dp), GFP_KERNEL);
> > +       if (!mtk_dp)
> > +               return -ENOMEM;
> > +
> > +       mtk_dp->dev = dev;
> > +
> > +       irq_num = platform_get_irq(pdev, 0);
> > +       if (irq_num < 0) {
> > +               dev_err(dev, "failed to request dp irq resource\n");
> > +               return -EPROBE_DEFER;
> > +       }
> > +
> > +       ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel,
> > +                                         &mtk_dp->next_bridge);
> > +       if (ret == -ENODEV) {
> > +               dev_info(
> > +                       dev,
> > +                       "No panel connected in devicetree, continuing as external DP\n");
> > +               mtk_dp->next_bridge = NULL;
> > +       } else if (ret) {
> > +               dev_err(dev, "Failed to find panel or bridge: %d\n", ret);
>
> Hi,
>
> We're seeing
> [    0.424599] mediatek-drm-dp 1c500000.edp_tx: Failed to find panel
> or bridge: -517
>
> It's probably better to use dev_err_probe here.
>
> Thanks

Good suggestion, it will be in v7.

Thanks for your review,
Guillaume.
>
> > +               return ret;
> > +       }
> > +
> > +       if (panel) {
> > +               mtk_dp->next_bridge = devm_drm_panel_bridge_add(dev, panel);
> > +               if (IS_ERR(mtk_dp->next_bridge)) {
> > +                       ret = PTR_ERR(mtk_dp->next_bridge);
> > +                       dev_err(dev, "Failed to create bridge: %d\n", ret);
> > +                       return -EPROBE_DEFER;
> > +               }
> > +       }
>
>
> <snip>
>
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
