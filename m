Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBC1530B72
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiEWIho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiEWIhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:37:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA61EC78
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:37:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so16874525pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HORsqsRgVOBZA14nSE2e7FyTeWgEO5D6Vi4Q6hdDzkA=;
        b=M4Bkd9gP/croFLXFB+CuZDimPMnOqzRihvoIdTgT51gZzf9whsUOIcNciLaH1v4CKE
         SLpHCkc+viFdpVT8k9rgzb7hCI0SqUQIkE8KoIrVY/YGi6HtY/NHzrMC1Cr8VGpU3Hio
         ERc2ZW6pZgZXueeFcM7zSwjsVMO4wFZjSHbjTZeWJ5W4dpnVbm5NgkVZpEKqPC2SV+mi
         M+eT6uF2+qhDYmRLI9JytWWl/TWYVDRK915uTT/LlvTyldDCO9VOShR1yi1eiSI+gJvh
         X8cS2KkTfutX17/8FDBeKF2zlRTKKI2DpVdm/ASJcCwbThWanCRRmOVeklO3KIq4eARv
         Jtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HORsqsRgVOBZA14nSE2e7FyTeWgEO5D6Vi4Q6hdDzkA=;
        b=4swdQFLh7ANVyzwUHD0lMsvwfkRkhXYE6eEAOZSGBa+cIihtBq6dMKa0x+8bl87aqr
         5QGeYWVLIgyeOBrv5QW+PlpFqDtAyKQgsEo2qsrNl8U0W9SKDw8hW9JXi4RmxbeZb4Y5
         YaneGrYQI048ExrQR33Rvn4tqbcGsUWyDgGCYz5SocSHbJ6mEZtpl69EvYb1OvwBoNJm
         s+ZkiFAh+46B7knamo8YumgmkfWAjTQCRGfwENyohjYPXeMYox4MPwkiajBcAvzAkGww
         JnQnIq8317SuL8SuOwpWSjHMfBZeJGnoxHByjUsYA0DuLFoCTeAbMh+JqGOl+udAmQqZ
         wjlg==
X-Gm-Message-State: AOAM531yfxWUQoGPRY4EGqt8Cb2logqE9Yqwfau0/DKIQodOt3lfeHAE
        vM9DfrPB/wM5s2d1t/mhtMSCtT/YQWlkRZPilh9KgQ==
X-Google-Smtp-Source: ABdhPJySGKSRaC8Rp00cV7JgVN8Qpt/CJ89/rm7OeTgEfK5OPZ+3wbN4zqXoAhwGpjdOCLyhXZZOGQCGeNOPmTPZwhM=
X-Received: by 2002:a17:902:8f81:b0:161:f4a7:f2fc with SMTP id
 z1-20020a1709028f8100b00161f4a7f2fcmr14964010plo.117.1653295056365; Mon, 23
 May 2022 01:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
 <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
 <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com>
 <CAGXv+5E1cCNWD98fMDjC38y2UztZd=PNQ+=G=wrBYfoXkswvHA@mail.gmail.com>
 <20220425091419.GA967110@anxtwsw-Precision-3640-Tower> <CAG3jFyvTim7P_y2G1Br5j3Pwz4KzvRjWgci_qQ3m_YW=3Bog8A@mail.gmail.com>
 <CAKMK7uFHyYTnGtP+vCzo2Uan90DW-QZpPFPn5S9bQ5aPiY=qzA@mail.gmail.com>
 <CAKMK7uHFGsPMZf2SUF4HDXo3XuOLjP3-DLfyp=gB2qpKR964Eg@mail.gmail.com>
 <20220523031324.GA3738288@anxtwsw-Precision-3640-Tower> <CAGXv+5EHghwSV+9Www9RvG74PkC7=AQuwn6sVG=cvCni-iwCyQ@mail.gmail.com>
In-Reply-To: <CAGXv+5EHghwSV+9Www9RvG74PkC7=AQuwn6sVG=cvCni-iwCyQ@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 23 May 2022 10:37:25 +0200
Message-ID: <CAG3jFysJLoQ2DMYw0oOfbQM3ifBmAhNLMxjPDEt12jq8sKCcSg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: anx7625: Use DPI bus type
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>, Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        bliang@analogixsemi.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
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

