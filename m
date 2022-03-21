Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E354F4E2B03
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349523AbiCUOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349462AbiCUOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:41:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5281890F4;
        Mon, 21 Mar 2022 07:39:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t2so15578417pfj.10;
        Mon, 21 Mar 2022 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=otEtZcU6MdpaBuEDZA9J3R3n8hjTa/J/6ZnkgJ1OboU=;
        b=dynQS1StUd8M+YLBvJbW1baAzNtE1ZWcmhSLV2F4BKkMHSYUQo9CzXJBxNklp7T7zF
         sUTGMf4kr2QZ+wZkJ62YrluqEKVw042Xu/IH5TRSRXbol5MCGoj484bR7TKt3bjNS+Ps
         rn3ht4jMcXD9OiMn7P19ESPQVKpYskydNUnWNY2HTGWNTG2NfjTzJvKjS3NK4rfd6YtQ
         Rf0LZbGPW+UwOvaTj4lJSyp460rqGr3TslK5zcpCn9c5i52d1pkChG179t86eHKbyAuv
         6bw1g55ZL3tPGm8xQk+grnj0OnI0zkr5cDYlEs+CjWnhGiro04vw3ezzyTIBm+D0NDXk
         bmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=otEtZcU6MdpaBuEDZA9J3R3n8hjTa/J/6ZnkgJ1OboU=;
        b=4xjgK793TJVc1wFbbxSvq1Z7cNWoqFL9AW7q55dgQ5M+lWKZZ9c+W7Bf87bkW7ds6X
         Ymmavnboc2fHNldY26ngBSC5xnBeeZ8u6UG+D6r8AoAxPsh9d5Xb7wOAERRV3T40jaCK
         DVY52WXR4Y9ep0lJdh1VhjxkehLrs1zBv8wKGypBgGjalcJmqnqc3zoRkHrb/YDEYsSu
         oDfcwcZi2o9xFe8kBc+MfHEh/tpgYX5Qqi3bKRwQSm+hoMpPG+ReqwzOnQyZpZPgF4HU
         l1Tqd2blX8GDtyPqjA626kp5Ihfpn68iT/doPsbyQfgRq9uD2vggDpSCsLYzEw81+LLh
         80TQ==
X-Gm-Message-State: AOAM533eUttaWaZo5pw10SdOJyORdRnLueUEgvhUtrX+oJvxDOzupq9O
        nhQAei/GUI2OwKdV/D4wfbsQMI1T8dnyMXVuIco=
X-Google-Smtp-Source: ABdhPJzt1jDFcRgvlEDBWJcGiWHbLWxR0X41mnznthjFPoZLD9uxyCOETKWi4zF8ymcspL5dNWDpejVEQCZj2iNBlGs=
X-Received: by 2002:a63:68c8:0:b0:380:3fbd:2ec9 with SMTP id
 d191-20020a6368c8000000b003803fbd2ec9mr18207249pgc.608.1647873574355; Mon, 21
 Mar 2022 07:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220321133651.291592-1-cbranchereau@gmail.com>
 <20220321133651.291592-4-cbranchereau@gmail.com> <GJM39R.I3L8ZIKHOJ252@crapouillou.net>
In-Reply-To: <GJM39R.I3L8ZIKHOJ252@crapouillou.net>
From:   Christophe Branchereau <cbranchereau@gmail.com>
Date:   Mon, 21 Mar 2022 15:39:23 +0100
Message-ID: <CAFsFa85Rcxh7G-X9zygHdAaca2nydUXxGfE2Vgcx_nzqgQZVgw@mail.gmail.com>
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

Following the introduction of bridge_atomic_enable in the ingenic
drm driver, the crtc is enabled between .prepare and .enable, if
it exists. Add it so the backlight is only enabled after the crtc is, to
avoid graphical issues.

As we're moving the "sleep in" command out of the init sequence
into .enable for the ABT, we need to switch the regmap cache
to REGCACHE_FLAT to be able to use regmap_set_bits, given this
panel registers are write-ony and read as 0.

