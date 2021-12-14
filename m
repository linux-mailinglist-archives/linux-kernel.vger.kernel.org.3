Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93A147461E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhLNPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhLNPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:13:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745BBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:13:13 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id t26so37398975lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+bLnAgO3b5siLg+4Vc0pITri5Pyuz0KEVByfdnYDUc=;
        b=kCE7rz4ty8OGXocOaIZ3U4M6gf6ZOKVj3wNbZYF0cgfawnSE7lraEFy4XZSw/fLgSF
         +znofuf+MuVMaaLS3TEXk10vJMTERr9+PeavbiQTq8Tls0YR5gjguTMLcRzSVqJt99K/
         0je4UkVDApqGfFNiKg32fiTXAGdspkepqWSlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+bLnAgO3b5siLg+4Vc0pITri5Pyuz0KEVByfdnYDUc=;
        b=CAm+L59/ceUDt+Ttj4quxx7k6Fxk+owPDbHV7p9QguZ74nrIfoNjLVaAV5Ylrx8KPH
         uOYkVD1JnZ9CsdtjecxS9MW5R0dpVmWncRyF6aDtVsE/qzt1AyPMUnxWPyzVTOLYN3FH
         G+WNZueDfdeg2CEYi6omgbqWBZW4v20Vgw7w1tFUcGlB3o85kBry4cf101S3hzWSiWqU
         +EWp1q8xwQA2GkqOIWN8x1nx7e39XIshOILcAM27TP4w9Dk45iA9IuZO2sZ3qaCRqrXw
         sFZPITvPZvp1XO1KfbXPCmMJAuTCrwJVzGlD9jDWhHtjV9L+XifitknnpFZT+msVHZk+
         GvKA==
X-Gm-Message-State: AOAM532AqwT2WOTUCm4eM3hYFlCgfKbh/Wgc5tg0rcukl/8CXsTz2bzv
        AG+dOrvnp5w7AIdvZBQHnWmCVtCV0sQ1nQY+mnRKYw==
X-Google-Smtp-Source: ABdhPJyJT7xqBLUyVs9umwlaLSNF7gCLRF7yhoSNNTuBadwQHuxuZn1gHe8yhGYuShqyro78Lu0JCvDSqBPxCAMGnYs=
X-Received: by 2002:a05:6512:1510:: with SMTP id bq16mr4926777lfb.628.1639494791345;
 Tue, 14 Dec 2021 07:13:11 -0800 (PST)
MIME-Version: 1.0
References: <20211022172413.195559-1-markyacoub@chromium.org> <20211026011318.GF2515@art_vandelay>
In-Reply-To: <20211026011318.GF2515@art_vandelay>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Tue, 14 Dec 2021 10:13:00 -0500
Message-ID: <CAJUqKUopyQEyLh7w32UnHfUJv0nNUoE_PHAdkEj8JOnkhVqbbQ@mail.gmail.com>
Subject: Re: [PATCH] mediatek: Set default value for Panel Orientation
 connector prop.
To:     Sean Paul <sean@poorly.run>
Cc:     linux-mediatek@lists.infradead.org, seanpaul@chromium.org,
        Mark Yacoub <markyacoub@google.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey CK, can we have this merged?
Thank you!

On Mon, Oct 25, 2021 at 9:13 PM Sean Paul <sean@poorly.run> wrote:
>
> On Fri, Oct 22, 2021 at 01:24:03PM -0400, Mark Yacoub wrote:
> > From: Mark Yacoub <markyacoub@chromium.org>
> >
> > [Why]
> > Creating the prop uses UNKNOWN as the initial value, which is not a
> > supported value if the props is to be supported.
> >
> > [How]
> > Set the panel orientation default value to NORMAL right after creating
> > the prop.
>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>
> >
> > Tested on Jacuzzi(MTK)
> > Fixes IGT@kms_properties@get_properties-sanity-{atomic,non-atomic}
> >
> > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 0ad7157660afa..b7c2528a8f41c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -1039,6 +1039,8 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
> >               DRM_ERROR("Unable to init panel orientation\n");
> >               goto err_cleanup_encoder;
> >       }
> > +     drm_connector_set_panel_orientation(dsi->connector,
> > +                                         DRM_MODE_PANEL_ORIENTATION_NORMAL);
> >
> >       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> >
> > --
> > 2.33.0.1079.g6e70778dc9-goog
> >
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