On Mon, 23 May 2022 at 09:18, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Mon, May 23, 2022 at 11:13 AM Xin Ji <xji@analogixsemi.com> wrote:
> >
> > On Sat, May 21, 2022 at 06:28:42PM +0200, Daniel Vetter wrote:
> > > On Sat, 21 May 2022 at 18:07, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > On Tue, 17 May 2022 at 18:09, Robert Foss <robert.foss@linaro.org> wrote:
> > > > >
> > > > > On Mon, 25 Apr 2022 at 11:14, Xin Ji <xji@analogixsemi.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 25, 2022 at 04:24:50PM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Fri, Apr 22, 2022 at 10:13 PM Robert Foss <robert.foss@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 22 Apr 2022 at 16:01, Robert Foss <robert.foss@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 22 Apr 2022 at 10:49, Xin Ji <xji@analogixsemi.com> wrote:
> > > > > > > > > >
> > > > > > > > > > As V4L2_FWNODE_BUS_TYPE_PARALLEL not properly descript for DPI
> > > > > > > > > > interface, this patch use new defined V4L2_FWNODE_BUS_TYPE_DPI for it.
> > > > > > > > > >
> > > > > > > > > > Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> > > > > > > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> > > > > > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > > > index 376da01243a3..71df977e8f53 100644
> > > > > > > > > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > > > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> > > > > > > > > >
> > > > > > > > > >         anx7625_get_swing_setting(dev, pdata);
> > > > > > > > > >
> > > > > > > > > > -       pdata->is_dpi = 1; /* default dpi mode */
> > > > > > > > > > +       pdata->is_dpi = 0; /* default dsi mode */
> > > > > > > > > >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> > > > > > > > > >         if (!pdata->mipi_host_node) {
> > > > > > > > > >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> > > > > > > > > >                 return -ENODEV;
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > > -       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > > > > > > > > > +       bus_type = 0;
> > > > > > > > > >         mipi_lanes = MAX_LANES_SUPPORT;
> > > > > > > > > >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> > > > > > > > > >         if (ep0) {
> > > > > > > > > > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> > > > > > > > > >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > > > > > > > > > -               pdata->is_dpi = 0;
> > > > > > > > > > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > > > > > > > > > +               pdata->is_dpi = 1;
> > > > > > > > > >
> > > > > > > > > >         pdata->mipi_lanes = mipi_lanes;
> > > > > > > > > >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> > > > > > > > >
> > > > > > > > > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > > > > > > >
> > > > > > > > Acked-by: Robert Foss <robert.foss@linaro.org>
> > > > > > >
> > > > > > > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > > > >
> > > > > > > Confirmed this fixes the display on Juniper (Acer Chromebook Spin 311) on
> > > > > > > mainline (next-20220422).
> > > > > > >
> > > > > > > Xin, in the future, please send the whole series to all recipients of
> > > > > > > all patches listed by get_maintainers.pl, not just the recipients of
> > > > > > > each patch. In the case of this series, they should have been sent
> > > > > > > to all of the mailing lists (media, devicetree, dri-devel) so that
> > > > > > > everyone has the same, full view of the patches.
> > > > > > Hi ChenYu, OK, I'll send to all media, devicetree, dri-devel next time.
> > > > > > Thanks,
> > > > > > Xin
> > > > > > >
> > > > > > > ChenYu
> > > > >
> > > > > Applied 3/4 + 4/4 to drm-misc-next.
> > > >
> > > > This patch doesn't even compile. Can you pls fix this up asap? Also
> > > > pls compile-test before pushing ...
> > >
> > > Marek says the prerequisite landed through linux-media, and that's why
> > > it compilers on linux-next but not in drm-misc-next.
> > >
> > > Don't do that.
> > >
> > > Instead:
> > > - merge all patches through one branch, with the foreign patches acked
> > > for that merge patch
> > > - wait until you can backmerge all the dependencies
> > > - do a topic branch
> > >
> > > This probably needs to be reverted here and instead merged through
> > > linux-media. Or you wait until -rc1 and then apply it to
> > > drm-misc-next.
> > > -Daniel
> > Hi Daniel, I use git send-email to upstream patch and automatically
> > generated reviewer list, so patch 1/4 and 2/4 send to linux-media, and
> > these 2 patches already merged in linux-media.
>
> This is one of the reasons why you should always send the "full" series
> to all recipients. That way people, especially maintainers, are more
> likely to notice build time cross tree dependencies like this one, and
> work towards a common resolution.

This mistake is mine, and I think the best solution is to revert 3+4 until rc1.

I'll send out the revert patches to the ML right away.


Rob.
