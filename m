Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA19586C93
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiHAOIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:08:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37DC18B26
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:08:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h205-20020a1c21d6000000b003a34ac64bdfso4385743wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=7tHtNE26iyqr1hTbPB+Yhcm5s0t0rMIPa9EX7DSsnDc=;
        b=A+CNsGhWMpo8Xwi2DUrOPv9VgoylV5k2A6+voIvpDPEYEgDbz/kBpC5LmdSRnHWPwr
         L5xqZYAZ9cteheeZ69EtJBUeolM64ZYyCqzraC8e11IB0Png9LGOhWM84dVSpLis6h2F
         J6rS3vkw1xvd0NOO09tdBt5yCjccDYqaY/gqr8HejLpJER9B7Z7roM2FMJykna7Fx/n8
         OId6UuBCA3NeLuZxMGTxa6MmBHJCfUANsp6O92uvxV1M6B41KtBOaH7q+d2xNH6nUjDj
         8YJo/EgSdBF6vK/LbGYit3ybvHSAv3xNNzsJxfVLIe1ZYJ/Oxw58Afjvc5MLUJ7MKJD9
         pEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=7tHtNE26iyqr1hTbPB+Yhcm5s0t0rMIPa9EX7DSsnDc=;
        b=cac5biMLv2A3EvsaXLiOMRsriXYo3bYWJhF2AV1vK0DVv04WZAi7HBbtx00fSbrkgt
         A9mYV/YEVHckQpWSp/+rTBXoajotkNKeSpYY1n1EADYPN6PODV3wbSIX/wW3Nq7NVOuY
         fLnv5RATi1wq3lmchGhTqDWFcPDcPBrPQXUdT5R2HEfhGHb9iw9PFXBRYZTbCJEIFq51
         qxSWNPxPe25XJPOFQff/hSGq3eGOxhg6iYl4YITBwMlLwa81dPq5TQ0lWHiODXE/mGvc
         U/ayQ3x5G1brSXq8SJJNgfoABiu5PZ6tHgtdDKJe7VFfomB+xGHl/rPjmLDBTcmFin8k
         /DYw==
X-Gm-Message-State: AJIora/wRzqgQkWdvAFhL+knJJ8e1AXsfReroE/Vn6Sz4TVWoNsEaZCv
        7a1Fix5sGqEmaHnU+NGUp1BSWA==
X-Google-Smtp-Source: AGRyM1sPo7MaMLLDy0Sohbq77DM16AtIjR3a/Wc957px080+P6wgSO8FApCOO4D2v6h5tVdQO2AJgQ==
X-Received: by 2002:a05:600c:211:b0:3a3:194d:7282 with SMTP id 17-20020a05600c021100b003a3194d7282mr11069798wmi.132.1659362884984;
        Mon, 01 Aug 2022 07:08:04 -0700 (PDT)
Received: from [192.168.1.69] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm11937822wrn.109.2022.08.01.07.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 07:08:04 -0700 (PDT)
Message-ID: <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
Date:   Mon, 1 Aug 2022 16:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver support
 for ECAP
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com
References: <20220728175124.468461-1-jpanis@baylibre.com>
 <20220728175124.468461-3-jpanis@baylibre.com>
 <20220731164116.30e91f34@jic23-huawei>
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20220731164116.30e91f34@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/2022 17:41, Jonathan Cameron wrote:
> On Thu, 28 Jul 2022 19:51:24 +0200
> Julien Panis <jpanis@baylibre.com> wrote:
>
>> ECAP hardware on AM62x SoC supports capture feature. It can be used
>> to timestamp events (falling/rising edges) detected on signal input pin.
>>
>> This commit adds capture driver support for ECAP hardware on AM62x SoC.
>>
>> In the ECAP hardware, capture pin can also be configured to be in
>> PWM mode. Current implementation only supports capture operating mode.
>> Hardware also supports timebase sync between multiple instances, but
>> this driver supports simple independent capture functionality.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Hi Julien,
>
> So this isn't the first ecap driver we've had proposed, but the previous
> one was a few years ago and never reached v2.
> https://lore.kernel.org/all/20200818153614.6438-1-dts86@cornell.edu/
>
> Honestly I can't remember much about it, but maybe the discussion around
> that will be worth a reread.

Hi Jonathan, thank you for your review.

I read the discussion about previous attempt, before submitting this 
patch. There were
interesting comments indeed.

