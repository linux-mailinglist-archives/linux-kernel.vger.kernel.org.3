Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8574D0366
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbiCGPuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiCGPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:50:20 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1557B40925
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:49:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b8so13959603pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL0gXsWbGhLI04YBjzXHDJu+JMl7WurtGcAsv91Hz5k=;
        b=Kp5yZGW0Ab5T2mjqzxPvmuVftl8sYQc7xz0cyW35fQuBN9lAzVFYMt+71xB4nVz2zH
         OeqnKiQ8ARMsefAnzjPdcQQr0qnaZSFSofHxl3uXNmPUJE+TWv9vC7pKnQ0E86RGO26f
         OmWvW9mIB3DCeM5SjFKiW2Eo6gDntru4y4WsxiJDX/YLcpy5ikRdvD8ki+fQtSYMyuSl
         8qHCRcaikR+yQiYofkjmEKsDWTY1r3w/SMRn3ST1rrDZ5PuIsof8pGiNyTxsNx3AA4gJ
         1afiH/g1Ob+IDASGSyiF5K7SScsJ7FSqIlYSkwfT9pdjNq5uF1A/5znvHVkBLct0O5sh
         nO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL0gXsWbGhLI04YBjzXHDJu+JMl7WurtGcAsv91Hz5k=;
        b=NCAnHIYguPg/gnMDozhNOQuAUYpSpWu7RoA6ATU6/NOcBRlVPb78UEtoCV+XlWfiPM
         yJyovQxGdwHdD9+eB5iFYA+GYVwWgkIkCNwDAo4iwiRQNeE0XC0wcCVfoydV6vawN/uU
         wZutaNze1/4CsiQn5pFu5IzBUdtjuK4uPIzhOHngd1+1Xb6r+i184uw1vEjr3pdJPUQv
         dSv0PtW0IL3W8595GsIFiinN1fVrOjj7XceFuZqXcSU08FvBs0hBfKTMTJP/EPzp/KPw
         4zcL0QInT3lo59TzwRTzClRtvSW7Fx5rMRyNLLpSH4lAKowdFnFiYaNnGUaxe2Gd62vB
         HeaQ==
X-Gm-Message-State: AOAM532dIA2YpBEP41tqZtqpgbEwwNqSq+9hbnL5x+kjDr3v59DCvI8+
        KcIhEcBw49rZnFZVCMCjPE6FmSlVBxo0xA22Jxz+AQ==
X-Google-Smtp-Source: ABdhPJy2roW03lthAIX6j+2h+EPCsVhhcpMTUdZeJAti7tvAKjOU/gBksPov6kZj/ME8zDET9PX1au5aJNKDhNlfY8s=
X-Received: by 2002:a17:90b:124c:b0:1bc:369b:7db5 with SMTP id
 gx12-20020a17090b124c00b001bc369b7db5mr26044708pjb.179.1646668162460; Mon, 07
 Mar 2022 07:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20211105031904.2641088-1-xji@analogixsemi.com>
 <20211105031904.2641088-3-xji@analogixsemi.com> <YiTruiCIkyxs3jTC@pendragon.ideasonboard.com>
 <YiWiYpEfTOOqgyAN@google.com>
In-Reply-To: <YiWiYpEfTOOqgyAN@google.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 7 Mar 2022 16:49:11 +0100
Message-ID: <CAG3jFys-BYsBp07AAFQ2O_TFsXOwhcVDnsOh8WVNNSag3HZw+Q@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] drm/bridge: anx7625: add MIPI DPI input feature
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Xin Ji <xji@analogixsemi.com>,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        dan.carpenter@oracle.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, pihsun@chromium.org, tzungbi@google.com,
        maxime@cerno.tech, drinkcat@google.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bliang@analogixsemi.com, qwen@analogixsemi.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
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

On Mon, 7 Mar 2022 at 07:12, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Sun, Mar 06, 2022 at 07:13:30PM +0200, Laurent Pinchart wrote:
> > Hello Xin,
> >
> > (Question for Rob below, and I'm afraid this is urgent as we need to
> > merge a fix in v5.17).
> >
> > On Fri, Nov 05, 2021 at 11:19:03AM +0800, Xin Ji wrote:
> > > The basic anx7625 driver only support MIPI DSI rx signal input.
> > > This patch add MIPI DPI rx input configuration support, after apply
> > > this patch, the driver can support DSI rx or DPI rx by adding
> > > 'bus-type' in DT.
> > >
> > > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 247 ++++++++++++++++------
> > >  drivers/gpu/drm/bridge/analogix/anx7625.h |  18 +-
> > >  2 files changed, 205 insertions(+), 60 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index f48e91134c20..f7c3386c8929 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
>
> [...]
>
> > >  static int anx7625_parse_dt(struct device *dev,
> > >                         struct anx7625_platform_data *pdata)
> > >  {
> > > -   struct device_node *np = dev->of_node;
> > > +   struct device_node *np = dev->of_node, *ep0;
> > >     struct drm_panel *panel;
> > >     int ret;
> > > +   int bus_type, mipi_lanes;
> > > +
> > > +   anx7625_get_swing_setting(dev, pdata);
> > >
> > > +   pdata->is_dpi = 1; /* default dpi mode */
> > >     pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> > >     if (!pdata->mipi_host_node) {
> > >             DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> > >             return -ENODEV;
> > >     }
> > >
> > > -   DRM_DEV_DEBUG_DRIVER(dev, "found dsi host node.\n");
> > > +   bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > > +   mipi_lanes = MAX_LANES_SUPPORT;
> > > +   ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> > > +   if (ep0) {
> > > +           if (of_property_read_u32(ep0, "bus-type", &bus_type))
> > > +                   bus_type = 0;
> > > +
> > > +           mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> > > +   }
> > > +
> > > +   if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> >
> > This is not correct *at all*. V4L2_FWNODE_BUS_TYPE_PARALLEL has nothing
> > to do with DSI. DSI stands for Digital *Serial* Interface. If anything,
> > the V4L2_FWNODE_BUS_TYPE_PARALLEL type would map better to DPI, even if
> > it's not an exact match.
> >
> > This patch has landed in v5.17-rc1, along with the corresponding
> > bindings. As DT bindings are an ABI, we should really fix this before
> > v5.17 is released. There is no DSI bus types defined in DT, and adding
> > one as a fix so late in the v5.17-rc cycle seems a bit of a stretch to
> > me (unless Rob disagrees).
> >
> > It would seem best to revert this series and the corresponding bindings,
> > and retry in v5.18.
>
> There is a DT patch using this property that is already queued up for 5.17
> in the soc tree:
>
> https://lore.kernel.org/all/20220214200507.2500693-1-nfraprado@collabora.com/
>
> merged here:
>
> http://git.kernel.org/soc/soc/c/32568ae37596b529628ac09b875f4874e614f63f
>
> We will need to revert that one as well.

I just submitted a series reverting the dt-binding change + the
related commit to "mt8183: jacuzzi".
Can I get a quick r-b/a-b in order to get this into v5.17.

https://lore.kernel.org/all/20220307154558.2505734-3-robert.foss@linaro.org/

>
> ChenYu
