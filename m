Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB5582306
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiG0JYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiG0JYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:24:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEDB286D0;
        Wed, 27 Jul 2022 02:24:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD8D56601B1C;
        Wed, 27 Jul 2022 10:23:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658913839;
        bh=YxKA8NbNYr/T/T5yWxpkBGAAPnobK5DETlXnkvtVFDg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QIAiuLjmvEEbKEec+BIRezcJgR+xEaWQpvqjmeTrQnRRARSsafgKiBmu7KaRmzzaS
         sfeUiW5nO1tNv+BmjiST9e4a+LQ8IYruMlkvOxnXA/kYxPVqlTAv+PQlZxLd19fQLv
         aHwZmg8VTTHUC4MnR7N0ViWZJYCEudKiPHFx56B4BUGGcx+L4DBdYRtpiWPLLYnKqN
         tG5B1E2+5Y+AUTml2FPuTCWJnA94fb3qb0FxVgOelUz3JbCwVPo5BZ6X1jpr17kV3w
         DKcspvI2N/AGAvad0ugpzoZN6KTuT0ZDiGgpcq3rNSsOz3r1Rl1rQ1zzESUs5/8OhC
         HiDHiV5RfxOFQ==
Message-ID: <82f6cd96-65e2-57f7-b7c5-05c111874087@collabora.com>
Date:   Wed, 27 Jul 2022 11:23:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 3/6] thermal: mediatek: Add LVTS drivers for SoC
 theraml zones for mt8192
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>, rafael@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220726135506.485108-1-bchihi@baylibre.com>
 <20220726135506.485108-4-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220726135506.485108-4-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/07/22 15:55, Balsam CHIHI ha scritto:
> Add a LVTS (Low voltage thermal sensor) driver to report junction
> temperatures in Mediatek SoC mt8192 and register the maximum temperature
> of sensors and each sensor as a thermal zone.
> 
> Signed-off-by: Yu-Chia Chang <ethan.chang@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>

Hello Balsam,

there are a few comments on this patch.

First of all, can you please fix the typo that you have in the commit title?
theraml -> thermal

...then, please, the commit description:
Add a LVTS (Low Voltage Thermal Sensor) <- capitalize

and

Mediatek -> MediaTek

> ---
>   drivers/thermal/mediatek/Kconfig         |  27 +
>   drivers/thermal/mediatek/Makefile        |   2 +
>   drivers/thermal/mediatek/lvts_mt8192.c   | 241 ++++++
>   drivers/thermal/mediatek/soc_temp.c      |   2 +-
>   drivers/thermal/mediatek/soc_temp_lvts.c | 928 +++++++++++++++++++++++
>   drivers/thermal/mediatek/soc_temp_lvts.h | 365 +++++++++
>   6 files changed, 1564 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/thermal/mediatek/lvts_mt8192.c
>   create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
>   create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h
> 
> diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
> index 9c41e9079fc3..7fc04237dd50 100644
> --- a/drivers/thermal/mediatek/Kconfig
> +++ b/drivers/thermal/mediatek/Kconfig
> @@ -20,4 +20,31 @@ config MTK_SOC_THERMAL
>   		configures thermal controllers to collect temperature
>   		via AUXADC interface.
>   
> +config MTK_SOC_THERMAL_LVTS
> +	tristate "LVTS (Low voltage thermal sensor) driver for Mediatek SoCs"
> +	depends on HAS_IOMEM
> +	depends on NVMEM
> +	depends on RESET_TI_SYSCON
> +	help
> +		Enable this option if you want to get SoC temperature
> +		information for MediaTek platforms. This driver
> +		configures LVTS thermal controllers to collect temperatures
> +		via Analog Serial Interface(ASIF).

Fix the indentation, please:

	help
	  Enable this option.......
(\t<space><space>)



> +
> +endif
> +
> +if MTK_SOC_THERMAL_LVTS
> +
> +config LVTS_MT8192
> +	tristate "LVTS driver for MediaTek MT8192 SoC"
> +	depends on HAS_IOMEM
> +	depends on NVMEM
> +	depends on RESET_TI_SYSCON
> +	depends on MTK_SOC_THERMAL_LVTS
> +	help
> +		Enable this option if you want to get SoC temperature
> +		information for MT8192. This driver
> +		configures LVTS thermal controllers to collect temperatures
> +		via ASIF.
> +
>   endif
> diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
> index 4b4cb04a358f..5ff1197e80ab 100644
> --- a/drivers/thermal/mediatek/Makefile
> +++ b/drivers/thermal/mediatek/Makefile
> @@ -1 +1,3 @@
>   obj-$(CONFIG_MTK_SOC_THERMAL)		+= soc_temp.o
> +obj-$(CONFIG_MTK_SOC_THERMAL_LVTS)	+= soc_temp_lvts.o
> +obj-$(CONFIG_LVTS_MT8192)			+= lvts_mt8192.o
> diff --git a/drivers/thermal/mediatek/lvts_mt8192.c b/drivers/thermal/mediatek/lvts_mt8192.c
> new file mode 100644
> index 000000000000..19e4e82c410b
> --- /dev/null
> +++ b/drivers/thermal/mediatek/lvts_mt8192.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + */
> +
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include "soc_temp_lvts.h"
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
> +	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int i, j;
> +	const unsigned int mt8192_TS[] = {MT8192_TS2_0, MT8192_TS3_0};


Please fix and reorder (here and for any other instance):

	const unsigned int mt8192_ts[] = { MT8192_TS2_0, MT8192_TS3_0 };
	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
	unsigned int i, j;

> +
> +	cal_data->golden_temp = GET_CAL_DATA_BITMASK(0, lvts_data, 31, 24);
> +
> +	for (i = 0; i < MT8192_NUM_TS_MCU; i++)
> +		cal_data->count_r[i] = GET_CAL_DATA_BITMASK(i + 1, lvts_data, 23, 0);
> +
> +	cal_data->count_rc[MT8192_TS1_0] = GET_CAL_DATA_BITMASK(21, lvts_data, 23, 0);

..snip..

