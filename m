Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ADB516C98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383940AbiEBI5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245657AbiEBI5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:57:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D2857B3B;
        Mon,  2 May 2022 01:53:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bv19so26529488ejb.6;
        Mon, 02 May 2022 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=97NknAfhIJTVGUDicYBaJlgJVnr/AnQ81iBK/dMpzfc=;
        b=FPnHZiGNt3cbPCI/MMxZJW1zlcr69H0lNW6GtEpqtL/eyjGPc3PWzoyx9PaBgwTqc3
         wfelJisnFiEFaIesBAvxu62DnsIJb+ut6yM6N6FjdnKzJxZU261zsQ4X9wdX0156YUIR
         6RHji6B6r7rfDDsw3kaw9cLyHPmQaGmFhmrUCBL+5PklDDV6quE1tDkrJXC4aucN40uu
         0hyQEJbflYL93g5ISQ5/49W0z2HbBpqdq5f4RId2dwyQGeA3IjuSbKRzOPbgxkTfzwTY
         fW593MlizFggPkfN8tq9zGgOdU4AuqnrRioytnzqZterd/wGyH6WXIKsbgzq8t8qFp5q
         2GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=97NknAfhIJTVGUDicYBaJlgJVnr/AnQ81iBK/dMpzfc=;
        b=GD++AfU7PPmXXRN7KrlRTfSljtCOD5WGFqvjwfFD8tiwIDq55YsZXClynyjK52YaxE
         7iLHu7lyzM2vjKdj2pmLSeFKu2V2yo+JoAUp3hu8dVCndwJQjoC5t6yb4COpg/z3MztN
         oTk46k6H7PzUYnNS4ANLAiQj2FOqggCITmj40cv/3q5PHRs/9RXgMotlm+w1/qr6652H
         Jhdz1wYFN+hlZw/RJx/OzqF7RxJBPY7LKSsYKFu5h+eRNrOKCR9pDz4+uTLxNzOebLcp
         DZpSZGJW+7MQP/dnBd/VlqtnjGCmnTC8Dq2lbJAaS0US4md2LzNoFn113QmQcrH5QY0K
         +oIg==
X-Gm-Message-State: AOAM530UcfqItWCCxb6A1qoYmjEphNYjxptvOojSul9izTfmFXCIeOJN
        04ekH8EoJSya7ABBqUdGJUo=
X-Google-Smtp-Source: ABdhPJxYxhST916Vy6y+iD7KQWzdM57Ja7XJ+LxZ0yoJtOw8KSCCgOsWmR4sJ7/lb9d72llwYsPpYg==
X-Received: by 2002:a17:907:1c25:b0:6f4:2d46:52ce with SMTP id nc37-20020a1709071c2500b006f42d4652cemr7234942ejc.25.1651481612499;
        Mon, 02 May 2022 01:53:32 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b006f3ef214e37sm3370248ejb.157.2022.05.02.01.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 01:53:32 -0700 (PDT)
Message-ID: <5d932a4a-790e-ca95-c5de-c2267e1f365c@gmail.com>
Date:   Mon, 2 May 2022 11:53:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] iio: adc: ad4130: add AD4130 driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
 <20220419150828.191933-3-cosmin.tanislav@analog.com>
 <20220501170807.1e728524@jic23-huawei>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20220501170807.1e728524@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/22 19:08, Jonathan Cameron wrote:
> On Tue, 19 Apr 2022 18:08:28 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
>> AD4130-8 is an ultra-low power, high precision, measurement solution for
>> low bandwidth battery operated applications.
>>
>> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
>> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
>> selectable filter options, smart sequencer, sensor biasing and excitation
>> options, diagnostics, and a FIFO buffer.
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Hi Cosmin,
> 
> Sorry this one took me a while to get back to.  Last week was a little
> crazy on the day job front.
> 
> Anyhow, whilst reading this I realised we have some unclear ABI documentation
> and hence divergence in interpretation of the units of hwfifo_watermark.
> See below. I've not done a thorough audit as don't have enough time today,
> but we have at least some drivers treating it as being in scans (+ the core
> does this for watermark) and some treating it as being in individual channel
> readings...  My intent IIRC was that it was in scans as otherwise you run into
> the problem you are working around with needing to tweak it to match scans
> within each driver.
> 
> A few other trivial things inline including the alignment issue I emailed
> the list about but haven't sent patches out for yet (about 90 driver are
> affected... *sigh*).
> 
> Thanks,
> 
> Jonathan
>  >
>> ---
> 
> ...
> 
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 39d806f6d457..c3aa7e4eca2f 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -6,6 +6,7 @@
>>   # When adding new entries keep the list in alphabetical order
>>   obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>>   obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>> +obj-$(CONFIG_AD4130) += ad4130.o
>>   obj-$(CONFIG_AD7091R5) += ad7091r5.o ad7091r-base.o
>>   obj-$(CONFIG_AD7124) += ad7124.o
>>   obj-$(CONFIG_AD7192) += ad7192.o
>> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
>> new file mode 100644
>> index 000000000000..dd2f18734cba
>> --- /dev/null
>> +++ b/drivers/iio/adc/ad4130.c
> 
> ...
> 
>> +struct ad4130_state {
>> +	const struct ad4130_chip_info	*chip_info;
>> +	struct spi_device		*spi;
>> +	struct regmap			*regmap;
>> +	struct clk			*mclk;
>> +	struct regulator_bulk_data	regulators[4];
>> +	u32				irq_trigger;
>> +	u32				inv_irq_trigger;
>> +
>> +	/*
>> +	 * Synchronize access to members of driver state, and ensure atomicity
>> +	 * of consecutive regmap operations.
>> +	 */
>> +	struct mutex			lock;
>> +	struct completion		completion;
>> +
>> +	struct iio_chan_spec		chans[AD4130_MAX_CHANNELS];
>> +	struct ad4130_chan_info		chans_info[AD4130_MAX_CHANNELS];
>> +	struct ad4130_slot_info		slots_info[AD4130_MAX_SETUPS];
>> +	enum ad4130_pin_function	pins_fn[AD4130_MAX_ANALOG_PINS];
>> +	u32				vbias_pins[AD4130_MAX_ANALOG_PINS];
>> +	u32				num_vbias_pins;
>> +	int				scale_tbls[AD4130_REF_SEL_MAX][AD4130_PGA_NUM][2];
>> +	struct gpio_chip		gc;
>> +	unsigned int			gpio_offsets[AD4130_MAX_GPIOS];
>> +	unsigned int			num_gpios;
>> +
>> +	u32			int_pin_sel;
>> +	u32			int_ref_uv;
>> +	u32			mclk_sel;
>> +	bool			int_ref_en;
>> +	bool			bipolar;
>> +
>> +	unsigned int		num_enabled_channels;
>> +	unsigned int		effective_watermark;
>> +	unsigned int		watermark;
>> +
>> +	struct spi_message	fifo_msg;
>> +	struct spi_transfer	fifo_xfer[2];
>> +
>> +	/*
>> +	 * DMA (thus cache coherency maintenance) requires the
>> +	 * transfer buffers to live in their own cache lines.
>> +	 */
>> +	u8			reset_buf[AD4130_RESET_BUF_SIZE] ____cacheline_aligned;
> 
> This needs a fix along with the other set that I'll hopefully get this weekend.
> In meantime if you change this to __aligned(IIO_ALIGN); then the fix I have
> coming shortly will change that define to be large enough for the odd ARM systems
> with 128 byte requirement for DMA and 64 byte L1 cache alignment (which is what
> ___cacheline_aligned guarantees.
> 

Sure thing.

> 
>> +	u8			reg_write_tx_buf[4];
>> +	u8			reg_read_tx_buf[1];
>> +	u8			reg_read_rx_buf[3];
>> +	u8			fifo_tx_buf[2];
>> +	u8			fifo_rx_buf[AD4130_FIFO_SIZE *
>> +					    AD4130_FIFO_MAX_SAMPLE_SIZE];
>> +};
>> +
> 
>> +static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned int val)
>> +{
>> +	struct ad4130_state *st = iio_priv(indio_dev);
>> +	unsigned int eff;
>> +	int ret;
>> +
>> +	if (val > AD4130_FIFO_SIZE)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Always set watermark to a multiple of the number of enabled channels
>> +	 * to avoid making the FIFO unaligned.
>> +	 */
>> +	eff = rounddown(val, st->num_enabled_channels);
>> +
>> +	mutex_lock(&st->lock);
>> +
>> +	ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
>> +				 AD4130_WATERMARK_MASK,
>> +				 FIELD_PREP(AD4130_WATERMARK_MASK,
>> +					    ad4130_watermark_reg_val(eff)));
>> +	if (ret)
>> +		goto out;
>> +
>> +	st->effective_watermark = eff;
>> +	st->watermark = val;
> 
> Hmm this is a potential inconsistency in the IIO ABI.
> ABI docs describes watermark as being number of 'scan elements' which is
> not the clearest text we could have gone with...
> 
> Now I may well have made a mistake in the following as it's rather a long time
> since I last looked at the core handling for this...
> 
> The core treats it as number datum (which is same as a scan) when using
> it for the main watermark attribute and also when using watermarks with the
> kfifo (the IIO fifo is made up of objects each of which is a scan. So kfifo_len()
> returns the number of scans.
>   
> Looking very quickly at a few other drivers
> adxl367 seems to use number of samples.
> adxl372 is using number of scans.
> bmc150 hardware seems to work on basis of frame count which I 'think' is probably scans.
> fxls8962 uses 'samples count' which is not clearly defined in the datasheet but there
> is an example showing that it's scans (I think)...
> lsm6dsx - some of the fifos used with this are based on tagged data so the connection to
> what hits the front end buffers is non obvious.
> 
> So, not great for consistency :(
> 
> Going forwards i think we should standardize the hardware fifo watermark on what is being
> used for the software watermark which I believe is number of scans.
> Not necessary much we can do about old drivers though due to risk of breaking ABI...
> We should make the documentation clearer though.
> 

I was confused too, but this seemed more logical to me at the time, and
since you didn't say anything regarding it on ADXL367, I did it the same
way here. I guess we can't go back and change it now on ADXL367, I'm
sorry for this. I'll fix it.

>> +
>> +out:
>> +	mutex_unlock(&st->lock);
>> +
>> +	return ret;
>> +}
>> +
> 
> 
> ...
> 
>> +
>> +static int ad4130_parse_fw_channel(struct iio_dev *indio_dev,
>> +				   struct fwnode_handle *child)
>> +{
>> +	struct ad4130_state *st = iio_priv(indio_dev);
>> +	unsigned int index = indio_dev->num_channels++;
>> +	struct device *dev = &st->spi->dev;
>> +	struct ad4130_chan_info *chan_info;
>> +	struct iio_chan_spec *chan;
>> +	u32 pins[2];
>> +	int ret;
>> +
>> +	if (index >= AD4130_MAX_CHANNELS)
>> +		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
>> +
>> +	chan = &st->chans[index];
>> +	chan_info = &st->chans_info[index];
>> +
>> +	*chan = ad4130_channel_template;
>> +	chan->scan_type.realbits = st->chip_info->resolution;
>> +	chan->scan_type.storagebits = st->chip_info->resolution;
>> +	chan->scan_index = index;
>> +
>> +	chan_info->slot = AD4130_INVALID_SLOT;
>> +	chan_info->setup.fs = AD4130_FS_MIN;
>> +	chan_info->initialized = true;
>> +
>> +	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
>> +					     ARRAY_SIZE(pins));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ad4130_validate_diff_channels(st, pins, ARRAY_SIZE(pins));
>> +	if (ret)
>> +		return ret;
>> +
>> +	chan->channel = pins[0];
>> +	chan->channel2 = pins[1];
>> +
>> +	ret = ad4130_parse_fw_setup(st, child, &chan_info->setup);
>> +	if (ret)
>> +		return ret;
>> +
>> +	fwnode_property_read_u32(child, "adi,excitation-pin-0",
>> +				 &chan_info->iout0);
>> +	if (chan_info->setup.iout0_val != AD4130_IOUT_OFF) {
> 
> It would be slightly better to set an explicit default value here as the fact it
> is 0 is hidden by the enum. e.g.
> 	chan_info->iout0 = AD4130_IOUT_OFF;
> 	fwnode_property_read_u32(child, "adi,excitation-pin-0",
> 			 	 &chan_info->iout0);
> 	if (chan_info->....
> That would save reviewers wondering what the default is and having to go
> check the enum (and I'm lazy :)

I understand the idea, but the default value for iout0 is not
AD4130_IOUT_OFF. iout0 is the pin that iout0_val current is
applied to, and AD4130_IOUT_OFF is a value for iout0_val.
Look at ad4130_parse_fw_setup.

For iout0, I guess I could do
#define AD4130_AIN0	0x0
...
chan_info->iout0 = AD4130_AIN0;

>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int ad4310_parse_fw(struct iio_dev *indio_dev)
>> +{
>> +	struct ad4130_state *st = iio_priv(indio_dev);
>> +	struct device *dev = &st->spi->dev;
>> +	u32 ext_clk_freq = AD4130_MCLK_FREQ_76_8KHZ;
>> +	bool int_clk_out = false;
>> +	unsigned int i;
>> +	int avdd_uv;
>> +	int irq;
>> +	int ret;
>> +
> 
> ...
> 
>> +
>> +	device_property_read_u32(dev, "adi,ext-clk-freq", &ext_clk_freq);
> 
> I'll note this in reviewing the binding, but the naming should incorporate the
> units.
> 
>> +	if (ext_clk_freq != AD4130_MCLK_FREQ_153_6KHZ &&
>> +	    ext_clk_freq != AD4130_MCLK_FREQ_76_8KHZ)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Invalid external clock frequency %u\n",
>> +				     ext_clk_freq);
>> +
> 
> ...
> 
>> +
>> +	return 0;
>> +}
>> +
> 
>> +
>> +static int ad4130_setup(struct iio_dev *indio_dev)
>> +{
>> +	struct ad4130_state *st = iio_priv(indio_dev);
>> +	struct device *dev = &st->spi->dev;
>> +	unsigned int int_ref_val;
>> +	unsigned long rate = AD4130_MCLK_FREQ_76_8KHZ;
>> +	unsigned int val;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	if (st->mclk_sel == AD4130_MCLK_153_6KHZ_EXT)
>> +		rate = AD4130_MCLK_FREQ_153_6KHZ;
>> +
>> +	ret = clk_set_rate(st->mclk, rate);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = clk_prepare_enable(st->mclk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_add_action_or_reset(dev, ad4130_clk_disable_unprepare,
>> +				       st->mclk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (st->int_ref_uv == AD4130_INT_REF_2_5V)
>> +		int_ref_val = AD4130_INT_REF_VAL_2_5V;
>> +	else
>> +		int_ref_val = AD4130_INT_REF_VAL_1_25V;
>> +
>> +	/* Switch to SPI 4-wire mode. */
>> +	val = AD4130_CSB_EN_MASK;
> 
> Trivial but I'd prefer to see this treated as a field as well for consistency.
> 	val = FIELD_PREP(AD4130_CSB_EN_MASK, 1);

Already did, but I waited for your input before pushing the new
patchset.

> >> +	val |= FIELD_PREP(AD4130_BIPOLAR_MASK, st->bipolar);
>> +	val |= FIELD_PREP(AD4130_INT_REF_EN_MASK, st->int_ref_en);
>> +	val |= FIELD_PREP(AD4130_MODE_MASK, AD4130_MODE_IDLE);
>> +	val |= FIELD_PREP(AD4130_MCLK_SEL_MASK, st->mclk_sel);
>> +	val |= FIELD_PREP(AD4130_INT_REF_VAL_MASK, int_ref_val);
>> +
>> +	ret = regmap_write(st->regmap, AD4130_REG_ADC_CONTROL, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = FIELD_PREP(AD4130_INT_PIN_SEL_MASK, st->int_pin_sel);
>> +	for (i = 0; i < st->num_gpios; i++)
>> +		val |= BIT(st->gpio_offsets[i]);
>> +
>> +	ret = regmap_write(st->regmap, AD4130_REG_IO_CONTROL, val);
>> +	if (ret)
>> +		return ret;
>> +
> 
