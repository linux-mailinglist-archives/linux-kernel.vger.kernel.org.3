Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD435A68CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiH3QwX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Aug 2022 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiH3Qv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:51:57 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B01107C50;
        Tue, 30 Aug 2022 09:51:27 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3378303138bso284139667b3.9;
        Tue, 30 Aug 2022 09:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZV7Kg6W/vTVFLUBFg6jxVlI+r/EZpRC/QIj/dDYrQDU=;
        b=q8AMRQjbr5jizA8a2khf8pKPbdzhm9vyxMrWfDune+8XgdvkfMU1dBjDn/m1zh41Zf
         YGXoMTgiqch8Rl9sVim4M41oYKmB4bid+KIhk+30/GWzZaV83i3RnEJIqUWgsm/XyG3A
         HNbzTVPA0gR84+vhCWYBs7uNMQx5LfZKXPqFf4Wot5khCg+l2j2bJHhQJ3DPXor4VZ8S
         wChnwal1mfCbYaTmk5ehPQYuObmMSPOZ/MQlwmZdraJ8kz3RdVItrHHXMH40a4MADXIY
         6OSLuwiOkIGKn4EHhk5JjJzaYP5VJUY+2ENKU8xMaqLBv9vaqsUKk8I9KNLxcXn6w1/D
         fulw==
X-Gm-Message-State: ACgBeo3Tw4KqPOyGPVZN3QCuFwYKQw7ddAn5HJQOH5EENEwsostq3+m2
        tCz3Z7GvI8MoFrUhkDz/1fCp8DzYjWR/5pEpR3U=
X-Google-Smtp-Source: AA6agR7EjPxb4LdPKyMy9NeO67zcqzZF2b4HRAmwI/ZFHEkBAIC91D5nzuCaGdIcEnejcGyE2z1eGT98QDGdW8LZKY8=
X-Received: by 2002:a81:4850:0:b0:33c:922b:5739 with SMTP id
 v77-20020a814850000000b0033c922b5739mr14561712ywa.515.1661878260966; Tue, 30
 Aug 2022 09:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <0fc7062d-696a-0794-8730-48ef08bcb8bd@linaro.org> <CAJZ5v0h0r2dW7xW+GW3=KDEZZEkyYOXVCOmD3fad=a2enNhddA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h0r2dW7xW+GW3=KDEZZEkyYOXVCOmD3fad=a2enNhddA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Aug 2022 18:50:49 +0200
Message-ID: <CAJZ5v0hNCezncvW-g1UVPoF-ZmeVWd192FCaZVWrV-+Ucsycpg@mail.gmail.com>
Subject: Re: [GIT PULL] early thermal changes for v6.1-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 8:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 24, 2022 at 1:38 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Rafael,
> >
> > this cycle will contain certainly a higher number of changes than the
> > previous ones. That will come from the rework of the thermal trip
> > handling / consolidation which is still WIP but where the drivers
> > changes are partly acked-by the different maintainers. The result will
> > be great IMO in terms of cleanup, encapsulation and maintainability.
> >
> > The thermal OF cleanup and rework have been consolidated meanwhile.
> >
> > In order to not have a huge pull request at the end of the v6.1
> > development cycle, I propose to send early but smaller pull requests
> > (release often, release early), so hopefully that will make the changes
> > smooth and may be hit the potential bugs for those who are sticking to
> > linux-pm instead of linux-next.
> >
> > This pull request is the first one and has been in the linux-next branch
> > since a couple of weeks.
> >
> > It includes the thermal OF rework, with the corresponding fixes and the
> > monitoring locking scheme path changes.
>
> Pulled, thanks!

So after merging this, the Dell XPS13 9360 in my office doesn't reboot any more.

Undoing the merge makes it reboot again.

Bisection indicates

commit 670a5e356cb6dfc61b87b599eba483af6a3a99ad
Author: Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Fri Aug 5 17:38:33 2022 +0200

   thermal/core: Move the thermal zone lock out of the governors

as the first bad commit, but I'm not sure what can be wrong with it yet.

Also a couple of commits before it are somewhat suspicious.

