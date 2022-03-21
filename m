Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377A44E33E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiCUXGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiCUXGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:06:21 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33D8334D30;
        Mon, 21 Mar 2022 15:53:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p5so10625023pfo.5;
        Mon, 21 Mar 2022 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oz6xjnR4j2xmDxKG1XvyE47iS0YFnci2l2UEM/dmixc=;
        b=SOKc28wevhkg+7ME4JLd0QJTKa2izrhVQYIfdTqc8si+BtGl3pqahSAAn3ZRnHuLKP
         spYdl6lWCcHz5nmU4LBvUxzjVdsJQ5vxlAdBb7zd9UWi1w7MY0wq+rl5uJfOr3vhEfAB
         tDKnzvmaLTB8rnqXbjtZID7HOUBAAYDQZKaYES6SEN3jDyfG0ae1VtEebOvxo8zyjxVk
         sziZHG2bL/WD4wG9YAJ+uBSqjcgO0yVJBdNuVcDJuspp8js7IsgtQNDjXy0yHjDVy9Jz
         n4aN3E+1i/eXOfs0JanuGfeMQv9BvFOEkxyZORqpNAWp5ipNBvtbwdpdekzmSlk9F4En
         ox9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oz6xjnR4j2xmDxKG1XvyE47iS0YFnci2l2UEM/dmixc=;
        b=OtBVt/iFrXYZKrWUbJEAlO/vKsoOAqvXiTLVMgAOsbnIFmdbmTfsrUD7/sM7hVAOYC
         CXBQJsxFB0PZPTtQEDNyEd5XWGmYGRdBOyi0NxdeckXpivlB6PlsF3VwjOSzSYGIBKd9
         R/BGS/LadiKSzkqvZIEVKwqtYNLt0QriiObtWysz31JLo94tZze8yvFUoYLxr1YnZhsD
         H/wXSiknWjgcPmrvRVrXmdA5cudPDPu/gSFk0FplEaJr2Ua3Eh45bAW9Xt+MPk3limbY
         FES1Z2r2H0u5D/1Yc/mJdqEEqvMz5Wff3obXzk+0yhKZ1GgssyqPNQZCqDxIlTPFh4fI
         meqQ==
X-Gm-Message-State: AOAM5311oGy0Vr2i82I977pSyGNm/LJ1qMr+0i9E5z5eywaRE5WycGiV
        dglueXJYfgjIscT9yrbtIhA7qXzflbWWc8r3
X-Google-Smtp-Source: ABdhPJy2ZB3gFZGhjV9BUKxX9n90sNMR9M0qrjr7UZnRmc1hT5+Yh754ckBCyM8H9CI7HHMM2Ry1qg==
X-Received: by 2002:a05:6a00:194c:b0:4f7:8a93:e814 with SMTP id s12-20020a056a00194c00b004f78a93e814mr25964720pfk.77.1647903174283;
        Mon, 21 Mar 2022 15:52:54 -0700 (PDT)
Received: from jagath-PC ([115.99.184.169])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090a65c700b001b936b8abe0sm446998pjs.7.2022.03.21.15.52.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Mar 2022 15:52:53 -0700 (PDT)
Date:   Tue, 22 Mar 2022 04:22:50 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] iio: accel: bma400: Add step change event
Message-ID: <20220321225248.GE10058@jagath-PC>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
 <20220319181023.8090-6-jagathjog1996@gmail.com>
 <20220320173726.5a9c02bb@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220320173726.5a9c02bb@jic23-huawei>
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

Hello Jonathan,

On Sun, Mar 20, 2022 at 05:37:26PM +0000, Jonathan Cameron wrote:
> On Sat, 19 Mar 2022 23:40:23 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
> 
> > Added support for event when there is a detection of single step
> > or double step change.
> 
> This is new - do we have any way of saying if it was single or
> double that was detected?

Sorry, I could have mentioned this properly. Device will detect single step.
If the sensor misses the detection of single step then it will indicate
as double step for the next step. (Register - INT-STAT1)

I will correct this in the next patch.
>   
> > INT1 pin is used to interrupt and event
> > is pushed to userspace.
> 
> My main question in here is the interaction between the event
> enable and the channel enable in the previous patch.

Channel enable will start the counter when sensor detects the steps,
But there will be no interrupts for each step detection since INT pin
mapping is not done here.

> 
> If the channel is enabled, the event will read as enabled but
> it looks to me like the interrupt will never happen...
> 
> So I think you need to also check if the interrupt is enabled.

Sorry my mistake, I will maintain separate member in device
structure for event.
> 
> The other way around is fine as any IIO ABI is allowed to affect
> any other so when you enable the interrupt it can also enable
> the channel in general.

