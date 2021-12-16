Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A565477B86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbhLPS3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbhLPS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:29:28 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9CEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:29:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id k23so39908549lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KVa7XRjdQTQQ+NHVe7KA6uaTzA6Zt7dgnU51Cr/arDU=;
        b=DvqnCNlGIVWTdXMQTfWTbX+P7/GCCoWVTp336sZp9LGWx1XowYFz2wjhc/+tgOZguA
         Tr6GSml0dR1myMW/Ve2wcssnvMkmO+JVg3lFnZmM9CZR3mszPyp9stqC4dG5ejrEf8WL
         pW1+yz10ocQOKxKRb6VMOLDZUNRFHBUd1iDsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KVa7XRjdQTQQ+NHVe7KA6uaTzA6Zt7dgnU51Cr/arDU=;
        b=F0xYG97JTaWUtqiDv0a9IzPxHuMvK9AhWIOpaXtoimxKb2ST+b+S1ru12HxwAuKtzy
         yYyqZecgheLG7fiWnYajW1owWYe+l9oLJ8RqfbxwO9chOmJ0+8zp6nbxhG5rogDmegQN
         oCW9ywT0vlhSpUlyLEX0WhK4+gsud0aqbtycWfFNtiBiN+bqAYkOjAyQ3dqlvDSP3MSG
         dK1c9ulFMTiLuXBDvxaPqTzD/hHCFgCHr3+AppFQZ7SBxWkocprwvtYlL4U/yph9l4S2
         OHy+CwiucY6C0PIoWI63HmmFS96cz6uzbGLY/B3bM/DO4FEo4GZ1Qu25PEgEKB/oCi8C
         xR4g==
X-Gm-Message-State: AOAM533gx2Vp5aM5QTlJJkZd3aoD8zGk1onqkNDdh3VUfegbAFZCfcbr
        BXinWEecMN782IQ340mwATY+GCTyZjMD8vJaltCIcA==
X-Google-Smtp-Source: ABdhPJw6LfqHGyB0ofB0fkrEV7zVM3ILMEfGUIWtLIfHpPovC9NhM0H8L41hVX+jM18mzDXtiFkEVi2hYqEMvJ1vqQU=
X-Received: by 2002:a2e:b947:: with SMTP id 7mr16919685ljs.89.1639679366471;
 Thu, 16 Dec 2021 10:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20211022172413.195559-1-markyacoub@chromium.org>
 <20211026011318.GF2515@art_vandelay> <CAJUqKUopyQEyLh7w32UnHfUJv0nNUoE_PHAdkEj8JOnkhVqbbQ@mail.gmail.com>
 <CAAOTY_84K_xCQE-H8zxWfBhn4kQF_kPsmaqDuRr8w2E4rti3QA@mail.gmail.com>
 <CAJUqKUrCibOCjPca_YaLpF2_zsb-85CbKbrs9KyGqWwGrWOGyg@mail.gmail.com> <CAAOTY_-b=F+moHec9sx_o5jv7XhfSd9A2crHsWGtzBdRSoiwHw@mail.gmail.com>
In-Reply-To: <CAAOTY_-b=F+moHec9sx_o5jv7XhfSd9A2crHsWGtzBdRSoiwHw@mail.gmail.com>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Thu, 16 Dec 2021 13:29:15 -0500
Message-ID: <CAJUqKUo2JzASTeVbiP7bAzDKqMYsJGQ5h9=b=9Y8D9z3Xj-YMw@mail.gmail.com>
Subject: Re: [PATCH] mediatek: Set default value for Panel Orientation
 connector prop.
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Sean Paul <sean@poorly.run>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Yacoub <markyacoub@google.com>,
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

This makes sense. Thanks for pointing that out I wasn't aware of it.
I'll take a closer look and try to come up with something better.

Thanks Chun-Kuang!

On Thu, Dec 16, 2021 at 11:53 AM Chun-Kuang Hu <chunkuang.hu@kernel.org> wr=
ote:
>
> Hi, Mark:
>
> Mark Yacoub <markyacoub@chromium.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=881=
6=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:25=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > On Wed, Dec 15, 2021 at 11:14 AM Chun-Kuang Hu <chunkuang.hu@kernel.org=
> wrote:
> > >
> > > Hi, Mark:
> > >
> > > Mark Yacoub <markyacoub@chromium.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=
=8814=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:13=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > >
> > > > Hey CK, can we have this merged?
> > > > Thank you!
> > > >
> > > > On Mon, Oct 25, 2021 at 9:13 PM Sean Paul <sean@poorly.run> wrote:
> > > > >
> > > > > On Fri, Oct 22, 2021 at 01:24:03PM -0400, Mark Yacoub wrote:
> > > > > > From: Mark Yacoub <markyacoub@chromium.org>
> > > > > >
> > > > > > [Why]
> > > > > > Creating the prop uses UNKNOWN as the initial value, which is n=
ot a
> > > > > > supported value if the props is to be supported.
> > > > > >
> > > > > > [How]
> > > > > > Set the panel orientation default value to NORMAL right after c=
reating
> > > > > > the prop.
> > > > >
> > > > > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > > > >
> > > > > >
> > > > > > Tested on Jacuzzi(MTK)
> > > > > > Fixes IGT@kms_properties@get_properties-sanity-{atomic,non-atom=
ic}
> > > > > >
> > > > > > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > > > > > ---
> > > > > >  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/d=
rm/mediatek/mtk_dsi.c
> > > > > > index 0ad7157660afa..b7c2528a8f41c 100644
> > > > > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > > > @@ -1039,6 +1039,8 @@ static int mtk_dsi_encoder_init(struct dr=
m_device *drm, struct mtk_dsi *dsi)
> > > > > >               DRM_ERROR("Unable to init panel orientation\n");
> > > > > >               goto err_cleanup_encoder;
> > > > > >       }
> > > > > > +     drm_connector_set_panel_orientation(dsi->connector,
> > > > > > +                                         DRM_MODE_PANEL_ORIENT=
ATION_NORMAL);
> > >
> > > In drm_connector_set_panel_orientation() [1], I find that the
> > > orientation could be set only once. Once you set it to normal, it
> > > could not be set to other orientation. Right?
> > >
> > Hello,
> > Yeah this looks true, and makes sense according to the documentation:
> > https://01.org/linuxgraphics/gfx-docs/drm/gpu/drm-kms.html#:~:text=3Don=
e%20standardized%20property%3A-,panel%20orientation%3A,-On%20some%20devices
> >
> > Panel orientation has to do with the how the hardware is mounted, in
> > contrast with the Rotation property. All the HW we have right now has
> > a normal panel orientation so it makes sense to be set this way. Among
>
> Many evidence [1], [2], [3], show that Chromebook plan to have other
> orientation on mt8183, so I think you should consider this.
>
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20210409045=
314.3420733-2-hsinyi@chromium.org/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c?h=3Dv5.16-rc5#n1474
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts?h=3Dv5.16-rc5=
#n22
>
> Regards,
> Chun-Kuang.
>
>
>
> > other drivers, panel orientation is always set right after the
> > property is initialized.
> >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/gpu/drm/drm_connector.c?h=3Dv5.16-rc5#n2302
> > >
> > > Regards,
> > > Chun-Kuang.
> > >
> > > > > >
> > > > > >       drm_connector_attach_encoder(dsi->connector, &dsi->encode=
r);
> > > > > >
> > > > > > --
> > > > > > 2.33.0.1079.g6e70778dc9-goog
> > > > > >
> > > > >
> > > > > --
> > > > > Sean Paul, Software Engineer, Google / Chromium OS