But in this previous attempt, only one-shot pulses were handled 
(moreover, global IRQ flag
was not cleared, so I'm not sure that IRQ could be raised more than once).

However, ECAP can be used to make time measurements for any type of 
"square waveform".
That's why I tried to make this event mode configurable. Besides, using 
a continuous mode allows
handling much more signal types (not only single pulses).

>
> The use of ABI here is unusual. So I'd definitely like to see some documentation
> probably as a file in the main kernel documentation to explain what the interface
> is an how that relates to what is being captured.

OK, I will add some userspace documentation.

>
> First thing to note here is the channel type of IIO_INDEX is now not actually
> used any more because we moved all the relevant drivers over to the counter
> subsystem (and we failed to mark it deprecated).

I evaluated this counter subsystem before starting development. Counting 
events is not "a priori"
the goal when using ECAP.

Nevertheless, maybe "counter_push_event" function could do the job. If I 
use counter API :
# Option 1 : CAP1/2/3/4 registers could be seen as 4 channels of the 
same counter...
but there are not channels, there are just sequential timestamps 
actually. So I'm afraid this leads
to misunderstanding for the user.
Moreover, the user will have to read several entries (counts 1/2/3/4) to 
gather timestamps from
the same input signal, which is not very convenient.
# Option 2 : Either CAP 1/2/3/4 events could be gathered in a single 
channel...but then it will not
be possible to configure their polarity (rising/falling edge) 
individually (unless I did
not understand well counter framework documentation).

So, even with counter framework, it will lead to some diverted use of 
the framwork, since ECAP
is a very specific hardware that do not fit 100% counter philosophy.

I admit that ECAP do not fit 100% IIO philosophy either.

Maybe misc API would be more relevant actually. Any opinion about it 
will be welcome. :-)

>
> Anyhow, I've reviewed below, but need docs to discuss this in depth.  In particular
> the mix of buffers and events interfaces is unlikely to be an acceptable path
> forwards.

OK, I will consider alternatives.

>
> Jonathan
>
>> ---
>>   drivers/iio/Kconfig               |   1 +
>>   drivers/iio/Makefile              |   1 +
>>   drivers/iio/time/Kconfig          |  22 ++
>>   drivers/iio/time/Makefile         |   6 +
>>   drivers/iio/time/capture-tiecap.c | 517 ++++++++++++++++++++++++++++++
>>   5 files changed, 547 insertions(+)
>>   create mode 100644 drivers/iio/time/Kconfig
>>   create mode 100644 drivers/iio/time/Makefile
>>   create mode 100644 drivers/iio/time/capture-tiecap.c
>>
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index b190846c3dc2..ba11b8824071 100644
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> @@ -99,5 +99,6 @@ source "drivers/iio/pressure/Kconfig"
>>   source "drivers/iio/proximity/Kconfig"
>>   source "drivers/iio/resolver/Kconfig"
>>   source "drivers/iio/temperature/Kconfig"
>> +source "drivers/iio/time/Kconfig"
>>   
>>   endif # IIO
>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> index 3be08cdadd7e..09283402a2c6 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -42,4 +42,5 @@ obj-y += proximity/
>>   obj-y += resolver/
>>   obj-y += temperature/
>>   obj-y += test/
>> +obj-y += time/
>>   obj-y += trigger/
>> diff --git a/drivers/iio/time/Kconfig b/drivers/iio/time/Kconfig
>> new file mode 100644
>> index 000000000000..02f6cf7ff79e
>> --- /dev/null
>> +++ b/drivers/iio/time/Kconfig
>> @@ -0,0 +1,22 @@
>> +#
>> +# Time drivers
>> +#
>> +
>> +menu "Time"
>> +
>> +config CAPTURE_TIECAP
>> +	tristate "ECAP capture support"
>> +	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>> +	depends on HAS_IOMEM
>> +	select IIO_BUFFER
>> +	select IIO_KFIFO_BUF
>> +	help
>> +	  IIO driver support for the ECAP capture hardware found on TI SoCs.
>> +
>> +	  It can be used to timestamp events (falling/rising edges) detected
>> +	  on signal input pin.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called capture-tiecap.
>> +
>> +endmenu
>> diff --git a/drivers/iio/time/Makefile b/drivers/iio/time/Makefile
>> new file mode 100644
>> index 000000000000..3a27f3557d1e
>> --- /dev/null
>> +++ b/drivers/iio/time/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Makefile for industrial I/O Time drivers
>> +#
>> +
>> +obj-$(CONFIG_CAPTURE_TIECAP) += capture-tiecap.o
>> diff --git a/drivers/iio/time/capture-tiecap.c b/drivers/iio/time/capture-tiecap.c
>> new file mode 100644
>> index 000000000000..305011836ef3
>> --- /dev/null
>> +++ b/drivers/iio/time/capture-tiecap.c
>> @@ -0,0 +1,517 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * ECAP Capture driver
>> + *
>> + * Copyright (C) 2022 Julien Panis <jpanis@baylibre.com>
>> + */
>> +
>> +#include <linux/module.h>
> Headers preferred in alphabetical order but with more specific
> headers in groups.
>
> #include <linux/clk.h
> ...
> #include <linux/regmap.h>
>
> #include <linux/iio/buffer.h>
> #include <linux/iio/iio.h>
> #include <linux/iio/kfifo_buf.h>

