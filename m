Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5524D4180
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbiCJHFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiCJHFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:05:22 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929409AE40;
        Wed,  9 Mar 2022 23:04:21 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id d62so5389773iog.13;
        Wed, 09 Mar 2022 23:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3trs2pA3ltu2tpChD+gMtYhE9FXUdqBskzBYDh3BX48=;
        b=FJVY6qA0kJjSEXkMVsxxZQ9LfiBarTvpbEZMFsFemGaS+ewFdhtsCvFJSm8qZIuXTd
         yELV6zAjGVHfhYIamlxsQCW2mWtakw7YmiMqdPYLxD+KpjJ1bPSNJ+doIOUuaS3ip/FI
         hMB2nvDxSYPZUYOHfF6GF2ByvKgLRurJ6Le6uomOy6wVej4R3/RvQelEiKHuh+g/Hzbs
         pumjQ17j5SOXJBDQ8FsxkouoLMsrKS/pgyeWOBul2hPCT4rHOcGB10F7ejWcFn3lwqb7
         mUizBBRBHCME2gqNIH0PbU1Lt8jmcFcGUGWz9FVqK6waxYReIklKCT0QXu92MyztxRmJ
         FFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3trs2pA3ltu2tpChD+gMtYhE9FXUdqBskzBYDh3BX48=;
        b=eMeol/JOI08CVojgzcctmKxWSoj6zUwgRjGxHuehVClYW3jPykSFaRGXm4/Tf0Qcyz
         yec8ZwMdIIaTVsZMwsAjFRxV64Os3JMr7hIhpdnyr9ZJYeenCfOuWdPmGemSNz6lQ4pu
         gVbcOcEc3Hjx7fl/0YM1GmFPiwlAsXnWc8f+d6BroroN6d2jg67/r9J9ibsaJAJ+xs3k
         uDGFN575OuUuhl1FCv97cGELw8eFnDxU+t3qKo0ro3UNY20YsJK0k6Gt4HsJOyPhpk6G
         M7Y0YEaIbOHeaO8RvyDPuWHVAVDCBHWnFPVQLMLLKbzAXff29zp1MQGc6l9cExeNr0SN
         EDKg==
X-Gm-Message-State: AOAM5316Yb9cTGJcOzuPjCoF8RRtfFbUjvq9u+j4XwaJqdQiAvtXzx3P
        D2YqAimRD/xPWODuNpVbqfMU3BsK6EoKD98uHjE=
X-Google-Smtp-Source: ABdhPJztHxKPx77u95nxcfb258lVdwwgwFNbipqCgBbuRd9CeFIK4bXoFP7BIrmchRG6Rg3EFV5CQS/U8Gw5NNBvRjQ=
X-Received: by 2002:a05:6602:2b8b:b0:608:c584:a1b0 with SMTP id
 r11-20020a0566022b8b00b00608c584a1b0mr2754428iov.159.1646895860641; Wed, 09
 Mar 2022 23:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20220310013140.127026-1-hypmean.kim@samsung.com>
 <CGME20220310013130epcas3p2f4a45192b643d348aa2824cfbea47ba4@epcms2p1>
 <20220310013140.127026-3-hypmean.kim@samsung.com> <20220310015722epcms2p1572aeba5201a70f5aaf94ba0b01f3723@epcms2p1>
In-Reply-To: <20220310015722epcms2p1572aeba5201a70f5aaf94ba0b01f3723@epcms2p1>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Thu, 10 Mar 2022 12:33:45 +0530
Message-ID: <CAGOxZ500VHZkCDLt9XsdsRxzaFY2cx_ymbphE9uxT5PFTcn3Yw@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: artpec8-tmu: Add tmu driver for artpec8
To:     hypmean.kim@samsung.com
Cc:     "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>, tauseef.n@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sang Min,

On Thu, Mar 10, 2022 at 7:43 AM Sang Min Kim <hypmean.kim@samsung.com> wrote:
>
>
> Add tmu driver to handle thermal management for artpec8 SoC.
>
> This driver is derived from the tmu of exynos and additionally supports
> the thermal zone of multiple remote sensors of artpec8.
>
> Signed-off-by: sangmin kim <hypmean.kim@samsung.com>
> ---

Any reason for adding a new TMU driver here? Can this SoC use the
existing exynos_tmu driver?
In case IP is similar and there are few differences in terms of
registers offset etc,
you can use a compatible name to differentiate the same.


