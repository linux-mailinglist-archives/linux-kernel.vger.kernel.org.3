Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC38475D26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244691AbhLOQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbhLOQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:14:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD46C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:14:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AC84B81D40
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46411C36AE2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639584893;
        bh=wo0crMKVlb7bmqaDIAvITIC848wu5jLZZ67Z80HKcRM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eNNwMRyTV221oRdj5G7UQ3XcsDP0G7RuGoRrkRZ8/lXE5fYOW59uAEH7VihbRwWxO
         rtb2Sx3uHnp5mBD933YemSHpayKk8aVSbhbS2kbp59RPunQhsSVllBTcTVxRaC+7vW
         LK2qW0jamydu8RrkXx6l9G5NH3CljOkpCbzelsgkQ+DbsD7UJZgwQN/fASuh112NmM
         U6qgHhfjUCfNgNxkWFW5Q4dO6fd1XNjIk25q+yElqtapX5MLBZakT3X8qjwoViNhkQ
         RY4ZSE4xqJravCkR194jmGdWpJY8xB6yXowVQwBYv9aqOFXzVRB/jv3/etMHkNSYGO
         1bwfUz3h+JsWA==
Received: by mail-ed1-f54.google.com with SMTP id g14so75758364edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:14:53 -0800 (PST)
X-Gm-Message-State: AOAM532HX6/hV5PwzDycKLI9wgobzULc3kvmKOlc6vbclWTJBuohR+zs
        B/hMQ0WbLieJundFTxb0zi0wYctUiLmIDb/ePQ==
X-Google-Smtp-Source: ABdhPJwb1dCWZnfzIsxAO7jQHE1+1kUJseuzbpP+YWd9CINPK/i/ENG5c75C9WxsfttHUDoyFH5Gb/7t73WX+PxlWKg=
X-Received: by 2002:a50:ef02:: with SMTP id m2mr15331810eds.172.1639584888656;
 Wed, 15 Dec 2021 08:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20211022172413.195559-1-markyacoub@chromium.org>
 <20211026011318.GF2515@art_vandelay> <CAJUqKUopyQEyLh7w32UnHfUJv0nNUoE_PHAdkEj8JOnkhVqbbQ@mail.gmail.com>
In-Reply-To: <CAJUqKUopyQEyLh7w32UnHfUJv0nNUoE_PHAdkEj8JOnkhVqbbQ@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 16 Dec 2021 00:14:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_84K_xCQE-H8zxWfBhn4kQF_kPsmaqDuRr8w2E4rti3QA@mail.gmail.com>
Message-ID: <CAAOTY_84K_xCQE-H8zxWfBhn4kQF_kPsmaqDuRr8w2E4rti3QA@mail.gmail.com>
Subject: Re: [PATCH] mediatek: Set default value for Panel Orientation
 connector prop.
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     Sean Paul <sean@poorly.run>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Yacoub <markyacoub@google.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark:

Mark Yacoub <markyacoub@chromium.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:13=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hey CK, can we have this merged?
> Thank you!
>
> On Mon, Oct 25, 2021 at 9:13 PM Sean Paul <sean@poorly.run> wrote:
> >
> > On Fri, Oct 22, 2021 at 01:24:03PM -0400, Mark Yacoub wrote:
> > > From: Mark Yacoub <markyacoub@chromium.org>
> > >
> > > [Why]
> > > Creating the prop uses UNKNOWN as the initial value, which is not a
> > > supported value if the props is to be supported.
> > >
> > > [How]
> > > Set the panel orientation default value to NORMAL right after creatin=
g
> > > the prop.
> >
> > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> >
> > >
> > > Tested on Jacuzzi(MTK)
> > > Fixes IGT@kms_properties@get_properties-sanity-{atomic,non-atomic}
> > >
> > > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/med=
iatek/mtk_dsi.c
> > > index 0ad7157660afa..b7c2528a8f41c 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > @@ -1039,6 +1039,8 @@ static int mtk_dsi_encoder_init(struct drm_devi=
ce *drm, struct mtk_dsi *dsi)
> > >               DRM_ERROR("Unable to init panel orientation\n");
> > >               goto err_cleanup_encoder;
> > >       }
> > > +     drm_connector_set_panel_orientation(dsi->connector,
> > > +                                         DRM_MODE_PANEL_ORIENTATION_=
NORMAL);

In drm_connector_set_panel_orientation() [1], I find that the
orientation could be set only once. Once you set it to normal, it
could not be set to other orientation. Right?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/gpu/drm/drm_connector.c?h=3Dv5.16-rc5#n2302

Regards,
Chun-Kuang.

> > >
> > >       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> > >
> > > --
> > > 2.33.0.1079.g6e70778dc9-goog
> > >
> >
> > --
> > Sean Paul, Software Engineer, Google / Chromium OS
