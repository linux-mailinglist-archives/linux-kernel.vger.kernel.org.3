Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6BD4E3236
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 22:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiCUVOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 17:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiCUVON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:14:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A20249C4D;
        Mon, 21 Mar 2022 14:12:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g19so16541453pfc.9;
        Mon, 21 Mar 2022 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1iwp5l85v8loGCVgV3W8r/7bIeP1JnAKj67uJsPecXk=;
        b=Eomn0Jx5RUxC+YScVnk3ZoRStMrY2lBLbthcHauzI8h2o4BUm+AW0p/8QJGxj8H8r6
         NDr9VdOuu0KUa3rV8hzGHAz/M5W/vHS+sYOy6CqsqvP1z0kty0WTSuOpWY9cWlQMIzZW
         cF3Q+p3I3AVwwML2KnWiUJV8HXlKHPIBqfYGjlsLxbaTiHtPOmCdszhJoHb/PQ9vRfDI
         tQNfTxYaZcDtFoR32W1fYIULCfd3sNCfq4GYZqL/MS/k+jgnjA23BQNP6a3rPZ0wIqT+
         9+ljw7njaXSAzzp6eAnM814PHOPiBc6AG6Ad+ijquFrBY/8AH65bLqXIcm2tX0CWKdY9
         Hrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1iwp5l85v8loGCVgV3W8r/7bIeP1JnAKj67uJsPecXk=;
        b=HN15i9a3wLknAlF4+sFMmIvVxxpAeDsM0UYLsIw0OrAWORtSLEmPOyvYYKhIa11cY+
         BGcVMoXUSgrPRnClLaUyFX6nMGVC0z/2nFQNFaF2HxHAzekjFzKYtKxyNwGwzX7Doob8
         dbd8Kc2KR0Oqv4ZCqA5ipJ/16GTGuH02kybrpfUXvuXeASl1DnEXrBHhILP/R7eui2u8
         HS0nJp+pwelV4vqnDYETfMXu6W2IKjSNzcLoj3gcw8IRUL6BHeMXgWXCrPFykWGgWnOP
         C/7XyKcwNE2+dPntpUofJZBUrClW/E42JNiCLq0FrhYwVXSxNwRDjlSBI1f7bIml8TEp
         Prmw==
X-Gm-Message-State: AOAM531cuQpTZBZl/B41f7gelunH7p/d41Z5PaP5dF4yiDAu8wH7NtuR
        nCquvflCRt4hjTlE+ojsvwk=
X-Google-Smtp-Source: ABdhPJzWbVEduY71wUeDaKyxRoH0iYM4Njyu/u6RqfKYFjSAwMsModi746XVxVEvL2LgbTpKJl1ssQ==
X-Received: by 2002:a63:4919:0:b0:382:6f3d:e48 with SMTP id w25-20020a634919000000b003826f3d0e48mr7252770pga.613.1647897165090;
        Mon, 21 Mar 2022 14:12:45 -0700 (PDT)
Received: from jagath-PC ([115.99.184.169])
        by smtp.gmail.com with ESMTPSA id k14-20020a056a00134e00b004f83f05608esm21052510pfu.31.2022.03.21.14.12.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Mar 2022 14:12:44 -0700 (PDT)
Date:   Tue, 22 Mar 2022 02:42:41 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] iio: accel: bma400: conversion to device-managed
 function
Message-ID: <20220321211237.GA10058@jagath-PC>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
 <20220319181023.8090-2-jagathjog1996@gmail.com>
 <20220320171422.614a4f25@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220320171422.614a4f25@jic23-huawei>
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

