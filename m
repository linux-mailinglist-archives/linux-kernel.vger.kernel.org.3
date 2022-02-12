Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E6A4B3374
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 07:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiBLG0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 01:26:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiBLG0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 01:26:17 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FEF27173;
        Fri, 11 Feb 2022 22:26:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id on2so9888094pjb.4;
        Fri, 11 Feb 2022 22:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=759he6F71+XYkYTylUJLsUNV+xnBn08xUZNDuZ3Hkj0=;
        b=JDhom/6jw6YRQfC4i0Qg9rFxxri8KjXE/6FnMoVdrQpdGoM1+IiTP/sQCDsivVXfDx
         5cwcgoOCVBrATbJQyj0mMITsPhLvrB2X7K5saJi+a0g7ANrdW2NA5qOQIAnvtrMBR2o3
         7a2BGTCidVSAvND0xf03ZcoK+qVcCZtQCbwsXjfRvvU1w4+maBNPt50Pcy6ih1b67ZlS
         BPMOC470SijeKuy4jEmUNfDKD0lnufmZVcFAInmQSjNAk5pk1EdYT8jfI+DIWdYJAXoh
         Wdaoj9VGgzF+y+1djFXEg9u50aMBk/nLXv0ADSvU8pnGkHTz3KN5fimp0lhLn6+iWr4/
         Jfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=759he6F71+XYkYTylUJLsUNV+xnBn08xUZNDuZ3Hkj0=;
        b=c8cjFmhROjm/VkNlb3pKY93ZsADRnPip9gUcoZqce48auKV+PP7Ulj5DUacjhBSlRU
         YrVhraRdXlK8YH/NQq4bHjg9HvJhzIqHRdREBKizYdNEIAHLWtx6wSLRMRNQf9dc46sm
         VP/+yGhZ3ffgyydMPWrRIj4DFl2f/wG4tNgtcsJ4PLC5i/ZG9g9uYudP4ruYHwPAIu8e
         uYj9ViA7uENjwyTSZQTBAolsLk5DUoNRfTWW6fLaw6WY/T2R0cmfp65hs57XZiXhhfDB
         Q0T+DAq3otiWqXrRKPhuo1jz89Xj/kF7WOhw+s0XZiDjsff0l8Z3Ma44ErqrkH7KLgZP
         SQCw==
X-Gm-Message-State: AOAM531pMls0pG54ePAVddGiQjC+rQ84lCRHZ99Mqp9+iaJS9t1RvM5K
        3KLJ7psDGuZIzbDEv5HD8iU=
X-Google-Smtp-Source: ABdhPJzTiKjyl8fpL/KGMx02tKWgmpJDYU9+edmDUKi5BTVAZt+8GHKrHcYhTqvLBFk9FDWNWjxDsg==
X-Received: by 2002:a17:902:d882:: with SMTP id b2mr4770999plz.162.1644647173427;
        Fri, 11 Feb 2022 22:26:13 -0800 (PST)
Received: from jagath-PC ([27.7.31.226])
        by smtp.gmail.com with ESMTPSA id o9sm25585756pfw.86.2022.02.11.22.26.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Feb 2022 22:26:13 -0800 (PST)
Date:   Sat, 12 Feb 2022 11:56:08 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: potentiometer: Add support for Maxim DS3502
Message-ID: <20220212062606.GA4425@jagath-PC>
References: <20220207040408.4273-1-jagathjog1996@gmail.com>
 <20220207040408.4273-3-jagathjog1996@gmail.com>
 <20220210175423.00005364@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220210175423.00005364@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 05:54:23PM +0000, Jonathan Cameron wrote:
> On Mon,  7 Feb 2022 09:34:08 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
> 
> > The DS3502 is a 7-bit, nonvolatile digital potentiometer featuring
> > an output voltage range of up to 15.5V.
> > DS3502 support is implemented into existing ds1803 driver
> > 
> > Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
> > 
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> Hi Jagath,
> 
> Comments inline.  Looks pretty clean in the end so this is definitely
> the better option than introducing another driver.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/potentiometer/Kconfig  |   4 +-
> >  drivers/iio/potentiometer/ds1803.c | 150 +++++++++++++++++++++++------
> >  2 files changed, 120 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> > index 832df8da2bc6..1741af33672c 100644
> > --- a/drivers/iio/potentiometer/Kconfig
> > +++ b/drivers/iio/potentiometer/Kconfig
> > @@ -27,10 +27,10 @@ config AD5272
> >  	  module will be called ad5272.
> >  
> >  config DS1803
> > -	tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
> > +	tristate "Maxim Integrated DS1803 and similar Digital Potentiometer driver"
> >  	depends on I2C
> >  	help
> > -	  Say yes here to build support for the Maxim Integrated DS1803
> > +	  Say yes here to build support for the Maxim Integrated DS1803 and DS3502
> >  	  digital potentiometer chip.
> >  
> >  	  To compile this driver as a module, choose M here: the
> > diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
> > index 20b45407eaac..5e403e3400f7 100644
> > --- a/drivers/iio/potentiometer/ds1803.c
> > +++ b/drivers/iio/potentiometer/ds1803.c
> > @@ -1,12 +1,15 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Maxim Integrated DS1803 digital potentiometer driver
> > + * Maxim Integrated DS1803 and DS3502 digital potentiometer driver
> 
> I'd stick to and similar wording here.  We want to be able
> to grep the part number and hit the Kconfig + drivers, but
> once is enough for either.  "and similar" avoids more churn
> than necessary when adding additional parts.

