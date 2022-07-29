Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D00585243
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbiG2PUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiG2PUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:20:24 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE222018D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:20:22 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-324293f1414so19817627b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpxH+0pcpwdGFQIy9DRev+uNqMcyJUe+RuBBYCncU+8=;
        b=uaoD4+E11ru9kzNBwgCQg73wXXd8Qu535Vg4usFywm+XxTbn2bQFO0gYrVGIETI09L
         1Mum+2d/sLV21Vijzmrbj3cHaNttcffFcy9nAvdaTJvNLtd0s0nXHj44Wrm7u+85uV7W
         svON+Shi7/KnZtWbSC9jkTaLZoqmXf57fYb62YNvFdcmHwtVGMvoFiz+icftdxSUGTVY
         IoD2YK4GiJMI9Hh9/GR2wDrnRc1RCTLMRNvx3O/BydKEgRdLTdksjyPUwC/YKeuOnt0P
         zmd1FGJUhOgqBbv2Ujh1SwpPJLhxb1YEYgiLyVuf2J0qeDpX38Tlx+1J9/WRnFqfz6HI
         tCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpxH+0pcpwdGFQIy9DRev+uNqMcyJUe+RuBBYCncU+8=;
        b=olBlFCP9ZrMU4CZoOzUwH2dWykt6NWguIjW9OVLS2Zt1dt851PhI984V0Rcon/dPOt
         srOTw59duWJx8k70CAEEzq5oH+XmO4e9sFzQUztHftPaxc13TWpLYcVG+bDAPgWGpooq
         81W2IsuyX9Gb+gkWUwM/xu8gDDbnZ10OrmFytxNwDtfyjzqpjbnQjlliMsu6TYNMHGnZ
         RglfhNC3upDWXrXq2G/nu31dQ92rMsp2Xg2pGmofGqsDs9mtUHFFH1qOtSLj4UulRM6Q
         SgblX1QLMmVk8fFwZBbHQoST9PlZ3e9fHLtFhIq3hpiIkDiVc8wFR0KKzAPAe1kwS8rD
         ITvA==
X-Gm-Message-State: ACgBeo0ogbBFbhiPw4G7l1NASgnzON693X2R3A1faoVqOBGsTJrdNFj7
        vcylJd79F1Ext4oaNaYRXdiD2peXaWlWumezS6slHA==
X-Google-Smtp-Source: AA6agR5LgLR6pYTs5w5w5fc+1Z3RdxkEoqGGkvJvcfN8qQUqzHYmYQWuz6pJKO/kmJsT/6k5rd+apjFglbV7OmOEMoc=
X-Received: by 2002:a81:b046:0:b0:31d:bd47:7fb with SMTP id
 x6-20020a81b046000000b0031dbd4707fbmr3601026ywk.88.1659108021846; Fri, 29 Jul
 2022 08:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220726135506.485108-1-bchihi@baylibre.com> <20220726135506.485108-2-bchihi@baylibre.com>
 <24250d03-b25f-e521-5abd-f36109885c36@linaro.org>
In-Reply-To: <24250d03-b25f-e521-5abd-f36109885c36@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 29 Jul 2022 17:19:45 +0200
Message-ID: <CAGuA+opxZ7DDrWHcnTRhMcm7YveCAypdy9MDSytt58asgekayw@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] thermal: mediatek: Relocate driver to mediatek folder
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
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

On Thu, Jul 28, 2022 at 10:53 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Balsam,
>
> On 26/07/2022 15:55, Balsam CHIHI wrote:
> > Add Mediatek proprietary folder to upstream more thermal zone and cooler
> > drivers. Relocate the original thermal controller driver to it and rename
> > as soc_temp.c to show its purpose more clearly.
>
> I realize the Kconfig, Makefiles format are not consistent across the
> boards. Before I fix this, you can comply to the format:
>
> drivers/thermal/Kconfig:
>
> menu "Mediatek thermal drivers"
> depends on ARCH_MEDIATEK || COMPILE_TEST
> source "drivers/thermal/mediatek/Kconfig"
> endmenu
>
> drivers/thermal/Makefile:
>
> -obj-$(CONFIG_MTK_THERMAL)      += mtk_thermal.o
> +obj-y                          += mediatek
>
> drivers/thermal/mediatek/Kconfig:
>
> config MTK_SOC_THERMAL
>         tristate "Temperature sensor driver for MediaTek SoCs"
>         depends on HAS_IOMEM
>         depends on NVMEM
>         depends on RESET_CONTROLLER
>         help
>                 Enable this option if you want to get SoC temperature
>                 information for MediaTek platforms. This driver
>                 configures thermal controllers to collect temperature
>                 via AUXADC interface.
>
> drivers/thermal/mediatek/Makefile:
>
> obj-$(MTK_SOC_THERMAL)  += soc_temp.o
>
> However, rename 'soc_temp' to something more SoC explicit, eg.
> mtxxx_thermal.c
>
> Thanks
>
>    -- Daniel

Hello Daniel,

Thank you for the feedback.
Changes have been made as you suggested.
Resubmitting seen.

Best regards.
Balsam.
