Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561AD58AA5D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbiHELyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiHELyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:54:18 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F67E5D0DD
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:54:16 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31e7ca45091so22048507b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 04:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B02RqxjBTQRs85a8gF2gLe9dL1JOQq3J4L0ycDQz7f4=;
        b=ECUBjQ6a3KqW1cyowmSgFitTkNeso0Ptc6F6gnpY6N5bqbTzGXPuJcI/pfHBU2BYGG
         7iUgbmsVaEJrs3RJuNxaMadfi+1iFQnDbL4PJ8FjroL22bN7bMNtzmxHslqP1RMmR257
         I7k9Tt+x6e2/Cx1n/EnZ1yR2O/CXu5PcOqI9rnlUt1AiqJqp+GgAr1PzA44lJK61HbKa
         W6D1uq7j4FWlUhlUF4DBHmg2hs/PskkOvgwqeCa25YKkXkvnVDh31JLE9jtk8YV8gFMV
         DXdJDBdg47uYSw9SPj6TwjWL97g6mwUHBr9xO2D2g8ULIUoBudCP4o7GDa2uitv0myvE
         Ejig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B02RqxjBTQRs85a8gF2gLe9dL1JOQq3J4L0ycDQz7f4=;
        b=nNZTrbzKserASC/yuht/kFiWd+JFg2GNANB9pyZ/qKQlL6/BLRGprlkRt1KgTQ3ZE0
         nF14IFcFfKkVXmVNOcvITXhF3ZTghOsIe+s1SUt+1vpPkzOMh7NMHd1H0bdh7Jk0mRXf
         +66t6i9GtKsZfYZoTvoe065Yc4UEb65KVQZDq2rFa6KxImBDWrXzgITrHEGJCVc9zplh
         j5seJjUyYqdIq/IASgtyL8ayhPOoCEE6VIhEk+UIiJjJllhvBzE1Gwu9ZHqV7YzhuwXo
         5xVGmUkFaGAAR5XG/t7Az8Xy6WhWOA/B4GuyhB82lA6giy8brVxjOXAhORs9+GcAx3uz
         +5jA==
X-Gm-Message-State: ACgBeo03YdE7j8EMfwv2p4Xbh3YAM60iOeP8I6N9h96TxxdpGyKZ0rWo
        XQ9vJ64byaYNgaAEfl1AP1vYm3plmA+XgqlXBuOXZw==
X-Google-Smtp-Source: AA6agR72QleJK186GhMdgMP/yTvyEphneAZ2QYvhg8nnZGfN+KY6QWW+tPlsHTl350LimpY/Cp8NATm/hRG1zpOFkm8=
X-Received: by 2002:a0d:e88e:0:b0:328:297a:fd9e with SMTP id
 r136-20020a0de88e000000b00328297afd9emr5960768ywe.88.1659700455699; Fri, 05
 Aug 2022 04:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220804130912.676043-1-bchihi@baylibre.com> <20220804130912.676043-2-bchihi@baylibre.com>
 <20220804230407.kwfsxy74qmmebfsj@notapiano>
In-Reply-To: <20220804230407.kwfsxy74qmmebfsj@notapiano>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 5 Aug 2022 13:53:39 +0200
Message-ID: <CAGuA+ornX-mt-kjYE9693PEYqCpQQGf=CdG1k4kwzaS4BBHxmg@mail.gmail.com>
Subject: Re: [PATCH v8.1, 1/7] thermal: mediatek: Relocate driver to mediatek folder
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 1:04 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Hi Balsam,
>
> On Thu, Aug 04, 2022 at 03:09:06PM +0200, bchihi@baylibre.com wrote:
> > From: Michael Kao <michael.kao@mediatek.com>
> >
> > Add MediaTek proprietary folder to upstream more thermal zone and coole=
r
> > drivers, relocate the original thermal controller driver to it, and ren=
ame it
> > as "mtxxxx_thermal.c" to show its purpose more clearly.
> >
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >  drivers/thermal/Kconfig                       | 14 ++++-------
> >  drivers/thermal/Makefile                      |  2 +-
> >  drivers/thermal/mediatek/Kconfig              | 23 +++++++++++++++++++
> >  drivers/thermal/mediatek/Makefile             |  1 +
> >  .../mtxxxx_thermal.c}                         |  2 +-
> >  5 files changed, 30 insertions(+), 12 deletions(-)
> >  create mode 100644 drivers/thermal/mediatek/Kconfig
> >  create mode 100644 drivers/thermal/mediatek/Makefile
> >  rename drivers/thermal/{mtk_thermal.c =3D> mediatek/mtxxxx_thermal.c} =
(99%)
> [..]
> > --- /dev/null
> > +++ b/drivers/thermal/mediatek/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_MTK_SOC_THERMAL)                +=3D mtxxxx_thermal.o
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mediatek/m=
txxxx_thermal.c
>
> When Daniel suggested using a more SoC explicit name like 'mtxxx_thermal'=
 [1]
> the xxxx was supposed to be substituted for the actual SoC (family) that =
makes
> use of this driver :-).
>
> From the compatibles looks like we have mt8173, mt2701, mt2712, mt7622, m=
t8183.
> So it doesn't look like it's a single SoC family... What about calling it
> auxadc_thermal?
>
> Thanks,
> N=C3=ADcolas

Hello N=C3=ADcolas,

"auxadc_thermal.c" makes more sense, since we have "lvts_thermal.c".
Thank you for the suggestion. I will take it.

Best regards,
Balsam

>
> [1] https://lore.kernel.org/linux-mediatek/24250d03-b25f-e521-5abd-f36109=
885c36@linaro.org/
>
> > similarity index 99%
> > rename from drivers/thermal/mtk_thermal.c
> > rename to drivers/thermal/mediatek/mtxxxx_thermal.c
> > index ede94eadddda..60924f8f98e9 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mediatek/mtxxxx_thermal.c
> > @@ -23,7 +23,7 @@
> >  #include <linux/reset.h>
> >  #include <linux/types.h>
> >
> > -#include "thermal_hwmon.h"
> > +#include "../thermal_hwmon.h"
> >
> >  /* AUXADC Registers */
> >  #define AUXADC_CON1_SET_V    0x008
> > --
> > 2.34.1
> >
> >