In v1 will add "and similar" instead of adding new part.

> 
> 
> >   * Copyright (c) 2016 Slawomir Stepien
> > + * Copyright (c) 2022 Jagath Jog J
> >   *
> >   * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1803.pdf
> > + * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
> >   *
> >   * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
> >   * ds1803	2	256		10, 50, 100		0101xxx
> > + * DS3502       1       128             10                      01010xx
> 
> Stick to lowercase for consistency.
> Also use tabs for spacing for consistency with existing table entry.

will fix this in v1

> 
> >   */
> >  
> >  #include <linux/err.h>
> > @@ -16,47 +19,88 @@
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> >  
> > -#define DS1803_MAX_POS		255
> > -#define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
> > +#define DS1803_WIPER_0		(0xA9)
> 
> Single constants don't need or benefit from being surrounding in
> brackets like this.

will fix this in v1

> 
> > +#define DS1803_WIPER_1		(0xAA)
> > +#define DS3502_WR_IVR		(0x00)
> > +#define DS3502_CR               (0x02)
> > +#define DS3502_MODE0		(0x00)
> > +#define DS3502_MODE1		(0x80)
> >  
> >  enum ds1803_type {
> >  	DS1803_010,
> >  	DS1803_050,
> >  	DS1803_100,
> > +	DS3502,
> >  };
> >  
> >  struct ds1803_cfg {
> > +	int wipers;
> > +	int avail[3];
> >  	int kohms;
> >  };
> >  
> >  static const struct ds1803_cfg ds1803_cfg[] = {
> > -	[DS1803_010] = { .kohms =  10, },
> > -	[DS1803_050] = { .kohms =  50, },
> > -	[DS1803_100] = { .kohms = 100, },
> > +	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10, },
> > +	[DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50, },
> > +	[DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100, },
> > +	[DS3502] =     { .wipers = 1, .avail = { 0, 1, 127 }, .kohms =  10, },
> > +};
> > +
> > +struct maxim_potentiometer {
> > +	const struct iio_chan_spec *channels;
> > +	u8 num_channels;
> >  };
> >  
> >  struct ds1803_data {
> >  	struct i2c_client *client;
> > +	enum ds1803_type chip_type;
> 
> Move this into the ds1803_cfg.
> 
> >  	const struct ds1803_cfg *cfg;
> > +	const struct maxim_potentiometer *chip;
> 
> Everything in here should go in ds1803_cfg as well.

Will add members of maxim_potentiometer in ds1803_cfg structure in v1

> 
> >  };
> >  
> > -#define DS1803_CHANNEL(ch) {					\
> > -	.type = IIO_RESISTANCE,					\
> > -	.indexed = 1,						\
> > -	.output = 1,						\
> > -	.channel = (ch),					\
> > -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > +#define DS1803_CHANNEL(ch, addr) {					\
> > +	.type = IIO_RESISTANCE,						\
> > +	.indexed = 1,							\
> > +	.output = 1,							\
> > +	.channel = (ch),						\
> > +	.address = (addr),						\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> > +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),	\
> 
> Adding available is new functionality for the old part.
> Good to have but ideally would be in a separate patch (probably before
> the main one)

I will first add available functionality for old part and send the
patch.

