Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C627052683E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382958AbiEMRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382933AbiEMRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:23:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D2C6EC7D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:23:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f2so5278736wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9JeC/UwGxq2Eyj4KJe9rSsGrpMRSgX/mq86/Sh1LXC8=;
        b=sP/9mb3p4SMkERCWlqWhOasd7ln5EzMoc/ho71rWbV5OjvjdEdtjagShwyCmIhtObB
         p2ms3JFqfTxHCGkYf2FGWAjUUpzKXF7kS/2amNwK0CK2spbdSJHiehDh4zm6hzHl14mY
         CkpcFiPXrn5D19GbG5vjqnJ3jEBj3cShkYtDuhC4pPm9rakJFjMsRhoNIXJYQ6Rk4yOH
         toH5DVFPv9Ig+iGvARQDVgiCuJ5k2TiFOduvhrnAithd4sw1Lu4NMQmOqRN0D4ddClv5
         7KnyzWZONMb56pP0j+aGNrCuwV/2F+UtUyuoUAgV1XPzMQI4D4rfuDsJh69BUtWJouto
         /RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9JeC/UwGxq2Eyj4KJe9rSsGrpMRSgX/mq86/Sh1LXC8=;
        b=dpdvV2A40yfXwQHR4lZ8CHmiD2j/x367jU+k0R9/hbm/ang7xvAaQerIUX6JKGI6Co
         6POZP/w88GS1xpOhZBkNLi2Qqq+Of+gYhf1Vee0+51NWuxUS2tSXpH0UqhPwMsf9VeG0
         DW3e94evfSlvGkgpUDUwL44Y3xHeftJ24g0KUMdX0kqxsUiUGo376O/oEcvVA/swP6La
         C0OR/UuwfD+LOCzsCVkXHQi3iwrDrWfhhdKSnNiDVbArln0wR6WiWPsiB6t8CympSvNg
         klykHHN7YMMF0961aa79+Nh+vzFCWePObjxL0lovNlooTHht0Vz9sT8EE0zC1I1/Jdm7
         At0g==
X-Gm-Message-State: AOAM533+Dh9rkmimj2JY0sGJZ8OJPXZH5F7RxzN3zttwvEornHV4VrQ4
        ipnkg2kC9F0x90jqlk6dT+LJbg==
X-Google-Smtp-Source: ABdhPJyAnD6twOkIHdeDiY+tGgaCRVKJA40sfewef7gLVL5NkSQK45NAtkIehF6CxV8wsR4e0UpFZw==
X-Received: by 2002:a5d:4b89:0:b0:20c:52e3:3073 with SMTP id b9-20020a5d4b89000000b0020c52e33073mr4997148wrt.140.1652462627136;
        Fri, 13 May 2022 10:23:47 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id p15-20020a7bcdef000000b00394517e7d98sm2997981wmj.25.2022.05.13.10.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 10:23:46 -0700 (PDT)
Message-ID: <63f1c4a0-d2c6-8157-5da0-198c2d8d1013@linaro.org>
Date:   Fri, 13 May 2022 19:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 00/14] thermal OF rework
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

if you are ok with this series, I'll pick it up.

Is that ok ?




