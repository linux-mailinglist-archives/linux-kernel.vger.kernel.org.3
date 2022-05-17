Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BDA52A7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350803AbiEQQJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346044AbiEQQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:09:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0F84A3D7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:09:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l14so6902177pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifrBYPe2YtnQaY3lXxkltamF2qFHora4+SSWUHtal+g=;
        b=meKfja/RfnUFtK6LLF92V1BikRFj4Hi+k9LJ5zrY74z2qMsVN11AEKVRBwyBJDuu2p
         ks7nknIk5lHQqiYK3YxVujkyYus+vCrzwhEkTO2mjVMD9EjRI38YpnIdVJEJW6JxW/+r
         SR1mIM0lnxlErVQGXEPlnDwgiZjHH5Z+XROOnjyRCIB20w+cu8JdoJsRxR3cZIF1hi9t
         BVWQUmxDowfct4m8QT2vXOhI+UApMmgO6K+22GbeEUKHmN3HGW2FfX/wYQj1IW02fHft
         kAMirnn0OAQd+ORlSBASJ1E+6amd4Y0m2YWsUdv1GqkwnZbHUN3qFi5U30AJWGARH429
         IDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifrBYPe2YtnQaY3lXxkltamF2qFHora4+SSWUHtal+g=;
        b=0Ktu0dtC6/8lGB9qqJnFLO8PAkIZ/GC0Vajkd2PhjKtWRXT0dXSsf8JFB8YrJ5PQ/r
         k+0s+xGO6Tq5CkNzURoJcqEHYbcxByCxdcZTKP99yI5NAkUCSl+MyGWMEPk5vdC9pVU9
         cfKOyJu9jTv06c1Jb4VMT7G7IcbEEfsY0oYilQhZeGaPyderx2cyKGv3AzTsKt/4sRhv
         Lp2rbdYsbKvta/3pOFf9YkRMqwDeEFrH1R6JV4LU12P3JI/x1cABlymAjN4H7d0Mc0Xw
         6HM0VZHuGjTI+T/bAWvlgCrP2BaS4LaiEdUNp8cxzsSggSH7Zvgg/kY6iAvnIvQEsiwW
         0zfA==
X-Gm-Message-State: AOAM530zfBFX8AOrHHiK0zjC8c6dyTBMdJlVNjEzizY8VGfGQjCul1pl
        w2CE9NuyIbEyMvoFM2oBjZQFB0seUA1LKWoS1mK7qQ==
X-Google-Smtp-Source: ABdhPJzwz1uqlJwkMERbAIE6HZqOnweEYejZgJePANr9Wer4P5Mw56U+tU7NKwLD4gQ6u0HnBx1I+4Nq63OKq214/i8=
X-Received: by 2002:a17:903:2350:b0:15e:93de:763a with SMTP id
 c16-20020a170903235000b0015e93de763amr23603747plh.117.1652803764549; Tue, 17
 May 2022 09:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
 <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
 <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com>
 <CAGXv+5E1cCNWD98fMDjC38y2UztZd=PNQ+=G=wrBYfoXkswvHA@mail.gmail.com> <20220425091419.GA967110@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220425091419.GA967110@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 17 May 2022 18:09:13 +0200
Message-ID: <CAG3jFyvTim7P_y2G1Br5j3Pwz4KzvRjWgci_qQ3m_YW=3Bog8A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: anx7625: Use DPI bus type
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        bliang@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 at 11:14, Xin Ji <xji@analogixsemi.com> wrote:
>
> On Mon, Apr 25, 2022 at 04:24:50PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Apr 22, 2022 at 10:13 PM Robert Foss <robert.foss@linaro.org> wrote:
> > >
> > > On Fri, 22 Apr 2022 at 16:01, Robert Foss <robert.foss@linaro.org> wrote:
> > > >
> > > > On Fri, 22 Apr 2022 at 10:49, Xin Ji <xji@analogixsemi.com> wrote:
> > > > >
> > > > > As V4L2_FWNODE_BUS_TYPE_PARALLEL not properly descript for DPI
> > > > > interface, this patch use new defined V4L2_FWNODE_BUS_TYPE_DPI for it.
> > > > >
> > > > > Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > ---
> > > > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > index 376da01243a3..71df977e8f53 100644
> > > > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> > > > >
> > > > >         anx7625_get_swing_setting(dev, pdata);
> > > > >
> > > > > -       pdata->is_dpi = 1; /* default dpi mode */
> > > > > +       pdata->is_dpi = 0; /* default dsi mode */
> > > > >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> > > > >         if (!pdata->mipi_host_node) {
> > > > >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> > > > >                 return -ENODEV;
> > > > >         }
> > > > >
> > > > > -       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > > > > +       bus_type = 0;
> > > > >         mipi_lanes = MAX_LANES_SUPPORT;
> > > > >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> > > > >         if (ep0) {
> > > > > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> > > > >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> > > > >         }
> > > > >
> > > > > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > > > > -               pdata->is_dpi = 0;
> > > > > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > > > > +               pdata->is_dpi = 1;
> > > > >
> > > > >         pdata->mipi_lanes = mipi_lanes;
> > > > >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> > > >
> > > > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > >
> > > Acked-by: Robert Foss <robert.foss@linaro.org>
> >
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > Confirmed this fixes the display on Juniper (Acer Chromebook Spin 311) on
> > mainline (next-20220422).
> >
> > Xin, in the future, please send the whole series to all recipients of
> > all patches listed by get_maintainers.pl, not just the recipients of
> > each patch. In the case of this series, they should have been sent
> > to all of the mailing lists (media, devicetree, dri-devel) so that
> > everyone has the same, full view of the patches.
> Hi ChenYu, OK, I'll send to all media, devicetree, dri-devel next time.
> Thanks,
> Xin
> >
> > ChenYu

Applied 3/4 + 4/4 to drm-misc-next.