> 
> >  }
> >  
> >  static const struct iio_chan_spec ds1803_channels[] = {
> > -	DS1803_CHANNEL(0),
> > -	DS1803_CHANNEL(1),
> > +	DS1803_CHANNEL(0, DS1803_WIPER_0),
> > +	DS1803_CHANNEL(1, DS1803_WIPER_1),
> > +};
> > +
> > +static const struct iio_chan_spec ds3502_channels[] = {
> > +	{
> > +		.type = IIO_RESISTANCE,
> > +		.indexed = 1,
> > +		.output = 1,
> > +		.channel = 0,
> > +		.address = (DS3502_WR_IVR),
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_ENABLE),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),
> > +	},
> > +};
> > +
> > +static const struct maxim_potentiometer maxim_potentiometer_chips[] = {
> > +	[DS1803_100] = {
> > +				.channels = ds1803_channels,
> 
> Very deep indenting. Stick to
> 		This level and reduce the indent of the closing bracket by one
> tab.

Will avoid deep indenting.

> 
> I would add this information to the existing ds1803_cfg structure.
> you will have to duplicate a elements, but you will save on the
> complexity of having two chip type related structures.
> You will have to reorder the code to make that work cleanly.

I will try to add this information into ds1803_cfg structure in v1.

> 
> > +				.num_channels = ARRAY_SIZE(ds1803_channels),
> > +		},
> > +	[DS3502]     = {
> > +				.channels = ds3502_channels,
> > +				.num_channels = ARRAY_SIZE(ds3502_channels),
> > +		},
> >  };
> >  
> >  static int ds1803_read_raw(struct iio_dev *indio_dev,
> > -			    struct iio_chan_spec const *chan,
> > -			    int *val, int *val2, long mask)
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> If there are valid white space tidy ups, please do them in
> a separate patch as they just distract form the important stuff
> ehre.

Will send the checkpatch fixes separately.

> 
> >  {
> >  	struct ds1803_data *data = iio_priv(indio_dev);
> >  	int pot = chan->channel;
> > @@ -65,17 +109,28 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > -		ret = i2c_master_recv(data->client, result,
> > -				indio_dev->num_channels);
> > +		switch (data->chip_type) {
> > +		case DS1803_010:
> > +		case DS1803_050:
> > +		case DS1803_100:
> > +			ret = i2c_master_recv(data->client, result,
> > +					      indio_dev->num_channels);
> Whilst it doesn't cause problems, as a general rule, you shouldn't use
> the output of a function if it has returned an error code. You should
> do the
> 			if (ret < 0)
> 				return ret;
> which seems have have gotten lost below.
> > +			*val = result[pot];
> 
> return IIO_VAL_INT; here

Will fix this in v1.

> 
> > +			break;
> > +		case DS3502:
> > +			ret = i2c_smbus_read_byte_data(data->client, chan->address);
> 
> Preference for 80 char max lines when there is no strong reason to go over. Here
> wrapping after client, will not hurt readability significantly.
> 
> > +			*val = ret;
> > +			break;
> 
> return here.

Will fix this in v1.

> 
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> >  		if (ret < 0)
> >  			return ret;
> > -
> > -		*val = result[pot];
> >  		return IIO_VAL_INT;
> > -
> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val = 1000 * data->cfg->kohms;
> > -		*val2 = DS1803_MAX_POS;
> > +		*val2 = data->cfg->avail[2];
> 
> Probably worth a comment on why [2] is the right option here.

Will add comment in v1

> 
> >  		return IIO_VAL_FRACTIONAL;
> >  	}
> >  
> > @@ -83,38 +138,64 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
> >  }
> >  
> >  static int ds1803_write_raw(struct iio_dev *indio_dev,
> > -			     struct iio_chan_spec const *chan,
> > -			     int val, int val2, long mask)
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long mask)
> 
> Check for white space only changes like this before sending patches.
> They are easy to accidentally introduce but should not be in a patch
> doing significant changes like this one.

Will send the checkpatch fixes separately first.