> > The following changes since commit 8c596324232d22e19f8df59ba03410b9b5b0f3d7:
> >
> >    dt-bindings: thermal: Fix missing required property (2022-08-15
> > 20:38:40 +0200)
> >
> > are available in the Git repository at:
> >
> >
> > ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> > tags/thermal-v6.1-rc1
> >
> > for you to fetch changes up to 06f36055121769b9eb9b7d28c7499d1cc8269dc3:
> >
> >    Revert "mlxsw: core: Add the hottest thermal zone detection"
> > (2022-08-17 20:32:27 +0200)
> >
> > ----------------------------------------------------------------
> > - Rework the device tree initialization, convert the drivers to the
> >    new API and remove the old OF code (Daniel Lezcano)
> >
> > - Fix return value to -ENODEV when searching for a specific thermal
> >    zone which does not exist (Daniel Lezcano)
> >
> > - Fix the return value inspection in of_thermal_zone_find() (Dan
> >    Carpenter)
> >
> > - Fix kernel panic when kasan is enabled as it detects an use after
> >    free when unregistering a thermal zone (Daniel Lezcano)
> >
> > - Move the set_trip ops inside the thermal sysfs code (Daniel Lezcano)
> >
> > - Remove unnecessary error message as it is already showed in the
> >    underlying function (Jiapeng Chong)
> >
> > - Rework the monitoring path and move the locks upper in the call
> >    stack to fix some potentials race windows (Daniel Lezcano)
> >
> > - Fix lockdep_assert() warning introduced by the lock rework (Daniel
> >    Lezcano)
> >
> > - Revert the Mellanox 'hotter thermal zone' feature because it is
> >    already handled in the thermal framework core code (Daniel Lezcano)
> >
> > ----------------------------------------------------------------
> > Dan Carpenter (1):
> >        thermal/of: Fix error code in of_thermal_zone_find()
> >
> > Daniel Lezcano (42):
> >        thermal/of: Rework the thermal device tree initialization
> >        thermal/of: Return -ENODEV instead of -EINVAL if registration fails
> >        thermal/of: Fix free after use in thermal_of_unregister()
> >        thermal/of: Make new code and old code co-exist
> >        thermal/drivers/rockchip: Switch to new of API
> >        thermal/drivers/uniphier: Switch to new of API
> >        thermal/drivers/generic-adc: Switch to new of API
> >        thermal/drivers/mmio: Switch to new of API
> >        thermal/drivers/tegra: Switch to new of API
> >        thermal/drivers/sun8i: Switch to new of API
> >        thermal/drivers/sprd: Switch to new of API
> >        thermal/drivers/broadcom: Switch to new of API
> >        thermal/drivers/qcom: Switch to new of API
> >        thermal/drivers/st: Switch to new of API
> >        thermal/drivers/amlogic: Switch to new of API
> >        thermal/drivers/armada: Switch to new of API
> >        thermal/drivers/db8500: Switch to new of API
> >        thermal/drivers/imx: Switch to new of API
> >        thermal/drivers/rcar: Switch to new of API
> >        thermal/drivers/rzg2l: Switch to new of API
> >        thermal/drivers/qoriq: Switch to new of API
> >        thermal/drivers/mtk: Switch to new of API
> >        thermal/drivers/banggap: Switch to new of API
> >        thermal/drivers/maxim: Switch to new of API
> >        thermal/drivers/hisilicon: Switch to new of API
> >        thermal/drivers/ti-soc: Switch to new of API
> >        ata/drivers/ahci_imx: Switch to new of thermal API
> >        hwmon: pm_bus: core: Switch to new of thermal API
> >        hwmon/drivers/core: Switch to new of thermal API
> >        iio/drivers/sun4i_gpadc: Switch to new of thermal API
> >        Input: sun4i-ts - switch to new of thermal API
> >        regulator/drivers/max8976: Switch to new of thermal API
> >        thermal/drivers/samsung: Switch to new of thermal API
> >        thermal/core: Move set_trip_temp ops to the sysfs code
> >        thermal/of: Remove old OF code
> >        thermal/core: Rearm the monitoring only one time
> >        thermal/core: Rework the monitoring a bit
> >        thermal/governors: Group the thermal zone lock inside the
> > throttle function
> >        thermal/core: Move the thermal zone lock out of the governors
> >        thermal/core: Move the mutex inside the
> > thermal_zone_device_update() function
> >        thermal/core: Fix lockdep_assert() warning
> >        Revert "mlxsw: core: Add the hottest thermal zone detection"
> >
> > Jiapeng Chong (1):
> >        thermal/drivers/qcom/spmi-adc-tm5: Remove unnecessary print
> > function dev_err()
> >
> >   drivers/ata/ahci_imx.c                             |   15 +-
> >   drivers/hwmon/hwmon.c                              |   14 +-
> >   drivers/hwmon/pmbus/pmbus_core.c                   |   10 +-
> >   drivers/hwmon/scpi-hwmon.c                         |   14 +-
> >   drivers/iio/adc/sun4i-gpadc-iio.c                  |   14 +-
> >   drivers/input/touchscreen/sun4i-ts.c               |   10 +-
> >   drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |   77 +-
> >   drivers/regulator/max8973-regulator.c              |   10 +-
> >   drivers/thermal/amlogic_thermal.c                  |   16 +-
> >   drivers/thermal/armada_thermal.c                   |   12 +-
> >   drivers/thermal/broadcom/bcm2711_thermal.c         |   14 +-
> >   drivers/thermal/broadcom/bcm2835_thermal.c         |   14 +-
> >   drivers/thermal/broadcom/brcmstb_thermal.c         |   20 +-
> >   drivers/thermal/broadcom/ns-thermal.c              |   50 +-
> >   drivers/thermal/broadcom/sr-thermal.c              |   16 +-
> >   drivers/thermal/db8500_thermal.c                   |    8 +-
> >   drivers/thermal/gov_bang_bang.c                    |   10 +-
> >   drivers/thermal/gov_fair_share.c                   |    3 +-
> >   drivers/thermal/gov_power_allocator.c              |   20 +-
> >   drivers/thermal/gov_step_wise.c                    |   10 +-
> >   drivers/thermal/hisi_thermal.c                     |   14 +-
> >   drivers/thermal/imx8mm_thermal.c                   |   14 +-
> >   drivers/thermal/imx_sc_thermal.c                   |   14 +-
> >   drivers/thermal/k3_bandgap.c                       |   12 +-
> >   drivers/thermal/k3_j72xx_bandgap.c                 |   12 +-
> >   drivers/thermal/max77620_thermal.c                 |    8 +-
> >   drivers/thermal/mtk_thermal.c                      |   10 +-
> >   drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   23 +-
> >   drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   12 +-
> >   drivers/thermal/qcom/tsens.c                       |   16 +-
> >   drivers/thermal/qoriq_thermal.c                    |   12 +-
> >   drivers/thermal/rcar_gen3_thermal.c                |   16 +-
> >   drivers/thermal/rcar_thermal.c                     |   13 +-
> >   drivers/thermal/rockchip_thermal.c                 |   14 +-
> >   drivers/thermal/rzg2l_thermal.c                    |   10 +-
> >   drivers/thermal/samsung/exynos_tmu.c               |   24 +-
> >   drivers/thermal/sprd_thermal.c                     |   18 +-
> >   drivers/thermal/st/stm_thermal.c                   |   18 +-
> >   drivers/thermal/sun8i_thermal.c                    |   14 +-
> >   drivers/thermal/tegra/soctherm.c                   |   21 +-
> >   drivers/thermal/tegra/tegra-bpmp-thermal.c         |   19 +-
> >   drivers/thermal/tegra/tegra30-tsensor.c            |   12 +-
> >   drivers/thermal/thermal-generic-adc.c              |   10 +-
> >   drivers/thermal/thermal_core.c                     |   63 +-
> >   drivers/thermal/thermal_core.h                     |    4 +-
> >   drivers/thermal/thermal_helpers.c                  |   73 +-
> >   drivers/thermal/thermal_mmio.c                     |   17 +-
> >   drivers/thermal/thermal_of.c                       | 1148
> > +++++++-------------
> >   drivers/thermal/thermal_sysfs.c                    |   11 +-
> >   drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   16 +-
> >   drivers/thermal/uniphier_thermal.c                 |   10 +-
> >   include/linux/thermal.h                            |   85 +-
> >   52 files changed, 796 insertions(+), 1324 deletions(-)
> >
> > --
> > <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> >
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog
