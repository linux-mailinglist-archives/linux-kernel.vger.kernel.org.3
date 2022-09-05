Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36DD5AD7C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiIEQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiIEQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:45:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F724F3A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:44:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w5so12037026wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=K1MTDdfAKz9aoSX8ilXubTYZq/WPr36VrJHx6svKATQ=;
        b=Mdbe4lNEjOKt1m/PIP5k4T93n4/hWuCfvqW5xyt5F1giDcWH5pRihFrgnYzNZ6jH3N
         PVthLMZOn1TijTS8UGOomkkEkjytWXbUddSTbGw++X9FxICXlCXjqAZiIosODJeyVsnT
         IdEuI6wOELPjKqrtgVPH8p24mbfxW0XZrMhJf0AaSr8uDQqUrsz0EHyQDRVluGPTqKDo
         puTSZeqE7aDznZMvOd1Y04Xqt6sQDGsX2yV/3hNZnpICYlkXlVZ4dI8PC6FGCMyFuXUR
         Nc4EcvRP+25XqhfkKKeF09qeCllHAMOWhggmi9aymtaYzY+YaMOFm4mbmZ9qbWU79/za
         +pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K1MTDdfAKz9aoSX8ilXubTYZq/WPr36VrJHx6svKATQ=;
        b=sdCIJGclZzgIkW1BSxQLL5bOBH3BHXhbMDUthFWY7+8gO4kVTPiCyJoYqoHuAezxV4
         vWQYewggR/8pg3hFGZVnIqNxPgrzaKCw7IWhc8ZzKfcOV2uowMIfqD/2SO2m8wYfDyQe
         WUGYVJR9dMwv6QdZSAlQgqEykoWDHMfkO8g4D/J06Rq8XP8WTuwwC8mGlJshFImR5n5x
         DmVR7Z03FXsIQReyW2J3njEhyilf9LxUtqe8o140LGNFFx4BR1hiIkmyAhUzWI0KYU3/
         XH0+qNBIMJ6TODqjMuCtkEdbDDUybxN5PGZnBMKK4jSyysdduLbakGj6bjzltmBmPc7O
         ARBw==
X-Gm-Message-State: ACgBeo3gd+5VMu7eyvKRmhfuI1hq0H9LOJNBNywYpGgAeWZYy6Esg7v6
        k9X5SX3Vt3TanzhspdP5HzML3cwqRcg0CQ==
X-Google-Smtp-Source: AA6agR7t7aJ+mQvwyZ7GyHu2aiCC097TUevBiMrtfX3x5O01CUJBT+T+h8nzcxw1HlNWIIR8vtWjpg==
X-Received: by 2002:adf:d1ec:0:b0:226:d538:40b0 with SMTP id g12-20020adfd1ec000000b00226d53840b0mr23811675wrd.693.1662396296690;
        Mon, 05 Sep 2022 09:44:56 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f3-20020a1cc903000000b003a604a29a34sm11217135wmb.35.2022.09.05.09.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 09:44:56 -0700 (PDT)
Message-ID: <e2bcc0db-8810-2652-0eba-9cdc096b2054@linaro.org>
Date:   Mon, 5 Sep 2022 18:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v9,4/7] thermal: mediatek: Add LVTS driver for mt8192
 thermal zones
To:     bchihi@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-5-bchihi@baylibre.com>
Content-Language: en-US
In-Reply-To: <20220817080757.352021-5-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Balsam,

On 17/08/2022 10:07, bchihi@baylibre.com wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add LVTS v4 (Low Voltage Thermal Sensor) driver to report junction
> temperatures in MediaTek SoC mt8192 and register the maximum temperature
> of sensors and each sensor as a thermal zone.

As it is a new driver submission, a more detailed hardware description 
of the sensors may help to have a better understanding of the driver 
implementation

I think also the patch size is too big and the driver should be 
submitted with a reduced number of changes.

The header file should be simplified as much as possible. As well as the 
structures.

The driver initialization should be lvts_v4_init -> lvts_init, that 
means one function to init and one to exit. No other functions being 
called from lvts_v4 to lvts

Overall the driver is very complex and hard to review. I tried to review 
as much as possible but there is too much code. So I gave up the review 
after digging into too many details to be reworked.

See below

> Co-developed-by: Yu-Chia Chang <ethan.chang@mediatek.com>
> Signed-off-by: Yu-Chia Chang <ethan.chang@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Co-developed-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Co-developed-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>   drivers/thermal/mediatek/Kconfig        |  21 +
>   drivers/thermal/mediatek/Makefile       |   2 +
>   drivers/thermal/mediatek/lvts_thermal.c | 861 ++++++++++++++++++++++++
>   drivers/thermal/mediatek/lvts_thermal.h | 385 +++++++++++
>   drivers/thermal/mediatek/lvts_v4.c      | 249 +++++++
>   5 files changed, 1518 insertions(+)
>   create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
>   create mode 100644 drivers/thermal/mediatek/lvts_thermal.h
>   create mode 100644 drivers/thermal/mediatek/lvts_v4.c
> 
> diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
> index 8ff32370b591..02a1b3b42ce0 100644
> --- a/drivers/thermal/mediatek/Kconfig
> +++ b/drivers/thermal/mediatek/Kconfig
> @@ -19,4 +19,25 @@ config MTK_SOC_THERMAL
>   	  information for MediaTek platforms. This driver configures
>   	  thermal controllers to collect temperature via AUXADC interface.
>   
> +config MTK_LVTS_THERMAL
> +	tristate "LVTS temperature sensor driver for MediaTek SoCs"
> +	depends on HAS_IOMEM
> +	depends on NVMEM
> +	depends on RESET_CONTROLLER
> +	help
> +	  Enable this option if you want to get SoC temperature information
> +	  for MediaTek platforms. This driver configures LVTS
> +	  (Low Voltage Thermal Sensor) thermal controllers to collect
> +	  temperatures via ASIF (Analog Serial Interface).

lvts_thermal.c is some kindof library and should be compiled 
unconditionnaly if MTK_LVTS_V4

So the block above should disappear. The help moved below and the option 
'if MTK_LVTS_THERMAL' removed.

When MTK_LVTS_V4 is set, then it selects MTK_LVTS_THERMAL. All the 
export symbols can be removed from lvts_thermal

> +if MTK_LVTS_THERMAL > +
> +config MTK_LVTS_V4
> +	tristate "LVTS v4 driver for MediaTek SoCs"
> +	help
> +	  Enable this option if you want to get temperature information
> +	  for LVTS v4 SoCs.
> +
> +endif
> +
>   endif
> diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
> index bec325f06a46..e4e62d726776 100644
> --- a/drivers/thermal/mediatek/Makefile
> +++ b/drivers/thermal/mediatek/Makefile
> @@ -1 +1,3 @@
>   obj-$(CONFIG_MTK_SOC_THERMAL)		+= auxadc_thermal.o
> +obj-$(CONFIG_MTK_LVTS_THERMAL)		+= lvts_thermal.o
> +obj-$(CONFIG_MTK_LVTS_V4)			+= lvts_v4.o
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> new file mode 100644
> index 000000000000..a1681b914c69
> --- /dev/null
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -0,0 +1,861 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/thermal.h>
> +#include "lvts_thermal.h"
> +
> +static int lvts_raw_to_temp(struct lvts_formula_coeff *co, unsigned int msr_raw)
> +{
> +	/* This function returns degree mC */

nit: extra line

> +	int temp;
> +
> +	temp = (co->a * ((unsigned long long)msr_raw)) >> 14;
> +	temp = temp + co->golden_temp * 500 + co->b;
> +
> +	return temp;
> +}
> +
> +static unsigned int lvts_temp_to_raw(struct lvts_formula_coeff *co, int temp)
> +{
> +	unsigned int msr_raw;
> +
> +	msr_raw = div_s64((s64)((co->golden_temp * 500 + co->b - temp)) << 14, (-1 * co->a));
> +
> +	return msr_raw;
> +}

Please explain and document the formulas raw <--> temp above
> +
> +static int soc_temp_lvts_read_temp(void *data, int *temperature)
> +{
> +	struct soc_temp_tz *lvts_tz = (struct soc_temp_tz *)data;
> +	struct lvts_data *lvts_data = lvts_tz->lvts_data;
> +	struct device *dev = lvts_data->dev;
> +	unsigned int msr_raw;
> +
> +	msr_raw = readl(lvts_data->reg[lvts_tz->id]) & MRS_RAW_MASK;
> +	if (msr_raw == 0) {
> +		/* Prevents a false critical temperature trap */
> +		*temperature = 0;
> +		dev_dbg(dev, "LVTS not yet ready\n");
> +
> +	} else
> +		*temperature = lvts_raw_to_temp(&lvts_data->coeff, msr_raw);
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops soc_temp_lvts_ops = {
> +	.get_temp = soc_temp_lvts_read_temp,
> +};

[ ... ] ^^

> +static void lvts_write_device(struct lvts_data *lvts_data, unsigned int data, int tc_id)
> +{
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);

Here every call is computing the base + addr_offset. But addr_offset is 
only used in the structure to compute this base address.

Pre-compute the base address for the slot and remove the GET_BASE_ADDR 
macro.

> +	writel(DEVICE_WRITE(lvts_data) | data, LVTS_CONFIG_0 + base);
> +	usleep_range(20, 30);

Why this delay is needed? There are a lot of calls to this function, 
these delays will sum.

IMO, a good understanding of why this is needed, will help to find out 
when to use it.

> +}
> +
> +static unsigned int lvts_read_device(struct lvts_data *lvts_data, unsigned int reg_idx, int tc_id)
> +{
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);