>  drivers/thermal/samsung/artpec8_tmu.c | 754 ++++++++++++++++++++++++++++++++++
>  1 file changed, 754 insertions(+)
>  create mode 100644 drivers/thermal/samsung/artpec8_tmu.c
>
> diff --git a/drivers/thermal/samsung/artpec8_tmu.c b/drivers/thermal/samsung/artpec8_tmu.c
> new file mode 100644
> index 0000000..d973827
> --- /dev/null
> +++ b/drivers/thermal/samsung/artpec8_tmu.c
> @@ -0,0 +1,754 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  artpec8_tmu.c - Samsung TMU (Thermal Management Unit)
> + *
> + *  Copyright (C) 2014 Samsung Electronics
> + *  Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> + *  Lukasz Majewski <l.majewski@samsung.com>
> + *
> + *  Copyright (C) 2011 Samsung Electronics
> + *  Donggeun Kim <dg77.kim@samsung.com>
> + *  Amit Daniel Kachhap <amit.kachhap@linaro.org>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/thermal/thermal_exynos.h>
> +
> +#include "../thermal_core.h"
> +
> +#define ARTPEC8_TMU_REG_TRIMINFO        0x0
> +#define ARTPEC8_TMU_REG_TRIMINFO1        0x4
> +#define ARTPEC8_TMU_REG_TRIMINFO2        0x8
> +#define ARTPEC8_TMU_REG_TRIMINFO3        0xC
> +#define ARTPEC8_TMU_REG_TRIMINFO4        0x10
> +#define ARTPEC8_TMU_REG_TRIMINFO5        0x14
> +#define ARTPEC8_TMU_REG_CONTROL                0x20
> +#define ARTPEC8_TMU_REG_CONTROL1        0x24
> +#define ARTPEC8_TMU_REG_STATUS                0x28
> +
> +#define ARTPEC8_TMU_REG_AVG_CONTROL        0x38
> +#define ARTPEC8_TMU_REG_TMU_TRIM0        0x3C
> +
> +#define ARTPEC8_TMU_REG_EMUL_CON        0x160
> +#define NUM_PROBE_OFFSET                16
> +
> +#define ARTPEC8_FIRST_POINT_TRIM        25
> +#define ARTPEC8_SECOND_POINT_TRIM        105
> +
> +#define ARTPEC8_EMUL_EN                        1
> +#define ARTPEC8_TIME_OFFSET                16
> +#define ARTPEC8_EMUL_NEXT_TIME                (0x4e20 << ARTPEC8_TIME_OFFSET)
> +
> +#define ARTPEC8_TMU_TEMP_MASK                0x1ff
> +#define ARTPEC8_CALIB_SEL_SHIFT                23
> +
> +#define ARTPEC8_EMUL_DATA_SHIFT                7
> +
> +#define ARTPEC8_T_BUF_VREF_SEL_SHIFT        18
> +#define ARTPEC8_T_BUF_SLOPE_SEL_SHIFT        18
> +#define ARTPEC8_INTEN_TRIPPING_SHIFT        7
> +#define ARTPEC8_INTEN_CLOCKDOWN_SHIFT        8
> +#define ARTPEC8_TRIMINFO_105_SHIFT        9
> +#define ARTPEC8_INTEN_FALL0_SHIFT        16
> +#define ARTPEC8_TMU_REF_VOLTAGE_SHIFT        24
> +#define ARTPEC8_TMU_REF_VOLTAGE_MASK        0x1f
> +#define ARTPEC8_TMU_BUF_SLOPE_SEL_SHIFT        8
> +#define ARTPEC8_TMU_BUF_SLOPE_SEL_MASK        0xf
> +
> +#define ARTPEC8_TMU_CONTROL_CORE_EN        1
> +#define ARTPEC8_TMU_CONTROL_AUTO_MODE        2
> +#define ARTPEC8_TMU_CONTROL_TRIP_EN        (1 << 12)
> +#define ARTPEC8_LPI_MODE_EN                (1 << 10)
> +
> +#define ARTPEC8_TRIM0_BGR_I_SHIFT        20
> +#define ARTPEC8_TRIM0_VREF_SHIFT        12
> +#define ARTPEC8_TRIM0_VBE_I_SHIFT        8
> +
> +
> +#define INTPEND_RISE_MASK                0xff
> +#define INTPEND_FALL_MASK                0xff0000
> +#define ARTPEC8_TRIM0_MASK                0xf
> +#define ARTPEC8_TRIM2_MASK                0x7
> +
> +#define ARTPEC8_TRIMINFO_TRIM0_SHIFT        18
> +
> +#define MCELSIUS                        1000
> +
> +#define LOW_TEMP_WEIGHT                        9203
> +#define HIGH_TEMP_WEIGHT                9745
> +#define TEMP_WEIGHT                        10000
> +
> +struct sensor_offset {
> +        u32 trim_offset;
> +        u32 temp_offset;
> +        u32 temp_reg_shift;
> +        u32 rise_offset;
> +        u32 fall_offset;
> +        u32 past_offset;
> +        u32 inten;
> +        u32 intpend;
> +};
> +
> +#define SENSOR(_tr, _te, _sh, _ri, _fa, _pa, _en, _pend)        \
> +        {                                                        \
> +                .trim_offset        = _tr,                                \
> +                .temp_offset        = _te,                                \
> +                .temp_reg_shift        = _sh,                                \
> +                .rise_offset        = _ri,                                \
> +                .fall_offset        = _fa,                                \
> +                .past_offset        = _pa,                                \
> +                .inten                = _en,                                \
> +                .intpend        = _pend,                        \
> +        }
> +
> +static const struct sensor_offset artpec8_sensors[] = {
> +        SENSOR(0x0,        0x40,        0,  0x50,        0x60,        0x70,        0x110,        0x118),
> +        SENSOR(0x4,        0x40,        9,  0x170,        0x180,        0x90,        0x120,        0x128),
> +        SENSOR(0x8,        0x44,        0,  0x190,        0x1a0,        0xb0,        0x130,        0x138),
> +        SENSOR(0xc,        0x44,        9,  0x1b0,        0x1c0,        0xd0,        0x140,        0x148),
> +        SENSOR(0x10,        0x44,        18, 0x1d0,        0x1e0,        0xf0,        0x150,        0x158),
> +        SENSOR(0x14,        0x48,        0,  0x1f0,        0x200,        0x250,        0x310,        0x318),
> +};
> +
> +/**
> + * struct artpec8_sensor: A structure to hold the private data of the sensor
> + * @tmudev: The tmu device which this sensor is connected.
> + * @tzd: Thermal zonde device pointer to register this sensor.
> + * @id: Identifier of the one instance of the thermal sensor.
> + * @ntrip: Number of threshols for this sensor.
> + * @triminfo_25: OTP information to trim temperature sensor error for 25C
> + * @triminfo_105: OTP information to trim temperature sensor error for 105C
> + * @trim_offset: Offset of triminfo register.
> + * @temp_offset: Offset of current temperature. The temperature values of
> + *                2 to 3 remote sensors are stored in this register.
> + * @temp_reg_shift: start location of each tempt in temp_off
> + * @rise_offset: Offset of rising threshold level 6 and 7.
> + * @fall_offset: Offset of falling thershold level 6 and 7.
> + * @past_offset: Offset of Past temperature 0,1.
> + * @inten: Offset of interrupt enable sfr.
> + * @intpend: Offset of interrupt pending sfr.
> + */
> +struct artpec8_sensor {
> +        struct artpec8_tmu_data *tmudev;
> +        struct thermal_zone_device *tzd;
> +        int id;
> +        unsigned int ntrip;
> +        u16 triminfo_25;
> +        u16 triminfo_105;
> +        u32 trim_offset;
> +        u32 temp_offset;
> +        u32 temp_reg_shift;
> +        u32 rise_offset;
> +        u32 fall_offset;
> +        u32 past_offset;
> +        u32 inten;
> +        u32 intpend;
> +};
> +
> +/**
> + * struct artpec8_tmu_data : A structure to hold the private data of the TMU
> +        driver
> + * @id: identifier of the one instance of the TMU controller.
> + * @base: base address of the single instance of the TMU controller.
> + * @irq: irq number of the TMU controller.
> + * @irq_work: pointer to the irq work structure.
> + * @lock: lock to implement synchronization.
> + * @clk: pointer to the clock structure.
> + * @cal_type: calibration type for temperature
> + * @nr_remote: number of remote temperature sensors.
> + * @sensor: variable size member including the information of each sensor
> + */
> +struct artpec8_tmu_data {
> +        int id;
> +        void __iomem *base;
> +        int irq;
> +        struct work_struct irq_work;
> +        struct mutex lock;
> +        struct clk *clk;
> +        u32 cal_type;
> +        unsigned int nr_remote;
> +
> +        struct artpec8_sensor sensor[0];
> +};
> +
> +static u16 temp_to_code(struct artpec8_sensor *sensor, int temp)
> +{
> +        int code;
> +        int weight;
> +
> +        if (sensor->tmudev->cal_type == TYPE_ONE_POINT_TRIMMING)
> +                return temp + sensor->triminfo_25 - ARTPEC8_FIRST_POINT_TRIM;
> +
> +        if (temp > ARTPEC8_FIRST_POINT_TRIM)
> +                weight = HIGH_TEMP_WEIGHT;
> +        else
> +                weight = LOW_TEMP_WEIGHT;
> +
> +        code = DIV_ROUND_CLOSEST((temp - ARTPEC8_FIRST_POINT_TRIM) *
> +                (sensor->triminfo_105 - sensor->triminfo_25) * TEMP_WEIGHT,
> +                (ARTPEC8_SECOND_POINT_TRIM - ARTPEC8_FIRST_POINT_TRIM) *
> +                weight);
> +        code += sensor->triminfo_25;
> +
> +        return (u16)code;
> +}
> +
> +static int code_to_temp(struct artpec8_sensor *sensor, u16 code)
> +{
> +        int temp;
> +        int weight;
> +
> +        if (sensor->tmudev->cal_type == TYPE_ONE_POINT_TRIMMING)
> +                return code - sensor->triminfo_25 + ARTPEC8_FIRST_POINT_TRIM;
> +
> +        if (code > sensor->triminfo_25)
> +                weight = HIGH_TEMP_WEIGHT;
> +        else
> +                weight = LOW_TEMP_WEIGHT;
> +
> +        temp = DIV_ROUND_CLOSEST((code - sensor->triminfo_25) *
> +                (ARTPEC8_SECOND_POINT_TRIM - ARTPEC8_FIRST_POINT_TRIM) * weight,
> +                (sensor->triminfo_105 - sensor->triminfo_25) * TEMP_WEIGHT);
> +        temp += ARTPEC8_FIRST_POINT_TRIM;
> +
> +        return temp;
> +}
> +
> +static void artpec8_tmu_set_trip_temp(struct artpec8_tmu_data *data,
> +                int trip, int temp, int remote)
> +{
> +        unsigned int reg_off, bit_off;
> +        u32 th;
> +        struct artpec8_sensor *sensor;
> +        unsigned int temp_rise;
> +
> +        sensor = &data->sensor[remote];
> +        temp_rise = sensor->rise_offset;
> +
> +        reg_off = ((7 - trip) / 2) * 4;
> +        bit_off = ((8 - trip) % 2);
> +
> +        th = readl(data->base + temp_rise + reg_off);
> +        th &= ~(ARTPEC8_TMU_TEMP_MASK << (16 * bit_off));
> +        th |= temp_to_code(sensor, temp) << (16 * bit_off);
> +        writel(th, data->base + temp_rise + reg_off);
> +}
> +
> +static void artpec8_tmu_set_trip_hyst(struct artpec8_tmu_data *data,
> +                int trip, int temp, int hyst, int remote)
> +{
> +        unsigned int reg_off, bit_off;
> +        u32 th;
> +        struct artpec8_sensor *sensor;
> +        unsigned int temp_fall;
> +
> +        sensor = &data->sensor[remote];
> +        temp_fall = sensor->fall_offset;
> +
> +        reg_off = ((7 - trip) / 2) * 4;
> +        bit_off = ((8 - trip) % 2);
> +
> +        th = readl(data->base + temp_fall + reg_off);
> +        th &= ~(ARTPEC8_TMU_TEMP_MASK << (16 * bit_off));
> +        th |= temp_to_code(sensor, temp - hyst) << (16 * bit_off);
> +        writel(th, data->base + temp_fall + reg_off);
> +}
> +
> +static void artpec8_enable_interrupt(struct artpec8_tmu_data *data,
> +                int sensor_idx)
> +{
> +        int i;
> +        unsigned int interrupt_en = 0;
> +        struct thermal_zone_device *tz = data->sensor[sensor_idx].tzd;
> +
> +        for (i = 0; i < data->sensor->ntrip; i++) {
> +                if (!of_thermal_is_trip_valid(tz, i))
> +                        continue;
> +                interrupt_en |= (1 << i);
> +        }
> +        writel(interrupt_en, data->base + data->sensor[sensor_idx].inten);
> +}
> +
> +static void artpec8_tmu_control(struct platform_device *pdev, bool on)
> +{
> +        struct artpec8_tmu_data *data = platform_get_drvdata(pdev);
> +        unsigned int con, con1, i;
> +        unsigned int vref;
> +        unsigned int slope;
> +        unsigned int trim0, trim0_bgr, trim0_vref, trim0_vbe, avg_mode;
> +
> +        vref = (readl(data->base + ARTPEC8_TMU_REG_TRIMINFO) >>
> +                ARTPEC8_T_BUF_VREF_SEL_SHIFT) &
> +                ARTPEC8_TMU_REF_VOLTAGE_MASK;
> +        slope = (readl(data->base + ARTPEC8_TMU_REG_TRIMINFO1) >>
> +                ARTPEC8_T_BUF_SLOPE_SEL_SHIFT) &
> +                ARTPEC8_TMU_BUF_SLOPE_SEL_MASK;
> +        con = (vref << ARTPEC8_TMU_REF_VOLTAGE_SHIFT) |
> +                (slope << ARTPEC8_TMU_BUF_SLOPE_SEL_SHIFT);
> +
> +        if (on) {
> +                for (i = 0; i < data->nr_remote; i++)
> +                        artpec8_enable_interrupt(data, i);
> +                con |= (ARTPEC8_TMU_CONTROL_CORE_EN |
> +                        ARTPEC8_TMU_CONTROL_AUTO_MODE);
> +        } else {
> +                con &= ~(ARTPEC8_TMU_CONTROL_CORE_EN);
> +        }
> +
> +        trim0_bgr = readl(data->base + ARTPEC8_TMU_REG_TRIMINFO3) >>
> +                ARTPEC8_TRIMINFO_TRIM0_SHIFT;
> +        trim0_bgr &= ARTPEC8_TRIM0_MASK;
> +        trim0_vref = readl(data->base + ARTPEC8_TMU_REG_TRIMINFO4) >>
> +                ARTPEC8_TRIMINFO_TRIM0_SHIFT;
> +        trim0_vref &= ARTPEC8_TRIM0_MASK;
> +        trim0_vbe = readl(data->base + ARTPEC8_TMU_REG_TRIMINFO5) >>
> +                ARTPEC8_TRIMINFO_TRIM0_SHIFT;
> +        trim0_vbe &= ARTPEC8_TRIM0_MASK;
> +        trim0 = trim0_bgr << ARTPEC8_TRIM0_BGR_I_SHIFT |
> +                trim0_vref << ARTPEC8_TRIM0_VREF_SHIFT |
> +                trim0_vbe << ARTPEC8_TRIM0_VBE_I_SHIFT;
> +
> +        con1 = (data->nr_remote << NUM_PROBE_OFFSET) | ARTPEC8_LPI_MODE_EN;
> +
> +        while (!readb(data->base + ARTPEC8_TMU_REG_STATUS))
> +                pr_debug("TMU busy waiting\n");
> +
> +
> +        avg_mode = readl(data->base + ARTPEC8_TMU_REG_AVG_CONTROL);
> +        avg_mode &= ~ARTPEC8_TRIM2_MASK;
> +        avg_mode |= (readl(data->base + ARTPEC8_TMU_REG_TRIMINFO2) >>
> +                ARTPEC8_TRIMINFO_TRIM0_SHIFT) & ARTPEC8_TRIM2_MASK;
> +
> +        writel(avg_mode, data->base + ARTPEC8_TMU_REG_AVG_CONTROL);
> +        writel(trim0, data->base + ARTPEC8_TMU_REG_TMU_TRIM0);
> +        writel(con1, data->base + ARTPEC8_TMU_REG_CONTROL1);
> +        writel(con, data->base + ARTPEC8_TMU_REG_CONTROL);
> +}
> +
> +static void artpec8_tmu_clear_irqs(struct artpec8_tmu_data *data, int i)
> +{
> +        u32 intp = readl(data->base + data->sensor[i].intpend);
> +
> +        writel(intp, data->base + data->sensor[i].intpend);
> +}
> +
> +static int artpec8_map_dt_data(struct platform_device *pdev)
> +{
> +        struct artpec8_tmu_data *data = platform_get_drvdata(pdev);
> +        struct device *dev;
> +        struct resource res;
> +
> +        if (!data || !pdev->dev.of_node)
> +                return -ENODEV;
> +
> +        dev = &pdev->dev;
> +        data->id = of_alias_get_id(dev->of_node, "tmuctrl");
> +        if (data->id < 0)
> +                data->id = 0;
> +
> +        data->irq = irq_of_parse_and_map(dev->of_node, 0);
> +        if (data->irq <= 0) {
> +                dev_warn(dev, "failed to get IRQ\n");
> +                return -ENODEV;
> +        }
> +
> +        if (of_address_to_resource(dev->of_node, 0, &res)) {
> +                dev_warn(dev, "failed to get Resource 0\n");
> +                return -ENODEV;
> +        }
> +
> +        data->base = devm_ioremap(dev, res.start, resource_size(&res));
> +        if (!data->base) {
> +                dev_warn(dev, "Failed to ioremap memory\n");
> +                return -EADDRNOTAVAIL;
> +        }
> +
> +        of_property_read_u32(dev->of_node, "remote_sensors",
> +                        &data->nr_remote);
> +
> +        data->cal_type = readl(data->base + ARTPEC8_TMU_REG_TRIMINFO) >>
> +                ARTPEC8_CALIB_SEL_SHIFT;
> +
> +        return 0;
> +}
> +
> +static void artpec8_tmu_work(struct work_struct *work)
> +{
> +        int i;
> +        u32 inten, intpend, rise, fall;
> +        struct artpec8_sensor *sensor;
> +        struct artpec8_tmu_data *data = container_of(work,
> +                        struct artpec8_tmu_data, irq_work);
> +
> +        for (i = 0; i < data->nr_remote; i++)
> +                thermal_zone_device_update(data->sensor[i].tzd,
> +                                THERMAL_EVENT_UNSPECIFIED);
> +
> +        mutex_lock(&data->lock);
> +        for (i = 0; i < data->nr_remote; i++) {
> +                sensor = &data->sensor[i];
> +                intpend = readl(data->base + sensor->intpend);
> +
> +                if (intpend) {
> +                        fall = intpend & INTPEND_FALL_MASK;
> +                        rise = intpend & INTPEND_RISE_MASK;
> +
> +                        if (fall) {
> +                                inten = readl(data->base + sensor->inten) &
> +                                        (~fall);
> +                                inten |= fall >> ARTPEC8_INTEN_FALL0_SHIFT;
> +                                writel(inten, data->base + sensor->inten);
> +                        }
> +
> +                        if (rise) {
> +                                inten = readl(data->base + sensor->inten) &
> +                                        (~rise);
> +                                inten |= (rise << ARTPEC8_INTEN_FALL0_SHIFT) |
> +                                        min_t(u32, rise << 1, BIT(sensor->ntrip - 1)) |
> +                                        (rise >> 1);
> +                                writel(inten, data->base + sensor->inten);
> +                        }
> +                        writel(intpend, data->base + sensor->intpend);
> +                }
> +        }
> +        mutex_unlock(&data->lock);
> +}
> +
> +static int artpec8_get_temp(void *p, int *temp)
> +{
> +        struct artpec8_sensor *sensor = p;
> +        struct artpec8_tmu_data *data;
> +        bool enabled, valid;
> +        u16 value;
> +        int ret = 0;
> +
> +        if (!sensor)
> +                return -EINVAL;
> +
> +        data = sensor->tmudev;
> +        if (!data)
> +                return -EINVAL;
> +
> +        enabled = readl(data->base + ARTPEC8_TMU_REG_CONTROL) & 0x1;
> +        valid = readl(data->base + ARTPEC8_TMU_REG_STATUS) & 0xf0;
> +        if (!enabled || !valid)
> +                return -EAGAIN;
> +
> +        mutex_lock(&data->lock);
> +
> +        value = (readl(data->base + sensor->temp_offset) >>
> +                sensor->temp_reg_shift) & ARTPEC8_TMU_TEMP_MASK;
> +        *temp = code_to_temp(sensor, value) * MCELSIUS;
> +
> +        mutex_unlock(&data->lock);
> +
> +        return ret;
> +}
> +
> +static int artpec8_tmu_set_emulation(void *p, int temp)
> +{
> +        struct artpec8_sensor *sensor = p;
> +        struct artpec8_tmu_data *data = sensor->tmudev;
> +        u32 temp_code, econ;
> +
> +        temp /= MCELSIUS;
> +
> +        mutex_lock(&data->lock);
> +
> +        temp_code = temp_to_code(sensor, temp);
> +        econ = ARTPEC8_EMUL_NEXT_TIME | temp_code << ARTPEC8_EMUL_DATA_SHIFT |
> +                ARTPEC8_EMUL_EN;
> +        writel(econ, data->base + ARTPEC8_TMU_REG_EMUL_CON);
> +
> +        mutex_unlock(&data->lock);
> +
> +        return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops artpec8_ops = {
> +        .get_temp = artpec8_get_temp,
> +        .set_emul_temp = artpec8_tmu_set_emulation,
> +};
> +
> +static void samsung_tmu_control(struct platform_device *pdev, bool on)
> +{
> +        struct artpec8_tmu_data *data = platform_get_drvdata(pdev);
> +
> +        mutex_lock(&data->lock);
> +        artpec8_tmu_control(pdev, on);
> +        mutex_unlock(&data->lock);
> +}
> +
> +static int artpec8_map_sensor_data(struct artpec8_tmu_data *data,
> +                int sensor_idx, struct artpec8_sensor *sensor)
> +{
> +        int id = sensor_idx;
> +
> +        sensor->id = id;
> +        sensor->tmudev = data;
> +        sensor->trim_offset = artpec8_sensors[id].trim_offset;
> +        sensor->temp_offset = artpec8_sensors[id].temp_offset;
> +        sensor->temp_reg_shift = artpec8_sensors[id].temp_reg_shift;
> +        sensor->rise_offset = artpec8_sensors[id].rise_offset;
> +        sensor->fall_offset = artpec8_sensors[id].fall_offset;
> +        sensor->past_offset = artpec8_sensors[id].past_offset;
> +        sensor->inten = artpec8_sensors[id].inten;
> +        sensor->intpend = artpec8_sensors[id].intpend;
> +        sensor->triminfo_25 = readl(data->base + sensor->trim_offset) &
> +                ARTPEC8_TMU_TEMP_MASK;
> +        sensor->triminfo_105 = (readl(data->base + sensor->trim_offset) >>
> +                ARTPEC8_TRIMINFO_105_SHIFT) & ARTPEC8_TMU_TEMP_MASK;
> +
> +        return 0;
> +}
> +
> +static int artpec8_register_tzd(struct platform_device *pdev)
> +{
> +        struct artpec8_tmu_data *data = platform_get_drvdata(pdev);
> +        struct artpec8_sensor *sensor;
> +        struct device *dev = &pdev->dev;
> +        int sensor_idx, ret = 0;
> +        struct thermal_zone_device *tzd;
> +        const struct thermal_trip *trips;
> +
> +        for (sensor_idx = 0; sensor_idx < data->nr_remote; sensor_idx++) {
> +                sensor = &data->sensor[sensor_idx];
> +
> +                ret = artpec8_map_sensor_data(data, sensor_idx, sensor);
> +                if (ret)
> +                        break;
> +
> +                tzd = devm_thermal_zone_of_sensor_register(dev,
> +                                sensor_idx, sensor, &artpec8_ops);
> +                if (IS_ERR(tzd))
> +                        continue;
> +
> +                sensor->tzd = tzd;
> +                trips = of_thermal_get_trip_points(tzd);
> +                if (!trips) {
> +                        dev_warn(dev,
> +                                "Cannot get trip points from device tree!\n");
> +                        ret = -ENODEV;
> +                        break;
> +                }
> +                sensor->ntrip = of_thermal_get_ntrips(tzd);
> +        }
> +
> +        return ret;
> +}
> +
> +static int artpec8_sensor_initialize(struct artpec8_tmu_data *data,
> +                int sensor_idx)
> +{
> +        struct thermal_zone_device *tzd;
> +        struct artpec8_sensor *sensor;
> +        int ret = 0, trip, temp, hyst;
> +
> +        sensor = &data->sensor[sensor_idx];
> +        if (!sensor)
> +                return -EINVAL;
> +
> +        tzd = sensor->tzd;
> +        for (trip = 0; trip < sensor->ntrip; trip++) {
> +                ret = tzd->ops->get_trip_temp(tzd, trip, &temp);
> +                if (ret)
> +                        break;
> +
> +                temp /= MCELSIUS;
> +                artpec8_tmu_set_trip_temp(data, trip, temp, sensor_idx);
> +
> +                ret = tzd->ops->get_trip_hyst(tzd, trip, &hyst);
> +                if (ret)
> +                        break;
> +
> +                hyst /= MCELSIUS;
> +                artpec8_tmu_set_trip_hyst(data, trip, temp, hyst, sensor_idx);
> +        }
> +        artpec8_tmu_clear_irqs(data, sensor_idx);
> +
> +        return ret;
> +}
> +
> +static int artpec8_tmu_initialize(struct platform_device *pdev)
> +{
> +        struct artpec8_tmu_data *data = platform_get_drvdata(pdev);
> +        int ret = 0, sensor_idx;
> +
> +        mutex_lock(&data->lock);
> +
> +        for (sensor_idx = 0; sensor_idx < data->nr_remote; sensor_idx++) {
> +                if (!readb(data->base + ARTPEC8_TMU_REG_STATUS)) {
> +                        ret = -EBUSY;
> +                        break;
> +                }
> +
> +                ret = artpec8_sensor_initialize(data, sensor_idx);
> +                if (ret)
> +                        break;
> +        }
> +
> +        mutex_unlock(&data->lock);
> +
> +        return ret;
> +}
> +
> +static irqreturn_t artpec8_tmu_irq(int irq, void *id)
> +{
> +        struct artpec8_tmu_data *data = id;
> +
> +        disable_irq_nosync(irq);
> +        schedule_work(&data->irq_work);
> +        enable_irq(data->irq);
> +
> +        return IRQ_HANDLED;
> +}
> +
> +static const struct of_device_id artpec8_tmu_match[] = {
> +        { .compatible = "axis,artpec8-tmu", },
> +        {},
> +};
> +MODULE_DEVICE_TABLE(of, artpec8_tmu_match);
> +
> +static int artpec8_tmu_probe(struct platform_device *pdev)
> +{
> +        int ret, sensor_idx, nr_remote;
> +        struct device *dev;
> +        const struct of_device_id *id;
> +        struct artpec8_tmu_data *data;
> +
> +        if (pdev->dev.of_node)
> +                dev = &pdev->dev;
> +        else
> +                dev = pdev->dev.parent;
> +
> +        id = of_match_node(artpec8_tmu_match, dev->of_node);
> +        if (id) {
> +                data = (struct artpec8_tmu_data *)id->data;
> +        } else {
> +                dev_warn(dev, "dev id error\n");
> +                return -EINVAL;
> +        }
> +
> +        of_property_read_u32(dev->of_node, "remote_sensors", &nr_remote);
> +        data = devm_kzalloc(dev, sizeof(struct artpec8_tmu_data) +
> +                        (sizeof(struct artpec8_sensor) * nr_remote),
> +                        GFP_KERNEL);
> +        if (!data)
> +                return -ENOMEM;
> +
> +        platform_set_drvdata(pdev, data);
> +        mutex_init(&data->lock);
> +
> +        ret = artpec8_map_dt_data(pdev);
> +        if (ret)
> +                return ret;
> +
> +        ret = artpec8_register_tzd(pdev);
> +        if (ret)
> +                return -EINVAL;
> +
> +        ret = artpec8_tmu_initialize(pdev);
> +        if (ret) {
> +                dev_warn(dev, "Failed to initialize TMU\n");
> +                goto err_thermal;
> +        }
> +
> +        INIT_WORK(&data->irq_work, artpec8_tmu_work);
> +
> +        data->clk = devm_clk_get(dev, "tmu_apbif");
> +        if (IS_ERR(data->clk)) {
> +                dev_warn(dev, "Failed to get clock\n");
> +                ret = PTR_ERR(data->clk);
> +                return -ENODEV;
> +        }
> +
> +        ret = clk_prepare(data->clk);
> +        if (ret) {
> +                dev_err(dev, "Failed to prepare clock\n");
> +                goto err_clk;
> +        }
> +
> +        ret = devm_request_irq(dev, data->irq, artpec8_tmu_irq,
> +                IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(dev), data);
> +        if (ret) {
> +                dev_warn(dev, "Failed to request irq: %d\n", data->irq);
> +                goto err_thermal;
> +        }
> +
> +        samsung_tmu_control(pdev, true);
> +
> +        return 0;
> +
> +err_thermal:
> +        for (sensor_idx = 0; sensor_idx < data->nr_remote; sensor_idx++)
> +                thermal_zone_of_sensor_unregister(dev,
> +                                data->sensor[sensor_idx].tzd);
> +err_clk:
> +        clk_unprepare(data->clk);
> +
> +        return ret;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int artpec8_tmu_suspend(struct device *dev)
> +{
> +        samsung_tmu_control(to_platform_device(dev), false);
> +
> +        return 0;
> +}
> +
> +static int artpec8_tmu_resume(struct device *dev)
> +{
> +        samsung_tmu_control(to_platform_device(dev), true);
> +
> +        return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(artpec8_tmu_pm,
> +                         artpec8_tmu_suspend, artpec8_tmu_resume);
> +#define ARTPEC8_TMU_PM        (&artpec8_tmu_pm)
> +#else
> +#define ARTPEC8_TMU_PM        NULL
> +#endif
> +
> +static int artpec8_tmu_remove(struct platform_device *pdev)
> +{
> +        struct artpec8_tmu_data *data = platform_get_drvdata(pdev);
> +        struct device *dev = &pdev->dev;
> +        int i;
> +
> +        for (i = 0; i < data->nr_remote; i++)
> +                thermal_zone_of_sensor_unregister(dev,
> +                                data->sensor[i].tzd);
> +        samsung_tmu_control(pdev, false);
> +
> +        clk_unprepare(data->clk);
> +
> +        return 0;
> +}
> +
> +static struct platform_driver artpec8_tmu_driver = {
> +        .driver = {
> +                .name   = "artpec8-tmu",
> +                .pm     = ARTPEC8_TMU_PM,
> +                .of_match_table = artpec8_tmu_match,
> +        },
> +        .probe = artpec8_tmu_probe,
> +        .remove        = artpec8_tmu_remove,
> +};
> +
> +module_platform_driver(artpec8_tmu_driver);
> +
> +MODULE_DESCRIPTION("ARTPEC8 TMU Driver");
> +MODULE_AUTHOR("Sangmin Kim <hypmean.kim@samsung.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:artpec8-tmu");
> --
> 2.9.5
>
>



-- 
Regards,
Alim