OK

>
>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/err.h>
>> +#include <linux/clk.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/of_device.h>
> Bad sign.  What's this used for?  Unless absolutely necessary please use
> linux/property.h interfaces.
> Probably you should have
> linux/mod_devicetable.h for the of_device_id structure definition.

OK

>
>
>> +#include <linux/bitfield.h>
>> +#include <linux/regmap.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/kfifo_buf.h>
>> +
>> +/* Registers */
>> +#define ECAP_NB_CAP			4
>> +
>> +#define ECAP_TSCNT_REG			0x00
>> +
>> +#define ECAP_CAP_REG(i)		(((i) << 2) + 0x08)
>> +
>> +#define ECAP_ECCTL_REG			0x28
>> +#define ECAP_CAPPOL_BIT(i)		BIT((i) << 1)
>> +#define ECAP_EV_MODE_MASK		GENMASK(7, 0)
>> +#define ECAP_CAPLDEN_BIT		BIT(8)
>> +#define ECAP_EVTFLTPS_MASK		GENMASK(13, 9)
>> +#define ECAP_PS_DEFAULT_VAL		0
>> +#define ECAP_PS_MAX_VAL		31
>> +#define ECAP_CONT_ONESHT_BIT		BIT(16)
>> +#define ECAP_STOPVALUE_MASK		GENMASK(18, 17)
>> +#define ECAP_REARM_RESET_BIT		BIT(19)
>> +#define ECAP_TSCNTSTP_BIT		BIT(20)
>> +#define ECAP_SYNCO_DIS_MASK		GENMASK(23, 22)
>> +#define ECAP_CAP_APWM_BIT		BIT(25)
>> +#define ECAP_ECCTL_EN_MASK		(ECAP_CAPLDEN_BIT | ECAP_TSCNTSTP_BIT)
>> +#define ECAP_ECCTL_CFG_MASK		(ECAP_EVTFLTPS_MASK | ECAP_SYNCO_DIS_MASK	\
>> +					| ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MASK	\
>> +					| ECAP_CAP_APWM_BIT | ECAP_CONT_ONESHT_BIT	\
>> +					| ECAP_REARM_RESET_BIT)
>> +
>> +#define ECAP_ECINT_EN_FLG_REG		0x2c
>> +#define ECAP_NB_CEVT			(ECAP_NB_CAP + 1)
>> +#define ECAP_CEVT_EN_MASK		GENMASK(ECAP_NB_CEVT, 1)
>> +#define ECAP_CEVT_FLG_BIT(i)		BIT((i) + 17)
>> +#define ECAP_OVF_VAL			0xff
>> +
>> +#define ECAP_ECINT_CLR_FRC_REG	0x30
>> +#define ECAP_INT_CLR_BIT		BIT(0)
>> +#define ECAP_CEVT_CLR_BIT(i)		BIT((i) + 1)
>> +#define ECAP_CEVT_CLR_MASK		GENMASK(ECAP_NB_CEVT, 0)
>> +
>> +#define ECAP_PID_REG			0x5c
>> +
>> +/*
>> + * Event modes
>> + * One bit for each CAPx register : 1 = falling edge / 0 = rising edge
>> + * e.g. mode = 13 = 0xd = 0b1101
>> + * -> falling edge for CAP1-3-4 / rising edge for CAP2
>> + */
>> +#define ECAP_NB_EV_MODES		GENMASK(ECAP_NB_CAP - 1, 0)
>> +#define ECAP_EV_MODE_BIT(i)		BIT(i)
>> +
>> +static unsigned int prescaler = ECAP_PS_DEFAULT_VAL;
>> +module_param(prescaler, uint, 0644);
>> +MODULE_PARM_DESC(prescaler, "Input capture signal prescaler from 0 to "
>> +		 __MODULE_STRING(ECAP_PS_MAX_VAL)", default "
>> +		 __MODULE_STRING(ECAP_PS_DEFAULT_VAL));
> What is this?  Needs a lot more description...  Right now I'd suggest it probably
> either wants to be firmware provided (DT) or userspace controlled via proper ABI.

