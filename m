Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37C64F0854
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355475AbiDCHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiDCHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 03:50:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D66DE82;
        Sun,  3 Apr 2022 00:48:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so6216505pjk.4;
        Sun, 03 Apr 2022 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ykERee7OgSh1nFhBzsy5cq2aVIaRqvjq9HpBUba5u0=;
        b=kFY7Z97F9caWxtCZ9foOx8rrG3Ojxu0OOb0/X3kyr+RpweTyXJoPetEMo/Ojb7pGXN
         Axx1/Z/Zw8BVLEymHX3ThDjMmqnjAMXDiJcNK3+rNzROzaMjCi66Yby5L79/OkmNwbbN
         L2igND6/B3JkqNyQ6AAat7fY3sGVHo1LPbGY/zpXZHvjG7QBBGk29r5/47i/pEZGxYOb
         Tz/Pc+hzhsP9oivEzPOrq/S1fsR66p5fKrnJnjHA7PhnGgUxN+qoTyVUyRR9bwXrgpfs
         D602w+uYoBKz0MKciAp1S3czHkNf/ZWmcEbIapQtXUNFW+pdR7d8dpeH+ZAh7hnXBpmg
         1Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ykERee7OgSh1nFhBzsy5cq2aVIaRqvjq9HpBUba5u0=;
        b=FeUtI15sdP7dXb8WHqRIoeLrMaUjzah/v9vtKfewSVeIyxa07wyCs/j176VJApzFvi
         XVxpc888vaiCs8XkojDDeWeyUcuetJrJwgKOOy+EHSAEp4mdb+Xq81zrxa418RCvIZJU
         vIPPKNGNWfkoeUjVC3wY9wWSMXoHwEh5WyZ8LgrsAGfRPhsUc+Db2O4MDHYAyp/uqsLG
         pa3DkNIAu6DtR8iLF0kon73/inAZunNI3j59JmwiLlp/MdOSY0mhOU/J/ZAzzRqGePzj
         8WG4n4EgTBpsp5NESxwSL8+IxZR0KQrintWgpEC4WuK0RY0L6stdARfYElUXQUlnNjWm
         6+vA==
X-Gm-Message-State: AOAM530ogMuW8dqQsfSvljDUc9lokDoVbgQIVDighdESUcCrq/yggBVN
        Jt+DA5sEYJs0cc/5u1dHcEo=
X-Google-Smtp-Source: ABdhPJztaG+X1kktHViNe9OXKc9wf944R11upCrAfU3p6f98USawmPP7u7+XAuO3Oaxz81kwkeh5tQ==
X-Received: by 2002:a17:902:d88a:b0:156:1609:1e62 with SMTP id b10-20020a170902d88a00b0015616091e62mr32035572plz.143.1648972104227;
        Sun, 03 Apr 2022 00:48:24 -0700 (PDT)
Received: from jagath-PC ([115.99.128.226])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b004fb157f136asm8314281pfe.153.2022.04.03.00.48.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Apr 2022 00:48:23 -0700 (PDT)
Date:   Sun, 3 Apr 2022 13:18:20 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: accel: bma400: Add step change event
Message-ID: <20220403074818.GA7583@jagath-PC>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
 <20220326194146.15549-6-jagathjog1996@gmail.com>
 <20220327175036.4b026481@jic23-huawei>
 <20220328203710.GA8027@jagath-PC>
 <20220402173707.426cb005@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220402173707.426cb005@jic23-huawei>
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

On Sat, Apr 02, 2022 at 05:37:07PM +0100, Jonathan Cameron wrote:
> On Tue, 29 Mar 2022 02:07:11 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Sun, Mar 27, 2022 at 05:50:36PM +0100, Jonathan Cameron wrote:
> > > On Sun, 27 Mar 2022 01:11:46 +0530
> > > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > >   
> > > > Added support for event when there is a detection of step change.
> > > > INT1 pin is used to interrupt and event is pushed to userspace.
> > > > 
> > > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>  
> > > 
> > > These last two patches look fine to me.  Simply having the
> > > event enable the channel makes things simpler.  
> > 
> > Means do I need to drop the step _INFO_ENABLE and handle the
> > enabling and disabling of step channel through the event enable and
> > disable?
> 
> No.  I was trying to say I like the solution you have now.

