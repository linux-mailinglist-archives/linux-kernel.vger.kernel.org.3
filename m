Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E7E524359
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbiELDXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbiELDXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:23:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7424157140;
        Wed, 11 May 2022 20:22:57 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id bq30so6795718lfb.3;
        Wed, 11 May 2022 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vDxPRNJ47MRH72+7zGqfBM9QHNeqbDBoxMkpFljWCrs=;
        b=T8BHKRSYIB6UI/eYY/8Qxf12CdDAjFFoO8zYHLFKzc+mSy4NMfGJC2b6J/LIC8W2XE
         Kq69Fs+Cbc6nyCDuK2215tVt5ob16Y/qVaSrJsdxFLOl/XtZ+6XIuaxBSc28MI3nHfeU
         GdEwjfhfho8k5KT6vPbP5HsMrobEIhdRQdl75m1Nqxix5LiZb1OXkMxENaQQu5RG5KUo
         w/8p42yvZ9WUOnz1OQi7VzVVVqkMz1lk5IKQ2f7m1bYcNUA4ahu00u7xGFeiT7aXdaXP
         kzWEJ9eWr9On/8CdafqLWKZaqF88acFUsUMMKQWsrm6Mb+/JnlhDaIrvSlST98qp1TMM
         K5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vDxPRNJ47MRH72+7zGqfBM9QHNeqbDBoxMkpFljWCrs=;
        b=BM3Zl0WMwQxBIkzxlWW2DyXFaiGj1ga7k9GhQ6GgUTUHtl8AryB7hQZw+lSvnyjWhZ
         EN5OIN8OAicr6TTA32LcR+pIuCEdNYj3F2C3QYkT8x2l8PAGLwyreBlrrA2ZNb5I7tum
         xNmeCQF3vEP/xINIz6Q5tED/LoVpsI2Df/B5RIGblpFcw8eZULRqILmxaUKoRJd/oL9g
         8wwdauNEXrtX01ZiAVFdjrwRjl7fPEbOvtgqy5sFDcvposWf5QFcasmEyvHpLdSUZFfW
         ReM13kpwm1vFZPM4bbYYydC8RA8vMrWssvStVCVK8eTb6j/0Uxy6KmDG1E7ODeh6qWpL
         fiIg==
X-Gm-Message-State: AOAM533mjszhKA5Gr7SK9eU+6NdOxHoxyoS/2jWQMDIfAR8ZhZBbIVyc
        XrSipIl5rMJN+5jxAFtOig8kwice0beXyIPWsRY=
X-Google-Smtp-Source: ABdhPJz5hhErvKjwfwdhA9nvvhAPbAbGLTwzikSLQ8u7BMgmCnvyTgA+xfu2/v0a9U5V1f6g9n/5j+ZnFUXk44/i4ns=
X-Received: by 2002:a05:6512:16a2:b0:448:1fbb:8ca1 with SMTP id
 bu34-20020a05651216a200b004481fbb8ca1mr22116326lfb.125.1652325775668; Wed, 11
 May 2022 20:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220428125610.66647-1-gengcixi@gmail.com> <CADBw62r8eGRNcXH1cAZvYQdKCgBjxUVnxhLsa=Oyzs-uwavRTA@mail.gmail.com>
In-Reply-To: <CADBw62r8eGRNcXH1cAZvYQdKCgBjxUVnxhLsa=Oyzs-uwavRTA@mail.gmail.com>
From:   =?UTF-8?B?6ZmI5rC45b+X?= <chenyongzhi811@gmail.com>
Date:   Thu, 12 May 2022 11:22:44 +0800
Message-ID: <CAJejCsY+DX0JywDS_dk=1P-fvyjUc4i1e67uM_WW64E3YVvzQg@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: Add enable the primary charger interface
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Cixi Geng <gengcixi@gmail.com>, Sebastian Reichel <sre@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=8C 12:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Apr 28, 2022 at 8:56 PM Cixi Geng <gengcixi@gmail.com> wrote:
> >
> > From: Chen Yongzhi <Yongzhi.Chen@unisoc.com>
> >
> > In the case of charging multiple charging ICs,the primary
> > charging IC often needs to be turned off in the fast
> > charging stage, and only using the charger pump to charge,
> > need to add a new power_supply_property attribute.
>
> I'm still confused why introducing a new
> POWER_SUPPLY_PROP_CHARGE_ENABLED property to control the charging, but
> you already controlled the charging by POWER_SUPPLY_PROP_STATUS?
>
Our purpose is to achieve two different stop charging states:
POWER_SUPPLY_PROP_STATUS: The software status stops charging, and the
hardware also stops charging=EF=BC=9B
POWER_SUPPLY_PROP_CHARGE_ENABLED: The hardware is stopped charging,
the software is still charging=EF=BC=9B
  Our  don't want to change the charge_status switch due to the
switching of charging and discharging of the charging IC in the
charging scenario of multiple charging ICs, and let the upper layer
perceive this switching
> >
> > Signed-off-by: Chen Yongzhi <Yongzhi.Chen@unisoc.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/all/202204230206.9TgyhSb1-lkp@intel.com
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/power/supply/sc2731_charger.c | 52 +++++++++++++++++++++++++--
> >  include/linux/power_supply.h          |  1 +
> >  2 files changed, 50 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supp=
ly/sc2731_charger.c
> > index 9ac17cf7a126..c15f9b75e6a8 100644
> > --- a/drivers/power/supply/sc2731_charger.c
> > +++ b/drivers/power/supply/sc2731_charger.c
> > @@ -1,5 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -// Copyright (C) 2018 Spreadtrum Communications Inc.
> > +// Copyright (C) 2022 Spreadtrum Communications Inc.
>
> Do not add unrelated changes.
>
  ok, do not change
