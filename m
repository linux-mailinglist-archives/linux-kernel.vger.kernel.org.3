Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089794E2748
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbiCUNN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347773AbiCUNNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:13:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3219C657B6;
        Mon, 21 Mar 2022 06:12:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so15364600pfh.8;
        Mon, 21 Mar 2022 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mEohOEa4Z3YAP5XexYCCbZz+gLzcw6SRQ1GP+Rej68Q=;
        b=MzB/0uANJBEzKT8Jth8tKtlNHY6ErC3WAqCY4nic7AOcrIarxPW3B/FVaYLwM7AJAx
         0daY0el8h98WxxSC2GwjQZiBP/pafbjJKOSLUxBa/ICHoNKAfCFqGr+uPvXPNq0erid2
         KmvBkXYJF7LLigcU4Tbq+isEYa2X8qExugiHx68fZSCZHR07+dyLKqLeskza+4PmOsCo
         MEPTy8UnNdpZtNt1Jvc2KNzOOBZEbDmjBrWQ8ee42J1s8y6ADeh/nY3CoJOQ4IDRk35K
         nmZGu4IEloLqCTzZaGAYtg0+Mebv5dkm+TvchRN9rdKGg0CKagO42SFEeBApblNE4cO5
         178w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mEohOEa4Z3YAP5XexYCCbZz+gLzcw6SRQ1GP+Rej68Q=;
        b=qFycHH0EUBLl69X4eQcd4yYT2nUv52I7KP7nmiuzJABbxm1SHHyVodV+bYrOIJazj1
         pABF9l+8rbNXqkrGfgWnb0MckbLfyGHgkmmStBLoa7+X1oA5r78Zx8PdX0fRpdHPl2or
         C7w4lU6Iy3nsrnLFRCcUGAgPN5nZQ79Ya18ly6riYp9KfP0TmyusfHZsmMBiInorCKkd
         Rkj/TJIW7WcNnXI3rjUor09fzcezmc6rVkwegHNbkFiNCsRFJIAmCBnC7bj/UJlwVY8U
         E735nMH4vyarS6CHfUqrD6hj3iD0uvm9ndb4mIyzE/x2h5yPXxnXqoOlqq642SznEZ96
         GIEw==
X-Gm-Message-State: AOAM532aHopiu5JE5QaiBATkOXP5upWQKTkyybzqVkuxdarzoreJTlhc
        I9gE5WWsbgNgXGu3vp51srhokjAJiPO2beoO7+I=
X-Google-Smtp-Source: ABdhPJwl8G9oRmj3N217o3SVJs7VpI4fVP6vZmjtJfii7jsKzpcDrZ+TUHrJHmClEgK6jTrHv6jwZwMlKwwfvAVdCog=
X-Received: by 2002:a05:6a00:23d1:b0:4f7:109d:a1c1 with SMTP id
 g17-20020a056a0023d100b004f7109da1c1mr24145314pfc.2.1647868342518; Mon, 21
 Mar 2022 06:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220301153122.20660-1-cbranchereau@gmail.com>
 <20220301153122.20660-4-cbranchereau@gmail.com> <VM548R.0I9BAN681OS83@crapouillou.net>
 <CAFsFa85Wb7HcxCqGCYQoSOHOTLJY9xtUHc85PoxO3XTbr=HN4g@mail.gmail.com> <736R8R.46MVQ2VHV6IY1@crapouillou.net>
In-Reply-To: <736R8R.46MVQ2VHV6IY1@crapouillou.net>
From:   Christophe Branchereau <cbranchereau@gmail.com>
Date:   Mon, 21 Mar 2022 14:12:10 +0100
Message-ID: <CAFsFa87U2REBB=W6c4yy5Y3u1nmPHoKY3_vn31tkM+7PZt1Omw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/panel : innolux-ej030na and abt-y030xx067a :
 add .enable and .disable
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, yes that works fine, thanks for checking it out

