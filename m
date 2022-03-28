Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A574E9F18
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbiC1Skq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbiC1Skn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:40:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB6C62C84;
        Mon, 28 Mar 2022 11:39:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m22so15043025pja.0;
        Mon, 28 Mar 2022 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ccQY+nh2LrlRuF220Zy4PJ1Pgg4dKfaXAR1grqXSOgk=;
        b=KrSlN2+RE1rrrywqYvhNoB0Ox2+Q+ZtEDV7fgm4o0+G7nELzn+1kPbrsiNyNe915Wl
         jTsKtjJlCCnArfLpVe1jlBiwZ0M6hAc5PEO1VoKGDELCkQSoqK5svZIJR2jSg9r0gBnH
         zYNc/M3yVZTMQKulOoYAWdzqq+7FGxREnSV/6rPNELRs8lwanDwi+Uhn1KZoGrHAKyuB
         GUhoWClwBxPOFj0A5ERiE6m5fx/dTNqSYQeCMMNwn0l45HFeXnw/e/NHANkqEOi8JgtU
         kTQiJutQgTJBw5sXRhDCwPyz6Dy6zmgJHmuKZc7AfzBJKD0skMzl4Iw7b6ePV4276hbi
         QxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ccQY+nh2LrlRuF220Zy4PJ1Pgg4dKfaXAR1grqXSOgk=;
        b=dhnkh2KoHvfTws24AI31JqJbF/VE5VYSZQHnwkKTwLxUsD3HLsHTSn+jZKXwdBFu3H
         VSXdA7luNXNfbsWAXi8wlmPwY6hqOnxUR3/8eTvHJ5UrdKAmS5tSzld7wAShD7J8AoYl
         p5gxrrMpMnHFUf81+gTmNYokztYBiPPU+DAls8iAQOoeDFuiBa8433xMMFjs5VFBhnwT
         JKN7yP85sZ55WE7dOcKrgiLXGe5cqCVgdOR/HAL0CYp3Nvw6tyha0ONPGu5IO2qW1z45
         BUGMyhL+Nh1hMGIpuOb6Y4v/98q5XvUCQNRYENyiYKJLePTsrAo26TyD6Oq/sbZvHc2i
         qTFQ==
X-Gm-Message-State: AOAM533Yztm4ApPetyYLCUaYwzvrF73yAUioRLynmOZ1eraxQHjE5rbe
        vwmQ2w7x2h3XBbji/M6f8IY=
X-Google-Smtp-Source: ABdhPJxRb20GkX9Lx2PRH//RxpoYIkA7P8jyuzbCPZ/guhKbbjPg1mU14UaIJVXvi6sUABIsWb2yaw==
X-Received: by 2002:a17:90b:4c12:b0:1c6:f450:729d with SMTP id na18-20020a17090b4c1200b001c6f450729dmr523934pjb.190.1648492741860;
        Mon, 28 Mar 2022 11:39:01 -0700 (PDT)
Received: from jagath-PC ([115.99.143.239])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a2c0c00b001bc4cf0107esm195989pjd.53.2022.03.28.11.39.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Mar 2022 11:39:01 -0700 (PDT)
Date:   Tue, 29 Mar 2022 00:08:57 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220328183852.GA4465@jagath-PC>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
 <20220326194146.15549-4-jagathjog1996@gmail.com>
 <20220327174545.41a15150@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220327174545.41a15150@jic23-huawei>
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

Hi Jonathan,

On Sun, Mar 27, 2022 at 05:45:45PM +0100, Jonathan Cameron wrote:
> On Sun, 27 Mar 2022 01:11:44 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
> 
> > Added trigger buffer support to read continuous acceleration
> > data from device with data ready interrupt which is mapped
> > to INT1 pin.
> > 
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> Hi Jagath,
> 
> Just a few small things noticed on this read through.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/accel/Kconfig       |   2 +
> >  drivers/iio/accel/bma400.h      |  10 +-
> >  drivers/iio/accel/bma400_core.c | 162 ++++++++++++++++++++++++++++++--
> >  drivers/iio/accel/bma400_i2c.c  |   2 +-
> >  drivers/iio/accel/bma400_spi.c  |   2 +-
> >  5 files changed, 168 insertions(+), 10 deletions(-)
> > 
> 
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index dc273381a0a2..fa3f4b5f229f 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -11,16 +11,22 @@
> >   *  - Create channel for sensor time
> >   */
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/bitops.h>
> >  #include <linux/device.h>
> > -#include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> 
> Is iio/sysfs.h actually used?  It rarely is these days as it contains
> the infrastructure for custom attributes and we try not to use any
> of those anymore.
> 
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
> This reorganization of headers is good but shouldn't be in this patch.
> Add an earlier patch in the series to move the existing pair down here
> before this patch then adds the new ones.

Sure I will do the reorganization of headers in the seperate patch.

> 
> 
> ...
> 
> >  
> >  static int bma400_get_temp_reg(struct bma400_data *data, int *val, int *val2)
> > @@ -659,6 +687,10 @@ static int bma400_init(struct bma400_data *data)
> >  	if (ret)
> >  		return ret;
> >  
> > +	/* Configure INT1 pin to open drain */
> > +	ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x06);
> > +	if (ret)
> > +		return ret;
> >  	/*
> >  	 * Once the interrupt engine is supported we might use the
> >  	 * data_src_reg, but for now ensure this is set to the
> > @@ -807,6 +839,33 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
> >  	}
> >  }
> >  
> > +static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > +					     bool state)
> > +{
> > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
> > +				 BMA400_INT_DRDY_MSK,
> > +				 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> > +				 BMA400_INT_DRDY_MSK,
> > +				 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> 	return regmap_update_bits()...
> 
> > +}
> 
> ...
> 
> 
> > +static irqreturn_t bma400_interrupt(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +	irqreturn_t ret = IRQ_NONE;
> > +	__le16 status;
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
> > +			       sizeof(status));
> > +	mutex_unlock(&data->mutex);
> > +	if (ret)
> > +		return IRQ_NONE;
> > +
> > +	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(status))) {
> > +		iio_trigger_poll_chained(data->trig);
> > +		ret = IRQ_HANDLED;
> Preference for this style
> 		return IRQ_HANDLED;
> > +	}
> > +
> return IRQ_NONE;
> and don't initialize above.

Sure I will make these changes and I will try to handle the events before
the data ready since step interrupt will occur less frequently compared to
data ready interrupts.

> 
> > +	return ret;
> > +}
> > +
> 
> 

Thank you,
Jagath