ditto

> +	struct device *dev = lvts_data->dev;
> +	unsigned int data;
> +	int ret;
> +
> +	writel(READ_DEVICE_REG(lvts_data, reg_idx), LVTS_CONFIG_0 + base);
> +	usleep_range(20, 30);

ditto

> +	ret = readl_poll_timeout(LVTS_CONFIG_0 + base, data, !(data & DEVICE_ACCESS_STARTUS), 2, 200);
> +	if (ret)
> +		dev_err(dev, "LVTS_TC_%d DEVICE_ACCESS_START is not ready\n", tc_id);

Should it return?

> +
> +	data = readl(LVTSRDATA0_0 + base);
> +
> +	return data;
> +}
> +
> +static const char * const lvts_error_table[] = {
> +	"Idle",
> +	"Write transaction",
> +	"Waiting for read after write",
> +	"Disable continue fetching on device",
> +	"Read transaction",
> +	"Set device special register for voltage threshold",
> +	"Set TSMCU number for fetch"
> +};
> +
> +static void wait_all_tc_sensing_point_idle(struct lvts_data *lvts_data)

return an error

> +{
> +	void __iomem *base;
> +	struct device *dev = lvts_data->dev;
> +	unsigned int error_code, is_error;
> +	int i, cnt, ret;
> +
> +	for (cnt = 0; cnt < 2; cnt++) {

Why 2 loops? It should be documented.

No litterals please.

> +		is_error = 0;
> +
> +		for (i = 0; i < lvts_data->num_tc; i++) {
> +			base = GET_BASE_ADDR(lvts_data, i);
> +			ret = readl_poll_timeout(LVTSMSRCTL1_0 + base, error_code,
> +				!(error_code & ALL_TC_SENSING_POINT_STATUS), 2, 200);

readl_poll_timeout() can fail, return ret

Replace 2, 200 by macros

> +			error_code = ((error_code & TC_SENSING_POINT_10) >> 8) +
> +				((error_code & TC_SENSING_POINT_7) >> 6) + (error_code & TC_SENSING_POINT_0);

Please document de decoding of the error code and move it after the 
check of 'ret'

> +			if (ret)
> +				dev_err(dev, "LVTS_TC_%d Error Code : %s\n", i, lvts_error_table[error_code]);

The error is coming from the read_poll_timeout() no from error_code, so 
if error_code is positive, then return something:

something:
  - "Write transaction", "Waiting for read after write", "Read 
transaction" -> -EBUSY ?

  - Other -> -EIO ?

I suggest to remove the lvts_error_table, just write a comment for the 
errors and write the number in the trace

> +
> +			if (error_code != 0)
> +				is_error = 1;
			
			return the error

> +		}
> +
> +		if (is_error == 0)
> +			break;
> +	}

return 0;

> +}
> +
> +static void lvts_reset(struct lvts_data *lvts_data)

error handling: static int ...

> +{
> +	if (lvts_data->reset)
> +		reset_control_assert(lvts_data->reset);

error handling

> +
> +	if (lvts_data->reset)
> +		reset_control_deassert(lvts_data->reset);

error handling

It is the same condition, both calls can go under the same block.


BTW, why assert + deassert ?

> +}
> +
> +static void device_identification(struct lvts_data *lvts_data)

error handling: static int ...

> +{
> +	void __iomem *base;
> +	struct device *dev = lvts_data->dev;
> +	unsigned int i, data;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +		writel(ENABLE_LVTS_CTRL_CLK, LVTSCLKEN_0 + base);

Isn't it already done with the clk framework ?

> +		lvts_write_device(lvts_data, RESET_ALL_DEVICES(lvts_data), i);

Why a call to RESET_*ALL*_DEVICES in the loop? I'm confused, it is 
resetting all the devices but with a 'tc_id' passed as parameter

Is it possible to use the assert reset for that ?

> +		writel(READ_BACK_DEVICE_ID(lvts_data), LVTS_CONFIG_0 + base);

What means READ_BACK?

> +		usleep_range(20, 30);

Why is that needed ?

> +		/* Check LVTS device ID */
> +		data = (readl(LVTS_ID_0 + base) & DEVICE_REG_DATA);
> +		if (data != (lvts_data->tc->dev_id + i))
> +			dev_err(dev, "LVTS_TC_%d, Device ID should be 0x%x, but 0x%x\n",
> +				i, (lvts_data->tc->dev_id + i), data);

I'm confused, what is the purpose of the device_identification() 
function if you already know the id? When this situation can happen?

> +	}
> +}
> +
> +static void disable_all_sensing_points(struct lvts_data *lvts_data)
> +{
> +	void __iomem *base;
> +	unsigned int i;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +		writel(DISABLE_SENSING_POINT, LVTSMONCTL0_0 + base);
> +	}
> +}
> +
> +static void enable_all_sensing_points(struct lvts_data *lvts_data)
> +{
> +	void __iomem *base;
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	unsigned int i, num;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +		num = tc[i].num_sensor;
> +		if (num > ALL_SENSING_POINTS) {
> +			dev_err(dev, "LVTS_TC_%d, illegal number of sensors: %d\n", i, tc[i].num_sensor);
> +
> +			continue;
> +		}
> +
> +		if ((tc[i].ts_offset == 1) && (num == 1))
> +			writel(LVTS_SINGLE_SENSE | (0x1 << tc[i].ts_offset), LVTSMONCTL0_0 + base);
> +
> +		else
> +			writel(ENABLE_SENSING_POINT(num), LVTSMONCTL0_0 + base);
> +	}
> +}
> +
> +static void set_polling_speed(struct lvts_data *lvts_data, int tc_id)
> +{
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	unsigned int lvts_mon_ctl_1, lvts_mon_ctl_2;
> +
> +	lvts_mon_ctl_1 = ((tc[tc_id].tc_speed->group_interval_delay << 20) &
> +		GROUP_INTERVAL_DELAY_MASK) | (tc[tc_id].tc_speed->period_unit & PERIOD_UNIT_MASK);
> +	lvts_mon_ctl_2 = ((tc[tc_id].tc_speed->filter_interval_delay << 16) &
> +		FILTER_INTERVAL_DELAY_MASK) | (tc[tc_id].tc_speed->sensor_interval_delay &
> +		SENSOR_INTERVAL_DELAY_MASK);
> +	/*
> +	 * Clock source of LVTS thermal controller is 26MHz.
> +	 * Period unit is a base for all interval delays
> +	 * All interval delays must multiply it to convert a setting to time.
> +	 * Filter interval delay is a delay between two samples of the same sensor
> +	 * Sensor interval delay is a delay between two samples of differnet sensors

s/differnet/different/

> +	 * Group interval delay is a delay between different rounds.
> +	 * For example:
> +	 *     If Period unit = C, filter delay = 1, sensor delay = 2, group delay = 1,
> +	 *     and two sensors, TS1 and TS2, are in a LVTS thermal controller
> +	 *     and then
> +	 *     Period unit = C * 1/26M * 256 = 12 * 38.46ns * 256 = 118.149us
> +	 *     Filter interval delay = 1 * Period unit = 118.149us
> +	 *     Sensor interval delay = 2 * Period unit = 236.298us
> +	 *     Group interval delay = 1 * Period unit = 118.149us
> +	 *
> +	 *     TS1    TS1 ... TS1    TS2    TS2 ... TS2    TS1...
> +	 *        <--> Filter interval delay
> +	 *                       <--> Sensor interval delay
> +	 *                                             <--> Group interval delay
> +	 */
> +	writel(lvts_mon_ctl_1, LVTSMONCTL1_0 + base);
> +	writel(lvts_mon_ctl_2, LVTSMONCTL2_0 + base);
> +	dev_dbg(dev, "lvts_tc_%d, LVTSMONCTL1_0= 0x%x, LVTSMONCTL2_0= 0x%x\n",
> +		 tc_id, readl(LVTSMONCTL1_0 + base), readl(LVTSMONCTL2_0 + base));
> +}
> +
> +static void set_hw_filter(struct lvts_data *lvts_data, int tc_id)
> +{
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	unsigned int option = tc[tc_id].hw_filter & 0x7;
> +
> +	/*
> +	 * hw filter
> +	 * 000: Get one sample
> +	 * 001: Get 2 samples and average them
> +	 * 010: Get 4 samples, drop max and min, then average the rest of 2 samples
> +	 * 011: Get 6 samples, drop max and min, then average the rest of 4 samples
> +	 * 100: Get 10 samples, drop max and min, then average the rest of 8 samples
> +	 * 101: Get 18 samples, drop max and min, then average the rest of 16 samples
> +	 */
> +	option = (option << 9) | (option << 6) | (option << 3) | option;

I'm missing to understand, can you explain this bit changes?

> +	writel(option, LVTSMSRCTL0_0 + base);
> +	dev_dbg(dev, "lvts_tc_%d, LVTSMSRCTL0_0= 0x%x\n", tc_id, readl(LVTSMSRCTL0_0 + base));
> +}
> +

This function deserves an explanation. Why a dominator index exists?

