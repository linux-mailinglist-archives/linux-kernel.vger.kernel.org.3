Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66D3585441
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiG2ROO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiG2ROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:14:12 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43F46E2FD;
        Fri, 29 Jul 2022 10:14:11 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31f661b3f89so57373027b3.11;
        Fri, 29 Jul 2022 10:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vrgLlU5CBRdYbcgZ/RNzcpWQVtEwPOeT1au2xWqewZs=;
        b=R3ABZL22U+kDuVM1gfpukSBBAI2cA2JxV8Sp7T+ukIw4Mk+48tYp3rWaLJeQN6h1QT
         CBjvLSZhKpaHfO/bQHNjTOstX6jIxBIUdsqw7Ihrg3HKR156jlIXE5k3zOhve+cn3jRF
         VIF3nmCBv4XMMWzjqtWCcGuZylDkTWJ3WLTO5mhnXIu/SzT/J/kRdPq1WLG6xHLqDaQC
         zX+xQbloOmnOki6ndEKUhWiEE7Yp4L7sSgBy/CIuX/inT+QN36tWuRepGC1ycD/BsXC5
         mjKNRInoH0Z30C06BdkTbLgaG+hMedI28eZTP7i3u//ul3YC8y1LfQ9PEOECRhqVQu6l
         10Ig==
X-Gm-Message-State: ACgBeo35SVxXuEykGHvBTNEZMW9Md+IwBnrjcwbNdsWyPyYcuY8jobEh
        AHcHNTAEwxo+dDlA3xLV5aerAxpRWXc+bwfD3qY=
X-Google-Smtp-Source: AA6agR4s7BWFtkaymPXUysYz5Sxc55tM5g8yUT+5CKwvoe8KKcHegAKLW+OyAMTfB10YjuLfxnoQIJaP8Jk+36vdmdY=
X-Received: by 2002:a81:4852:0:b0:322:6fcf:f016 with SMTP id
 v79-20020a814852000000b003226fcff016mr3795581ywa.515.1659114850959; Fri, 29
 Jul 2022 10:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <930e7e1b-f0d2-c3ea-cd1a-c212332e0057@linaro.org>
In-Reply-To: <930e7e1b-f0d2-c3ea-cd1a-c212332e0057@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Jul 2022 19:14:00 +0200
Message-ID: <CAJZ5v0iL2wQDxPfCpRTtp0Wv=Jm+UJvyWw6Stma=tEEEEbs3yA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.20-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        jinxiaoyun2@huawei.com, Julia Lawall <julia.lawall@lip6.fr>,
        Biju Das <biju.das@bp.renesas.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Slark Xiao <slark_xiao@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 6:47 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider pulling the following changes:
>
> Thanks!
>
>
> The following changes since commit 62f46fc7b8c639bc97cc9c69e063c40970b6e14c:
>
>    thermal: intel_tcc_cooling: Add TCC cooling support for RaptorLake
> (2022-06-30 19:48:44 +0200)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v5.20-rc1
>
> for you to fetch changes up to d0c75fa2c17f082b32a5f26ff40bf378b12952de:
>
>    thermal/of: Initialize trip points separately (2022-07-28 17:29:57 +0200)
>
> ----------------------------------------------------------------
> - Make per cpufreq / devfreq cooling device ops instead of using a
>    global variable, fix comments and rework the trace information
>    (Lukasz Luba)
>
> - Add the include/dt-bindings/thermal.h under the area covered by the
>    thermal maintainer in the MAINTAINERS file (Lukas Bulwahn)
>
> - Improve the error output by giving the sensor identification when a
>    thermal zone failed to initialize, the DT bindings by changing the
>    positive logic and adding the r8a779f0 support on the rcar3 (Wolfram
>    Sang)
>
> - Convert the QCom tsens DT binding to the dtsformat format (Krzysztof
>    Kozlowski)
>
> - Remove the pointless get_trend() function in the QCom, Ux500 and
>    tegra thermal drivers, along with the unused DROP_FULL and
>    RAISE_FULL trends definitions. Simplify the code by using clamp()
>    macros (Daniel Lezcano)
>
> - Fix ref_table memory leak at probe time on the k3_j72xx bandgap
>    (Bryan Brattlof)
>
> - Fix array underflow in prep_lookup_table (Dan Carpenter)
>
> - Add static annotation to the k3_j72xx_bandgap_j7* data structure
>    (Jin Xiaoyun)
>
> - Fix typos in comments detected on sun8i by Coccinelle (Julia Lawall)
>
> - Fix typos in comments on rzg2l (Biju Das)
>
> - Remove as unnecessary call to dev_err() as the error is already
>    printed by the failing function on u8500 (Yang Li)
>
> - Register the thermal zones as hwmon sensors for the Qcom thermal
>    sensors (Dmitry Baryshkov)
>
> - Fix 'tmon' tool compilation issue by adding phtread.h include
>    (Markus Mayer)
>
> - Fix typo in the comments for the 'tmon' tool (Slark Xiao)
>
> - Consolidate the thermal core code by beginning to move the thermal
>    trip structure from the thermal OF code as a generic structure to be
>    used by the different sensors when registering a thermal zone
>    (Daniel Lezcano)
>
> ----------------------------------------------------------------
> Biju Das (1):
>        thermal/drivers/rzg2l: Fix comments
>
> Bryan Brattlof (1):
>        thermal/drivers/k3_j72xx_bandgap: Fix ref_table memory leak
> during probe
>
> Dan Carpenter (1):
>        thermal/drivers/k3_j72xx_bandgap: Fix array underflow in
> prep_lookup_table()
>
> Daniel Lezcano (16):
>        thermal/drivers/qcom: Remove get_trend function
>        thermal/drivers/tegra: Remove get_trend function
>        thermal/drivers/u8500: Remove the get_trend function
>        thermal/core: Use clamp() helper in the stepwise governor
>        thermal/core: Remove DROP_FULL and RAISE_FULL
>        thermal/core: Avoid calling ->get_trip_temp() unnecessarily
>        thermal/core: Remove duplicate information when an error occurs
>        thermal/of: Replace device node match with device node search
>        thermal/of: Remove the device node pointer for thermal_trip
>        thermal/of: Move thermal_trip structure to thermal.h
>        thermal/core: Remove unneeded EXPORT_SYMBOLS
>        thermal/core: Move thermal_set_delay_jiffies to static
>        thermal/core: Rename 'trips' to 'num_trips'
>        thermal/core: Add thermal_trip in thermal_zone
>        thermal/of: Use thermal trips stored in the thermal zone
>        thermal/of: Initialize trip points separately
>
> Dmitry Baryshkov (2):
>        thermal/drivers/qcom/temp-alarm: Register thermal zones as hwmon
> sensors
>        thermal/drivers/qcom/spmi-adc-tm5: Register thermal zones as
> hwmon sensors
>
> Jason Wang (1):
>        thermal/ti-soc-thermal: Fix comment typo
>
> Jin Xiaoyun (1):
>        thermal/drivers/k3_j72xx_bandgap: Make
> k3_j72xx_bandgap_j721e_data and k3_j72xx_bandgap_j7200_data static
>
> Julia Lawall (1):
>        thermal/drivers/sun8i: Fix typo in comment
>
> Krzysztof Kozlowski (1):
>        dt-bindings: thermal: qcom,spmi-temp-alarm: convert to dtschema
>
> Lukas Bulwahn (1):
>        MAINTAINERS: add include/dt-bindings/thermal to THERMAL
>
> Lukasz Luba (4):
>        drivers/thermal/cpufreq_cooling: Use private callback ops for
> each cooling device
>        drivers/thermal/cpufreq_cooling : Refactor
> thermal_power_cpu_get_power tracing
>        drivers/thermal/cpufreq_cooling: Update outdated comments
>        drivers/thermal/devfreq_cooling: Extend the
> devfreq_cooling_device with ops
>
> Markus Mayer (1):
>        thermal/tools/tmon: Include pthread and time headers in tmon.h
>
> Slark Xiao (1):
>        thermal/tools/tmon: Fix typo 'the the' in comment
>
> Wolfram Sang (3):
>        drivers/thermal/rcar_gen3_thermal: Improve logging during probe
>        dt-bindings: thermal: rcar-gen3-thermal: use positive logic
>        dt-bindings: thermal: rcar-gen3-thermal: Add r8a779f0 support
>
> Yang Li (1):
>        thermal/drivers/u8500: Remove unnecessary print function dev_err()
>
>   .../bindings/thermal/qcom,spmi-temp-alarm.yaml     |  85 +++++++++
>   .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  51 ------
>   .../bindings/thermal/rcar-gen3-thermal.yaml        |  36 ++--
>   MAINTAINERS                                        |   1 +
>   drivers/thermal/cpufreq_cooling.c                  |  77 +++-----
>   drivers/thermal/db8500_thermal.c                   |  34 +---
>   drivers/thermal/devfreq_cooling.c                  |  27 +--
>   drivers/thermal/gov_fair_share.c                   |   6 +-
>   drivers/thermal/gov_power_allocator.c              |   4 +-
>   drivers/thermal/gov_step_wise.c                    |  26 +--
>   drivers/thermal/k3_j72xx_bandgap.c                 |  13 +-
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   5 +
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   5 +
>   drivers/thermal/qcom/tsens.c                       |  12 --
>   drivers/thermal/qcom/tsens.h                       |   2 -
>   drivers/thermal/rcar_gen3_thermal.c                |   4 +-
>   drivers/thermal/rzg2l_thermal.c                    |  18 +-
>   drivers/thermal/sun8i_thermal.c                    |   2 +-
>   drivers/thermal/tegra/soctherm.c                   |  32 ----
>   drivers/thermal/tegra/tegra30-tsensor.c            |   2 +-
>   drivers/thermal/thermal_core.c                     |  61 ++++---
>   drivers/thermal/thermal_core.h                     |  15 --
>   drivers/thermal/thermal_helpers.c                  |  13 +-
>   drivers/thermal/thermal_netlink.c                  |   2 +-
>   drivers/thermal/thermal_of.c                       | 201
> ++++++++++++---------
>   drivers/thermal/thermal_sysfs.c                    |  22 +--
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
>   include/linux/thermal.h                            |  26 ++-
>   include/trace/events/thermal.h                     |  28 +--
>   tools/thermal/tmon/pid.c                           |   2 +-
>   tools/thermal/tmon/tmon.h                          |   3 +
>   31 files changed, 387 insertions(+), 430 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
>   delete mode 100644
> Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
>
> --

Pulled, thanks!