> 
> >  {
> >  	struct ds1803_data *data = iio_priv(indio_dev);
> > -	int pot = chan->channel;
> > +	int max_pos = data->cfg->avail[2];
> > +	u8 addr = chan->address;
> >  
> >  	if (val2 != 0)
> >  		return -EINVAL;
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > -		if (val > DS1803_MAX_POS || val < 0)
> > +		if (val > max_pos || val < 0)
> 
> as max_pos is just used here I would not bother with the local
> variable.
> 
> > +			return -EINVAL;
> > +		break;
> > +	case IIO_CHAN_INFO_ENABLE:
> 
> This doesn't seem to map to enable as it is about whether the
> value is written to the initial value register or not.
> We may need to invent some new sysfs attributes to cover that
> though I'd be a bit surprised if we have no precedence in other
> DACs.

Sure I will not use enable in next v1.
Will wait for mode functionality in new part as it required new 
sysfs attribute

> 
> 
> > +		if (val == 1)
> > +			val = DS3502_MODE1;
> > +		else if (val != DS3502_MODE0)
> >  			return -EINVAL;
> > +		addr = DS3502_CR;
> 
> In cases like this it's better to assign addr in both
> case statements as one is no more of a 'default' than the
> other choice.

Will use addr in both case statements in v1.

> 
> >  		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> >  
> > -	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
> > +	return i2c_smbus_write_byte_data(data->client, addr, val);
> 
> > +}
> > +
> > +static int ds1803_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> > +			     const int **vals, int *type, int *length, long mask)
> > +{
> 
> As mentioned above. This is great, but not strictly about support for
> the new part, so it should be a different patch.

Will add available functionality for old part and send the patch

> 
> > +	struct ds1803_data *data = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		*vals = data->cfg->avail;
> > +		*length = ARRAY_SIZE(data->cfg->avail);
> > +		*type = IIO_VAL_INT;
> > +		return IIO_AVAIL_RANGE;
> > +	}
> > +	return -EINVAL;
> >  }
> >  
> >  static const struct iio_info ds1803_info = {
> >  	.read_raw = ds1803_read_raw,
> > +	.read_avail = ds1803_read_avail,
> >  	.write_raw = ds1803_write_raw,
> >  };
> >  
> >  static int ds1803_probe(struct i2c_client *client,
> > -			 const struct i2c_device_id *id)
> > +			const struct i2c_device_id *id)
> 
> Another white space change.  Fixing up the alignment is a good thing
> to do but needs to be in a separate patch.

Will send the checkpatch fixes separately.

> 
> >  {
> >  	struct device *dev = &client->dev;
> >  	struct ds1803_data *data;
> >  	struct iio_dev *indio_dev;
> > +	enum ds1803_type chip_type = (id->driver_data <= DS1803_100 ? DS1803_100 : DS3502);
> 
> Why this dance?  You have all the models covered by a switch statement anyway.

Will fix this in v1 as there will no need to maintain two 
chip type related structures

> 
> > +	const struct maxim_potentiometer *chip = &maxim_potentiometer_chips[chip_type];
> >  
> >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> >  	if (!indio_dev)
> > @@ -125,10 +206,12 @@ static int ds1803_probe(struct i2c_client *client,
> >  	data = iio_priv(indio_dev);
> >  	data->client = client;
> >  	data->cfg = &ds1803_cfg[id->driver_data];
> 
> Unrelated to this patch, but note that for DT based bindings this relies
> on the part after the comma precisely matching the entry in the 
> i2c_device_id table which is rather fragile. At somepoint we should tidy
> this up to first check if there is a firmware provided entry with data
> and only if there is not fall back to using id->driver_data if available.
> It never is on ACPI platforms for starters.

Since firmware provided entry with data is available in this driver
I will try to use device_get_match_data to retrive chip specific data.

> 
> > +	data->chip = chip;
> 
> Not used anywhere that I can see.

Will fix this in v1

> 
> > +	data->chip_type = chip_type;
> >  
> >  	indio_dev->info = &ds1803_info;
> > -	indio_dev->channels = ds1803_channels;
> > -	indio_dev->num_channels = ARRAY_SIZE(ds1803_channels);
> > +	indio_dev->channels = chip->channels;
> > +	indio_dev->num_channels = chip->num_channels;
> >  	indio_dev->name = client->name;
> >  
> >  	return devm_iio_device_register(dev, indio_dev);
> > @@ -138,6 +221,7 @@ static const struct of_device_id ds1803_dt_ids[] = {
> >  	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
> >  	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
> >  	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
> > +	{ .compatible = "maxim,ds3502",     .data = &ds1803_cfg[DS3502] },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
> > @@ -146,6 +230,7 @@ static const struct i2c_device_id ds1803_id[] = {
> >  	{ "ds1803-010", DS1803_010 },
> >  	{ "ds1803-050", DS1803_050 },
> >  	{ "ds1803-100", DS1803_100 },
> > +	{ "ds3502",	DS3502	   },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ds1803_id);
> > @@ -162,5 +247,6 @@ static struct i2c_driver ds1803_driver = {
> >  module_i2c_driver(ds1803_driver);
> >  
> >  MODULE_AUTHOR("Slawomir Stepien <sst@poczta.fm>");
> > -MODULE_DESCRIPTION("DS1803 digital potentiometer");
> > +MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
> > +MODULE_DESCRIPTION("DS1803 and DS3502 digital potentiometer");
> 
> I would use and similar here, or just don't bother changing the
> description. It's common for these to not cover all the devices
> supported.

Will fix this in v1.

> 
> >  MODULE_LICENSE("GPL v2");
> 

Thanks for feedback,
First will send checkpatch fixes and new available feature
in separate patch for old part then I will try to add new part in v1.


Regards,
Jagath