On Mon, Mar 21, 2022 at 3:21 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Christophe,
>
> Le lun., mars 21 2022 at 14:36:51 +0100, Christophe Branchereau
> <cbranchereau@gmail.com> a =C3=A9crit :
> > Following the introduction of bridge_atomic_enable in the ingenic
> > drm driver, the crtc is enabled between .prepare and .enable, if
> > it exists.
> >
> > Add it so the backlight is only enabled after the crtc is, to avoid
> > graphical issues.
> >
> > Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
>
> Didn't Sam acked it?
>
> > ---
> >  drivers/gpu/drm/panel/panel-abt-y030xx067a.c  | 31
> > +++++++++++++++++--
> >  drivers/gpu/drm/panel/panel-innolux-ej030na.c | 31
> > ++++++++++++++++---
> >  2 files changed, 55 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > index f043b484055b..ddfacaeac1d4 100644
> > --- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > +++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > @@ -140,7 +140,7 @@ static const struct reg_sequence
> > y030xx067a_init_sequence[] =3D {
> >       { 0x03, REG03_VPOSITION(0x0a) },
> >       { 0x04, REG04_HPOSITION1(0xd2) },
> >       { 0x05, REG05_CLIP | REG05_NVM_VREFRESH | REG05_SLBRCHARGE(0x2) }=
,
> > -     { 0x06, REG06_XPSAVE | REG06_NT },
> > +     { 0x06, REG06_NT },
> >       { 0x07, 0 },
> >       { 0x08, REG08_PANEL(0x1) | REG08_CLOCK_DIV(0x2) },
> >       { 0x09, REG09_SUB_BRIGHT_R(0x20) },
> > @@ -183,8 +183,6 @@ static int y030xx067a_prepare(struct drm_panel
> > *panel)
> >               goto err_disable_regulator;
> >       }
> >
> > -     msleep(120);
> > -
> >       return 0;
> >
> >  err_disable_regulator:
> > @@ -202,6 +200,30 @@ static int y030xx067a_unprepare(struct drm_panel
> > *panel)
> >       return 0;
> >  }
> >
> > +static int y030xx067a_enable(struct drm_panel *panel)
> > +{
> > +
> > +     struct y030xx067a *priv =3D to_y030xx067a(panel);
> > +
> > +     regmap_set_bits(priv->map, 0x06, REG06_XPSAVE);
> > +
> > +     if (panel->backlight) {
> > +             /* Wait for the picture to be ready before enabling backl=
ight */
> > +             msleep(120);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int y030xx067a_disable(struct drm_panel *panel)
> > +{
> > +     struct y030xx067a *priv =3D to_y030xx067a(panel);
> > +
> > +     regmap_clear_bits(priv->map, 0x06, REG06_XPSAVE);
> > +
> > +     return 0;
> > +}
> > +
> >  static int y030xx067a_get_modes(struct drm_panel *panel,
> >                               struct drm_connector *connector)
> >  {
> > @@ -239,6 +261,8 @@ static int y030xx067a_get_modes(struct drm_panel
> > *panel,
> >  static const struct drm_panel_funcs y030xx067a_funcs =3D {
> >       .prepare        =3D y030xx067a_prepare,
> >       .unprepare      =3D y030xx067a_unprepare,
> > +     .enable         =3D y030xx067a_enable,
> > +     .disable        =3D y030xx067a_disable,
> >       .get_modes      =3D y030xx067a_get_modes,
> >  };
> >
> > @@ -246,6 +270,7 @@ static const struct regmap_config
> > y030xx067a_regmap_config =3D {
> >       .reg_bits =3D 8,
> >       .val_bits =3D 8,
> >       .max_register =3D 0x15,
> > +     .cache_type =3D REGCACHE_FLAT,
>
> I understand that this is added because the panel registers are
> write-only and read as zero, and it is needed for
> regmap_{clear,set}_bits to work.
>
> This information should definitely be added to the commit message.
>
> If you can add it inline here, and I'll update the commit message when
> applying the patch.
>
> Cheers,
> -Paul
>
> >  };
> >
> >  static int y030xx067a_probe(struct spi_device *spi)
> > diff --git a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > index c558de3f99be..6de7370185cd 100644
> > --- a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > +++ b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > @@ -80,8 +80,6 @@ static const struct reg_sequence
> > ej030na_init_sequence[] =3D {
> >       { 0x47, 0x08 },
> >       { 0x48, 0x0f },
> >       { 0x49, 0x0f },
> > -
> > -     { 0x2b, 0x01 },
> >  };
> >
> >  static int ej030na_prepare(struct drm_panel *panel)
> > @@ -109,8 +107,6 @@ static int ej030na_prepare(struct drm_panel
> > *panel)
> >               goto err_disable_regulator;
> >       }
> >
> > -     msleep(120);
> > -
> >       return 0;
> >
> >  err_disable_regulator:
> > @@ -128,6 +124,31 @@ static int ej030na_unprepare(struct drm_panel
> > *panel)
> >       return 0;
> >  }
> >
> > +static int ej030na_enable(struct drm_panel *panel)
> > +{
> > +     struct ej030na *priv =3D to_ej030na(panel);
> > +
> > +     /* standby off */
> > +     regmap_write(priv->map, 0x2b, 0x01);
> > +
> > +     if (panel->backlight) {
> > +             /* Wait for the picture to be ready before enabling backl=
ight */
> > +             msleep(120);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ej030na_disable(struct drm_panel *panel)
> > +{
> > +     struct ej030na *priv =3D to_ej030na(panel);
> > +
> > +     /* standby on */
> > +     regmap_write(priv->map, 0x2b, 0x00);
> > +
> > +     return 0;
> > +}
> > +
> >  static int ej030na_get_modes(struct drm_panel *panel,
> >                            struct drm_connector *connector)
> >  {
> > @@ -165,6 +186,8 @@ static int ej030na_get_modes(struct drm_panel
> > *panel,
> >  static const struct drm_panel_funcs ej030na_funcs =3D {
> >       .prepare        =3D ej030na_prepare,
> >       .unprepare      =3D ej030na_unprepare,
> > +     .enable         =3D ej030na_enable,
> > +     .disable        =3D ej030na_disable,
> >       .get_modes      =3D ej030na_get_modes,
> >  };
> >
> > --
> > 2.35.1
> >
>
>