OK

>
>> +
>> +static const struct regmap_config ecap_iio_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +	.max_register = ECAP_PID_REG,
>> +};
>> +
>> +/*
>> + * struct ecap_iio_context - IIO device context
>> + * @ev_mode:   event mode describing falling/rising edges for captures 1 to 4
>> + * @time_cntr: timestamp counter value
>> + */
>> +struct ecap_iio_context {
>> +	u8 ev_mode;
>> +	unsigned int time_cntr;
>> +};
> I don't see advantage in defining this outside of ecap_iio_dev.
> If the grouping is particular useful, feel free to embed the structure in there
> and give it a name.

OK

>
>> +
>> +/*
> when in kernel-doc format use /**

OK

>
>> + * struct ecap_iio_data - IIO device data
>> + * @ev_idx:  event index (0 to 3 for CAP1 to CAP4)
> That's a long way from standard ABI.

OK, I will consider alternatives.

>
>> + * @ev_time: falling/rising edge timestamp
>> + */
>> +struct ecap_iio_data {
>> +	u8 ev_idx;
>> +	s64 ev_time __aligned(sizeof(s64));
>> +};
>> +
>> +/*
>> + * struct ecap_iio_dev - IIO device private data structure
>> + * @enabled:  device state
>> + * @clk:      device clock
>> + * @clk_rate: device clock rate
>> + * @regmap:   device register map
>> + * @pm_ctx:   device context for PM operations
>> + * @data:     device data
>> + */
>> +struct ecap_iio_dev {
>> +	bool enabled;
>> +	struct clk *clk;
>> +	unsigned long clk_rate;
>> +	struct regmap *regmap;
>> +	struct ecap_iio_context pm_ctx;
>> +	struct ecap_iio_data data;
>> +};
>> +
>> +static u8 ecap_iio_capture_get_evmode(struct iio_dev *indio_dev)
>> +{
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +	u8 ev_mode = 0;
>> +	unsigned int regval;
>> +	int i;
>> +
>> +	pm_runtime_get_sync(indio_dev->dev.parent);
>> +	regmap_read(ecap_dev->regmap, ECAP_ECCTL_REG, &regval);
>> +	pm_runtime_put_sync(indio_dev->dev.parent);
>> +
>> +	for (i = 0 ; i < ECAP_NB_CAP ; i++) {
>> +		if (regval & ECAP_CAPPOL_BIT(i))
>> +			ev_mode |= ECAP_EV_MODE_BIT(i);
>> +	}
>> +
>> +	return ev_mode;
>> +}
>> +
>> +static void ecap_iio_capture_set_evmode(struct iio_dev *indio_dev, u8 ev_mode)
>> +{
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +	unsigned int regval = 0;
>> +	int i;
>> +
>> +	for (i = 0 ; i < ECAP_NB_CAP ; i++) {
>> +		if (ev_mode & ECAP_EV_MODE_BIT(i))
>> +			regval |= ECAP_CAPPOL_BIT(i);
>> +	}
>> +
>> +	pm_runtime_get_sync(indio_dev->dev.parent);
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_EV_MODE_MASK, regval);
>> +	pm_runtime_put_sync(indio_dev->dev.parent);
>> +}
>> +
>> +static void ecap_iio_capture_enable(struct iio_dev *indio_dev, bool rearm)
>> +{
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +	unsigned int regval = 0;
>> +
>> +	pm_runtime_get_sync(indio_dev->dev.parent);
>> +
>> +	/* Enable interrupts on events */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG,
>> +			   ECAP_CEVT_EN_MASK, ECAP_CEVT_EN_MASK);
>> +
>> +	/* Run counter */
>> +	regval |= FIELD_PREP(ECAP_EVTFLTPS_MASK, prescaler)
>> +		| ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MASK;
> Should simply be
> regval = ...
> and don't set to 0 above.