Thanks, I will keep the solution same.
Currently I am testing the BMA400 activity events like STILL, WALKING,
RUNNING and also BMA400 acceleration threshold events, soon I will send the
next v3 patch series by including these events.

> 
> > 
> > > I briefly wondered if we need to care about sequences like
> > > 
> > > 1) Enable event
> > > 2) Enable channel (already enabled, but perhaps this indicates separate intent)
> > > 3) Disable event.
> > > 4) Is the channel still enabled?
> > > 
> > > or the simpler case of whether we should disable the channel if the event is
> > > disabled and it wasn't otherwise turned on.
> > > 
> > > However, I can't see a sensible way to do so. Hence I think what you have
> > > gone with is the best we can do.
> > > 
> > > Thanks,
> > > 
> > > Jonathan  
> > 
> > Thanks for reviewing the patch series. I will also address all the comments
> > from Andy in the next patch v3.
> > 
> > Thank you
> > Jagath
> > >   
> > > > ---
> > > >  drivers/iio/accel/bma400.h      |  2 +
> > > >  drivers/iio/accel/bma400_core.c | 73 +++++++++++++++++++++++++++++++++
> > > >  2 files changed, 75 insertions(+)
> > > > 
> > > > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > > > index c9b856b37021..c4ec0cf6dc00 100644
> > > > --- a/drivers/iio/accel/bma400.h
> > > > +++ b/drivers/iio/accel/bma400.h
> > > > @@ -39,6 +39,7 @@
> > > >  #define BMA400_INT_STAT0_REG        0x0e
> > > >  #define BMA400_INT_STAT1_REG        0x0f
> > > >  #define BMA400_INT_STAT2_REG        0x10
> > > > +#define BMA400_INT12_MAP_REG	    0x23
> > > >  
> > > >  /* Temperature register */
> > > >  #define BMA400_TEMP_DATA_REG        0x11
> > > > @@ -54,6 +55,7 @@
> > > >  #define BMA400_STEP_CNT3_REG        0x17
> > > >  #define BMA400_STEP_STAT_REG        0x18
> > > >  #define BMA400_STEP_INT_MSK	    BIT(0)
> > > > +#define BMA400_STEP_STAT_MASK	    GENMASK(9, 8)
> > > >  
> > > >  /*
> > > >   * Read-write configuration registers
> > > > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > > > index ec2f9c380bda..aaa104a2698b 100644
> > > > --- a/drivers/iio/accel/bma400_core.c
> > > > +++ b/drivers/iio/accel/bma400_core.c
> > > > @@ -24,6 +24,7 @@
> > > >  #include <linux/iio/iio.h>
> > > >  #include <linux/iio/sysfs.h>
> > > >  #include <linux/iio/buffer.h>
> > > > +#include <linux/iio/events.h>
> > > >  #include <linux/iio/trigger.h>
> > > >  #include <linux/iio/trigger_consumer.h>
> > > >  #include <linux/iio/triggered_buffer.h>
> > > > @@ -70,6 +71,7 @@ struct bma400_data {
> > > >  	int scale;
> > > >  	struct iio_trigger *trig;
> > > >  	int steps_enabled;
> > > > +	bool step_event_en;
> > > >  	/* Correct time stamp alignment */
> > > >  	struct {
> > > >  		__le16 buff[3];
> > > > @@ -167,6 +169,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
> > > >  	{ }
> > > >  };
> > > >  
> > > > +static const struct iio_event_spec bma400_step_detect_event = {
> > > > +	.type = IIO_EV_TYPE_CHANGE,
> > > > +	.dir = IIO_EV_DIR_NONE,
> > > > +	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> > > > +};
> > > > +
> > > >  #define BMA400_ACC_CHANNEL(_index, _axis) { \
> > > >  	.type = IIO_ACCEL, \
> > > >  	.modified = 1, \
> > > > @@ -209,6 +217,8 @@ static const struct iio_chan_spec bma400_channels[] = {
> > > >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > > >  				      BIT(IIO_CHAN_INFO_ENABLE),
> > > >  		.scan_index = -1, /* No buffer support */
> > > > +		.event_spec = &bma400_step_detect_event,
> > > > +		.num_event_specs = 1,
> > > >  	},
> > > >  	IIO_CHAN_SOFT_TIMESTAMP(4),
> > > >  };
> > > > @@ -878,6 +888,58 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
> > > >  	}
> > > >  }
> > > >  
> > > > +static int bma400_read_event_config(struct iio_dev *indio_dev,
> > > > +				    const struct iio_chan_spec *chan,
> > > > +				    enum iio_event_type type,
> > > > +				    enum iio_event_direction dir)
> > > > +{
> > > > +	struct bma400_data *data = iio_priv(indio_dev);
> > > > +
> > > > +	switch (type) {
> > > > +	case IIO_EV_TYPE_CHANGE:
> > > > +		return data->step_event_en;
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > > +static int bma400_write_event_config(struct iio_dev *indio_dev,
> > > > +				     const struct iio_chan_spec *chan,
> > > > +				     enum iio_event_type type,
> > > > +				     enum iio_event_direction dir, int state)
> > > > +{
> > > > +	int ret;
> > > > +	struct bma400_data *data = iio_priv(indio_dev);
> > > > +
> > > > +	switch (type) {
> > > > +	case IIO_EV_TYPE_CHANGE:
> > > > +		mutex_lock(&data->mutex);
> > > > +		if (!data->steps_enabled) {
> > > > +			ret = regmap_update_bits(data->regmap,
> > > > +						 BMA400_INT_CONFIG1_REG,
> > > > +						 BMA400_STEP_INT_MSK,
> > > > +						 FIELD_PREP(BMA400_STEP_INT_MSK,
> > > > +							    1));
> > > > +			if (ret)
> > > > +				return ret;
> > > > +			data->steps_enabled = 1;
> > > > +		}
> > > > +
> > > > +		ret = regmap_update_bits(data->regmap,
> > > > +					 BMA400_INT12_MAP_REG,
> > > > +					 BMA400_STEP_INT_MSK,
> > > > +					 FIELD_PREP(BMA400_STEP_INT_MSK,
> > > > +						    state));
> > > > +		mutex_unlock(&data->mutex);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +		data->step_event_en = state;
> > > > +		return 0;
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > >  static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > > >  					     bool state)
> > > >  {
> > > > @@ -910,6 +972,8 @@ static const struct iio_info bma400_info = {
> > > >  	.read_avail        = bma400_read_avail,
> > > >  	.write_raw         = bma400_write_raw,
> > > >  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
> > > > +	.read_event_config = bma400_read_event_config,
> > > > +	.write_event_config = bma400_write_event_config,
> > > >  };
> > > >  
> > > >  static const struct iio_trigger_ops bma400_trigger_ops = {
> > > > @@ -965,6 +1029,15 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
> > > >  		ret = IRQ_HANDLED;
> > > >  	}
> > > >  
> > > > +	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(status))) {
> > > > +		iio_push_event(indio_dev,
> > > > +			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
> > > > +					      IIO_EV_DIR_NONE,
> > > > +					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
> > > > +			       iio_get_time_ns(indio_dev));
> > > > +		ret = IRQ_HANDLED;
> > > > +	}
> > > > +
> > > >  	return ret;
> > > >  }
> > > >    
> > >   
> 