> +
> +static const struct lvts_tc_settings mt8192_tc_mcu_settings[] = {
> +	[0] = {
> +		.dev_id = 0x81,
> +		.addr_offset = 0x0,
> +		.num_sensor = 2,
> +		.sensor_map = {MT8192_TS1_0, MT8192_TS1_1},

Please, leave a space after opening and before closing the braces.

> +		.tc_speed = &tc_speed_mt8192,
> +		.hw_filter = LVTS_FILTER_2_OF_4,
> +		.dominator_sensing_point = SENSING_POINT1,
> +		.hw_reboot_trip_point = HW_REBOOT_TRIP_POINT,
> +		.irq_bit = BIT(3),
> +	},

..snip..

> +
> +static const struct lvts_data mt8192_lvts_ap_data = {
> +	.num_tc = (ARRAY_SIZE(mt8192_tc_ap_settings)),
> +	.tc = mt8192_tc_ap_settings,
> +	.num_sensor = MT8192_NUM_TS_AP,
> +	.ops = {
> +		.efuse_to_cal_data = mt8192_ap_efuse_to_cal_data,
> +		.device_enable_and_init = lvts_device_enable_and_init_v4,
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

I don't like having one driver per SoC, where we have only two specific functions.

I suggest to either:
- Remove the static word from mt8192_lvts_ap_data and put the of_match
   in soc_temp_lvts.c; or
- Separate the SoCs by LVTS version: create a lvts_v4.c where we group all
   of the V4 SoCs (so, currently, MT8192 and MT8195): this will allow us to
   eventually get a lvts_v3, lvts_v2, etc, where we group other SoCs.

I prefer the second way, as MediaTek has a lot of SoCs and I can see this list
growing a lot when these will be (hopefully) upstreamed.



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
> +	.driver = {
> +		.name = "mtk-soc-temp-lvts-mt8192",
> +		.of_match_table = lvts_of_match,
> +	},
> +};
> +module_platform_driver(soc_temp_lvts);
> +
> +MODULE_AUTHOR("Yu-Chia Chang <ethan.chang@mediatek.com>");
> +MODULE_AUTHOR("Michael Kao <michael.kao@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek soc temperature driver");
> +MODULE_LICENSE("GPL v2");

You should run checkpatch.pl. Please.

> diff --git a/drivers/thermal/mediatek/soc_temp.c b/drivers/thermal/mediatek/soc_temp.c
> index ede94eadddda..60924f8f98e9 100644
> --- a/drivers/thermal/mediatek/soc_temp.c
> +++ b/drivers/thermal/mediatek/soc_temp.c
> @@ -23,7 +23,7 @@
>   #include <linux/reset.h>
>   #include <linux/types.h>
>   
> -#include "thermal_hwmon.h"
> +#include "../thermal_hwmon.h"

This change doesn't belong to this commit.

>   
>   /* AUXADC Registers */
>   #define AUXADC_CON1_SET_V	0x008
> diff --git a/drivers/thermal/mediatek/soc_temp_lvts.c b/drivers/thermal/mediatek/soc_temp_lvts.c
> new file mode 100644
> index 000000000000..ee7efc0de65f
> --- /dev/null
> +++ b/drivers/thermal/mediatek/soc_temp_lvts.c
> @@ -0,0 +1,928 @@
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
> +#include "soc_temp_lvts.h"
> +
> +static int lvts_raw_to_temp(struct lvts_formula_coeff *co, unsigned int msr_raw)
> +{
> +	/* This function returns degree mC */
> +
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
> +	msr_raw = div_s64((s64)((co->golden_temp * 500 + co->b - temp)) << 14,
> +		(-1 * co->a));
> +
> +	return msr_raw;
> +}
> +
> +static int soc_temp_lvts_read_temp(void *data, int *temperature)
> +{
> +	struct soc_temp_tz *lvts_tz = (struct soc_temp_tz *)data;
> +	struct lvts_data *lvts_data = lvts_tz->lvts_data;
> +	unsigned int msr_raw;
> +
> +	msr_raw = readl(lvts_data->reg[lvts_tz->id]) & MRS_RAW_MASK;
> +	if (msr_raw == 0)
> +		return -EINVAL;
> +
> +	*temperature = lvts_raw_to_temp(&lvts_data->coeff, msr_raw);
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops soc_temp_lvts_ops = {
> +	.get_temp = soc_temp_lvts_read_temp,
> +};
> +
> +static void lvts_write_device(struct lvts_data *lvts_data, unsigned int data,
> +	int tc_id)
> +{
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
> +
> +	writel(DEVICE_WRITE | data, LVTS_CONFIG_0 + base);
> +
> +	usleep_range(5, 15);
> +}
> +
> +static unsigned int lvts_read_device(struct lvts_data *lvts_data,
> +	unsigned int reg_idx, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	void __iomem *base = GET_BASE_ADDR(lvts_data, tc_id);
> +	unsigned int data;
> +	int ret;
> +
> +	writel(READ_DEVICE_REG(reg_idx), LVTS_CONFIG_0 + base);
> +
> +	usleep_range(5, 15);
> +
> +	ret = readl_poll_timeout(LVTS_CONFIG_0 + base, data,
> +		!(data & DEVICE_ACCESS_STARTUS), 2, 200);
> +	if (ret)
> +		dev_err(dev,
> +			"Error: LVTS %d DEVICE_ACCESS_START is not ready\n", tc_id);
> +
> +	data = readl(LVTSRDATA0_0 + base);
> +
> +	return data;
> +}
> +
> +static const char * const lvts_error_table[] = {"IDLE", "Write transaction",
> +	"Waiting for read after Write", "Disable Continue fetching on Device",
> +	"Read transaction", "Set Device special Register for Voltage threshold",
> +	"Set TSMCU number for Fetch"};

In my opinion, that's unreadable.

static const char * const lvts_error_table[] = {

	"Idle",

	"Write transaction",

	"Waiting for read after write",

	"Disable continue fetching on device",

	"Read transaction",

	"Set device special register for voltage threshold",

	"Set TSMCU number for fetch"

};

...but like this, it's way more readable.


> +
> +static void wait_all_tc_sensing_point_idle(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	unsigned int mask, error_code, is_error;
> +	void __iomem *base;
> +	int i, cnt, ret;
> +
> +	mask = BIT(10) | BIT(7) | BIT(0);

What are these magic bits?
Please add definitions.

> +
> +	for (cnt = 0; cnt < 2; cnt++) {
> +		is_error = 0;
> +		for (i = 0; i < lvts_data->num_tc; i++) {
> +			base = GET_BASE_ADDR(lvts_data, i);
> +			ret = readl_poll_timeout(LVTSMSRCTL1_0 + base, error_code,
> +						 !(error_code & mask), 2, 200);
> +
> +			error_code = ((error_code & BIT(10)) >> 8) +
> +				((error_code & BIT(7)) >> 6) +
> +				(error_code & BIT(0));
> +
> +			if (ret)
> +				dev_err(dev, "LVTS %d error: %s\n",
> +					i, lvts_error_table[error_code]);
> +
> +			if (error_code != 0)
> +				is_error = 1;
> +		}
> +
> +		if (is_error == 0)
> +			break;
> +	}
> +}
> +

...snip...

> +static void set_hw_filter(struct lvts_data *lvts_data, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	unsigned int option;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(lvts_data, tc_id);
> +	option = tc[tc_id].hw_filter & 0x7;
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
> +
> +	writel(option, LVTSMSRCTL0_0 + base);
> +	dev_dbg(dev, "LVTS_TC_%d, LVTSMSRCTL0_0= 0x%x\n",
> +		 tc_id, readl(LVTSMSRCTL0_0 + base));
> +}
> +
> +static int get_dominator_index(struct lvts_data *lvts_data, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	int d_index;
> +
> +	if (tc[tc_id].dominator_sensing_point == ALL_SENSING_POINTS) {
> +		d_index = ALL_SENSING_POINTS;
> +	} else if (tc[tc_id].dominator_sensing_point <
> +		tc[tc_id].num_sensor){

There's no reason to break this line.

> +		d_index = tc[tc_id].dominator_sensing_point;
> +	} else {
> +		dev_err(dev,
> +			"Error: LVTS%d, dominator_sensing_point= %d should smaller than num_sensor= %d\n",

"Error:" is unneeded, as this is a dev_err, so it's definitely an error.
Also, s/should/shall be/g

> +			tc_id, tc[tc_id].dominator_sensing_point,
> +			tc[tc_id].num_sensor);
> +
> +		dev_err(dev, "Use the sensing point 0 as the dominated sensor\n");
> +		d_index = SENSING_POINT0;
> +	}
> +
> +	return d_index;
> +}
> +
> +static void disable_hw_reboot_interrupt(struct lvts_data *lvts_data, int tc_id)
> +{
> +	unsigned int temp;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(lvts_data, tc_id);
> +
> +	/*
> +	 * LVTS thermal controller has two interrupts for thermal HW reboot
> +	 * One is for AP SW and the other is for RGU
> +	 * The interrupt of AP SW can turn off by a bit of a register, but
> +	 * the other for RGU cannot.
> +	 * To prevent rebooting device accidentally, we are going to add
> +	 * a huge offset to LVTS and make LVTS always report extremely low
> +	 * temperature.
> +	 */
> +
> +	/*
> +	 * After adding the huge offset 0x3FFF, LVTS alawys adds the

s/alawys/always/g

> +	 * offset to MSR_RAW.
> +	 * When MSR_RAW is larger, SW will convert lower temperature/
> +	 */
> +	temp = readl(LVTSPROTCTL_0 + base);
> +	writel(temp | 0x3FFF, LVTSPROTCTL_0 + base);
> +
> +	/* Disable the interrupt of AP SW */
> +	temp = readl(LVTSMONINT_0 + base);
> +	writel(temp & ~(STAGE3_INT_EN), LVTSMONINT_0 + base);
> +}
> +
> +static void enable_hw_reboot_interrupt(struct lvts_data *lvts_data, int tc_id)
> +{
> +	unsigned int temp;
> +	void __iomem *base;
> +
> +	base = GET_BASE_ADDR(lvts_data, tc_id);
> +
> +	/* Enable the interrupt of AP SW */
> +	temp = readl(LVTSMONINT_0 + base);
> +	writel(temp | STAGE3_INT_EN, LVTSMONINT_0 + base);
> +	/* Clear the offset */
> +	temp = readl(LVTSPROTCTL_0 + base);
> +	writel(temp & ~PROTOFFSET, LVTSPROTCTL_0 + base);
> +}
> +
> +static void set_tc_hw_reboot_threshold(struct lvts_data *lvts_data,
> +	int trip_point, int tc_id)
> +{
> +	struct device *dev = lvts_data->dev;
> +	unsigned int msr_raw, temp, config, d_index;
> +	void __iomem *base;

	void __iomem *base;
	struct device *dev = lvts_data->dev;
	unsigned int msr_raw, temp, config, d_index;

or

	unsigned int msr_raw, temp, config, d_index;
	struct device *dev = lvts_data->dev;
	void __iomem *base;

Make it pretty - human readabilty is important.
P.S.: I prefer the first option.
P.P.S.: This is not the only instance!

> +
> +	base = GET_BASE_ADDR(lvts_data, tc_id);
> +	d_index = get_dominator_index(lvts_data, tc_id);
> +
> +	dev_info(dev, "lvts_tc_%d: dominator sensing point = %d\n", tc_id, d_index);

dev_dbg().

> +
> +	disable_hw_reboot_interrupt(lvts_data, tc_id);
> +
> +	temp = readl(LVTSPROTCTL_0 + base);
> +	if (d_index == ALL_SENSING_POINTS) {
> +		/* Maximum of 4 sensing points */
> +		config = (0x1 << 16);
> +		writel(config | temp, LVTSPROTCTL_0 + base);
> +	} else {
> +		/* Select protection sensor */
> +		config = ((d_index << 2) + 0x2) << 16;
> +		writel(config | temp, LVTSPROTCTL_0 + base);
> +	}
> +
> +	msr_raw = lvts_temp_to_raw(&lvts_data->coeff, trip_point);
> +	writel(msr_raw, LVTSPROTTC_0 + base);
> +
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
> +
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
> +		dev_err(dev,
> +			"Error: Failed to enable lvts controller clock: %d\n",
> +			ret);

This should be:
		dev_err(dev, "Failed to enable lvts controller clock: %d\n", ret);

(or return dev_err_probe()).

> +		return ret;
> +	}
> +
> +	lvts_reset(lvts_data);
> +
> +	device_identification(lvts_data);
> +	if (ops->device_enable_and_init)
> +		ops->device_enable_and_init(lvts_data);
> +
> +	if (HAS_FEATURE(lvts_data, FEATURE_DEVICE_AUTO_RCK)) {
> +		if (ops->device_enable_auto_rck)
> +			ops->device_enable_auto_rck(lvts_data);
> +	} else {
> +		if (ops->device_read_count_rc_n)
> +			ops->device_read_count_rc_n(lvts_data);
> +	}

	if (HAS_FEATURE(lvts_data, FEATURE_DEVICE_AUTO_RCK) && ops....)
		ops....
	else if (ops.....)
		ops.....

> +
> +	if (ops->set_cal_data)
> +		ops->set_cal_data(lvts_data);
> +
> +	disable_all_sensing_points(lvts_data);
> +	wait_all_tc_sensing_point_idle(lvts_data);
> +	if (ops->init_controller)
> +		ops->init_controller(lvts_data);
> +	enable_all_sensing_points(lvts_data);
> +
> +	set_all_tc_hw_reboot(lvts_data);
> +
> +	return 0;
> +}
> +
> +static int prepare_calibration_data(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	struct platform_ops *ops = &lvts_data->ops;
> +	int i, offset;
> +	char buffer[512];
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
> +	if (cal_data->golden_temp == 0 || cal_data->golden_temp > GOLDEN_TEMP_MAX)
> +		cal_data->use_fake_efuse = 1;
> +
> +	if (cal_data->use_fake_efuse) {
> +		/* It means all efuse data are equal to 0 */
> +		dev_err(dev,
> +			"%s: This sample is not calibrated, fake !!\n", __func__);
> +
> +		cal_data->golden_temp = cal_data->default_golden_temp;
> +		for (i = 0; i < lvts_data->num_sensor; i++) {
> +			cal_data->count_r[i] = cal_data->default_count_r;
> +			cal_data->count_rc[i] = cal_data->default_count_rc;
> +		}
> +	}
> +
> +	lvts_data->coeff.golden_temp = cal_data->golden_temp;
> +
> +	dev_dbg(dev, "golden_temp = %d\n", cal_data->golden_temp);
> +
> +	offset = snprintf(buffer, sizeof(buffer), "[lvts_cal] num:g_count:g_count_rc ");
> +	for (i = 0; i < lvts_data->num_sensor; i++)
> +		offset += snprintf(buffer + offset, sizeof(buffer) - offset, "%d:%d:%d ",
> +			i, cal_data->count_r[i], cal_data->count_rc[i]);
> +
> +	buffer[offset] = '\0';

What is this string for?
You're formatting it but never using, what's the point?

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
> +					sizeof(*lvts_data->efuse), GFP_KERNEL);
> +	if (!lvts_data->efuse)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lvts_data->num_efuse_block; i++) {
> +		snprintf(cell_name, sizeof(cell_name), "lvts_calib_data%d", i + 1);
> +		cell = nvmem_cell_get(dev, cell_name);
> +		if (IS_ERR(cell)) {
> +			dev_err(dev, "Error: Failed to get nvmem cell %s\n", cell_name);
> +			return PTR_ERR(cell);
> +		}
> +
> +		buf = (u32 *)nvmem_cell_read(cell, &len);
> +		nvmem_cell_put(cell);
> +
> +		if (IS_ERR(buf))
> +			return PTR_ERR(buf);
> +
> +		for (j = 0; j < (len / sizeof(u32)); j++) {
> +			if (index >= lvts_data->num_efuse_addr) {
> +				dev_err(dev, "Array efuse is going to overflow");
> +				kfree(buf);
> +				return -EINVAL;

If we get an error here, you should free all of the allocated buffers, which means
that you have to walk back from i to 0 and kfree everything, or this is going to be
a (relatively) big memory leak.

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
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	unsigned int i, j, s_index;
> +	void __iomem *base;
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
> +			lvts_data->reg[s_index] = LVTSMSR0_0 + base + 0x4 * j;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int of_update_lvts_data(struct lvts_data *lvts_data,
> +	struct platform_device *pdev)
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
> +		return -ENXIO;
> +	}
> +
> +	lvts_data->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(lvts_data->base)) {
> +		dev_err(dev, "Failed to remap io\n");
> +		return PTR_ERR(lvts_data->base);
> +	}
> +
> +	/* Get interrupt number */
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "No irq resource\n");
> +		return -EINVAL;

Why are you overriding the return value? return ret here.

> +	}
> +	lvts_data->irq_num = ret;
> +
> +	/* Get reset control */
> +	lvts_data->reset = devm_reset_control_get_by_index(dev, 0);
> +	if (IS_ERR(lvts_data->reset)) {
> +		dev_err(dev, "Failed to get reset control\n");
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

..snip..

> +
> +static irqreturn_t irq_handler(int irq, void *dev_id)
> +{
> +	struct lvts_data *lvts_data = (struct lvts_data *)dev_id;
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	unsigned int i, *irq_bitmap;
> +	void __iomem *base;
> +
> +	irq_bitmap = kcalloc(1, sizeof(*irq_bitmap), GFP_ATOMIC);
> +

You're using this for debugging only? Also, why wasn't this stack-allocated?

Just remove it.

> +	if (!irq_bitmap)
> +		return IRQ_NONE;
> +
> +	base = lvts_data->base;
> +	*irq_bitmap = readl(THERMINTST + base);
> +	dev_dbg(dev, "THERMINTST = 0x%x\n", *irq_bitmap);
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		if (tc[i].irq_bit == 0)
> +			tc_irq_handler(lvts_data, i);
> +	}
> +
> +	kfree(irq_bitmap);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int lvts_register_irq_handler(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	int ret;
> +
> +	ret = devm_request_irq(dev, lvts_data->irq_num, irq_handler,
> +		IRQF_TRIGGER_HIGH, "mtk_lvts", lvts_data);

Interrupt flags are specified in devicetree: why are you forcing TRIGGER_HIGH here?

> +
> +	if (ret) {
> +		dev_err(dev, "Failed to register LVTS IRQ, ret %d, irq_num %d\n",
> +			ret, lvts_data->irq_num);
> +		lvts_close(lvts_data);
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
> +			return -ENOMEM;
> +		}
> +
> +		lvts_tz->id = i;
> +		lvts_tz->lvts_data = lvts_data;
> +
> +		tzdev = devm_thermal_zone_of_sensor_register(dev, lvts_tz->id,
> +			lvts_tz, &soc_temp_lvts_ops);
> +
> +		if (IS_ERR(tzdev)) {
> +			if (lvts_tz->id != 0)
> +				return 0;
> +
> +			ret = PTR_ERR(tzdev);
> +			dev_err(dev, "Error: Failed to register lvts tz %d, ret = %d\n",

s/Error: //g - here and everywhere else: a dev_err() *is* an error print.

> +				lvts_tz->id, ret);
> +			lvts_close(lvts_data);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

..snip..

> +
> +int lvts_device_read_count_rc_n_v4(struct lvts_data *lvts_data)
> +{
> +	/* Resistor-Capacitor Calibration */
> +	/* count_RC_N: count RC now */
> +	struct device *dev = lvts_data->dev;
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int offset, size, s_index, data;
> +	void __iomem *base;
> +	int ret, i, j;
> +	char buffer[512];

I don't think that you need this buffer to be that long and I'm sure that its
size can be reduced.
I didn't check how much you need, but I'm guessing that you need less than a
quarter of that size.

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
> +
> +			lvts_write_device(lvts_data, SELECT_SENSOR_RCK_V4(j), i);
> +			lvts_write_device(lvts_data, SET_DEVICE_SINGLE_MODE_V4, i);
> +			usleep_range(10, 20);
> +
> +			lvts_write_device(lvts_data, KICK_OFF_RCK_COUNTING_V4, i);
> +			usleep_range(30, 40);
> +
> +			ret = readl_poll_timeout(LVTS_CONFIG_0 + base, data,
> +						 !(data & DEVICE_SENSING_STATUS), 2, 200);
> +			if (ret)
> +				dev_err(dev,
> +					"Error: LVTS %d DEVICE_SENSING_STATUS didn't ready\n", i);
> +
> +			data = lvts_read_device(lvts_data, 0x00, i);
> +
> +			cal_data->count_rc_now[s_index] = (data & GENMASK(23, 0));

No magic GENMASK() or BIT() please, add a definition for readability.

> +		}
> +
> +		/* Recover Setting for Normal Access on
> +		 * temperature fetch
> +		 */
> +		lvts_write_device(lvts_data, SET_SENSOR_NO_RCK_V4, i);
> +		lvts_write_device(lvts_data, SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
> +	}
> +
> +	size = sizeof(buffer);
> +	offset = snprintf(buffer, size, "[COUNT_RC_NOW] ");
> +	for (i = 0; i < lvts_data->num_sensor; i++)
> +		offset += snprintf(buffer + offset, size - offset, "%d:%d ",
> +			i, cal_data->count_rc_now[i]);
> +
> +	buffer[offset] = '\0';
> +	dev_dbg(dev, "%s\n", buffer);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lvts_device_read_count_rc_n_v4);
> +
> +void lvts_set_calibration_data_v4(struct lvts_data *lvts_data)
> +{
> +	const struct lvts_tc_settings *tc = lvts_data->tc;
> +	struct lvts_sensor_cal_data *cal_data = &lvts_data->cal_data;
> +	unsigned int i, j, s_index, lvts_calib_data;
> +	void __iomem *base;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +
> +		for (j = 0; j < tc[i].num_sensor; j++) {
> +			s_index = tc[i].sensor_map[j];
> +			if (HAS_FEATURE(lvts_data, FEATURE_DEVICE_AUTO_RCK))
> +				lvts_calib_data = cal_data->count_r[s_index];
> +			else
> +				lvts_calib_data = (((unsigned long long)

lvts_calib_data is unsigned int. You're assigning unsigned long long here.

Also, since this is register-size bound, use fixed size types.

> +					cal_data->count_rc_now[s_index]) *
> +					cal_data->count_r[s_index]) >> 14;
> +
> +			writel(lvts_calib_data, LVTSEDATA00_0 + base + 0x4 * j);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(lvts_set_calibration_data_v4);
> +
> +void lvts_init_controller_v4(struct lvts_data *lvts_data)
> +{
> +	struct device *dev = lvts_data->dev;
> +	unsigned int i;
> +	void __iomem *base;
> +
> +	for (i = 0; i < lvts_data->num_tc; i++) {
> +		base = GET_BASE_ADDR(lvts_data, i);
> +
> +		lvts_write_device(lvts_data, SET_DEVICE_LOW_POWER_SINGLE_MODE_V4, i);
> +
> +		writel(SET_SENSOR_INDEX, LVTSTSSEL_0 + base);
> +		writel(SET_CALC_SCALE_RULES, LVTSCALSCALE_0 + base);
> +
> +		set_polling_speed(lvts_data, i);
> +		set_hw_filter(lvts_data, i);
> +
> +		dev_info(dev, "lvts_tc_%d: read all %d sensors in %d us, one in %d us\n",
> +			i, GET_TC_SENSOR_NUM(lvts_data, i), GROUP_LATENCY_US(i), SENSOR_LATENCY_US(i));

dev_dbg().

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
> +
> +	if (!lvts_data)	{
> +		dev_err(dev, "Error: Failed to get lvts platform data\n");
> +		return -ENODATA;
> +	}
> +
> +	lvts_data->dev = &pdev->dev;
> +
> +	ret = of_update_lvts_data(lvts_data, pdev);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, lvts_data);
> +
> +	ret = lvts_init(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = lvts_register_irq_handler(lvts_data);
> +	if (ret)
> +		return ret;

If anything goes wrong here, you're leaving the lvts_data->clk clock enabled.
Please fix.

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
> +
> +	lvts_close(lvts_data);
> +
> +	return 0;
> +}
> +
> +int lvts_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct lvts_data *lvts_data;
> +
> +	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
> +
> +	lvts_close(lvts_data);
> +
> +	return 0;
> +}
> +
> +int lvts_resume(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct lvts_data *lvts_data;
> +
> +	lvts_data = (struct lvts_data *)platform_get_drvdata(pdev);
> +
> +	ret = lvts_init(lvts_data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +MODULE_AUTHOR("Yu-Chia Chang <ethan.chang@mediatek.com>");
> +MODULE_AUTHOR("Michael Kao <michael.kao@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek soc temperature driver");
> +MODULE_LICENSE("GPL v2");

Regards,
Angelo