OK

>
>> +	if (rearm) {
>> +		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, 0);
>> +		regval |= ECAP_REARM_RESET_BIT;
>> +	}
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_CFG_MASK, regval);
>> +}
>> +
>> +static void ecap_iio_capture_disable(struct iio_dev *indio_dev)
>> +{
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +
>> +	/* Disable interrupts on events */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, ECAP_CEVT_EN_MASK, 0);
>> +
>> +	/* Stop counter */
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_EN_MASK, 0);
>> +
>> +	pm_runtime_put_sync(indio_dev->dev.parent);
>> +}
>> +
>> +static int ecap_iio_read_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int *val, int *val2, long info)
>> +{
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +
>> +	switch (info) {
>> +	case IIO_CHAN_INFO_ENABLE:
>> +		*val = ecap_dev->enabled;
>> +		return IIO_VAL_INT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int ecap_iio_write_raw(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec const *chan,
>> +			      int val, int val2, long info)
>> +{
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +
>> +	switch (info) {
>> +	case IIO_CHAN_INFO_ENABLE:
>> +		if (val < 0 || val > 1)
>> +			return -EINVAL;
>> +		if (val == ecap_dev->enabled)
>> +			return 0;
>> +		if (val)
>> +			ecap_iio_capture_enable(indio_dev, true);
>> +		else
>> +			ecap_iio_capture_disable(indio_dev);
>> +		ecap_dev->enabled = val;
> Blank line here.   Generally add one before any simple return
> statements as it makes the flow a little more readable.

OK

>
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int ecap_iio_read_event_value(struct iio_dev *indio_dev,
>> +				     const struct iio_chan_spec *chan,
>> +				     enum iio_event_type type,
>> +				     enum iio_event_direction dir,
>> +				     enum iio_event_info info,
>> +				     int *val, int *val2)
>> +{
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		switch (dir) {
>> +		case IIO_EV_DIR_FALLING:
>> +			*val = ecap_iio_capture_get_evmode(indio_dev);
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int ecap_iio_write_event_value(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir,
>> +				      enum iio_event_info info,
>> +				      int val, int val2)
>> +{
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		switch (dir) {
>> +		case IIO_EV_DIR_FALLING:
>> +			if (val < 0 || val > ECAP_NB_EV_MODES)
> So you are using a value as a magic enum to set mode?
>
> Don't do that without documentation (and probably not acceptable then).
> This is device specific ABI pretending to be generic.

OK, I will consider alternatives.

>
>> +				return -EINVAL;
>> +			if (ecap_dev->enabled)
>> +				return -EBUSY;
>> +			ecap_iio_capture_set_evmode(indio_dev, val);
>> +			return 0;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_info ecap_iio_info = {
>> +	.read_raw = ecap_iio_read_raw,
>> +	.write_raw = ecap_iio_write_raw,
>> +	.read_event_value = ecap_iio_read_event_value,
>> +	.write_event_value = ecap_iio_write_event_value,
>> +};
>> +
>> +static const struct iio_event_spec ecap_iio_events[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_CHANGE,
>> +		.dir = IIO_EV_DIR_FALLING,
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>> +	},
>> +};
>> +
>> +static const struct iio_chan_spec ecap_iio_channels[] = {
>> +	{
>> +		.scan_index = 0,
>> +		.type = IIO_INDEX,
>> +		.address = 0,
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_ENABLE),
>> +		.modified = 0,
> C will initialize anything not specificed to 0 anyway, so just add
> 0 entries if they aren't the natural default (i.e. enums etc).

OK

>
>> +		.event_spec = ecap_iio_events,
>> +		.num_event_specs = ARRAY_SIZE(ecap_iio_events),
>> +		.scan_type = {
>> +			.sign = 'u',
>> +			.endianness = IIO_LE,
>> +			.realbits = 2,
>> +			.storagebits = 8,
>> +			.shift = 0,
>> +		},
>> +	},
>> +	IIO_CHAN_SOFT_TIMESTAMP(1),
>> +};
>> +
>> +static irqreturn_t ecap_iio_isr(int irq, void *dev_id)
>> +{
>> +	struct iio_dev *indio_dev = dev_id;
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +	struct ecap_iio_data *ecap_data = &ecap_dev->data;
>> +	unsigned int clr = 0;
>> +	unsigned int flg;
>> +	unsigned int cap_time;
>> +	int i;
>> +
>> +	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
>> +
>> +	for (i = 0 ; i < ECAP_NB_CEVT ; i++) {
>> +		if (flg & ECAP_CEVT_FLG_BIT(i)) {
>> +			if (i < ECAP_NB_CAP) {
>> +				/*
>> +				 * Input signal edge detected
>> +				 * time_ns = 10^9 * time_cycles / clk_rate
>> +				 */
>> +				ecap_data->ev_idx = i;
>> +				regmap_read(ecap_dev->regmap, ECAP_CAP_REG(i), &cap_time);
>> +				ecap_data->ev_time = cap_time * NSEC_PER_SEC;
>> +				do_div(ecap_data->ev_time, ecap_dev->clk_rate);
> Is there any attempt to align that timestamp with the iio clock used for software timestamps?

No, this is not my goal. I just need to log hardware timestamp.
But I am not sure that I fully understand what you mean (?).

>> +			} else {
>> +				/* Counter overflow */
>> +				ecap_data->ev_idx = ECAP_OVF_VAL;
>> +				ecap_data->ev_time = 0;
> Don't push it if you've lost data.

This is not a lost data.
That was intentional (equivalent in counter subsystem would be 
COUNTER_EVENT_OVERFLOW).
For a long duration signal, user will be aware that counter overflow 
occurred (this can avoid misleading
consecutive timestamp interpretations).
Do you confirm that I should not push it ? Or maybe just explaining this 
overflow better ?

>
>> +			}
>> +			iio_push_to_buffers(indio_dev, ecap_data);
>> +
>> +			clr |= ECAP_CEVT_CLR_BIT(i);
>> +		}
>> +	}
>> +
>> +	clr |= ECAP_INT_CLR_BIT;
>> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_CLR_FRC_REG, ECAP_CEVT_CLR_MASK, clr);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void ecap_iio_clk_disable(void *clk)
>> +{
>> +	clk_disable_unprepare(clk);
>> +}
>> +
>> +static int ecap_iio_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct ecap_iio_dev *ecap_dev;
>> +	struct iio_dev *indio_dev;
>> +	void __iomem *mmio_base;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*ecap_dev));
>> +	if (IS_ERR(indio_dev))
>> +		return PTR_ERR(indio_dev);
>> +
>> +	ecap_dev = iio_priv(indio_dev);
>> +
>> +	ecap_dev->clk = devm_clk_get(dev, "fck");
>> +	if (IS_ERR(ecap_dev->clk)) {
>> +		dev_err(dev, "failed to get clock\n");
>> +		return PTR_ERR(ecap_dev->clk);
> Preference in probe() for using dev_err_probe() throughout.
> It will handle any deferred probes that show up + does nicer message printing.

OK

>
>> +	}
>> +
>> +	ret = clk_prepare_enable(ecap_dev->clk);
> There is a continuing effort to add devm support for clock management.
> Not sure if it will land this cycle, but if it does please update to use
> that.
> https://lore.kernel.org/all/20220520075737.758761-1-u.kleine-koenig@pengutronix.de/

OK, I've seen the discussion about it.

>
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable clock\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, ecap_iio_clk_disable, ecap_dev->clk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to add clock disable action\n");
>> +		return ret;
>> +	}
>> +
>> +	ecap_dev->clk_rate = clk_get_rate(ecap_dev->clk);
>> +	if (!ecap_dev->clk_rate) {
>> +		dev_err(dev, "failed to get clock rate\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (prescaler > ECAP_PS_MAX_VAL) {
>> +		prescaler = ECAP_PS_MAX_VAL;
>> +		dev_warn(dev, "prescaler out of range, forced to %d\n", prescaler);
>> +	}
>> +
>> +	mmio_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(mmio_base))
>> +		return PTR_ERR(mmio_base);
>> +
>> +	ecap_dev->regmap = regmap_init_mmio(dev, mmio_base, &ecap_iio_regmap_config);
> Mixing devm and non devm just makes for possible race conditions.
> devm_regmap_init_mmio() should be fine here. If it's not I'd expect to see clear
> comments saying why not.

OK

>
>> +	if (IS_ERR(ecap_dev->regmap)) {
>> +		dev_err(dev, "failed to init regmap\n");
>> +		return PTR_ERR(ecap_dev->regmap);
>> +	}
>> +
>> +	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL,
>> +					 "ecap-iio-%p", mmio_base);
> The name is a part number only, not instances specific.  The instance can usually
> be easily established from other available info.  If you need to provide more information
> there is a label attribute in the ABI (normally used for things like 'where' the sensor
> is, but could be used for this as well).

OK

>
>> +	indio_dev->info = &ecap_iio_info;
>> +	indio_dev->channels = ecap_iio_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(ecap_iio_channels);
>> +	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
>> +
>> +	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, NULL, NULL);
> Might as well use the non _ext() variant that is just a wrapper around this
> with one fewer parameter.

OK

>
>> +	if (ret) {
>> +		dev_err(dev, "failed to setup iio buffer\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = platform_get_irq(pdev, 0);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get irq\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_request_irq(dev, ret, ecap_iio_isr, 0, pdev->name, indio_dev);
>> +	if (ret) {
>> +		dev_err(dev, "failed to request irq\n");
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, indio_dev);
>> +	pm_runtime_enable(&pdev->dev);
>> +
>> +	ecap_dev->enabled = 0;
> Will be set by default anyway as iio_priv() is kzalloc'd but
> fine to leave it here if you think it adds documentation.

OK

>
>> +	ecap_iio_capture_set_evmode(indio_dev, 0);
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +static int ecap_iio_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +
>> +	if (ecap_dev->enabled)
>> +		ecap_iio_capture_disable(indio_dev);
>> +
>> +	regmap_exit(ecap_dev->regmap);
>> +
>> +	pm_runtime_disable(&pdev->dev);
> Order in remove should be reverse of probe() unless there is really
> good reason why not.  Otherwise there tend to be race conditions
> hiding.

OK

>
>> +
>> +	return 0;
>> +}
>> +
>> +static __maybe_unused int ecap_iio_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +
>> +	/* If eCAP is running, stop capture then save timestamp counter */
>> +	if (ecap_dev->enabled) {
>> +		ecap_iio_capture_disable(indio_dev);
>> +
>> +		pm_runtime_get_sync(indio_dev->dev.parent);
>> +		regmap_read(ecap_dev->regmap, ECAP_TSCNT_REG, &ecap_dev->pm_ctx.time_cntr);
>> +		pm_runtime_put_sync(indio_dev->dev.parent);
>> +	}
>> +
>> +	ecap_dev->pm_ctx.ev_mode = ecap_iio_capture_get_evmode(indio_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static __maybe_unused int ecap_iio_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
>> +
>> +	ecap_iio_capture_set_evmode(indio_dev, ecap_dev->pm_ctx.ev_mode);
>> +
>> +	/* If eCAP was running, restore timestamp counter then run capture */
>> +	if (ecap_dev->enabled) {
>> +		pm_runtime_get_sync(indio_dev->dev.parent);
>> +		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, ecap_dev->pm_ctx.time_cntr);
>> +		pm_runtime_put_sync(indio_dev->dev.parent);
>> +
>> +		ecap_iio_capture_enable(indio_dev, false);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(ecap_iio_pm_ops, ecap_iio_suspend, ecap_iio_resume);
> DEFINE_SIMPLE_DEV_PM_OPS() as per docs in pm.h which mark this version as deprecated.

OK

>
>> +
>> +static const struct of_device_id ecap_iio_of_match[] = {
>> +	{ .compatible	= "ti,am62-ecap-capture" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, ecap_iio_of_match);
>> +
>> +static struct platform_driver ecap_iio_driver = {
>> +	.probe = ecap_iio_probe,
>> +	.remove = ecap_iio_remove,
>> +	.driver = {
>> +		.name = "ecap-capture",
>> +		.of_match_table = of_match_ptr(ecap_iio_of_match),
> Drop the of_match_ptr() protection.  It provides no real advantages and breaks
> some non dt firmwares.

OK

>
>> +		.pm = &ecap_iio_pm_ops,
> pm_sleep_ptr() and remove the __maybe_unused markings above as this new set
> of pm macros lets the compiler remove the code without the need for that trickery.

OK

>   
>> +	},
>> +};
>> +module_platform_driver(ecap_iio_driver);
>> +
>> +MODULE_DESCRIPTION("ECAP Capture driver");
>> +MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
>> +MODULE_LICENSE("GPL");