> +static int get_dominator_index(struct lvts_data *lvts_data, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	int d_index;
> +
> +	if (tc[tc_id].dominator_sensing_point == ALL_SENSING_POINTS) {
> +		d_index = ALL_SENSING_POINTS;
> +
> +	} else if ((tc[tc_id].dominator_sensing_point < tc[tc_id].num_sensor) ||
> +		(tc[tc_id].ts_offset != 0)) {
> +		d_index = tc[tc_id].dominator_sensing_point;
> +
> +	} else {
> +		dev_err(dev, "LVTS_TC_%d: dominator sensing point = %d. \
> +			It should be smaller than num_sensor %d\n",
> +			tc_id, tc[tc_id].dominator_sensing_point, tc[tc_id].num_sensor);
> +		dev_err(dev, "Using the sensing point 0 as the dominated sensor\n");
> +		d_index = SENSING_POINT0;
> +	}
> +
> +	return d_index;
> +}
> +
> +static void disable_hw_reboot_interrupt(struct lvts_data *lvts_data, int tc_id)
> +{
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
> +	unsigned int temp;
> +
> +	/*
> +	* LVTS thermal controller has two interrupts for thermal HW reboot.
> +	* One is for AP SW and the other is for RGU.

May be reword "thermal controller" to something like "thermal domain" or 
whatever. It is confusing with the thermal controller contained in 
lvts_data.

> +	* The interrupt of AP SW can be turned off by a bit of a register,
> +	* but the other for RGU cannot.
> +	* To prevent rebooting device accidentally, we are going to add
> +	* a huge offset 0x3FFF to LVTS and make it always report extremely low temperature.
> +	* LVTS always adds the offset 0x3FFF to MSR_RAW.
> +	* When MSR_RAW is larger, SW will convert lower temperature.

I'm not sure to fully understand the explanation and the goal.

> +	*/ > +	temp = readl(LVTSPROTCTL_0 + base);
> +	writel(temp | 0x3FFF, LVTSPROTCTL_0 + base);
> +
> +	/* Disable the interrupt of AP SW */
> +	temp = readl(LVTSMONINT_0 + base);
> +	writel(temp & ~(STAGE3_INT_EN), LVTSMONINT_0 + base);
> +}
> +
> +static void enable_hw_reboot_interrupt(struct lvts_data *lvts_data, int tc_id)
> +{
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
> +	unsigned int temp;
> +
> +	/* Enable the interrupt of AP SW */
> +	temp = readl(LVTSMONINT_0 + base);
> +	writel(temp | STAGE3_INT_EN, LVTSMONINT_0 + base);
> +
> +	/* Clear the offset */
> +	temp = readl(LVTSPROTCTL_0 + base);
> +	writel(temp & ~PROTOFFSET, LVTSPROTCTL_0 + base);
> +}
> +
> +static void set_tc_hw_reboot_threshold(struct lvts_data *lvts_data, int trip_point, int tc_id)
> +{
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
> +	struct device *dev = lvts_data->dev;
> +	unsigned int msr_raw, temp, config, d_index;
> +
> +	d_index = get_dominator_index(lvts_data, tc_id);
> +
> +	dev_dbg(dev, "lvts_tc_%d: dominator sensing point = %d\n", tc_id, d_index);
> +
> +	disable_hw_reboot_interrupt(lvts_data, tc_id);
> +	temp = readl(LVTSPROTCTL_0 + base);
> +	if (d_index == ALL_SENSING_POINTS) {
> +		/* Maximum of 4 sensing points */
> +		config = (0x1 << 16);
> +		writel(config | temp, LVTSPROTCTL_0 + base);
> +
> +	} else {
> +		/* Select protection sensor */
> +		config = ((d_index << 2) + 0x2) << 16;
> +		writel(config | temp, LVTSPROTCTL_0 + base);
> +	}

So if ALL_SENSING_POINTS is set, the hardware is able to reboot on the 
first sensors reaching the hw reboot temp, otherwise it is the specified 
sensor which triggers the hw reboot? Do I read it correctly?

Why not use the ALL_SENSING_POINTS for all the cases?

> +	msr_raw = lvts_temp_to_raw(&lvts_data->coeff, trip_point);
> +	writel(msr_raw, LVTSPROTTC_0 + base);
> +	enable_hw_reboot_interrupt(lvts_data, tc_id);
> +}
> +
> +static void set_all_tc_hw_reboot(struct lvts_data *lvts_data)
> +{
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	int i, trip_point;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		trip_point = tc[i].hw_reboot_trip_point;
> +
> +		if (tc[i].num_sensor == 0)
> +			continue;
> +
> +		if (trip_point == THERMAL_TEMP_INVALID)
> +			continue;

This initialization happens nowhere AFAICT.

> +		set_tc_hw_reboot_threshold(lvts_data, trip_point, i);
> +	}
> +}
> +
> +static int lvts_init(struct lvts_data *lvts_data)
> +{
> +	struct platform_ops *ops = &lvts_data->ops;
> +	struct device *dev = lvts_data->dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(lvts_data->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable lvts controller clock: %d\n", ret);
> +
> +		return ret;
> +	}
> +
> +	lvts_reset(lvts_data);
> +	device_identification(lvts_data);
> +	if (ops->device_enable_and_init)
> +		ops->device_enable_and_init(lvts_data);
> +
> +	if (HAS_FEATURE(lvts_data, FEATURE_DEVICE_AUTO_RCK) && (ops->device_enable_auto_rck))
> +		ops->device_enable_auto_rck(lvts_data);
> +
> +	else if (ops->device_read_count_rc_n)
> +		ops->device_read_count_rc_n(lvts_data);
> +
> +	if (ops->set_cal_data)
> +		ops->set_cal_data(lvts_data);
> +
> +	disable_all_sensing_points(lvts_data);
> +	wait_all_tc_sensing_point_idle(lvts_data);

Check the return code from wait_all_tc_sensing_point_idle() and if it is 
-EBUSY retry, if it fails again, return ret.

> +	if (ops->init_controller)
> +		ops->init_controller(lvts_data);
> +
> +	enable_all_sensing_points(lvts_data);
> +	set_all_tc_hw_reboot(lvts_data);

I'm not seeing so many error handling. Please check the errors, that 
will probably help removing all the dev_dbg around

> +	return 0;
> +}
> +
> +static int prepare_calibration_data(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	struct platform_ops *ops = &lvts_data->ops;
> +	int i;
> +
> +	cal_data->count_r = devm_kcalloc(dev, lvts_data->num_sensor,
> +		sizeof(*cal_data->count_r), GFP_KERNEL);
> +	if (!cal_data->count_r)
> +		return -ENOMEM;
> +
> +	cal_data->count_rc = devm_kcalloc(dev, lvts_data->num_sensor,
> +		sizeof(*cal_data->count_rc), GFP_KERNEL);
> +	if (!cal_data->count_rc)
> +		return -ENOMEM;
> +
> +	if (ops->efuse_to_cal_data && !cal_data->use_fake_efuse)
> +		ops->efuse_to_cal_data(lvts_data);
> +
> +	if (cal_data->golden_temp == 0 || cal_data->golden_temp > GOLDEN_TEMP_MAX)
> +		cal_data->use_fake_efuse = 1;
> +
> +	if (cal_data->use_fake_efuse) {
> +		/* It means all efuse data are equal to 0 */
> +		dev_err(dev, "This sample is not calibrated, fake !!\n");
> +		cal_data->golden_temp = cal_data->default_golden_temp;
> +		for (i = 0; i < lvts_data->num_sensor; i++) {
> +			cal_data->count_r[i] = cal_data->default_count_r;
> +			cal_data->count_rc[i] = cal_data->default_count_rc;
> +		}
> +	}
> +
> +	lvts_data->coeff.golden_temp = cal_data->golden_temp;
> +	dev_dbg(dev, "golden_temp = %d\n", cal_data->golden_temp);
> +
> +	return 0;
> +}
> +
> +static int get_calibration_data(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	char cell_name[32];
> +	struct nvmem_cell *cell;
> +	u32 *buf;
> +	size_t len;
> +	int i, j, index = 0, ret;
> +
> +	lvts_data->efuse = devm_kcalloc(dev, lvts_data->num_efuse_addr,
> +		sizeof(*lvts_data->efuse), GFP_KERNEL);
> +	if (!lvts_data->efuse)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lvts_data->num_efuse_block; i++) {
> +		snprintf(cell_name, sizeof(cell_name), "lvts_calib_data%d", i + 1);
> +		cell = nvmem_cell_get(dev, cell_name);
> +		if (IS_ERR(cell)) {
> +			dev_err(dev, "Failed to get nvmem cell %s\n", cell_name);
> +
> +			return PTR_ERR(cell);
> +		}
> +
> +		buf = (u32 *)nvmem_cell_read(cell, &len);
> +		nvmem_cell_put(cell);
> +		if (IS_ERR(buf))
> +			return PTR_ERR(buf);
> +
> +		for (j = 0; j < (len / sizeof(u32)); j++) {
> +			if (index >= lvts_data->num_efuse_addr) {
> +				dev_err(dev, "Array efuse is going to overflow");
> +				kfree(buf);
> +
> +				return -EINVAL;
> +			}
> +
> +			lvts_data->efuse[index] = buf[j];
> +			index++;
> +		}
> +
> +		kfree(buf);
> +	}
> +
> +	ret = prepare_calibration_data(lvts_data);
> +
> +	return ret;
> +}
> +
> +static int lvts_init_tc_regs(struct device *dev, struct lvts_data *lvts_data)
> +{
> +	void __iomem *base;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	unsigned int i, j, s_index, x;
> +
> +	lvts_data->reg = devm_kcalloc(dev, lvts_data->num_sensor,
> +		sizeof(*lvts_data->reg), GFP_KERNEL);
> +	if (!lvts_data->reg)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +		for (j = 0; j < tc[i].num_sensor; j++) {
> +			s_index = tc[i].sensor_map[j];
> +			x = j + tc[i].ts_offset;
> +			lvts_data->reg[s_index] = LVTSMSR0_0 + base + 0x4 * x;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int of_update_lvts_data(struct lvts_data *lvts_data, struct platform_device *pdev)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct resource *res;
> +	int ret;
> +
> +	lvts_data->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(lvts_data->clk))
> +		return PTR_ERR(lvts_data->clk);
> +
> +	/* Get base address */
> +	res = platform_get_mem_or_io(pdev, 0);
> +	if (!res) {
> +		dev_err(dev, "No IO resource\n");
> +
> +		return -ENXIO;
> +	}
> +
> +	lvts_data->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(lvts_data->base)) {
> +		dev_err(dev, "Failed to remap io\n");
> +
> +		return PTR_ERR(lvts_data->base);
> +	}
> +
> +	/* Get interrupt number */
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "No irq resource\n");
> +
> +		return ret;
> +	}
> +
> +	lvts_data->irq_num = ret;
> +	/* Get reset control */
> +	lvts_data->reset = devm_reset_control_get_by_index(dev, 0);
> +	if (IS_ERR(lvts_data->reset)) {
> +		dev_err(dev, "Failed to get reset control\n");
> +
> +		return PTR_ERR(lvts_data->reset);
> +	}
> +
> +	ret = lvts_init_tc_regs(dev, lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = get_calibration_data(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void lvts_device_close(struct lvts_data *lvts_data)
> +{
> +	void __iomem *base;
> +	unsigned int i;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +		lvts_write_device(lvts_data, RESET_ALL_DEVICES(lvts_data), i);
> +		writel(DISABLE_LVTS_CTRL_CLK, LVTSCLKEN_0 + base);
> +	}
> +}
> +
> +static void lvts_close(struct lvts_data *lvts_data)
> +{
> +	disable_all_sensing_points(lvts_data);
> +	wait_all_tc_sensing_point_idle(lvts_data);
> +	lvts_device_close(lvts_data);
> +	clk_disable_unprepare(lvts_data->clk);
> +}
> +
> +static void tc_irq_handler(struct lvts_data *lvts_data, int tc_id)
> +{
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
> +	const struct device *dev = lvts_data->dev;
> +	unsigned int ret = readl(LVTSMONINTSTS_0 + base);
> +
> +	/* Write back to clear interrupt status */
> +	writel(ret, LVTSMONINTSTS_0 + base);
> +	dev_dbg(dev, "LVTS thermal controller %d, LVTSMONINTSTS=0x%08x\n", tc_id, ret);
> +	if (ret & THERMAL_PROTECTION_STAGE_3)

That means ?

> +		dev_dbg(dev, "Thermal protection stage 3 interrupt triggered\n");

When do we notify the thermal zone an interrupt happened because of a 
trip point?

> +}
> +
> +static irqreturn_t irq_handler(int irq, void *dev_id)
> +{
> +	void __iomem *base;
> +	struct lvts_data *lvts_data = (struct lvts_data *)dev_id;
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	unsigned int i, irq_bitmap;
> +
> +	base = lvts_data->base;
> +	irq_bitmap = readl(THERMINTST + base);
> +	dev_dbg(dev, "THERMINTST = 0x%x\n", irq_bitmap);

IIUC, there is one interrupt happening when a temperature threshold is 
crossed but we don't know which sensor it is. So we retrieve the bit 
mask of interrupt pending, right ? ...

> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		if (tc[i].irq_bit == 0)

... but then what do we do with this bitmap ?

> +			tc_irq_handler(lvts_data, i);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int lvts_register_irq_handler(struct lvts_data *lvts_data)

You should use lvts_register_irq_handler(struct device *dev, int irq, 
void *data)

> +{
> +	struct device *dev = lvts_data->dev;
> +	int ret;
> +
> +	ret = devm_request_irq(dev, lvts_data->irq_num, irq_handler, IRQF_TRIGGER_NONE,
> +		"mtk_lvts", lvts_data);

Change the name in order to prevent duplicate names, eg. dev_name(dev)

> +	if (ret) {
> +		dev_err(dev, "Failed to register LVTS IRQ, ret %d, irq_num %d\n",
> +			ret, lvts_data->irq_num);
> +		lvts_close(lvts_data);

lvts_close() should be called from the call site of 
lvts_register_irq_handler() if this one fails

> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lvts_register_thermal_zones(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct thermal_zone_device *tzdev;
> +	struct soc_temp_tz *lvts_tz;
> +	int i, ret;
> +
> +	for (i = 0; i < lvts_data->num_sensor; i++) {
> +		lvts_tz = devm_kzalloc(dev, sizeof(*lvts_tz), GFP_KERNEL);
> +		if (!lvts_tz) {
> +			lvts_close(lvts_data);
> +
> +			return -ENOMEM;
> +		}
> +
> +		lvts_tz->id = i;
> +		lvts_tz->lvts_data = lvts_data;
> +		tzdev = devm_thermal_zone_of_sensor_register(dev, lvts_tz->id, lvts_tz,
> +			&soc_temp_lvts_ops);
> +		if (IS_ERR(tzdev)) {
> +			if (lvts_tz->id != 0)
> +				return 0;
> +
> +			ret = PTR_ERR(tzdev);
> +			dev_err(dev, "Failed to register lvts tz %d, ret = %d\n", lvts_tz->id, ret);
> +			lvts_close(lvts_data);
> +
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void lvts_device_enable_and_init(struct lvts_data *lvts_data)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		lvts_write_device(lvts_data, STOP_COUNTING_V4, i);
> +		lvts_write_device(lvts_data, SET_RG_TSFM_LPDLY_V4, i);
> +		lvts_write_device(lvts_data, SET_COUNTING_WINDOW_20US1_V4, i);
> +		lvts_write_device(lvts_data, SET_COUNTING_WINDOW_20US2_V4, i);
> +		lvts_write_device(lvts_data, TSV2F_CHOP_CKSEL_AND_TSV2F_EN_V4, i);
> +		lvts_write_device(lvts_data, TSBG_DEM_CKSEL_X_TSBG_CHOP_EN_V4, i);
> +		lvts_write_device(lvts_data, SET_TS_RSV_V4, i);
> +		lvts_write_device(lvts_data, SET_TS_EN_V4, i);
> +		lvts_write_device(lvts_data, TOGGLE_RG_TSV2F_VCO_RST1_V4, i);
> +		lvts_write_device(lvts_data, TOGGLE_RG_TSV2F_VCO_RST2_V4, i);
> +	}
> +
> +	lvts_data->counting_window_us = 20;
> +}
> +EXPORT_SYMBOL_GPL(lvts_device_enable_and_init);
> +
> +void lvts_device_enable_auto_rck_v4(struct lvts_data *lvts_data)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++)
> +		lvts_write_device(lvts_data, SET_LVTS_AUTO_RCK_V4, i);
> +}
> +EXPORT_SYMBOL_GPL(lvts_device_enable_auto_rck_v4);
> +
> +int lvts_device_read_count_rc_n_v4(struct lvts_data *lvts_data)
> +{
> +	void __iomem *base;
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int s_index, data;
> +	int ret, i, j;
> +
> +	cal_data->count_rc_now = devm_kcalloc(dev, lvts_data->num_sensor,
> +		sizeof(*cal_data->count_rc_now), GFP_KERNEL);
> +	if (!cal_data->count_rc_now)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +		for (j = 0; j < tc[i].num_sensor; j++) {
> +			s_index = tc[i].sensor_map[j];
> +			lvts_write_device(lvts_data, SELECT_SENSOR_RCK_V4(j), i);
> +			lvts_write_device(lvts_data, SET_DEVICE_SINGLE_MODE_V4, i);
> +			lvts_write_device(lvts_data, KICK_OFF_RCK_COUNTING_V4, i);
> +			ret = readl_poll_timeout(LVTS_CONFIG_0 + base, data,
> +				!(data & DEVICE_SENSING_STATUS), 2, 200);
> +			if (ret)
> +				dev_err(dev, "LVTS_TC_%d DEVICE_SENSING_STATUS didn't ready\n", i);
> +
> +			data = lvts_read_device(lvts_data, 0x00, i);
> +			cal_data->count_rc_now[s_index] = (data & COUNT_RC_NOW_MASK);
> +		}
> +
> +		/* Recover Setting for Normal Access on
> +		 * temperature fetch
> +		 */
> +		lvts_write_device(lvts_data, SET_SENSOR_NO_RCK_V4, i);
> +		lvts_write_device(lvts_data, SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lvts_device_read_count_rc_n_v4);
> +
> +void lvts_set_calibration_data_v4(struct lvts_data *lvts_data)
> +{
> +	void __iomem *base;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int i, j, s_index, x;
> +	u32 lvts_calib_data;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +		for (j = 0; j < tc[i].num_sensor; j++) {
> +			s_index = tc[i].sensor_map[j];
> +			x = j + tc[i].ts_offset;
> +			if (HAS_FEATURE(lvts_data, FEATURE_DEVICE_AUTO_RCK))
> +				lvts_calib_data = cal_data->count_r[s_index];
> +
> +			else
> +				lvts_calib_data = (((u32)cal_data->count_rc_now[s_index]) *
> +					cal_data->count_r[s_index]) >> 14;
> +
> +			writel(lvts_calib_data, LVTSEDATA00_0 + base + 0x4 * x);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(lvts_set_calibration_data_v4);
> +
> +void lvts_init_controller_v4(struct lvts_data *lvts_data)
> +{
> +	void __iomem *base;
> +	struct device *dev = lvts_data->dev;
> +	unsigned int i;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +		lvts_write_device(lvts_data, SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
> +		writel(SET_SENSOR_INDEX, LVTSTSSEL_0 + base);
> +		writel(SET_CALC_SCALE_RULES, LVTSCALSCALE_0 + base);
> +		set_polling_speed(lvts_data, i);
> +		set_hw_filter(lvts_data, i);
> +		dev_dbg(dev, "lvts_tc_%d: read all %d sensors in %d us, one in %d us\n",
> +			i, GET_TC_SENSOR_NUM(lvts_data, i), GROUP_LATENCY_US(lvts_data, i),
> +			SENSOR_LATENCY_US(lvts_data, i));
> +	}
> +}
> +EXPORT_SYMBOL_GPL(lvts_init_controller_v4);
> +
> +int lvts_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct lvts_data *lvts_data;
> +	int ret;
> +
> +	lvts_data = (struct lvts_data *)of_device_get_match_data(dev);
> +	if (!lvts_data)	{
> +		dev_err(dev, "Failed to get lvts platform data\n");
> +
> +		return -ENODATA;
> +	}
> +
> +	lvts_data->dev = &pdev->dev;
> +	ret = of_update_lvts_data(lvts_data, pdev);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, lvts_data);
> +	ret = lvts_init(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = lvts_register_irq_handler(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = lvts_register_thermal_zones(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int lvts_remove(struct platform_device *pdev)
> +{
> +	struct lvts_data *lvts_data;
> +
> +	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
> +	lvts_close(lvts_data);
> +
> +	return 0;
> +}
> +
> +int lvts_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	int ret;
> +
> +	ret = lvts_remove(pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int lvts_resume(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = lvts_probe(pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +void lvts_shutdown(struct platform_device *pdev)
> +{
> +	lvts_remove(pdev);
> +}
> +
> +MODULE_AUTHOR("Yu-Chia Chang <ethan.chang@mediatek.com>");
> +MODULE_AUTHOR("Michael Kao <michael.kao@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek LVTS Thermal Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/thermal/mediatek/lvts_thermal.h b/drivers/thermal/mediatek/lvts_thermal.h
> new file mode 100644
> index 000000000000..a94ce46acccd
> --- /dev/null
> +++ b/drivers/thermal/mediatek/lvts_thermal.h
> @@ -0,0 +1,385 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_SOC_TEMP_LVTS_H__
> +#define __MTK_SOC_TEMP_LVTS_H__
> +
> +#define PERIOD_UNIT				12
> +#define GROUP_INTERVAL_DELAY	1
> +#define FILTER_INTERVAL_DELAY	1
> +#define SENSOR_INTERVAL_DELAY	1
> +
> +#define HW_REBOOT_TRIP_POINT	117000
> +
> +#define FEATURE_DEVICE_AUTO_RCK	BIT(0)
> +#define NUM_EFUSE_ADDR			22
> +#define NUM_EFUSE_BLOCK_MT8192	1
> +#define DEFAULT_GOLDEN_TEMP		50
> +#define DEFAULT_CUONT_R			35000
> +#define DEFAULT_CUONT_RC		2750
> +#define COEFF_A					-250460
> +#define COEFF_B					250460
> +
> +#define CLOCK_26MHZ_CYCLE_NS	38
> +#define BUS_ACCESS_US			2
> +#define GOLDEN_TEMP_MAX			62
> +
> +#define LVTS_FILTER_SAMPLES_1	1
> +#define LVTS_FILTER_SAMPLES_2	2
> +#define LVTS_FILTER_SAMPLES_4	4
> +#define LVTS_FILTER_SAMPLES_6	6
> +#define LVTS_FILTER_SAMPLES_10	10
> +#define LVTS_FILTER_SAMPLES_18	18
> +
> +#define TC_SENSING_POINT_0			BIT(0)
> +#define TC_SENSING_POINT_7			BIT(7)
> +#define TC_SENSING_POINT_10			BIT(10)
> +#define ALL_TC_SENSING_POINT_STATUS	(BIT(10) | BIT(7) | BIT(0))
> +#define COUNT_RC_NOW_MASK			GENMASK(23, 0)
> +#define PERIOD_UNIT_MASK			GENMASK(9, 0)
> +#define GROUP_INTERVAL_DELAY_MASK	GENMASK(29, 20)
> +#define FILTER_INTERVAL_DELAY_MASK	GENMASK(25, 16)
> +#define SENSOR_INTERVAL_DELAY_MASK	GENMASK(9, 0)
> +
> +/* LVTS device register */
> +#define RG_TSFM_DATA_0			0x00
> +#define RG_TSFM_DATA_1			0x01
> +#define RG_TSFM_DATA_2			0x02
> +#define RG_TSFM_CTRL_0			0x03
> +#define RG_TSFM_CTRL_1			0x04
> +#define RG_TSFM_CTRL_2			0x05
> +#define RG_TSFM_CTRL_3			0x06
> +#define RG_TSFM_CTRL_4			0x07
> +#define RG_TSV2F_CTRL_0			0x08
> +#define RG_TSV2F_CTRL_1			0x09
> +#define RG_TSV2F_CTRL_2			0x0A
> +#define RG_TSV2F_CTRL_3			0x0B
> +#define RG_TSV2F_CTRL_4			0x0C
> +#define RG_TSV2F_CTRL_5			0x0D
> +#define RG_TSV2F_CTRL_6			0x0E
> +#define RG_TEMP_DATA_0			0x10
> +#define RG_TEMP_DATA_1			0x11
> +#define RG_TEMP_DATA_2			0x12
> +#define RG_TEMP_DATA_3			0x13
> +#define RG_RC_DATA_0			0x14
> +#define RG_RC_DATA_1			0x15
> +#define RG_RC_DATA_2			0x16
> +#define RG_RC_DATA_3			0x17
> +#define RG_DIV_DATA_0			0x18
> +#define RG_DIV_DATA_1			0x19
> +#define RG_DIV_DATA_2			0x1A
> +#define RG_DIV_DATA_3			0x1B
> +#define RG_TST_DATA_0			0x70
> +#define RG_TST_DATA_1			0x71
> +#define RG_TST_DATA_2			0x72
> +#define RG_TST_CTRL				0x73
> +#define RG_DBG_FQMTR			0xF0
> +#define RG_DBG_LPSEQ			0xF1
> +#define RG_DBG_STATE			0xF2
> +#define RG_DBG_CHKSUM			0xF3
> +#define RG_DID_LVTS				0xFC
> +#define RG_DID_REV				0xFD
> +#define RG_TSFM_RST				0xFF
> +
> +/* LVTS controller register */
> +#define LVTSMONCTL0_0				0x000
> +#define ENABLE_SENSING_POINT(num)	(LVTS_SINGLE_SENSE | GENMASK(((num) - 1), 0))
> +#define DISABLE_SENSING_POINT		(LVTS_SINGLE_SENSE | 0x0)
> +#define LVTSMONCTL1_0				0x004
> +#define LVTSMONCTL2_0				0x008
> +#define LVTSMONINT_0				0x00C
> +#define STAGE3_INT_EN				BIT(31)
> +#define LVTSMONINTSTS_0				0x010
> +#define LVTSMONIDET0_0				0x014
> +#define LVTSMONIDET1_0				0x018
> +#define LVTSMONIDET2_0				0x01C
> +#define LVTSMONIDET3_0				0x020
> +#define LVTSH2NTHRE_0				0x024
> +#define LVTSHTHRE_0					0x028
> +#define LVTSCTHRE_0					0x02C
> +#define LVTSOFFSETH_0				0x030
> +#define LVTSOFFSETL_0				0x034
> +#define LVTSMSRCTL0_0				0x038
> +#define LVTSMSRCTL1_0				0x03C
> +#define LVTSTSSEL_0					0x040
> +#define SET_SENSOR_INDEX			0x13121110
> +#define LVTSDEVICETO_0				0x044
> +#define LVTSCALSCALE_0				0x048
> +#define SET_CALC_SCALE_RULES		0x00000300
> +#define LVTS_ID_0					0x04C
> +#define LVTS_CONFIG_0				0x050
> +
> +#define SCK_ONLY					BIT(31)
> +#define BROADCAST_ID_UPDATE			BIT(26)
> +#define DEVICE_SENSING_STATUS		BIT(25)
> +#define DEVICE_ACCESS_STARTUS		BIT(24)
> +#define READ_32BIT_ACCESS			BIT(17)
> +#define WRITE_ACCESS				BIT(16)
> +#define LVTS_SINGLE_SENSE			BIT(9)
> +#define FEATURE_CK26M_ACTIVE		BIT(1)
> +#define DEVICE_REG_DATA				GENMASK(7, 0)
> +
> +#define LVTSEDATA00_0				0x054
> +#define LVTSEDATA01_0				0x058
> +#define LVTSEDATA02_0				0x05C
> +#define LVTSEDATA03_0				0x060
> +#define LVTSMSR0_0					0x090
> +#define MRS_RAW_MASK				GENMASK(15, 0)
> +#define MRS_RAW_VALID_BIT			BIT(16)
> +#define LVTSMSR1_0					0x094
> +#define LVTSMSR2_0					0x098
> +#define LVTSMSR3_0					0x09C
> +#define LVTSIMMD0_0					0x0A0
> +#define LVTSIMMD1_0					0x0A4
> +#define LVTSIMMD2_0					0x0A8
> +#define LVTSIMMD3_0					0x0AC
> +#define LVTSRDATA0_0				0x0B0
> +#define LVTSRDATA1_0				0x0B4
> +#define LVTSRDATA2_0				0x0B8
> +#define LVTSRDATA3_0				0x0BC
> +#define LVTSPROTCTL_0				0x0C0
> +#define PROTOFFSET					GENMASK(15, 0)
> +#define LVTSPROTTA_0				0x0C4
> +#define LVTSPROTTB_0				0x0C8
> +#define LVTSPROTTC_0				0x0CC
> +#define LVTSCLKEN_0					0x0E4
> +#define ENABLE_LVTS_CTRL_CLK		(1)
> +#define DISABLE_LVTS_CTRL_CLK		(0)
> +#define LVTSDBGSEL_0				0x0E8
> +#define LVTSDBGSIG_0				0x0EC
> +#define LVTSSPARE0_0				0x0F0
> +#define LVTSSPARE1_0				0x0F4
> +#define LVTSSPARE2_0				0x0F8
> +#define LVTSSPARE3_0				0x0FC
> +#define THERMINTST					0xF04
> +
> +/* LVTS register mask */
> +#define THERMAL_COLD_INTERRUPT_0			BIT(0)
> +#define THERMAL_HOT_INTERRUPT_0				BIT(1)
> +#define THERMAL_LOW_OFFSET_INTERRUPT_0		BIT(2)
> +#define THERMAL_HIGH_OFFSET_INTERRUPT_0		BIT(3)
> +#define THERMAL_HOT2NORMAL_INTERRUPT_0		BIT(4)
> +#define THERMAL_COLD_INTERRUPT_1			BIT(5)
> +#define THERMAL_HOT_INTERRUPT_1				BIT(6)
> +#define THERMAL_LOW_OFFSET_INTERRUPT_1		BIT(7)
> +#define THERMAL_HIGH_OFFSET_INTERRUPT_1		BIT(8)
> +#define THERMAL_HOT2NORMAL_INTERRUPT_1		BIT(9)
> +#define THERMAL_COLD_INTERRUPT_2			BIT(10)
> +#define THERMAL_HOT_INTERRUPT_2				BIT(11)
> +#define THERMAL_LOW_OFFSET_INTERRUPT_2		BIT(12)
> +#define THERMAL_HIGH_OFFSET_INTERRUPT_2		BIT(13)
> +#define THERMAL_HOT2NORMAL_INTERRUPT_2		BIT(14)
> +#define THERMAL_AHB_TIMEOUT_INTERRUPT		BIT(15)
> +#define THERMAL_DEVICE_TIMEOUT_INTERRUPT	BIT(15)
> +#define THERMAL_IMMEDIATE_INTERRUPT_0		BIT(16)
> +#define THERMAL_IMMEDIATE_INTERRUPT_1		BIT(17)
> +#define THERMAL_IMMEDIATE_INTERRUPT_2		BIT(18)
> +#define THERMAL_FILTER_INTERRUPT_0			BIT(19)
> +#define THERMAL_FILTER_INTERRUPT_1			BIT(20)
> +#define THERMAL_FILTER_INTERRUPT_2			BIT(21)
> +#define THERMAL_COLD_INTERRUPT_3			BIT(22)
> +#define THERMAL_HOT_INTERRUPT_3				BIT(23)
> +#define THERMAL_LOW_OFFSET_INTERRUPT_3		BIT(24)
> +#define THERMAL_HIGH_OFFSET_INTERRUPT_3		BIT(25)
> +#define THERMAL_HOT2NORMAL_INTERRUPT_3		BIT(26)
> +#define THERMAL_IMMEDIATE_INTERRUPT_3		BIT(27)
> +#define THERMAL_FILTER_INTERRUPT_3			BIT(28)
> +#define THERMAL_PROTECTION_STAGE_1			BIT(29)
> +#define THERMAL_PROTECTION_STAGE_2			BIT(30)
> +#define THERMAL_PROTECTION_STAGE_3			BIT(31)
> +
> +#define CFG_REGISTER(reg, value)			(reg << 8 | value)
> +#define STOP_COUNTING_V4					CFG_REGISTER(RG_TSFM_CTRL_0, 0x00)
> +#define SET_RG_TSFM_LPDLY_V4				CFG_REGISTER(RG_TSFM_CTRL_4, 0xA6)
> +#define SET_COUNTING_WINDOW_20US1_V4		CFG_REGISTER(RG_TSFM_CTRL_2, 0x00)
> +#define SET_COUNTING_WINDOW_20US2_V4		CFG_REGISTER(RG_TSFM_CTRL_1, 0x20)
> +#define TSV2F_CHOP_CKSEL_AND_TSV2F_EN_V4	CFG_REGISTER(RG_TSV2F_CTRL_2, 0x84)
> +#define TSBG_DEM_CKSEL_X_TSBG_CHOP_EN_V4	CFG_REGISTER(RG_TSV2F_CTRL_4, 0x7C)
> +#define SET_TS_RSV_V4						CFG_REGISTER(RG_TSV2F_CTRL_1, 0x8D)
> +#define SET_TS_EN_V4						CFG_REGISTER(RG_TSV2F_CTRL_0, 0xF4)
> +#define TOGGLE_RG_TSV2F_VCO_RST1_V4			CFG_REGISTER(RG_TSV2F_CTRL_0, 0xFC)
> +#define TOGGLE_RG_TSV2F_VCO_RST2_V4			CFG_REGISTER(RG_TSV2F_CTRL_0, 0xF4)
> +
> +#define SET_LVTS_AUTO_RCK_V4				CFG_REGISTER(RG_TSV2F_CTRL_6, 0x01)
> +#define SELECT_SENSOR_RCK_V4(id)			CFG_REGISTER(RG_TSV2F_CTRL_5, (id))
> +#define SET_DEVICE_SINGLE_MODE_V4			CFG_REGISTER(RG_TSFM_CTRL_3, 0x78)
> +#define KICK_OFF_RCK_COUNTING_V4			CFG_REGISTER(RG_TSFM_CTRL_0, 0x02)
> +#define SET_SENSOR_NO_RCK_V4				CFG_REGISTER(RG_TSV2F_CTRL_5, 0x10)
> +#define SET_DEVICE_LOW_POWER_SINGLE_MODE_V4	CFG_REGISTER(RG_TSFM_CTRL_3, 0xB8)
> +
> +#define HAS_FEATURE(lvts_data, feature)		(lvts_data->feature_bitmap & (feature))
> +#define GET_BASE_ADDR(lvts_data, tc_id)		(lvts_data->base + lvts_data->tc[tc_id].addr_offset)
> +#define GET_CAL_DATA_BITMASK(index, lvts_data, h, l)	(((index) < lvts_data->num_efuse_addr) ? \
> +	((lvts_data->efuse[(index)] & GENMASK(h, l)) >> l) : 0)
> +
> +#define GET_TC_SENSOR_NUM(lvts_data, tc_id)	(lvts_data->tc[tc_id].num_sensor)
> +#define ONE_SAMPLE(lvts_data)				(lvts_data->counting_window_us + 2 * BUS_ACCESS_US)
> +#define NUM_OF_SAMPLE(lvts_data, tc_id)		((lvts_data->tc[tc_id].hw_filter < LVTS_FILTER_2) ? \
> +	LVTS_FILTER_SAMPLES_1 : ((lvts_data->tc[tc_id].hw_filter > LVTS_FILTER_16_OF_18) ? \
> +	LVTS_FILTER_SAMPLES_1 : ((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_16_OF_18) ? \
> +	LVTS_FILTER_SAMPLES_18 : ((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_8_OF_10) ? \
> +	LVTS_FILTER_SAMPLES_10 : (lvts_data->tc[tc_id].hw_filter * 2)))))
> +
> +#define PERIOD_UNIT_US(lvts_data, tc_id)   ((lvts_data->tc[tc_id].tc_speed->period_unit * 256 \
> +	* CLOCK_26MHZ_CYCLE_NS) / 1000)
> +#define FILTER_INT_US(lvts_data, tc_id)    (lvts_data->tc[tc_id].tc_speed->filter_interval_delay \
> +	* PERIOD_UNIT_US(lvts_data, tc_id))
> +#define SENSOR_INT_US(lvts_data, tc_id)    (lvts_data->tc[tc_id].tc_speed->sensor_interval_delay \
> +	* PERIOD_UNIT_US(lvts_data, tc_id))
> +#define GROUP_INT_US(lvts_data, tc_id)     (lvts_data->tc[tc_id].tc_speed->group_interval_delay \
> +	* PERIOD_UNIT_US(lvts_data, tc_id))
> +#define SENSOR_LATENCY_US(lvts_data, tc_id)	((NUM_OF_SAMPLE(lvts_data, tc_id) - 1) * \
> +	FILTER_INT_US(lvts_data, tc_id) + NUM_OF_SAMPLE(lvts_data, tc_id) * ONE_SAMPLE(lvts_data))
> +#define GROUP_LATENCY_US(lvts_data, tc_id)	(GET_TC_SENSOR_NUM(lvts_data, tc_id) * \
> +	SENSOR_LATENCY_US(lvts_data, tc_id) + (GET_TC_SENSOR_NUM(lvts_data, tc_id) - 1) * \
> +	SENSOR_INT_US(lvts_data, tc_id) + GROUP_INT_US(lvts_data, tc_id))
> +
> +#define CK26M_ACTIVE(lvts_data)				(((lvts_data->feature_bitmap & FEATURE_CK26M_ACTIVE) \
> +	? 1 : 0) << 30)
> +#define DEVICE_ACCESS					  (SCK_ONLY | DEVICE_ACCESS_STARTUS | READ_32BIT_ACCESS)
> +#define DEVICE_READ(lvts_data)			  (CK26M_ACTIVE(lvts_data) | DEVICE_ACCESS)
> +#define DEVICE_WRITE(lvts_data)			  (CK26M_ACTIVE(lvts_data) | DEVICE_ACCESS | WRITE_ACCESS)
> +#define RESET_ALL_DEVICES(lvts_data)	  (DEVICE_WRITE(lvts_data) | RG_TSFM_RST << 8 | 0xFF)
> +#define READ_DEVICE_REG(lvts_data, reg_id) (DEVICE_READ(lvts_data) | (reg_id) << 8 | 0x00)
> +#define READ_BACK_DEVICE_ID(lvts_data)	   (CK26M_ACTIVE(lvts_data) | DEVICE_ACCESS | \
> +	BROADCAST_ID_UPDATE | RG_DID_LVTS << 8)
> +
> +/*
> + * LVTS HW filter settings
> + * 000: Get one sample
> + * 001: Get 2 samples and average them
> + * 010: Get 4 samples, drop max and min, then average the rest of 2 samples
> + * 011: Get 6 samples, drop max and min, then average the rest of 4 samples
> + * 100: Get 10 samples, drop max and min, then average the rest of 8 samples
> + * 101: Get 18 samples, drop max and min, then average the rest of 16 samples
> + */
> +enum lvts_hw_filter {
> +	LVTS_FILTER_1,
> +	LVTS_FILTER_2,
> +	LVTS_FILTER_2_OF_4,
> +	LVTS_FILTER_4_OF_6,
> +	LVTS_FILTER_8_OF_10,
> +	LVTS_FILTER_16_OF_18
> +};
> +
> +enum lvts_sensing_point {
> +	SENSING_POINT0,
> +	SENSING_POINT1,
> +	SENSING_POINT2,
> +	SENSING_POINT3,
> +	ALL_SENSING_POINTS

Usually, the naming convention is NUM_SENSING_POINTS

> +};
> +
> +struct lvts_data;

