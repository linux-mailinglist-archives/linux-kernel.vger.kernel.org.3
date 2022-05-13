Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5012D5268D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383193AbiEMR4r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 13:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383226AbiEMR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:56:44 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2DE1356BA;
        Fri, 13 May 2022 10:56:32 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id x74so3896362ybe.4;
        Fri, 13 May 2022 10:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6e/oSgyfVARToRdeUYxHVtQ6AaUn4CgE1vbZwPLu6BI=;
        b=PSBgBNYlfpDf0Z3bbt5FDi4oiBkguaeBh8TF6uDl0kNAZOWFnn0hV50LJzweRs56on
         NiHrLwNiu72yeUYejQ5bcVoWczMRi1V8H0hHVx2yRkj9wTKR7KLKvw8vVgG9V4fyeJ8q
         Pn8C9Olr0WfHI59xE3ej+8umpKsiBYY+OIr6Zip4n8wx/LQUYLasYePzE4S89U/Lt1kw
         D3iVeFHTV3a7tYdPNYo5KTyE6b0HxVZ//Dwbg9demhWt9enVOTGD/ANNFCZ7+89VOGEA
         t5+XZSFpc/1TGyMoZwh+Jlzi+EJUf8bddp6pb8Wsbcm27aKnwJQ0XGtwqexzTyz/iYWc
         dNxA==
X-Gm-Message-State: AOAM5302AoolLwax64CLKlsK73iz1K59Jj2239dlNWtS3gawXG7lrXgX
        OzVZOwKqmj7vn+c8WBBCbecWWFRmtamz5PmtJq0=
X-Google-Smtp-Source: ABdhPJyajGmsQ2qElA4nEpdS0uYIgFI8XDIlXxzY7qVC4nr9FiwxJJnbtYuLgK6ynqYgnTaLubbNX2Vu+ze+pD/UFIw=
X-Received: by 2002:a25:d4f:0:b0:64b:a4b1:2d50 with SMTP id
 76-20020a250d4f000000b0064ba4b12d50mr2860970ybn.482.1652464590248; Fri, 13
 May 2022 10:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org> <63f1c4a0-d2c6-8157-5da0-198c2d8d1013@linaro.org>
In-Reply-To: <63f1c4a0-d2c6-8157-5da0-198c2d8d1013@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 May 2022 19:56:17 +0200
Message-ID: <CAJZ5v0iexz36LL52rZ0BTtSXCf63UnU0kMJR7w6Qfe7P5ZmHTA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] thermal OF rework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, May 13, 2022 at 7:23 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> if you are ok with this series, I'll pick it up.
>
> Is that ok ?

Give me some more time to look at it, please.

I'll respond in the first half of next week.

