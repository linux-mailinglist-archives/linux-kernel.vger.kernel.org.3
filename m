Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2A4E2B10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345058AbiCUOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349508AbiCUOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:43:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23518BCFB;
        Mon, 21 Mar 2022 07:42:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d18so12928381plr.6;
        Mon, 21 Mar 2022 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=itwmKt5D3YRmhePmZfG4X/rjRFYViLaVcU1Zd/ou0pM=;
        b=Iy48cvT2SJoI0Y2J0k4o97AvhdQ6RHEcwKzzsgUzHhYvya6G44v/Caw2bM8uP8GX+4
         lQRwewSNc9UnV7jx4cO6kzOEUmoHGQBA4MI4oDPDgXyVYI38gLc3l1m9VfabR62V3Fgf
         k8XUmyQ8CmaVnixy35W5nGFRfk53nRLsxMhO6rJn16+voNEn4F+VqjJ6IRaAj3cdPhj/
         zD4+/5lYyHUsekI/K140bl4UG+fzVFzPAgkkguvGfOyvqt6msKeh2FA9l/muaqYeJEsg
         aWPGa/bLsPwbYsdpgvRPOQMx499QvSTtcLkL8bziZpID6c1qR2tGjjTb4SeJEgL7Sipo
         hEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=itwmKt5D3YRmhePmZfG4X/rjRFYViLaVcU1Zd/ou0pM=;
        b=ZBgiZRTvrxe3J2uzUYnQiu8a7onhjGzA2fDCAxkYavwYpo622oDUMl232dx2sqIFMe
         1FxQPnk1UjZrNsUXiLXXRACULIdnk4VL8Yaw605cQDYyo0fOPTroFi86jfecXZL+YS8K
         /o4Gr4gWQJ43R9SfbxehMAEwKcdCq+8nh03R8jrL3LUDL9cW0cdfYkpA41V8cC0OjVvj
         KPTnJoLGzRFQ1znF40M7+bF4BgHWW7Gbh3VifQRni5a1Dc4ru+i4MwW00AjPl2ZIWy1B
         KZ237evlrtLrmY2CnsxaU5uF1o4/xOMHRdyZMqztVfAvMqAGFNlgRQ/x98b0QDhQg65F
         pEcg==
X-Gm-Message-State: AOAM533g1WUlKggo2J0jBq/Aj53qxkkDD1SN7sYG7H55q+JFjG3Mu6vM
        DeW6txIe8ZC5eOjDaaJ6azqIlaxctlrfboIbHPE=
X-Google-Smtp-Source: ABdhPJyBnbo/UgxXqMV8gAY32qIJY6RHi9yPSeHqk0GIu5ekRfhkzA4VaeBXM8z2kz7ftDIR1xkMsAdLb/iUTjzJGYU=
X-Received: by 2002:a17:90a:7e8b:b0:1be:ef6c:9797 with SMTP id
 j11-20020a17090a7e8b00b001beef6c9797mr36644729pjl.183.1647873739850; Mon, 21
 Mar 2022 07:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220321133651.291592-1-cbranchereau@gmail.com>
 <20220321133651.291592-4-cbranchereau@gmail.com> <GJM39R.I3L8ZIKHOJ252@crapouillou.net>
 <CAFsFa85Rcxh7G-X9zygHdAaca2nydUXxGfE2Vgcx_nzqgQZVgw@mail.gmail.com>
In-Reply-To: <CAFsFa85Rcxh7G-X9zygHdAaca2nydUXxGfE2Vgcx_nzqgQZVgw@mail.gmail.com>
From:   Christophe Branchereau <cbranchereau@gmail.com>
Date:   Mon, 21 Mar 2022 15:42:08 +0100
Message-ID: <CAFsFa85P8V-yePR5LTLjn57GCoqJJYn5pX6WNdp+a+G23XEbSg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] drm/panel : innolux-ej030na and abt-y030xx067a :
 add .enable and .disable
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
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

Sorry I meant "sleep out" not "sleep in" obviously

On Mon, Mar 21, 2022 at 3:39 PM Christophe Branchereau
<cbranchereau@gmail.com> wrote:
>
> Following the introduction of bridge_atomic_enable in the ingenic
> drm driver, the crtc is enabled between .prepare and .enable, if
> it exists. Add it so the backlight is only enabled after the crtc is, to
> avoid graphical issues.
>
> As we're moving the "sleep in" command out of the init sequence
> into .enable for the ABT, we need to switch the regmap cache
> to REGCACHE_FLAT to be able to use regmap_set_bits, given this
> panel registers are write-ony and read as 0.
>
> On Mon, Mar 21, 2022 at 3:21 PM Paul Cercueil <paul@crapouillou.net> wrot=
e:
> >
> > Hi Christophe,
> >
> > Le lun., mars 21 2022 at 14:36:51 +0100, Christophe Branchereau
> > <cbranchereau@gmail.com> a =C3=A9crit :
> > > Following the introduction of bridge_atomic_enable in the ingenic
> > > drm driver, the crtc is enabled between .prepare and .enable, if
> > > it exists.
> > >
> > > Add it so the backlight is only enabled after the crtc is, to avoid
> > > graphical issues.
> > >
> > > Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> >
> > Didn't Sam acked it?
> >
> > > ---
> > >  drivers/gpu/drm/panel/panel-abt-y030xx067a.c  | 31
> > > +++++++++++++++++--
> > >  drivers/gpu/drm/panel/panel-innolux-ej030na.c | 31
> > > ++++++++++++++++---
> > >  2 files changed, 55 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > > b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > > index f043b484055b..ddfacaeac1d4 100644
> > > --- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > > +++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > > @@ -140,7 +140,7 @@ static const struct reg_sequence
> > > y030xx067a_init_sequence[] =3D {
> > >       { 0x03, REG03_VPOSITION(0x0a) },
> > >       { 0x04, REG04_HPOSITION1(0xd2) },
> > >       { 0x05, REG05_CLIP | REG05_NVM_VREFRESH | REG05_SLBRCHARGE(0x2)=
 },
> > > -     { 0x06, REG06_XPSAVE | REG06_NT },
> > > +     { 0x06, REG06_NT },
> > >       { 0x07, 0 },
> > >       { 0x08, REG08_PANEL(0x1) | REG08_CLOCK_DIV(0x2) },
> > >       { 0x09, REG09_SUB_BRIGHT_R(0x20) },
> > > @@ -183,8 +183,6 @@ static int y030xx067a_prepare(struct drm_panel
> > > *panel)
> > >               goto err_disable_regulator;
> > >       }
> > >
> > > -     msleep(120);
> > > -
> > >       return 0;
> > >
> > >  err_disable_regulator:
> > > @@ -202,6 +200,30 @@ static int y030xx067a_unprepare(struct drm_panel
> > > *panel)
> > >       return 0;
> > >  }
> > >
> > > +static int y030xx067a_enable(struct drm_panel *panel)
> > > +{
> > > +
> > > +     struct y030xx067a *priv =3D to_y030xx067a(panel);
> > > +
> > > +     regmap_set_bits(priv->map, 0x06, REG06_XPSAVE);
> > > +
> > > +     if (panel->backlight) {
> > > +             /* Wait for the picture to be ready before enabling bac=
klight */
> > > +             msleep(120);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int y030xx067a_disable(struct drm_panel *panel)
> > > +{
> > > +     struct y030xx067a *priv =3D to_y030xx067a(panel);
> > > +
> > > +     regmap_clear_bits(priv->map, 0x06, REG06_XPSAVE);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int y030xx067a_get_modes(struct drm_panel *panel,
> > >                               struct drm_connector *connector)
> > >  {
> > > @@ -239,6 +261,8 @@ static int y030xx067a_get_modes(struct drm_panel
> > > *panel,
> > >  static const struct drm_panel_funcs y030xx067a_funcs =3D {
> > >       .prepare        =3D y030xx067a_prepare,
> > >       .unprepare      =3D y030xx067a_unprepare,
> > > +     .enable         =3D y030xx067a_enable,
> > > +     .disable        =3D y030xx067a_disable,
> > >       .get_modes      =3D y030xx067a_get_modes,
> > >  };
> > >
> > > @@ -246,6 +270,7 @@ static const struct regmap_config
> > > y030xx067a_regmap_config =3D {
> > >       .reg_bits =3D 8,
> > >       .val_bits =3D 8,
> > >       .max_register =3D 0x15,
> > > +     .cache_type =3D REGCACHE_FLAT,
> >
> > I understand that this is added because the panel registers are
> > write-only and read as zero, and it is needed for
> > regmap_{clear,set}_bits to work.
> >
> > This information should definitely be added to the commit message.
> >
> > If you can add it inline here, and I'll update the commit message when
> > applying the patch.
> >
> > Cheers,
> > -Paul
> >
> > >  };
> > >
> > >  static int y030xx067a_probe(struct spi_device *spi)
> > > diff --git a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > > b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > > index c558de3f99be..6de7370185cd 100644
> > > --- a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > > +++ b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > > @@ -80,8 +80,6 @@ static const struct reg_sequence
> > > ej030na_init_sequence[] =3D {
> > >       { 0x47, 0x08 },
> > >       { 0x48, 0x0f },
> > >       { 0x49, 0x0f },
> > > -
> > > -     { 0x2b, 0x01 },
> > >  };
> > >
> > >  static int ej030na_prepare(struct drm_panel *panel)
> > > @@ -109,8 +107,6 @@ static int ej030na_prepare(struct drm_panel
> > > *panel)
> > >               goto err_disable_regulator;
> > >       }
> > >
> > > -     msleep(120);
> > > -
> > >       return 0;
> > >
> > >  err_disable_regulator:
> > > @@ -128,6 +124,31 @@ static int ej030na_unprepare(struct drm_panel
> > > *panel)
> > >       return 0;
> > >  }
> > >
> > > +static int ej030na_enable(struct drm_panel *panel)
> > > +{
> > > +     struct ej030na *priv =3D to_ej030na(panel);
> > > +
> > > +     /* standby off */
> > > +     regmap_write(priv->map, 0x2b, 0x01);
> > > +
> > > +     if (panel->backlight) {
> > > +             /* Wait for the picture to be ready before enabling bac=
klight */
> > > +             msleep(120);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int ej030na_disable(struct drm_panel *panel)
> > > +{
> > > +     struct ej030na *priv =3D to_ej030na(panel);
> > > +
> > > +     /* standby on */
> > > +     regmap_write(priv->map, 0x2b, 0x00);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int ej030na_get_modes(struct drm_panel *panel,
> > >                            struct drm_connector *connector)
> > >  {
> > > @@ -165,6 +186,8 @@ static int ej030na_get_modes(struct drm_panel
> > > *panel,
> > >  static const struct drm_panel_funcs ej030na_funcs =3D {
> > >       .prepare        =3D ej030na_prepare,
> > >       .unprepare      =3D ej030na_unprepare,
> > > +     .enable         =3D ej030na_enable,
> > > +     .disable        =3D ej030na_disable,
> > >       .get_modes      =3D ej030na_get_modes,
> > >  };
> > >
> > > --
> > > 2.35.1
> > >
> >
> >
