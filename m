Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA44EA19F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbiC1UjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344688AbiC1Ui6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:38:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEA449241;
        Mon, 28 Mar 2022 13:37:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso590833pjh.3;
        Mon, 28 Mar 2022 13:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k1sAzWPEhJpG5DdAbfTOhs7ujkwRBjEkka+5p8v/Jc8=;
        b=M78+4fhZXB18iHIh1n+x4EJG+IAdhjoF7HijGVTF1ukn3EOi/yj83n2h1NWqL8urqz
         hXG+Mhkyl8q+MZsJcj4YN3O5hqyY8VYl0CBJ19I+WVtC7+U7SSKWdAsqMJnMaJCUC4gr
         9m2ORQxN/UweBQMmG4deC3UYy+QGSPHpf6KEHnXK6Rg1uUSlJ4eWyHw+9/13fHPYj8+n
         KuDhU4i2GNycL+SkKoHzvkgT4Ggd9IILwhig/hYDvsFYSsYNywqZIFppy2G8Lf7l3G0r
         yHZvWQvP0W73PdvZfxCN7OvegVCwGtld1kdPM5AduokYksFgoxGsAnuVecMH7DK2CHAm
         w9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k1sAzWPEhJpG5DdAbfTOhs7ujkwRBjEkka+5p8v/Jc8=;
        b=dZ5PSNdBPKuQD2zdeKSQE8iqenIlIdXHWIfkY+SWZoqeHvbyIya8+nc4Y/3mR4YWe5
         Cua8ppXBDdL2qAd47Q58kmM9rBgc6oEbCpc2y6TyYmlfHZeQfXba7pOToJilRjoCPEH3
         vJ2FPtF44cPGZxcVNRfYmhbj/nTFnqZQ6MTYCi0KTjImC7JkEysKPOW1Gm6btcly4mCT
         ddC8l+kYXzBMh17NVej1SwEes7XcRZEhk+IGBaBmHyDO6IZERQHdiLOz3tR9wMMfwVAW
         CwvobVsi/m+nw5vIpUeqajFXTQ9yL7LkImJus080yMgcCf8ZotrgInFzcO3A7JkSAXzP
         Yxqw==
X-Gm-Message-State: AOAM530RVjNpQrUkDsmdEW4qXf8WJfhgTanQjO56bnjKCHI43RaxJKvP
        kzS3m82yeAyzLGHEdThjO5s=
X-Google-Smtp-Source: ABdhPJwxFfbJ4v3cPPUQB2PgDobQREi0NAVBWSeX1qfisVw1NAy2wIadm6Kio/gXfD4sQJ6g+Z7CDg==
X-Received: by 2002:a17:902:e5c3:b0:154:7d95:ba7e with SMTP id u3-20020a170902e5c300b001547d95ba7emr27540996plf.140.1648499835817;
        Mon, 28 Mar 2022 13:37:15 -0700 (PDT)
Received: from jagath-PC ([115.99.143.239])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm14134673pgc.50.2022.03.28.13.37.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Mar 2022 13:37:15 -0700 (PDT)
Date:   Tue, 29 Mar 2022 02:07:11 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: accel: bma400: Add step change event
Message-ID: <20220328203710.GA8027@jagath-PC>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
 <20220326194146.15549-6-jagathjog1996@gmail.com>
 <20220327175036.4b026481@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220327175036.4b026481@jic23-huawei>
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

On Sun, Mar 27, 2022 at 05:50:36PM +0100, Jonathan Cameron wrote:
> On Sun, 27 Mar 2022 01:11:46 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
> 
> > Added support for event when there is a detection of step change.
> > INT1 pin is used to interrupt and event is pushed to userspace.
> > 
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> 
> These last two patches look fine to me.  Simply having the
> event enable the channel makes things simpler.

Means do I need to drop the step _INFO_ENABLE and handle the
enabling and disabling of step channel through the event enable and
disable?