On 07/05/2022 14:54, Daniel Lezcano wrote:
> The thermal framework initialization with the device tree appears to
> be complicated and hard to make it to evolve.
> 
> It contains duplication of almost the same thermal generic structures
> and has an assymetric initialization making hard any kind of serious
> changes for more complex features. One of them is the multiple sensors
> support per thermal zone.
> 
> In order to set the scene for the aforementioned feature with generic
> code, we need to cleanup and rework the device tree initialization.
> 
> However this rework is not obvious because of the multiple components
> entering in the composition of a thermal zone and being initialized at
> different moments. For instance, a cooling device can be initialized
> before a sensor, so the thermal zones must exist before the cooling
> device as well as the sensor. This asynchonous initialization forces
> the thermal zone to be created with fake ops because they are
> mandotory and build a list of cooling devices which is used to lookup
> afterwards when the cooling device driver is registering itself.
> 
> As there could be a large number of changes, this first series provide
> some steps forward for a simpler device tree initialization.
> 
> Changelog:
>   - V2:
>     - Drop patch 1/15 which contains too many changes for a simple
>       structure renaming. This could be addressed in a separate series as
>       it is not necessary for the OF rework
>       
>     - Fixed of_node_put with gchild not initialized as reported by
>       kbuild and Dan Carpenter
> 
>   - V1:
>     - Initial post
> 
> Daniel Lezcano (14):
>    thermal/core: Change thermal_zone_ops to thermal_sensor_ops
>    thermal/core: Add a thermal sensor structure in the thermal zone
>    thermal/core: Remove duplicate information when an error occurs
>    thermal/of: Replace device node match with device node search
>    thermal/of: Remove the device node pointer for thermal_trip
>    thermal/of: Move thermal_trip structure to thermal.h
>    thermal/core: Remove unneeded EXPORT_SYMBOLS
>    thermal/core: Move thermal_set_delay_jiffies to static
>    thermal/core: Rename trips to ntrips
>    thermal/core: Add thermal_trip in thermal_zone
>    thermal/core: Register with the trip points
>    thermal/of: Store the trips in the thermal zone
>    thermal/of: Use thermal trips stored in the thermal zone
>    thermal/of: Initialize trip points separately
> 
>   .../driver-api/thermal/sysfs-api.rst          |   2 +-
>   drivers/acpi/thermal.c                        |   6 +-
>   .../ethernet/chelsio/cxgb4/cxgb4_thermal.c    |   2 +-
>   .../ethernet/mellanox/mlxsw/core_thermal.c    |   6 +-
>   drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   2 +-
>   drivers/platform/x86/acerhdf.c                |   2 +-
>   drivers/power/supply/power_supply_core.c      |   2 +-
>   drivers/thermal/armada_thermal.c              |   2 +-
>   drivers/thermal/broadcom/bcm2835_thermal.c    |   2 +-
>   drivers/thermal/da9062-thermal.c              |   2 +-
>   drivers/thermal/dove_thermal.c                |   2 +-
>   drivers/thermal/gov_bang_bang.c               |   6 +-
>   drivers/thermal/gov_fair_share.c              |  10 +-
>   drivers/thermal/gov_power_allocator.c         |  22 +-
>   drivers/thermal/gov_step_wise.c               |   4 +-
>   drivers/thermal/imx_thermal.c                 |   2 +-
>   .../intel/int340x_thermal/int3400_thermal.c   |   2 +-
>   .../int340x_thermal/int340x_thermal_zone.c    |   6 +-
>   .../int340x_thermal/int340x_thermal_zone.h    |   4 +-
>   .../processor_thermal_device.c                |   4 +-
>   .../processor_thermal_device_pci.c            |   2 +-
>   drivers/thermal/intel/intel_pch_thermal.c     |   2 +-
>   .../thermal/intel/intel_quark_dts_thermal.c   |   2 +-
>   drivers/thermal/intel/intel_soc_dts_iosf.c    |   2 +-
>   drivers/thermal/intel/x86_pkg_temp_thermal.c  |   2 +-
>   drivers/thermal/kirkwood_thermal.c            |   2 +-
>   drivers/thermal/rcar_gen3_thermal.c           |   6 +-
>   drivers/thermal/rcar_thermal.c                |   4 +-
>   drivers/thermal/samsung/exynos_tmu.c          |   6 +-
>   drivers/thermal/spear_thermal.c               |   2 +-
>   drivers/thermal/st/st_thermal.c               |   2 +-
>   drivers/thermal/tegra/soctherm.c              |  10 +-
>   drivers/thermal/tegra/tegra30-tsensor.c       |   6 +-
>   drivers/thermal/thermal_core.c                | 102 ++++----
>   drivers/thermal/thermal_core.h                |  25 +-
>   drivers/thermal/thermal_helpers.c             |  35 ++-
>   drivers/thermal/thermal_hwmon.c               |   4 +-
>   drivers/thermal/thermal_netlink.c             |  10 +-
>   drivers/thermal/thermal_of.c                  | 221 ++++++++++--------
>   drivers/thermal/thermal_sysfs.c               |  62 ++---
>   include/linux/thermal.h                       |  34 ++-
>   41 files changed, 341 insertions(+), 290 deletions(-)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