This forward declaration should not be needed

> +/**
> + * struct lvts_speed_settings - A structure to hold the data related to polling rate
> + * @period_unit: Period unit is a base for all interval delays
> + * @group_interval_delay:  Delay between different rounds
> + * @filter_interval_delay: Delay between two samples of the same sensor
> + * @sensor_interval_delay: Delay between two samples of differnet sensors
> + *
> + * Calculation is achieved with the following equations:
> + * For the period unit: (period_us * 1000) / (256 * clock_26mhz_cycle_ns)
> + * For the interval delays: delay / period_us
> + */
> +struct lvts_speed_settings {
> +	unsigned int period_unit;
> +	unsigned int group_interval_delay;
> +	unsigned int filter_interval_delay;
> +	unsigned int sensor_interval_delay;
> +};
> +
> +struct lvts_tc_settings {
> +	unsigned int dev_id;
> +	unsigned int addr_offset;
> +	unsigned int num_sensor;
> +	unsigned int ts_offset;
> +	unsigned int sensor_map[ALL_SENSING_POINTS];	/* In sensor ID */

Can you explain what is for the sensor_map?

> +	struct lvts_speed_settings *tc_speed;
> +	/*
> +	 * HW filter setting
> +	 * 000: Get one sample
> +	 * 001: Get 2 samples and average them
> +	 * 010: Get 4 samples, drop max and min, then average the rest of 2 samples
> +	 * 011: Get 6 samples, drop max and min, then average the rest of 4 samples
> +	 * 100: Get 10 samples, drop max and min, then average the rest of 8 samples
> +	 * 101: Get 18 samples, drop max and min, then average the rest of 16 samples
> +	 */
> +	unsigned int hw_filter;

Isn't possible to specify a latency constraint instead of a hw_filter 
and deduce this one?

> +	/*
> +	 * Dominator_sensing point is used to select a sensing point
> +	 * and reference its temperature to trigger Thermal HW Reboot
> +	 * When it is ALL_SENSING_POINTS, it will select all sensing points
> +	 */
> +	int dominator_sensing_point;

replace int by the enum, hopefully 'clang' can detect enum mismatches

> +	int hw_reboot_trip_point;		/* -274000: Disable HW reboot */

It is not necessary to specify the hw_reboot_trip_point, it is all the 
same in the declaration.

> +	unsigned int irq_bit;
> +};
> +
> +struct lvts_formula_coeff {
> +	int a;
> +	int b;
> +	unsigned int golden_temp;
> +};
> +
> +struct lvts_sensor_cal_data {
> +	int use_fake_efuse;				/* 1: Use fake efuse, 0: Use real efuse */
> +	unsigned int golden_temp;
> +	unsigned int *count_r;
> +	unsigned int *count_rc;
> +	unsigned int *count_rc_now;
> +	unsigned int default_golden_temp;
> +	unsigned int default_count_r;
> +	unsigned int default_count_rc;
> +};
> +
> +struct platform_ops {
> +	void (*efuse_to_cal_data)(struct lvts_data *lvts_data);
> +	void (*device_enable_and_init)(struct lvts_data *lvts_data);
> +	void (*device_enable_auto_rck)(struct lvts_data *lvts_data);
> +	int (*device_read_count_rc_n)(struct lvts_data *lvts_data);
> +	void (*set_cal_data)(struct lvts_data *lvts_data);
> +	void (*init_controller)(struct lvts_data *lvts_data);
> +};
> +
> +struct lvts_data {

IMO it would make sense to rename the lvts_data to lvts_thermal_domain

> +	struct device *dev;
> +	struct clk *clk;
> +	void __iomem *base;				/* LVTS base addresses */
> +	unsigned int irq_num;			/* LVTS interrupt numbers */

The probe function can be reworked to get the irq and the pass it the 
register function. No need to store it in this structure.

> +	struct reset_control *reset;
> +	int num_tc;						/* Number of LVTS thermal controllers */
> +	const struct lvts_tc_settings *tc;
> +	int counting_window_us;			/* LVTS device counting window */
> +	int num_sensor;					/* Number of sensors in this platform */
> +	void __iomem **reg;
> +	struct platform_ops ops;
> +	int feature_bitmap;				/* Show what features are enabled */
> +	unsigned int num_efuse_addr;
> +	unsigned int *efuse;
> +	unsigned int num_efuse_block;	/* Number of contiguous efuse indexes */
> +	struct lvts_sensor_cal_data cal_data;

Everything related to the initialization must be somehow removed from 
this structure.

> +	struct lvts_formula_coeff coeff;
> +};
> +
> +struct soc_temp_tz {
> +	unsigned int id;
> +	struct lvts_data *lvts_data;
> +};
> +
> +extern void lvts_device_enable_and_init(struct lvts_data *lvts_data);
> +extern void lvts_device_enable_auto_rck_v4(struct lvts_data *lvts_data);
> +extern int lvts_device_read_count_rc_n_v4(struct lvts_data *lvts_data);
> +extern void lvts_set_calibration_data_v4(struct lvts_data *lvts_data);
> +extern void lvts_init_controller_v4(struct lvts_data *lvts_data);
> +
> +extern int lvts_probe(struct platform_device *pdev);
> +extern int lvts_remove(struct platform_device *pdev);
> +extern int lvts_suspend(struct platform_device *pdev, pm_message_t state);
> +extern int lvts_resume(struct platform_device *pdev);
> +extern void lvts_shutdown(struct platform_device *pdev);
> +
> +#endif /* __MTK_SOC_TEMP_LVTS_H__ */
> diff --git a/drivers/thermal/mediatek/lvts_v4.c b/drivers/thermal/mediatek/lvts_v4.c
> new file mode 100644
> index 000000000000..3dc00d2589f9
> --- /dev/null
> +++ b/drivers/thermal/mediatek/lvts_v4.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include "lvts_thermal.h"
> +
> +enum mt8192_lvts_mcu_sensor_enum {
> +	MT8192_TS1_0,
> +	MT8192_TS1_1,
> +	MT8192_TS2_0,
> +	MT8192_TS2_1,
> +	MT8192_TS3_0,
> +	MT8192_TS3_1,
> +	MT8192_TS3_2,
> +	MT8192_TS3_3,
> +	MT8192_NUM_TS_MCU
> +};
> +
> +enum mt8192_lvts_ap_sensor_enum {
> +	MT8192_TS4_0,
> +	MT8192_TS4_1,
> +	MT8192_TS5_0,
> +	MT8192_TS5_1,
> +	MT8192_TS6_0,
> +	MT8192_TS6_1,
> +	MT8192_TS7_0,
> +	MT8192_TS7_1,
> +	MT8192_TS7_2,
> +	MT8192_NUM_TS_AP
> +};
> +
> +static void mt8192_mcu_efuse_to_cal_data(struct lvts_data *lvts_data)
> +{
> +	const unsigned int mt8192_ts[] = { MT8192_TS2_0, MT8192_TS3_0 };
> +	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int i, j;
> +
> +	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, lvts_data, 31, 24);
> +
> +	for (i = 0; i < MT8192_NUM_TS_MCU; i++)
> +		cal_data->count_r[i] = GET_CAL_DATA_BITMASK(i + 1, lvts_data, 23, 0);
> +
> +	cal_data->count_rc[MT8192_TS1_0] = GET_CAL_DATA_BITMASK(21, lvts_data, 23, 0);
> +
> +	for (i = 0; i < (ARRAY_SIZE(mt8192_ts)); i++) {
> +		for (j = 1; j <= 18; j++) {
> +			cal_data->count_rc[mt8192_ts[i]] = (GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24)
> +				<< 16) + (GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24) << 8) +
> +				GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24);
> +		}
> +	}
> +}
> +
> +static void mt8192_ap_efuse_to_cal_data(struct lvts_data *lvts_data)
> +{
> +	const unsigned int mt8192_ts[] = { MT8192_TS4_0, MT8192_TS5_0, MT8192_TS6_0, MT8192_TS7_0 };
> +	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int i, j;
> +
> +	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, lvts_data, 31, 24);
> +
> +	for (i = 0; i < MT8192_NUM_TS_AP; i++)
> +		cal_data->count_r[i] = GET_CAL_DATA_BITMASK(i + 1, lvts_data, 23, 0);
> +
> +	for (i = 0; i < (ARRAY_SIZE(mt8192_ts)); i++) {
> +		for (j = 1; j <= 18; j++) {
> +			cal_data->count_rc[mt8192_ts[i]] = (GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24)
> +				<< 16) + (GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24) << 8) +
> +				GET_CAL_DATA_BITMASK(j, lvts_data, 31, 24);
> +		}
> +	}
> +}
> +
> +static struct lvts_speed_settings tc_speed_mt8192 = {
> +	.period_unit = PERIOD_UNIT,
> +	.group_interval_delay = GROUP_INTERVAL_DELAY,
> +	.filter_interval_delay = FILTER_INTERVAL_DELAY,
> +	.sensor_interval_delay = SENSOR_INTERVAL_DELAY,
> +};
> +
> +static const struct lvts_tc_settings mt8192_tc_mcu_settings[] = {
> +	[0] = {
> +		.dev_id = 0x81,
> +		.addr_offset = 0x0,
> +		.num_sensor = 2,
> +		.ts_offset = 0,
> +		.sensor_map = { MT8192_TS1_0, MT8192_TS1_1 },
> +		.tc_speed = &tc_speed_mt8192,
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT1,
> +		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
> +		.irq_bit = BIT(3),
> +	},
> +	[1] = {
> +		.dev_id = 0x82,
> +		.addr_offset = 0x100,
> +		.num_sensor = 2,
> +		.ts_offset = 0,
> +		.sensor_map = { MT8192_TS2_0, MT8192_TS2_1 },
> +		.tc_speed = &tc_speed_mt8192,
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT0,
> +		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
> +		.irq_bit = BIT(4),
> +	},
> +	[2] = {
> +		.dev_id = 0x83,
> +		.addr_offset = 0x200,
> +		.num_sensor = 4,
> +		.ts_offset = 0,
> +		.sensor_map = { MT8192_TS3_0, MT8192_TS3_1, MT8192_TS3_2, MT8192_TS3_3 },
> +		.tc_speed = &tc_speed_mt8192,
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT0,
> +		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
> +		.irq_bit = BIT(5),
> +	}
> +};
> +
> +static const struct lvts_tc_settings mt8192_tc_ap_settings[] = {
> +	[0] = {
> +		.dev_id = 0x84,
> +		.addr_offset = 0x0,
> +		.num_sensor = 2,
> +		.ts_offset = 0,
> +		.sensor_map = { MT8192_TS4_0, MT8192_TS4_1 },
> +		.tc_speed = &tc_speed_mt8192,
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT0,
> +		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
> +		.irq_bit = BIT(3),
> +	},
> +	[1] = {
> +		.dev_id = 0x85,
> +		.addr_offset = 0x100,
> +		.num_sensor = 2,
> +		.ts_offset = 0,
> +		.sensor_map = { MT8192_TS5_0, MT8192_TS5_1 },
> +		.tc_speed = &tc_speed_mt8192,
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT1,
> +		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
> +		.irq_bit = BIT(4),
> +	},
> +	[2] = {
> +		.dev_id = 0x86,
> +		.addr_offset = 0x200,
> +		.num_sensor = 2,
> +		.ts_offset = 0,
> +		.sensor_map = { MT8192_TS6_0, MT8192_TS6_1 },
> +		.tc_speed = &tc_speed_mt8192,
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT1,
> +		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
> +		.irq_bit = BIT(5),
> +	},
> +	[3] = {
> +		.dev_id = 0x87,
> +		.addr_offset = 0x300,
> +		.num_sensor = 3,
> +		.ts_offset = 0,
> +		.sensor_map = { MT8192_TS7_0, MT8192_TS7_1, MT8192_TS7_2 },
> +		.tc_speed = &tc_speed_mt8192,
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT2,
> +		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
> +		.irq_bit = BIT(6),
> +	}
> +};
> +
> +static const struct lvts_data mt8192_lvts_mcu_data = {
> +	.num_tc = (ARRAY_SIZE(mt8192_tc_mcu_settings)),
> +	.tc = mt8192_tc_mcu_settings,
> +	.num_sensor = MT8192_NUM_TS_MCU,
> +	.ops = {
> +		.efuse_to_cal_data = mt8192_mcu_efuse_to_cal_data,
> +		.device_enable_and_init = lvts_device_enable_and_init,
> +		.device_enable_auto_rck = lvts_device_enable_auto_rck_v4,
> +		.device_read_count_rc_n = lvts_device_read_count_rc_n_v4,
> +		.set_cal_data = lvts_set_calibration_data_v4,
> +		.init_controller = lvts_init_controller_v4,
> +	},
> +	.feature_bitmap = FEATURE_DEVICE_AUTO_RCK,
> +	.num_efuse_addr = NUM_EFUSE_ADDR,
> +	.num_efuse_block = NUM_EFUSE_BLOCK_MT8192,
> +	.cal_data = {
> +		.default_golden_temp = DEFAULT_GOLDEN_TEMP,
> +		.default_count_r = DEFAULT_CUONT_R,
> +		.default_count_rc = DEFAULT_CUONT_RC,
> +	},
> +	.coeff = {
> +		.a = COEFF_A,
> +		.b = COEFF_B,
> +	},
> +};
> +
> +static const struct lvts_data mt8192_lvts_ap_data = {
> +	.num_tc = (ARRAY_SIZE(mt8192_tc_ap_settings)),
> +	.tc = mt8192_tc_ap_settings,
> +	.num_sensor = MT8192_NUM_TS_AP,
> +	.ops = {
> +		.efuse_to_cal_data = mt8192_ap_efuse_to_cal_data,
> +		.device_enable_and_init = lvts_device_enable_and_init,
> +		.device_enable_auto_rck = lvts_device_enable_auto_rck_v4,
> +		.device_read_count_rc_n = lvts_device_read_count_rc_n_v4,
> +		.set_cal_data = lvts_set_calibration_data_v4,
> +		.init_controller = lvts_init_controller_v4,
> +	},
> +	.feature_bitmap = FEATURE_DEVICE_AUTO_RCK,
> +	.num_efuse_addr = NUM_EFUSE_ADDR,
> +	.num_efuse_block = NUM_EFUSE_BLOCK_MT8192,
> +	.cal_data = {
> +		.default_golden_temp = DEFAULT_GOLDEN_TEMP,
> +		.default_count_r = DEFAULT_CUONT_R,
> +		.default_count_rc = DEFAULT_CUONT_RC,
> +	},
> +	.coeff = {
> +		.a = COEFF_A,
> +		.b = COEFF_B,
> +	},
> +};
> +
> +static const struct of_device_id lvts_of_match[] = {
> +	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data, },
> +	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data, },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, lvts_of_match);
> +
> +static struct platform_driver soc_temp_lvts = {
> +	.probe = lvts_probe,
> +	.remove = lvts_remove,
> +	.suspend = lvts_suspend,
> +	.resume = lvts_resume,
> +	.shutdown = lvts_shutdown,
> +	.driver = {
> +		.name = "mtk-lvts-thermal-v4",
> +		.of_match_table = lvts_of_match,
> +	},
> +};
> +module_platform_driver(soc_temp_lvts);
> +
> +MODULE_AUTHOR("Yu-Chia Chang <ethan.chang@mediatek.com>");
> +MODULE_AUTHOR("Michael Kao <michael.kao@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek LVTS V4 Thermal Driver");
> +MODULE_LICENSE("GPL");


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
