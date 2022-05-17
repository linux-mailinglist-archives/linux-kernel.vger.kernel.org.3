Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84452A754
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349951AbiEQPtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiEQPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:49:13 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78684236;
        Tue, 17 May 2022 08:49:12 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f863469afbso192617717b3.0;
        Tue, 17 May 2022 08:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWogli/pW05aFBBg7KsBp0A7vldGxHspbOQvXcRSAFM=;
        b=i93WRrzkXs+KjXb6GuXX9zKTZeVl27E/vZ4MO7Z6S5FPlVYUMPZHxJ0qV2idvOL/Ws
         HIvIaT0r3ddV0SqQvhERqN/jzb1n0xcszdK74lrBAvGCRIVi40qqViFdYU0p38YTDUEF
         CA5E1x1h2hY5YFr0x+W3sAk8ohHKUFwtKdKkTK0cx9W+z2KNA2/bGJPAXhPkvuK8bHHB
         dyV8MLiv+FscoGvOMkkdfp7oomHZgDSBDDIDnh6a/Kgspai5Fedmfivyw9e8JuZEn0yN
         06v5+jVzgjpWbaZlzUYNRnKfIn0rJwR1CIf7CniGZ8DO1uMZFOnMyxWqtJvnxFo0HDio
         gALw==
X-Gm-Message-State: AOAM53062TACYm4qJpXJGTyuMl5oRRG+nJybg79U/wCZaoy7FnQcXK+q
        L1RVL2vfQS2rLe05UFuLjsCqfMFtmt+gUEJNNyA=
X-Google-Smtp-Source: ABdhPJz+VVjgUE0zkQrHgO9YJFE3f4UIkeP8cSUtkZc6vH6YKRwei6tjzDlaCIlEm/jsPuiRZM3A/VYRO9+O+Fm7jS4=
X-Received: by 2002:a81:91d4:0:b0:2fe:e300:3581 with SMTP id
 i203-20020a8191d4000000b002fee3003581mr14901615ywg.7.1652802551620; Tue, 17
 May 2022 08:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org> <20220426221523.3056696-11-daniel.lezcano@linexp.org>
In-Reply-To: <20220426221523.3056696-11-daniel.lezcano@linexp.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 17:49:00 +0200
Message-ID: <CAJZ5v0gU2DKN8=Me0=fwKLC-ZOL=W4dPaSCpBWO+3FQfMVGgXA@mail.gmail.com>
Subject: Re: [PATCH 10/15] thermal/core: Rename trips to ntrips
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:15 AM Daniel Lezcano
<daniel.lezcano@linexp.org> wrote:
>
> In order to use thermal trips defined in the thermal structure, rename
> the 'trips' field to 'ntrips' to have the 'trips' field containing the
> thermal trip points.

So I would call this trips_count.