On Sun, Mar 20, 2022 at 05:14:22PM +0000, Jonathan Cameron wrote:
> On Sat, 19 Mar 2022 23:40:19 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
> 
> > This is a conversion to device-managed by using devm_iio_device_register
> > inside probe function, now disabling the regulator and putting bma400 to
> > power down via a devm_add_action_or_reset() hook.
> > 
> > The dev_set_drvdata() call, bma400_remove() function and hooks in the I2C
> > and SPI driver struct is removed as devm_iio_device_register function is
> > used to automatically unregister on driver detach.
> > 
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> 
> Hi Jagath,
> 
> There is an oddity in the existing driver that has lead this in
> what I think is the wrong direction.  See below.
> 
> > ---
> >  drivers/iio/accel/bma400.h      |  2 --
> >  drivers/iio/accel/bma400_core.c | 39 ++++++++++++++-------------------
> >  drivers/iio/accel/bma400_i2c.c  |  8 -------
> >  drivers/iio/accel/bma400_spi.c  |  8 -------
> >  4 files changed, 17 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > index c4c8d74155c2..e938da5a57b4 100644
> > --- a/drivers/iio/accel/bma400.h
> > +++ b/drivers/iio/accel/bma400.h
> > @@ -94,6 +94,4 @@ extern const struct regmap_config bma400_regmap_config;
> >  
> >  int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
> >  
> > -void bma400_remove(struct device *dev);
> > -
> >  #endif
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index fd2647b728d3..dcc7549c7a0e 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -793,6 +793,19 @@ static const struct iio_info bma400_info = {
> >  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
> >  };
> >  
> > +static void bma400_disable(void *data_ptr)
> > +{
> > +	struct bma400_data *data = data_ptr;
> > +	int ret;
> > +
> > +	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
> > +	if (ret)
> > +		dev_warn(data->dev, "Failed to put device into sleep mode (%pe)\n",
> > +			 ERR_PTR(ret));
> > +
> > +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> 
> So this raised alarm bells.  You almost never want a devm callback to do two things.
> 
> The reason it 'looks' like this might be ok is that the driver is currently calling
> bma400_set_power_mode(data, POWER_MODE_SLEEP) in error paths during probe.
> I think it should be.  If you make that modification first you'll see that to
> keep a clean: "only undo things you have done" approach you'll then need
> to have a pair of devm_add_action_or_reset() callbacks so as to cover the
> disabling of the regulators when the power enabling fails and then to
> cover the change to sleep mode if anything else fails.

Sure I will add separate functions for regulators disable and power disable
then use them with help of two devm_add_action_or_reset() callbacks in bma400_init
function. Is below is correct?

static void bma400_regulators_disable(void *data_ptr)
{
        struct bma400_data *data = data_ptr;

        regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
}

static void bma400_power_disable(void *data_ptr)
{
        struct bma400_data *data = data_ptr;
        int ret;

        mutex_lock(&data->mutex);
        ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
        if (ret)
                dev_warn(data->dev, "Failed to put device into sleep mode (%pe)\n",
                         ERR_PTR(ret));
        mutex_unlock(&data->mutex);
}

static int bma400_init(struct bma400_data *data)
{
        unsigned int val;
        int ret;

......

       ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
                                    data->regulators);
        if (ret) {
                dev_err(data->dev, "Failed to enable regulators: %d\n",
                        ret);
                goto out;
        }

        ret = devm_add_action_or_reset(data->dev, bma400_regulators_disable, data);
        if (ret)
		return ret;

...

        if (data->power_mode != POWER_MODE_NORMAL) {
                ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
                if (ret) {
                        dev_err(data->dev, "Failed to wake up the device\n");
                        goto err_reg_disable;
                }
                /*
                 * TODO: The datasheet waits 1500us here in the example, but
                 * lists 2/ODR as the wakeup time.
                 */
                usleep_range(1500, 2000);
        }

        ret = devm_add_action_or_reset(data->dev, bma400_power_disable, data);
        if (ret)
		return ret;
....

        return regmap_write(data->regmap, BMA400_ACC_CONFIG2_REG, 0x00);

err_reg_disable:
        regulator_bulk_disable(ARRAY_SIZE(data->regulators),
                               data->regulators);
out:
        return ret;
}

> 
> 
> Jonathan
> 
> > +}
> > +
> >  int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
> >  {
> >  	struct iio_dev *indio_dev;
> > @@ -822,31 +835,13 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
> >  	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> > -	dev_set_drvdata(dev, indio_dev);
> > -
> > -	return iio_device_register(indio_dev);
> > -}
> > -EXPORT_SYMBOL(bma400_probe);
> > -
> > -void bma400_remove(struct device *dev)
> > -{
> > -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > -	struct bma400_data *data = iio_priv(indio_dev);
> > -	int ret;
> > -
> > -	mutex_lock(&data->mutex);
> > -	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
> > -	mutex_unlock(&data->mutex);
> > -
> > +	ret = devm_add_action_or_reset(dev, bma400_disable, data);
> >  	if (ret)
> > -		dev_warn(dev, "Failed to put device into sleep mode (%pe)\n", ERR_PTR(ret));
> > -
> > -	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> > -			       data->regulators);
> > +		return ret;
> >  
> > -	iio_device_unregister(indio_dev);
> > +	return devm_iio_device_register(dev, indio_dev);
> >  }
> > -EXPORT_SYMBOL(bma400_remove);
> > +EXPORT_SYMBOL(bma400_probe);
> >  
> >  MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
> >  MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
> > diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
> > index f50df5310beb..56da06537562 100644
> > --- a/drivers/iio/accel/bma400_i2c.c
> > +++ b/drivers/iio/accel/bma400_i2c.c
> > @@ -27,13 +27,6 @@ static int bma400_i2c_probe(struct i2c_client *client,
> >  	return bma400_probe(&client->dev, regmap, id->name);
> >  }
> >  
> > -static int bma400_i2c_remove(struct i2c_client *client)
> > -{
> > -	bma400_remove(&client->dev);
> > -
> > -	return 0;
> > -}
> > -
> >  static const struct i2c_device_id bma400_i2c_ids[] = {
> >  	{ "bma400", 0 },
> >  	{ }
> > @@ -52,7 +45,6 @@ static struct i2c_driver bma400_i2c_driver = {
> >  		.of_match_table = bma400_of_i2c_match,
> >  	},
> >  	.probe    = bma400_i2c_probe,
> > -	.remove   = bma400_i2c_remove,
> >  	.id_table = bma400_i2c_ids,
> >  };
> >  
> > diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
> > index 9f622e37477b..96dc9c215401 100644
> > --- a/drivers/iio/accel/bma400_spi.c
> > +++ b/drivers/iio/accel/bma400_spi.c
> > @@ -87,13 +87,6 @@ static int bma400_spi_probe(struct spi_device *spi)
> >  	return bma400_probe(&spi->dev, regmap, id->name);
> >  }
> >  
> > -static int bma400_spi_remove(struct spi_device *spi)
> > -{
> > -	bma400_remove(&spi->dev);
> > -
> > -	return 0;
> > -}
> > -
> >  static const struct spi_device_id bma400_spi_ids[] = {
> >  	{ "bma400", 0 },
> >  	{ }
> > @@ -112,7 +105,6 @@ static struct spi_driver bma400_spi_driver = {
> >  		.of_match_table = bma400_of_spi_match,
> >  	},
> >  	.probe    = bma400_spi_probe,
> > -	.remove   = bma400_spi_remove,
> >  	.id_table = bma400_spi_ids,
> >  };
> >  
> 