Then I will enable channel also while enabling interrupt.
> 
> > 
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > ---
> >  drivers/iio/accel/bma400.h      |  2 +
> >  drivers/iio/accel/bma400_core.c | 72 +++++++++++++++++++++++++++++++++
> >  2 files changed, 74 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > index 65bbc80cbb7f..c833119bb42e 100644
> > --- a/drivers/iio/accel/bma400.h
> > +++ b/drivers/iio/accel/bma400.h
> > @@ -39,6 +39,7 @@
> >  #define BMA400_INT_STAT0_REG        0x0e
> >  #define BMA400_INT_STAT1_REG        0x0f
> >  #define BMA400_INT_STAT2_REG        0x10
> > +#define BMA400_INT12_MAP_REG	    0x23
> >  
> >  /* Temperature register */
> >  #define BMA400_TEMP_DATA_REG        0x11
> > @@ -54,6 +55,7 @@
> >  #define BMA400_STEP_CNT3_REG        0x17
> >  #define BMA400_STEP_STAT_REG        0x18
> >  #define BMA400_STEP_INT_MSK         BIT(0)
> > +#define BMA400_STEP_STAT_MASK	    GENMASK(1, 0)
> >  
> >  /*
> >   * Read-write configuration registers
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index 305643e99eb5..79321e41df51 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/iio/trigger.h>
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/events.h>
> >  
> >  #include "bma400.h"
> >  
> > @@ -69,6 +70,7 @@ struct bma400_data {
> >  	int scale;
> >  	struct iio_trigger *trig;
> >  	int steps_enabled;
> > +	bool step_event_en;
> >  	/* Correct time stamp alignment */
> >  	struct {
> >  		__be16 buff[3];
> > @@ -166,6 +168,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
> >  	{ }
> >  };
> >  
> > +static const struct iio_event_spec bma400_step_detect_event = {
> > +	.type = IIO_EV_TYPE_CHANGE,
> > +	.dir = IIO_EV_DIR_NONE,
> > +	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> > +};
> > +
> >  #define BMA400_ACC_CHANNEL(_index, _axis) { \
> >  	.type = IIO_ACCEL, \
> >  	.modified = 1, \
> > @@ -208,6 +216,8 @@ static const struct iio_chan_spec bma400_channels[] = {
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> >  				      BIT(IIO_CHAN_INFO_ENABLE),
> >  		.scan_index = -1, /* No buffer support */
> > +		.event_spec = &bma400_step_detect_event,
> > +		.num_event_specs = 1,
> >  	},
> >  
> >  	IIO_CHAN_SOFT_TIMESTAMP(4),
> > @@ -858,6 +868,59 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
> >  	}
> >  }
> >  
> > +static int bma400_read_event_config(struct iio_dev *indio_dev,
> > +				    const struct iio_chan_spec *chan,
> > +				    enum iio_event_type type,
> > +				    enum iio_event_direction dir)
> > +{
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +
> > +	switch (chan->type) {
> > +	case IIO_STEPS:
> > +		switch (type) {
> > +		case IIO_EV_TYPE_CHANGE:
> > +			return data->steps_enabled;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int bma400_write_event_config(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				     enum iio_event_type type,
> > +				     enum iio_event_direction dir, int state)
> > +{
> > +	int ret;
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +
> > +	switch (chan->type) {
> > +	case IIO_STEPS:
> > +		switch (type) {
> > +		case IIO_EV_TYPE_CHANGE:
> > +			mutex_lock(&data->mutex);
> > +			ret = regmap_update_bits(data->regmap,
> > +						 BMA400_INT12_MAP_REG,
> > +						 BMA400_STEP_INT_MSK,
> > +						 FIELD_PREP(BMA400_STEP_INT_MSK,
> > +							    state));
> > +			mutex_unlock(&data->mutex);
> > +			if (ret)
> > +				return ret;
> > +			data->steps_enabled = state;
> 
> How does this interact with the use in the previous patch?
> 
> > +			return 0;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> >  					     bool state)
> >  {
> > @@ -890,6 +953,8 @@ static const struct iio_info bma400_info = {
> >  	.read_avail        = bma400_read_avail,
> >  	.write_raw         = bma400_write_raw,
> >  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
> > +	.read_event_config = bma400_read_event_config,
> > +	.write_event_config = bma400_write_event_config,
> >  };
> >  
> >  static const struct iio_trigger_ops bma400_trigger_ops = {
> > @@ -945,6 +1010,13 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
> >  	if (status & BMA400_INT_DRDY_MSK)
> >  		iio_trigger_poll_chained(data->trig);
> >  
> > +	if (status & (BMA400_STEP_STAT_MASK << 8)) {
> 
> FIELD_GET() would be cleaner
> 
> > +		iio_push_event(indio_dev,
> > +			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
> > +					      IIO_EV_DIR_NONE,
> > +					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
> > +			       iio_get_time_ns(indio_dev));
> > +		}
> >  out:
> >  	return IRQ_HANDLED;
> >  }
> 
