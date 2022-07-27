Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A065822AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiG0JER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiG0JEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:04:14 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8E474CB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:04:13 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r3so29232671ybr.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2f3kh3jqi9yjSQzKeEhCTNVhq9kV2tSI6rer8mhvNI=;
        b=WjFzxSO2wJzIbJH4XkUpRb5mtLv5lM7tMqrUu61P+vX0mCZ/dxyDFrjHgg+qBFmghP
         nfGkL9gbS4Vwnuud/OmpQCyB0dChfNXSYl32JihYvnsBaCCarUtHOOga4p4XSzpQttS6
         tzpx1dwoudB1NWkAiJvbO21luJ/qSTi1mF8Ku8IMdXHKV/5OiSzbGwXEVW0QvM71M8EC
         SeUocZhlVq/HD29CtUs1jWRlWUZg0UGiSRK1SMN0nL1eB+v5zdZz/2mSy009D7aOwqFW
         KSeQ/Q7fVmh7VjJga5qADbHbVztwLQMIU30KVKqPo5h4nsiKuHvwDyAZGhzrWlgFzhK3
         N3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2f3kh3jqi9yjSQzKeEhCTNVhq9kV2tSI6rer8mhvNI=;
        b=dkHQlqOq/6EXahRI5El8+jCW1FhCYkn7kqTAENuhmRfqqbgvJ/rmumggjaIFaMCUHK
         qHSgPyUd6xJxtMVKBJRJaCxPAznwfXyWbBB8g5aXr/IBkcjJGJC441CPCx9TwigOGbaS
         e6CPtS9WFQD9sKbHJ21AoiT9yg79rmhrIT4yqBzy4vtrZBBJgl4WWzlTbkJhkMmlAqzI
         BFiFcwkEctBfsBQ/1nSRU+UY65lZjltIjDzMCJbdI7Gcc9AMUtoXS3XddJ0saB5j2ZgH
         uBR6uATyLQnEPCGNnvuQQLyafQHI64+ORHo5a7ip85TBFSi6Xjx30slVHsYnrOY2qkuR
         6DyA==
X-Gm-Message-State: AJIora9pDn+/F21UkG0MoFePKaOTFtw7QLN5aMr3XvuhZbwQrT6KYf6H
        7vAkYbTk/AFN+045hqJcovlY8PCP7veXLzU/0wXM8Q==
X-Google-Smtp-Source: AGRyM1tFqXVl1Wq7EQt3qviY8BvioiYzPA9jdIWLjIYucLUw/m0e/HDPSy2RNp34GiUJ0LE93SKzgQ/kW9FUP7L1iYE=
X-Received: by 2002:a25:ba02:0:b0:670:8171:3176 with SMTP id
 t2-20020a25ba02000000b0067081713176mr15910761ybg.61.1658912652855; Wed, 27
 Jul 2022 02:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220726135506.485108-1-bchihi@baylibre.com> <20220726135506.485108-2-bchihi@baylibre.com>
 <3cb97e73-d60a-086d-83c2-1711c70057a2@collabora.com>
In-Reply-To: <3cb97e73-d60a-086d-83c2-1711c70057a2@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 27 Jul 2022 11:03:36 +0200
Message-ID: <CAGuA+orsPVDjKcD=nMoHNKkQd3LNP8FP+TDSCWvabmR9f19TWw@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] thermal: mediatek: Relocate driver to mediatek folder
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 10:24 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 26/07/22 15:55, Balsam CHIHI ha scritto:
> > Add Mediatek proprietary folder to upstream more thermal zone and cooler
> > drivers. Relocate the original thermal controller driver to it and rename
> > as soc_temp.c to show its purpose more clearly.
> >
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >   drivers/thermal/Kconfig                       | 14 ++++-------
> >   drivers/thermal/Makefile                      |  2 +-
> >   drivers/thermal/mediatek/Kconfig              | 23 +++++++++++++++++++
> >   drivers/thermal/mediatek/Makefile             |  1 +
> >   .../{mtk_thermal.c => mediatek/soc_temp.c}    |  0
> >   5 files changed, 29 insertions(+), 11 deletions(-)
> >   create mode 100644 drivers/thermal/mediatek/Kconfig
> >   create mode 100644 drivers/thermal/mediatek/Makefile
> >   rename drivers/thermal/{mtk_thermal.c => mediatek/soc_temp.c} (100%)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 0e5cc948373c..ecba8d6e313b 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -412,16 +412,10 @@ config DA9062_THERMAL
> >         zone.
> >         Compatible with the DA9062 and DA9061 PMICs.
> >
> > -config MTK_THERMAL
> > -     tristate "Temperature sensor driver for mediatek SoCs"
> > -     depends on ARCH_MEDIATEK || COMPILE_TEST
> > -     depends on HAS_IOMEM
> > -     depends on NVMEM || NVMEM=n
> > -     depends on RESET_CONTROLLER
> > -     default y
> > -     help
> > -       Enable this option if you want to have support for thermal management
> > -       controller present in Mediatek SoCs
> > +menu "Mediatek thermal drivers"
> > +depends on ARCH_MEDIATEK || COMPILE_TEST
> > +source "drivers/thermal/mediatek/Kconfig"
> > +endmenu
> >
> >   config AMLOGIC_THERMAL
> >       tristate "Amlogic Thermal Support"
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index def8e1a0399c..3c00e864ad55 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -55,7 +55,7 @@ obj-y                               += st/
> >   obj-$(CONFIG_QCOM_TSENS)    += qcom/
> >   obj-y                               += tegra/
> >   obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> > -obj-$(CONFIG_MTK_THERMAL)    += mtk_thermal.o
> > +obj-$(CONFIG_MTK_THERMAL)    += mediatek/
> >   obj-$(CONFIG_GENERIC_ADC_THERMAL)   += thermal-generic-adc.o
> >   obj-$(CONFIG_UNIPHIER_THERMAL)      += uniphier_thermal.o
> >   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> > diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
> > new file mode 100644
> > index 000000000000..9c41e9079fc3
> > --- /dev/null
> > +++ b/drivers/thermal/mediatek/Kconfig
> > @@ -0,0 +1,23 @@
> > +config MTK_THERMAL
> > +     tristate "MediaTek thermal drivers"
> > +     depends on THERMAL_OF
> > +     help
> > +             This is the option for MediaTek thermal software
> > +             solutions. Please enable corresponding options to
> > +             get temperature information from thermal sensors or
> > +             turn on throttle mechaisms for thermal mitigation.
>
> Sorry, I just noticed that the indentation must be fixed.
>
>         help
>           This is the option .....
>
> Thanks,
> Angelo
OK, It will be fixed ASAP.

Thanks,
Balsam.