> I briefly wondered if we need to care about sequences like
> 
> 1) Enable event
> 2) Enable channel (already enabled, but perhaps this indicates separate intent)
> 3) Disable event.
> 4) Is the channel still enabled?
> 
> or the simpler case of whether we should disable the channel if the event is
> disabled and it wasn't otherwise turned on.
> 
> However, I can't see a sensible way to do so. Hence I think what you have
> gone with is the best we can do.
> 
> Thanks,
> 
> Jonathan

Thanks for reviewing the patch series. I will also address all the comments
from Andy in the next patch v3.

Thank you
Jagath
> 
> > ---
> >  drivers/iio/accel/bma400.h      |  2 +
> >  drivers/iio/accel/bma400_core.c | 73 +++++++++++++++++++++++++++++++++
> >  2 files changed, 75 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > index c9b856b37021..c4ec0cf6dc00 100644
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
> >  #define BMA400_STEP_INT_MSK	    BIT(0)
> > +#define BMA400_STEP_STAT_MASK	    GENMASK(9, 8)
> >  
> >  /*
> >   * Read-write configuration registers
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index ec2f9c380bda..aaa104a2698b 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>
> > +#include <linux/iio/events.h>
> >  #include <linux/iio/trigger.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/triggered_buffer.h>
> > @@ -70,6 +71,7 @@ struct bma400_data {
> >  	int scale;
> >  	struct iio_trigger *trig;
> >  	int steps_enabled;
> > +	bool step_event_en;
> >  	/* Correct time stamp alignment */
> >  	struct {
> >  		__le16 buff[3];
> > @@ -167,6 +169,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
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
> > @@ -209,6 +217,8 @@ static const struct iio_chan_spec bma400_channels[] = {
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> >  				      BIT(IIO_CHAN_INFO_ENABLE),
> >  		.scan_index = -1, /* No buffer support */
> > +		.event_spec = &bma400_step_detect_event,
> > +		.num_event_specs = 1,
> >  	},
> >  	IIO_CHAN_SOFT_TIMESTAMP(4),
> >  };
> > @@ -878,6 +888,58 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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
> > +	switch (type) {
> > +	case IIO_EV_TYPE_CHANGE:
> > +		return data->step_event_en;
> > +	default:
> > +		return -EINVAL;
> > +	}
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
> > +	switch (type) {
> > +	case IIO_EV_TYPE_CHANGE:
> > +		mutex_lock(&data->mutex);
> > +		if (!data->steps_enabled) {
> > +			ret = regmap_update_bits(data->regmap,
> > +						 BMA400_INT_CONFIG1_REG,
> > +						 BMA400_STEP_INT_MSK,
> > +						 FIELD_PREP(BMA400_STEP_INT_MSK,
> > +							    1));
> > +			if (ret)
> > +				return ret;
> > +			data->steps_enabled = 1;
> > +		}
> > +
> > +		ret = regmap_update_bits(data->regmap,
> > +					 BMA400_INT12_MAP_REG,
> > +					 BMA400_STEP_INT_MSK,
> > +					 FIELD_PREP(BMA400_STEP_INT_MSK,
> > +						    state));
> > +		mutex_unlock(&data->mutex);
> > +		if (ret)
> > +			return ret;
> > +		data->step_event_en = state;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> >  					     bool state)
> >  {
> > @@ -910,6 +972,8 @@ static const struct iio_info bma400_info = {
> >  	.read_avail        = bma400_read_avail,
> >  	.write_raw         = bma400_write_raw,
> >  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
> > +	.read_event_config = bma400_read_event_config,
> > +	.write_event_config = bma400_write_event_config,
> >  };
> >  
> >  static const struct iio_trigger_ops bma400_trigger_ops = {
> > @@ -965,6 +1029,15 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
> >  		ret = IRQ_HANDLED;
> >  	}
> >  
> > +	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(status))) {
> > +		iio_push_event(indio_dev,
> > +			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
> > +					      IIO_EV_DIR_NONE,
> > +					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
> > +			       iio_get_time_ns(indio_dev));
> > +		ret = IRQ_HANDLED;
> > +	}
> > +
> >  	return ret;
> >  }
> >  
> 