On Mon, Mar 14, 2022 at 9:54 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Christophe,
>
> Le lun., mars 7 2022 at 19:12:49 +0100, Christophe Branchereau
> <cbranchereau@gmail.com> a =C3=A9crit :
> > Hi Paul, it should in theory, but doesn't work in practice, the
> > display doesn't like having that bit set outside of the init sequence.
> >
> > Feel free to experiment if you think you can make it work though, you
> > should have that panel on 1 or 2 devices I think.
>
> It does actually work in practice; what probably fails for you is the
> regmap_set_bits(), which causes a spi-read-then-write. Since AFAIK it
> is not possible to read registers from this panel (only write), then
> this does not work.
>
> An easy fix would be to just use REGCACHE_FLAT as the cache type in the
> regmap_config. Then regmap_set_bits() can be used.
>
> Cheers,
> -Paul
>
> >
> > KR
> > CB
> >
> > On Wed, Mar 2, 2022 at 12:22 PM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>
> >>  Hi Christophe,
> >>
> >>  Le mar., mars 1 2022 at 16:31:22 +0100, Christophe Branchereau
> >>  <cbranchereau@gmail.com> a =C3=A9crit :
> >>  > Following the introduction of bridge_atomic_enable in the ingenic
> >>  > drm driver, the crtc is enabled between .prepare and .enable, if
> >>  > it exists.
> >>  >
> >>  > Add it so the backlight is only enabled after the crtc is, to
> >> avoid
> >>  > graphical issues.
> >>  >
> >>  > Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> >>  > ---
> >>  >  drivers/gpu/drm/panel/panel-abt-y030xx067a.c  | 23 ++++++++++++--
> >>  >  drivers/gpu/drm/panel/panel-innolux-ej030na.c | 31
> >>  > ++++++++++++++++---
> >>  >  2 files changed, 48 insertions(+), 6 deletions(-)
> >>  >
> >>  > diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> >>  > b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> >>  > index f043b484055b..b5736344e3ec 100644
> >>  > --- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> >>  > +++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> >>  > @@ -183,8 +183,6 @@ static int y030xx067a_prepare(struct drm_panel
> >>  > *panel)
> >>  >               goto err_disable_regulator;
> >>  >       }
> >>  >
> >>  > -     msleep(120);
> >>  > -
> >>  >       return 0;
> >>  >
> >>  >  err_disable_regulator:
> >>  > @@ -202,6 +200,25 @@ static int y030xx067a_unprepare(struct
> >> drm_panel
> >>  > *panel)
> >>  >       return 0;
> >>  >  }
> >>  >
> >>  > +static int y030xx067a_enable(struct drm_panel *panel)
> >>  > +{
> >>  > +     if (panel->backlight) {
> >>  > +             /* Wait for the picture to be ready before enabling
> >> backlight */
> >>  > +             msleep(120);
> >>  > +     }
> >>  > +
> >>  > +     return 0;
> >>  > +}
> >>  > +
> >>  > +static int y030xx067a_disable(struct drm_panel *panel)
> >>  > +{
> >>  > +     struct y030xx067a *priv =3D to_y030xx067a(panel);
> >>  > +
> >>  > +     regmap_clear_bits(priv->map, 0x06, REG06_XPSAVE);
> >>
> >>  Shouldn't that be balanced by a regmap_set_bits() in the .enable()
> >>  function?
> >>
> >>  Cheers,
> >>  -Paul
> >>
> >>  > +
> >>  > +     return 0;
> >>  > +}
> >>  > +
> >>  >  static int y030xx067a_get_modes(struct drm_panel *panel,
> >>  >                               struct drm_connector *connector)
> >>  >  {
> >>  > @@ -239,6 +256,8 @@ static int y030xx067a_get_modes(struct
> >> drm_panel
> >>  > *panel,
> >>  >  static const struct drm_panel_funcs y030xx067a_funcs =3D {
> >>  >       .prepare        =3D y030xx067a_prepare,
> >>  >       .unprepare      =3D y030xx067a_unprepare,
> >>  > +     .enable         =3D y030xx067a_enable,
> >>  > +     .disable        =3D y030xx067a_disable,
> >>  >       .get_modes      =3D y030xx067a_get_modes,
> >>  >  };
> >>  >
> >>  > diff --git a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> >>  > b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> >>  > index c558de3f99be..6de7370185cd 100644
> >>  > --- a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> >>  > +++ b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> >>  > @@ -80,8 +80,6 @@ static const struct reg_sequence
> >>  > ej030na_init_sequence[] =3D {
> >>  >       { 0x47, 0x08 },
> >>  >       { 0x48, 0x0f },
> >>  >       { 0x49, 0x0f },
> >>  > -
> >>  > -     { 0x2b, 0x01 },
> >>  >  };
> >>  >
> >>  >  static int ej030na_prepare(struct drm_panel *panel)
> >>  > @@ -109,8 +107,6 @@ static int ej030na_prepare(struct drm_panel
> >>  > *panel)
> >>  >               goto err_disable_regulator;
> >>  >       }
> >>  >
> >>  > -     msleep(120);
> >>  > -
> >>  >       return 0;
> >>  >
> >>  >  err_disable_regulator:
> >>  > @@ -128,6 +124,31 @@ static int ej030na_unprepare(struct drm_panel
> >>  > *panel)
> >>  >       return 0;
> >>  >  }
> >>  >
> >>  > +static int ej030na_enable(struct drm_panel *panel)
> >>  > +{
> >>  > +     struct ej030na *priv =3D to_ej030na(panel);
> >>  > +
> >>  > +     /* standby off */
> >>  > +     regmap_write(priv->map, 0x2b, 0x01);
> >>  > +
> >>  > +     if (panel->backlight) {
> >>  > +             /* Wait for the picture to be ready before enabling
> >> backlight */
> >>  > +             msleep(120);
> >>  > +     }
> >>  > +
> >>  > +     return 0;
> >>  > +}
> >>  > +
> >>  > +static int ej030na_disable(struct drm_panel *panel)
> >>  > +{
> >>  > +     struct ej030na *priv =3D to_ej030na(panel);
> >>  > +
> >>  > +     /* standby on */
> >>  > +     regmap_write(priv->map, 0x2b, 0x00);
> >>  > +
> >>  > +     return 0;
> >>  > +}
> >>  > +
> >>  >  static int ej030na_get_modes(struct drm_panel *panel,
> >>  >                            struct drm_connector *connector)
> >>  >  {
> >>  > @@ -165,6 +186,8 @@ static int ej030na_get_modes(struct drm_panel
> >>  > *panel,
> >>  >  static const struct drm_panel_funcs ej030na_funcs =3D {
> >>  >       .prepare        =3D ej030na_prepare,
> >>  >       .unprepare      =3D ej030na_unprepare,
> >>  > +     .enable         =3D ej030na_enable,
> >>  > +     .disable        =3D ej030na_disable,
> >>  >       .get_modes      =3D ej030na_get_modes,
> >>  >  };
> >>  >
> >>  > --
> >>  > 2.34.1
> >>  >
> >>
> >>
>
>