> On 07/05/2022 14:54, Daniel Lezcano wrote:
> > The thermal framework initialization with the device tree appears to
> > be complicated and hard to make it to evolve.
> >
> > It contains duplication of almost the same thermal generic structures
> > and has an assymetric initialization making hard any kind of serious
> > changes for more complex features. One of them is the multiple sensors
> > support per thermal zone.
> >
> > In order to set the scene for the aforementioned feature with generic
> > code, we need to cleanup and rework the device tree initialization.
> >
> > However this rework is not obvious because of the multiple components
> > entering in the composition of a thermal zone and being initialized at
> > different moments. For instance, a cooling device can be initialized
> > before a sensor, so the thermal zones must exist before the cooling
> > device as well as the sensor. This asynchonous initialization forces
> > the thermal zone to be created with fake ops because they are
> > mandotory and build a list of cooling devices which is used to lookup
> > afterwards when the cooling device driver is registering itself.
> >
> > As there could be a large number of changes, this first series provide
> > some steps forward for a simpler device tree initialization.
> >
> > Changelog:
> >   - V2:
> >     - Drop patch 1/15 which contains too many changes for a simple
> >       structure renaming. This could be addressed in a separate series as
> >       it is not necessary for the OF rework
> >
> >     - Fixed of_node_put with gchild not initialized as reported by
> >       kbuild and Dan Carpenter
> >
> >   - V1:
> >     - Initial post
> >
> > Daniel Lezcano (14):
> >    thermal/core: Change thermal_zone_ops to thermal_sensor_ops
> >    thermal/core: Add a thermal sensor structure in the thermal zone
> >    thermal/core: Remove duplicate information when an error occurs
> >    thermal/of: Replace device node match with device node search
> >    thermal/of: Remove the device node pointer for thermal_trip
> >    thermal/of: Move thermal_trip structure to thermal.h
> >    thermal/core: Remove unneeded EXPORT_SYMBOLS
> >    thermal/core: Move thermal_set_delay_jiffies to static
> >    thermal/core: Rename trips to ntrips
> >    thermal/core: Add thermal_trip in thermal_zone
> >    thermal/core: Register with the trip points
> >    thermal/of: Store the trips in the thermal zone
> >    thermal/of: Use thermal trips stored in the thermal zone
> >    thermal/of: Initialize trip points separately
> >
> >   .../driver-api/thermal/sysfs-api.rst          |   2 +-
> >   drivers/acpi/thermal.c                        |   6 +-
> >   .../ethernet/chelsio/cxgb4/cxgb4_thermal.c    |   2 +-
> >   .../ethernet/mellanox/mlxsw/core_thermal.c    |   6 +-
> >   drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   2 +-
> >   drivers/platform/x86/acerhdf.c                |   2 +-
> >   drivers/power/supply/power_supply_core.c      |   2 +-
> >   drivers/thermal/armada_thermal.c              |   2 +-
> >   drivers/thermal/broadcom/bcm2835_thermal.c    |   2 +-
> >   drivers/thermal/da9062-thermal.c              |   2 +-
> >   drivers/thermal/dove_thermal.c                |   2 +-
> >   drivers/thermal/gov_bang_bang.c               |   6 +-
> >   drivers/thermal/gov_fair_share.c              |  10 +-
> >   drivers/thermal/gov_power_allocator.c         |  22 +-
> >   drivers/thermal/gov_step_wise.c               |   4 +-
> >   drivers/thermal/imx_thermal.c                 |   2 +-
> >   .../intel/int340x_thermal/int3400_thermal.c   |   2 +-
> >   .../int340x_thermal/int340x_thermal_zone.c    |   6 +-
> >   .../int340x_thermal/int340x_thermal_zone.h    |   4 +-
> >   .../processor_thermal_device.c                |   4 +-
> >   .../processor_thermal_device_pci.c            |   2 +-
> >   drivers/thermal/intel/intel_pch_thermal.c     |   2 +-
> >   .../thermal/intel/intel_quark_dts_thermal.c   |   2 +-
> >   drivers/thermal/intel/intel_soc_dts_iosf.c    |   2 +-
> >   drivers/thermal/intel/x86_pkg_temp_thermal.c  |   2 +-
> >   drivers/thermal/kirkwood_thermal.c            |   2 +-
> >   drivers/thermal/rcar_gen3_thermal.c           |   6 +-
> >   drivers/thermal/rcar_thermal.c                |   4 +-
> >   drivers/thermal/samsung/exynos_tmu.c          |   6 +-
> >   drivers/thermal/spear_thermal.c               |   2 +-
> >   drivers/thermal/st/st_thermal.c               |   2 +-
> >   drivers/thermal/tegra/soctherm.c              |  10 +-
> >   drivers/thermal/tegra/tegra30-tsensor.c       |   6 +-
> >   drivers/thermal/thermal_core.c                | 102 ++++----
> >   drivers/thermal/thermal_core.h                |  25 +-
> >   drivers/thermal/thermal_helpers.c             |  35 ++-
> >   drivers/thermal/thermal_hwmon.c               |   4 +-
> >   drivers/thermal/thermal_netlink.c             |  10 +-
> >   drivers/thermal/thermal_of.c                  | 221 ++++++++++--------
> >   drivers/thermal/thermal_sysfs.c               |  62 ++---
> >   include/linux/thermal.h                       |  34 ++-
> >   41 files changed, 341 insertions(+), 290 deletions(-)
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