> >
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> > @@ -146,6 +146,24 @@ static int sc2731_charger_get_status(struct sc2731=
_charger_info *info)
> >         return POWER_SUPPLY_STATUS_CHARGING;
> >  }
> >
> > +static int sc2731_charger_set_status(struct sc2731_charger_info *info,=
 int val)
> > +{
> > +       int ret =3D 0;
> > +
> > +       if (!val && info->charging) {
> > +               sc2731_charger_stop_charge(info);
> > +               info->charging =3D false;
> > +       } else if (val && !info->charging) {
> > +               ret =3D sc2731_charger_start_charge(info);
> > +               if (ret)
> > +                       dev_err(info->dev, "start charge failed\n");
>
> Duplicate error information, since you already print errors in
   fix it
> sc2731_charger_usb_set_property()
>
> > +               else
> > +                       info->charging =3D true;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  static int sc2731_charger_get_current(struct sc2731_charger_info *info=
,
> >                                       u32 *cur)
> >  {
> > @@ -204,7 +222,7 @@ sc2731_charger_usb_set_property(struct power_supply=
 *psy,
> >                                 const union power_supply_propval *val)
> >  {
> >         struct sc2731_charger_info *info =3D power_supply_get_drvdata(p=
sy);
> > -       int ret;
> > +       int ret =3D 0;
> >
> >         mutex_lock(&info->lock);
> >
> > @@ -214,6 +232,12 @@ sc2731_charger_usb_set_property(struct power_suppl=
y *psy,
> >         }
> >
> >         switch (psp) {
> > +       case POWER_SUPPLY_PROP_STATUS:
> > +               ret =3D sc2731_charger_set_status(info, val->intval);
> > +               if (ret < 0)
> > +                       dev_err(info->dev, "set charge status failed\n"=
);
> > +               break;
> > +
> >         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> >                 ret =3D sc2731_charger_set_current(info, val->intval / =
1000);
> >                 if (ret < 0)
> > @@ -227,6 +251,15 @@ sc2731_charger_usb_set_property(struct power_suppl=
y *psy,
> >                         dev_err(info->dev, "set input current limit fai=
led\n");
> >                 break;
> >
> > +       case POWER_SUPPLY_PROP_CHARGE_ENABLED:
> > +               if (val->intval =3D=3D true) {
> > +                       ret =3D sc2731_charger_start_charge(info);
> > +                       if (ret)
> > +                               dev_err(info->dev, "start charge failed=
\n");
> > +               } else if (val->intval =3D=3D false) {
> > +                       sc2731_charger_stop_charge(info);
> > +               }
> > +               break;
> >         default:
> >                 ret =3D -EINVAL;
> >         }
> > @@ -241,7 +274,7 @@ static int sc2731_charger_usb_get_property(struct p=
ower_supply *psy,
> >  {
> >         struct sc2731_charger_info *info =3D power_supply_get_drvdata(p=
sy);
> >         int ret =3D 0;
> > -       u32 cur;
> > +       u32 cur, enabled;
> >
> >         mutex_lock(&info->lock);
> >
> > @@ -277,6 +310,16 @@ static int sc2731_charger_usb_get_property(struct =
power_supply *psy,
> >                 }
> >                 break;
> >
> > +       case POWER_SUPPLY_PROP_CHARGE_ENABLED:
> > +               ret =3D regmap_read(info->regmap, info->base + SC2731_C=
HG_CFG0, &enabled);
> > +               if (ret) {
> > +                       dev_err(info->dev, "get sc2731 charge enabled f=
ailed\n");
> > +                       goto out;
> > +               }
> > +
> > +               val->intval =3D enabled & SC2731_CHARGER_PD;
> > +
> > +               break;
> >         default:
> >                 ret =3D -EINVAL;
> >         }
> > @@ -292,8 +335,10 @@ static int sc2731_charger_property_is_writeable(st=
ruct power_supply *psy,
> >         int ret;
> >
> >         switch (psp) {
> > +       case POWER_SUPPLY_PROP_STATUS:
> >         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> >         case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> > +       case POWER_SUPPLY_PROP_CHARGE_ENABLED:
> >                 ret =3D 1;
> >                 break;
> >
> > @@ -308,6 +353,7 @@ static enum power_supply_property sc2731_usb_props[=
] =3D {
> >         POWER_SUPPLY_PROP_STATUS,
> >         POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> >         POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> > +       POWER_SUPPLY_PROP_CHARGE_ENABLED,
> >  };
> >
> >  static const struct power_supply_desc sc2731_charger_desc =3D {
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.=
h
> > index cb380c1d9459..1dfe194d8a5e 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -167,6 +167,7 @@ enum power_supply_property {
> >         POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> >         POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> >         POWER_SUPPLY_PROP_CALIBRATE,
> > +       POWER_SUPPLY_PROP_CHARGE_ENABLED,
> >         POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
> >         POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
> >         POWER_SUPPLY_PROP_MANUFACTURE_DAY,
> > --
> > 2.25.1
> >
>
>
> --
> Baolin Wang
