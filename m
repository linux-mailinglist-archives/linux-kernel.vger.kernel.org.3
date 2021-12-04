Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632B2468743
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 20:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350880AbhLDTyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 14:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbhLDTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 14:54:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC29C061751;
        Sat,  4 Dec 2021 11:51:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so25789436edu.4;
        Sat, 04 Dec 2021 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jOIfU3Wjc0eitlWJwaCGwfxRt4PZBuAtxxcR8Dac9ec=;
        b=GlBqSDqcja/beVtvutNka+zhhy0R1uM1eZaeuR/0DK+YDNNQDV0P+m/JVRt9RSo2oO
         erk7wjocuhypHbd1tk0eX00jrd+lJcMIaUbxWc5Ke5rN0ynhlHuG6BMyhP2g6btuIEDU
         gPb8VuFU/5pN7XltwCpX9XUEbr+qv9aW3adU5NNM3yLpDZIt7ArYXYxfwmV8WwjafjPq
         +6kXmUriXkvh4VWeFzP9y+jdd0C+lmUXKNo4nY8YijzD5C/DLYYHuCT59wxD4w7D7aqs
         5o4fZ3mhHP/O5gVldx+FL11QuKd7ScWuYftDamjZfP6MYMyNNSjLzJcvYanHEbLT/htQ
         OMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jOIfU3Wjc0eitlWJwaCGwfxRt4PZBuAtxxcR8Dac9ec=;
        b=iJT5uJFkukcJY+RPflaHTs/4G2KGTivpbk8/4Kk3aqLKLAA+mwm8fHj5MqzcGBT3SX
         KzDtZCucWJg1JgCSnbYhn8b12AhS8HJwgdenVdfeROFVBTVavCsg0so+WA0RiiwD6423
         CbyS13D+qyesamOFCBQyWsnhCn221frXOIfLHThtpTwI27zDJgmri6ryXc1DU1uUBVmG
         EfuVnPgVxQOmYjvmB8lmz7F8qDZYuEBjnEofpv92AZJt6N3DreTl66adavl7JeG13mfc
         vJEKojHkizCBHRAIichwi/LOtz7rRNohVrtpTEfeYNGLvd8KXl/Brjvw8AKUlTBGAJH5
         09+A==
X-Gm-Message-State: AOAM531mfk3H3TwidRm+fBUjJIoTeiEpD2EYB6LjBMWtYIPQ0XBdwKkp
        ZzJaMwFrJA9A0SdA4t6smn8=
X-Google-Smtp-Source: ABdhPJw7Y9n83LJDosuInheOcs+qwty3xHXxLUeR7oFYwM3CFdbf7mrXYf1ZVGFQ81xGQFTYjMOYaw==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr38329877edj.87.1638647475885;
        Sat, 04 Dec 2021 11:51:15 -0800 (PST)
Received: from [192.168.0.182] ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id f7sm4429125edl.33.2021.12.04.11.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 11:51:15 -0800 (PST)
Message-ID: <b22d6d96-6b31-be24-f492-7bc3219cc8c3@gmail.com>
Date:   Sat, 4 Dec 2021 21:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v9 3/3] iio: addac: add AD74413R driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
References: <20211202232507.358113-1-cosmin.tanislav@analog.com>
 <20211202232507.358113-4-cosmin.tanislav@analog.com>
 <20211204174111.0c657ad1@jic23-huawei>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20211204174111.0c657ad1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/21 19:41, Jonathan Cameron wrote:
> On Fri,  3 Dec 2021 01:25:07 +0200
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
>> The AD74412R and AD74413R are quad-channel, software configurable,
>> input/output solutions for building and process control applications.
>>
>> They contain functionality for analog output, analog input, digital input,
>> resistance temperature detector, and thermocouple measurements integrated
>> into a single chip solution with an SPI interface.
>>
>> The devices feature a 16-bit ADC and four configurable 13-bit DACs to
>> provide four configurable input/output channels and a suite of diagnostic
>> functions.
>>
>> The AD74413R differentiates itself from the AD74412R by being
>> HART-compatible.
>>
>> When configured with channel 0 as voltage output, channel 1 as current
>> output, channel 2 as voltage input and channel 3 as current input, the
>> following structure is created under the corresponding IIO device.
>>
>> .
>> ├── in_current0_offset
>> ├── in_current0_raw
>> ├── in_current0_sampling_frequency
>> ├── in_current0_sampling_frequency_available
>> ├── in_current0_scale
>> ├── in_voltage1_offset
>> ├── in_voltage1_raw
>> ├── in_voltage1_sampling_frequency
>> ├── in_voltage1_sampling_frequency_available
>> ├── in_voltage1_scale
>> ├── in_voltage2_offset
>> ├── in_voltage2_raw
>> ├── in_voltage2_sampling_frequency
>> ├── in_voltage2_sampling_frequency_available
>> ├── in_voltage2_scale
>> ├── in_current3_offset
>> ├── in_current3_raw
>> ├── in_current3_sampling_frequency
>> ├── in_current3_sampling_frequency_available
>> ├── in_current3_scale
>> ├── out_voltage0_raw
>> ├── out_voltage0_scale
>> ├── out_current1_raw
>> ├── out_current1_scale
>> ├── name
>> ├── buffer
>> │   ├── data_available
>> │   ├── enable
>> │   ├── length
>> │   └── watermark
>> └── scan_elements
>>      ├── in_current0_en
>>      ├── in_current0_index
>>      ├── in_current0_type
>>      ├── in_voltage1_en
>>      ├── in_voltage1_index
>>      ├── in_voltage1_type
>>      ├── in_voltage2_en
>>      ├── in_voltage2_index
>>      ├── in_voltage2_type
>>      ├── in_current3_en
>>      ├── in_current3_index
>>      └── in_current3_type
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> You haven't picked up Linus' tag from v7.  I'm assuming that wasn't deliberate
> so please add it for v10. I think there is just enough stuff in here that it makes
> more sense for you to spin a new version than for me to fix it whilst applying...

Yes, it wasn't deliberate.


> All minor stuff so shouldn't take long hopefully + we still need a dt review
> which might take a while depending on how busy Rob is.
>
> thanks,
>
> Jonathan
>
>> ---
>> --- /dev/null
>> +++ b/drivers/iio/addac/ad74413r.c
>> @@ -0,0 +1,1476 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2021 Analog Devices, Inc.
>> + * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> + */
>> +
>
> ...
>
>> +struct ad74413r_state {
>> +	struct ad74413r_channel_config	channel_configs[AD74413R_CHANNEL_MAX];
>> +	unsigned int			gpo_gpio_offsets[AD74413R_CHANNEL_MAX];
>> +	unsigned int			comp_gpio_offsets[AD74413R_CHANNEL_MAX];
>> +	struct gpio_chip		gpo_gpiochip;
>> +	struct gpio_chip		comp_gpiochip;
>> +	struct completion		adc_data_completion;
>> +	unsigned int			num_gpo_gpios;
>> +	unsigned int			num_comparator_gpios;
>> +	u32				sense_resistor_ohms;
>> +
>> +	/*
>> +	 * Synchronize consecutive operations when doing a one-shot
>> +	 * conversion and when updating the ADC samples SPI message.
>> +	 */
>> +	struct mutex			lock;
>> +
>> +	const struct ad74413r_chip_info	*chip_info;
>> +	struct spi_device		*spi;
>> +	struct regulator		*refin_reg;
>> +	struct regmap			*regmap;
>> +	struct device			*dev;
>> +	struct iio_trigger		*trig;
>> +
>> +	size_t			adc_active_channels;
>> +	struct spi_message	adc_samples_msg;
>> +	struct spi_transfer	adc_samples_xfer[AD74413R_CHANNEL_MAX + 1];
>> +
>> +	/*
>> +	 * DMA (thus cache coherency maintenance) requires the
>> +	 * transfer buffers to live in their own cache lines.
>> +	 */
>> +	struct {
>> +		u8 rx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
>> +		s64 timestamp;
>> +	} adc_samples_buf ____cacheline_aligned;
>> +
>> +	u8	adc_samples_tx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX]
>> +			____cacheline_aligned;
> What was your thinking for needing to have both adc_samples_buf and adc_samples_tx_buf
> at force alignment?  I would have expected only adc_samples_buf would be necessary,
> unless there are paths in which you are writing into one whilst DMA is going on into
> the other..  If there is a reason add a comment.
>
Sorry, this is just something I missed when removing the other extra 
____cacheline_aligned.


>> +	u8	reg_tx_buf[AD74413R_FRAME_SIZE];
>> +	u8	reg_rx_buf[AD74413R_FRAME_SIZE];
>> +};
>> +
>> +
>> +static int ad74413r_probe(struct spi_device *spi)
>> +{
>> +	struct ad74413r_state *st;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	st = iio_priv(indio_dev);
>> +
>> +	st->spi = spi;
>> +	st->dev = &spi->dev;
>> +	st->chip_info = device_get_match_data(&spi->dev);
>> +	mutex_init(&st->lock);
>> +	init_completion(&st->adc_data_completion);
>> +
>> +	st->regmap = devm_regmap_init(st->dev, NULL, st,
>> +				      &ad74413r_regmap_config);
>> +	if (IS_ERR(st->regmap))
>> +		return PTR_ERR(st->regmap);
>> +
>> +	st->refin_reg = devm_regulator_get(st->dev, "refin");
>> +	if (IS_ERR(st->refin_reg))
>> +		return dev_err_probe(st->dev, PTR_ERR(st->refin_reg),
>> +				     "Failed to get refin regulator\n");
>> +
>> +	ret = regulator_enable(st->refin_reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_add_action_or_reset(st->dev, ad74413r_regulator_disable,
>> +				       st->refin_reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	st->sense_resistor_ohms = 100000000;
>> +	device_property_read_u32(st->dev, "shunt-resistor-micro-ohms",
>> +				 &st->sense_resistor_ohms);
>> +	st->sense_resistor_ohms /= 1000000;
>> +
>> +	st->trig = devm_iio_trigger_alloc(st->dev, "%s-dev%d",
>> +					  st->chip_info->name, iio_device_id(indio_dev));
>> +	if (!st->trig)
>> +		return -ENOMEM;
>> +
>> +	st->trig->ops = &ad74413r_trigger_ops;
>> +	iio_trigger_set_drvdata(st->trig, st);
>> +
>> +	ret = devm_iio_trigger_register(st->dev, st->trig);
>> +	if (ret)
>> +		return ret;
>> +
>> +	indio_dev->name = st->chip_info->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &ad74413r_info;
>> +	indio_dev->trig = iio_trigger_get(st->trig);
>> +
>> +	ret = ad74413r_reset(st);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ad74413r_parse_channel_configs(indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ad74413r_setup_channels(indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ad74413r_setup_gpios(st);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (st->num_gpo_gpios) {
>> +		st->gpo_gpiochip.owner = THIS_MODULE;
>> +		st->gpo_gpiochip.label = st->chip_info->name;
>> +		st->gpo_gpiochip.base = -1;
>> +		st->gpo_gpiochip.ngpio = st->num_gpo_gpios;
>> +		st->gpo_gpiochip.parent = st->dev;
>> +		st->gpo_gpiochip.can_sleep = true;
>> +		st->gpo_gpiochip.set = ad74413r_gpio_set;
>> +		st->gpo_gpiochip.set_multiple = ad74413r_gpio_set_multiple;
>> +		st->gpo_gpiochip.set_config = ad74413r_gpio_set_gpo_config;
>> +		st->gpo_gpiochip.get_direction =
>> +			ad74413r_gpio_get_gpo_direction;
>> +
>> +		ret = devm_gpiochip_add_data(st->dev, &st->gpo_gpiochip, st);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (st->num_comparator_gpios) {
>> +		st->comp_gpiochip.owner = THIS_MODULE;
>> +		st->comp_gpiochip.label = st->chip_info->name;
>> +		st->comp_gpiochip.base = -1;
>> +		st->comp_gpiochip.ngpio = st->num_comparator_gpios;
>> +		st->comp_gpiochip.parent = st->dev;
>> +		st->comp_gpiochip.can_sleep = true;
>> +		st->comp_gpiochip.get = ad74413r_gpio_get;
>> +		st->comp_gpiochip.get_multiple = ad74413r_gpio_get_multiple;
>> +		st->comp_gpiochip.set_config = ad74413r_gpio_set_comp_config;
>> +		st->comp_gpiochip.get_direction =
>> +			ad74413r_gpio_get_comp_direction;
>> +
>> +		ret = devm_gpiochip_add_data(st->dev, &st->comp_gpiochip, st);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = ad74413r_set_adc_conv_seq(st, AD74413R_CONV_SEQ_OFF);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_request_irq(st->dev, spi->irq, ad74413r_adc_data_interrupt,
>> +			       0, st->chip_info->name, indio_dev);
>> +	if (ret)
> Minor, but would be good to have a dev_err_probe() here as
> this is something that can result in a deferred response and it would
> be good to log the debugging info.

Sure thing, will change it for the next revision.


>> +		return ret;
>> +
>> +	ret = devm_iio_triggered_buffer_setup(st->dev, indio_dev,
>> +					      &iio_pollfunc_store_time,
>> +					      &ad74413r_trigger_handler,
>> +					      &ad74413r_buffer_ops);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(st->dev, indio_dev);
>> +}


(sorry for sending the mail again, I was using Gmail before but now I 
tried using Thunderbird so I can disable HTML formatting.