>
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/gov_fair_share.c        |  6 +++---
>  drivers/thermal/gov_power_allocator.c   |  4 ++--
>  drivers/thermal/tegra/tegra30-tsensor.c |  2 +-
>  drivers/thermal/thermal_core.c          | 20 ++++++++++----------
>  drivers/thermal/thermal_helpers.c       |  4 ++--
>  drivers/thermal/thermal_netlink.c       |  2 +-
>  drivers/thermal/thermal_sysfs.c         | 22 +++++++++++-----------
>  include/linux/thermal.h                 |  2 +-
>  8 files changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
> index 3ce42a8e9dbd..82a89465a614 100644
> --- a/drivers/thermal/gov_fair_share.c
> +++ b/drivers/thermal/gov_fair_share.c
> @@ -25,10 +25,10 @@ static int get_trip_level(struct thermal_zone *tz)
>         int trip_temp;
>         enum thermal_trip_type trip_type;
>
> -       if (tz->trips == 0 || !tz->sensor.ops->get_trip_temp)
> +       if (tz->ntrips == 0 || !tz->sensor.ops->get_trip_temp)
>                 return 0;
>
> -       for (count = 0; count < tz->trips; count++) {
> +       for (count = 0; count < tz->ntrips; count++) {
>                 tz->sensor.ops->get_trip_temp(tz, count, &trip_temp);
>                 if (tz->temperature < trip_temp)
>                         break;
> @@ -53,7 +53,7 @@ static long get_target_state(struct thermal_zone *tz,
>
>         cdev->ops->get_max_state(cdev, &max_state);
>
> -       return (long)(percentage * level * max_state) / (100 * tz->trips);
> +       return (long)(percentage * level * max_state) / (100 * tz->ntrips);
>  }
>
>  /**
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 448baaa642a5..3385e8345f73 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -527,7 +527,7 @@ static void get_governor_trips(struct thermal_zone *tz,
>         last_active = INVALID_TRIP;
>         last_passive = INVALID_TRIP;
>
> -       for (i = 0; i < tz->trips; i++) {
> +       for (i = 0; i < tz->ntrips; i++) {
>                 enum thermal_trip_type type;
>                 int ret;
>
> @@ -668,7 +668,7 @@ static int power_allocator_bind(struct thermal_zone *tz)
>
>         get_governor_trips(tz, params);
>
> -       if (tz->trips > 0) {
> +       if (tz->ntrips > 0) {
>                 ret = tz->sensor.ops->get_trip_temp(tz,
>                                                     params->trip_max_desired_temperature,
>                                                     &control_temp);
> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
> index ad35a9694845..2678f2111070 100644
> --- a/drivers/thermal/tegra/tegra30-tsensor.c
> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -316,7 +316,7 @@ static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone *tzd,
>         *hot_trip  = 85000;
>         *crit_trip = 90000;
>
> -       for (i = 0; i < tzd->trips; i++) {
> +       for (i = 0; i < tzd->ntrips; i++) {
>                 enum thermal_trip_type type;
>                 int trip_temp;
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index e741c932236e..79cb9e0a7229 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -505,7 +505,7 @@ void thermal_zone_update(struct thermal_zone *tz,
>
>         tz->notify_event = event;
>
> -       for (count = 0; count < tz->trips; count++)
> +       for (count = 0; count < tz->ntrips; count++)
>                 handle_thermal_trip(tz, count);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_update);
> @@ -630,7 +630,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone *tz,
>         unsigned long max_state;
>         int result, ret;
>
> -       if (trip >= tz->trips || trip < 0)
> +       if (trip >= tz->ntrips || trip < 0)
>                 return -EINVAL;
>
>         list_for_each_entry(pos1, &thermal_tz_list, node) {
> @@ -811,7 +811,7 @@ static void __bind(struct thermal_zone *tz, int mask,
>  {
>         int i, ret;
>
> -       for (i = 0; i < tz->trips; i++) {
> +       for (i = 0; i < tz->ntrips; i++) {
>                 if (mask & (1 << i)) {
>                         unsigned long upper, lower;
>
> @@ -1056,7 +1056,7 @@ static void __unbind(struct thermal_zone *tz, int mask,
>  {
>         int i;
>
> -       for (i = 0; i < tz->trips; i++)
> +       for (i = 0; i < tz->ntrips; i++)
>                 if (mask & (1 << i))
>                         thermal_zone_unbind_cooling_device(tz, i, cdev);
>  }
> @@ -1168,7 +1168,7 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
>  /**
>   * thermal_zone_register() - register a new thermal zone device
>   * @type:      the thermal zone device type
> - * @trips:     the number of trip points the thermal zone support
> + * @ntrips:    the number of trip points the thermal zone support
>   * @mask:      a bit string indicating the writeablility of trip points
>   * @devdata:   private device data
>   * @ops:       standard thermal zone device callbacks
> @@ -1190,7 +1190,7 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
>   * IS_ERR*() helpers.
>   */
>  struct thermal_zone *
> -thermal_zone_register(const char *type, int trips, int mask,
> +thermal_zone_register(const char *type, int ntrips, int mask,
>                              void *devdata, struct thermal_sensor_ops *ops,
>                              struct thermal_zone_params *tzp, int passive_delay,
>                              int polling_delay)
> @@ -1214,7 +1214,7 @@ thermal_zone_register(const char *type, int trips, int mask,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
> +       if (ntrips > THERMAL_MAX_TRIPS || ntrips < 0 || mask >> ntrips) {
>                 pr_err("Incorrect number of thermal trips\n");
>                 return ERR_PTR(-EINVAL);
>         }
> @@ -1224,7 +1224,7 @@ thermal_zone_register(const char *type, int trips, int mask,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
> +       if (ntrips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
>                 return ERR_PTR(-EINVAL);
>
>         tz = kzalloc(sizeof(*tz), GFP_KERNEL);
> @@ -1254,7 +1254,7 @@ thermal_zone_register(const char *type, int trips, int mask,
>         tz->tzp = tzp;
>         tz->device.class = &thermal_class;
>         tz->devdata = devdata;
> -       tz->trips = trips;
> +       tz->ntrips = ntrips;
>
>         thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>         thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> @@ -1272,7 +1272,7 @@ thermal_zone_register(const char *type, int trips, int mask,
>         if (result)
>                 goto release_device;
>
> -       for (count = 0; count < trips; count++) {
> +       for (count = 0; count < ntrips; count++) {
>                 if (tz->sensor.ops->get_trip_type(tz, count, &trip_type) ||
>                     tz->sensor.ops->get_trip_temp(tz, count, &trip_temp) ||
>                     !trip_temp)
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index aa687dee4d64..183bbec4d492 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -89,7 +89,7 @@ int thermal_zone_get_temp(struct thermal_zone *tz, int *temp)
>         ret = tz->sensor.ops->get_temp(tz, temp);
>
>         if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
> -               for (count = 0; count < tz->trips; count++) {
> +               for (count = 0; count < tz->ntrips; count++) {
>                         ret = tz->sensor.ops->get_trip_type(tz, count, &type);
>                         if (!ret && type == THERMAL_TRIP_CRITICAL) {
>                                 ret = tz->sensor.ops->get_trip_temp(tz, count,
> @@ -137,7 +137,7 @@ void thermal_zone_set_trips(struct thermal_zone *tz)
>         if (!tz->sensor.ops->set_trips || !tz->sensor.ops->get_trip_hyst)
>                 goto exit;
>
> -       for (i = 0; i < tz->trips; i++) {
> +       for (i = 0; i < tz->ntrips; i++) {
>                 int trip_low;
>
>                 tz->sensor.ops->get_trip_temp(tz, i, &trip_temp);
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index 0e95f113d525..0b770af9aab3 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -469,7 +469,7 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
>
>         mutex_lock(&tz->lock);
>
> -       for (i = 0; i < tz->trips; i++) {
> +       for (i = 0; i < tz->ntrips; i++) {
>
>                 enum thermal_trip_type type;
>                 int temp, hyst = 0;
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 33d8c9f47990..63ea7aad3217 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -416,15 +416,15 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
>         int indx;
>
>         /* This function works only for zones with at least one trip */
> -       if (tz->trips <= 0)
> +       if (tz->ntrips <= 0)
>                 return -EINVAL;
>
> -       tz->trip_type_attrs = kcalloc(tz->trips, sizeof(*tz->trip_type_attrs),
> +       tz->trip_type_attrs = kcalloc(tz->ntrips, sizeof(*tz->trip_type_attrs),
>                                       GFP_KERNEL);
>         if (!tz->trip_type_attrs)
>                 return -ENOMEM;
>
> -       tz->trip_temp_attrs = kcalloc(tz->trips, sizeof(*tz->trip_temp_attrs),
> +       tz->trip_temp_attrs = kcalloc(tz->ntrips, sizeof(*tz->trip_temp_attrs),
>                                       GFP_KERNEL);
>         if (!tz->trip_temp_attrs) {
>                 kfree(tz->trip_type_attrs);
> @@ -432,7 +432,7 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
>         }
>
>         if (tz->sensor.ops->get_trip_hyst) {
> -               tz->trip_hyst_attrs = kcalloc(tz->trips,
> +               tz->trip_hyst_attrs = kcalloc(tz->ntrips,
>                                               sizeof(*tz->trip_hyst_attrs),
>                                               GFP_KERNEL);
>                 if (!tz->trip_hyst_attrs) {
> @@ -442,7 +442,7 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
>                 }
>         }
>
> -       attrs = kcalloc(tz->trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
> +       attrs = kcalloc(tz->ntrips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
>         if (!attrs) {
>                 kfree(tz->trip_type_attrs);
>                 kfree(tz->trip_temp_attrs);
> @@ -451,7 +451,7 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
>                 return -ENOMEM;
>         }
>
> -       for (indx = 0; indx < tz->trips; indx++) {
> +       for (indx = 0; indx < tz->ntrips; indx++) {
>                 /* create trip type attribute */
>                 snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
>                          "trip_point_%d_type", indx);
> @@ -478,7 +478,7 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
>                         tz->trip_temp_attrs[indx].attr.store =
>                                                         trip_point_temp_store;
>                 }
> -               attrs[indx + tz->trips] = &tz->trip_temp_attrs[indx].attr.attr;
> +               attrs[indx + tz->ntrips] = &tz->trip_temp_attrs[indx].attr.attr;
>
>                 /* create Optional trip hyst attribute */
>                 if (!tz->sensor.ops->get_trip_hyst)
> @@ -496,10 +496,10 @@ static int create_trip_attrs(struct thermal_zone *tz, int mask)
>                         tz->trip_hyst_attrs[indx].attr.store =
>                                         trip_point_hyst_store;
>                 }
> -               attrs[indx + tz->trips * 2] =
> +               attrs[indx + tz->ntrips * 2] =
>                                         &tz->trip_hyst_attrs[indx].attr.attr;
>         }
> -       attrs[tz->trips * 3] = NULL;
> +       attrs[tz->ntrips * 3] = NULL;
>
>         tz->trips_attribute_group.attrs = attrs;
>
> @@ -540,7 +540,7 @@ int thermal_zone_create_device_groups(struct thermal_zone *tz,
>         for (i = 0; i < size - 2; i++)
>                 groups[i] = thermal_zone_attribute_groups[i];
>
> -       if (tz->trips) {
> +       if (tz->ntrips) {
>                 result = create_trip_attrs(tz, mask);
>                 if (result) {
>                         kfree(groups);
> @@ -561,7 +561,7 @@ void thermal_zone_destroy_device_groups(struct thermal_zone *tz)
>         if (!tz)
>                 return;
>
> -       if (tz->trips)
> +       if (tz->ntrips)
>                 destroy_trip_attrs(tz);
>
>         kfree(tz->device.groups);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c3bd01ac4cb0..e58a2f053e1c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -170,7 +170,7 @@ struct thermal_zone {
>         struct thermal_attr *trip_hyst_attrs;
>         enum thermal_device_mode mode;
>         void *devdata;
> -       int trips;
> +       int ntrips;
>         unsigned long trips_disabled;   /* bitmap for disabled trips */
>         unsigned long passive_delay_jiffies;
>         unsigned long polling_delay_jiffies;
> --
> 2.25.1
>
