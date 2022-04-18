Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7C505F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiDRWOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiDRWMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:12:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B2910A0;
        Mon, 18 Apr 2022 15:09:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id md4so14108581pjb.4;
        Mon, 18 Apr 2022 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KFgtlf9sXMO8UasKU8rCZcmfKt6EiIeryG73SRp/xMU=;
        b=Faj6WMSbUkWJVTURZElWqf8aN0CJ5h6IPHrmXauc/bDvTg0efjjiuCtzEXKz2zyIgY
         Dkx8rp9fg5iVwg005ToqBz6Jxg0TiKTNGLGkxYu/loHm0DX98Wn1U9Pd8f498M0WxL9t
         O+JOxxfZxB4O0rSZh/8OLLHkbq+UncB4eazpLl68r4WSVTzcN9aJuGSVtBXrIolCFUPv
         Nva5k2QCHHgEexwa0EWnyAne6GjN9jh2ueGb0urL92vaHBe4CNK3dZvJK9mJ5BvJn84A
         tULI4nG1N89TK3p6cQdw7qIGR396RAIc8Rn0yy/6LZ07KQt6b2caQP4xCvVDoLU1kdYP
         LUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KFgtlf9sXMO8UasKU8rCZcmfKt6EiIeryG73SRp/xMU=;
        b=lDuqMNtWUOa+122uATJLcWK0PGWnIMPVSBWqJ2ChF2jPgZD06WgcUWOa9mL6TMleqS
         XKpz+cz7ghiB4BVw6uioEb8zeB0CwzxKY+S+TSE8JmD+my42sURmEysvvj0BgVUVCeLm
         DUh6CKnn1pWpxzedYTFKurXdHYDzz0MnBdcy3xOXEnej3e4LKPrSRPHxstgWJrMrLtyX
         /3BcqHSQwdmiKc5+DLh8nca3I0Z5xBmPY/o3bSdt+LioQtmgyikjTaMtXnvbspFoabTv
         K+m6MX1Bk9BhQaeAryagidHgGeVUNV7t8sG7Njl03fYFGrco4bwHBn4YE+m613a6o6QQ
         yAmA==
X-Gm-Message-State: AOAM532c/pR+69838p8gePZccFsWpnwqmKWcRYPUbUlc322DFaKLllUl
        JJWg9fF5PY3HO0KGgV8638AvOhGIICI=
X-Google-Smtp-Source: ABdhPJyyk+n6fyH2TFtdWxS5IaHzkpE4x0LCGyCw1Ok7hF9dusdybrPNTOJxTQMHaNdL9H/mogVtzA==
X-Received: by 2002:a17:902:e9c4:b0:158:f77d:afb7 with SMTP id 4-20020a170902e9c400b00158f77dafb7mr8509753plk.143.1650319787625;
        Mon, 18 Apr 2022 15:09:47 -0700 (PDT)
Received: from jagath-PC ([125.99.244.75])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a680100b001d28905b214sm4803035pjj.39.2022.04.18.15.09.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Apr 2022 15:09:47 -0700 (PDT)
Date:   Tue, 19 Apr 2022 03:39:43 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] iio: accel: bma400: Add support for activity and
 inactivity events
Message-ID: <20220418220941.GA16030@jagath-PC>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
 <20220411203133.19929-10-jagathjog1996@gmail.com>
 <20220416175537.193cfc10@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220416175537.193cfc10@jic23-huawei>
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

Thanks for your suggestions, I will fix the locking and unlocking for all
patches in the next series.

Please can you guide me for auto build test error reported by kernel test
robot for set_mask_bits(&data->generic_event_en, msk, field_value);
in this patch.

On Sat, Apr 16, 2022 at 05:55:37PM +0100, Jonathan Cameron wrote:
> On Tue, 12 Apr 2022 02:01:33 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
> 
> > Add support for activity and inactivity events for all axis based on the
> > threshold, duration and hysteresis value set from the userspace. INT1 pin
> > is used to interrupt and event is pushed to userspace.
> > 
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > ---
> >  drivers/iio/accel/bma400.h      |  11 ++
> >  drivers/iio/accel/bma400_core.c | 229 ++++++++++++++++++++++++++++++++
> >  2 files changed, 240 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > index bc4641279be3..cbf8035c817e 100644
> > --- a/drivers/iio/accel/bma400.h
> > +++ b/drivers/iio/accel/bma400.h
> > @@ -93,6 +93,17 @@
> >  #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
> >  #define BMA400_ACC_ODR_MIN_HZ       12
> >  
> > +/* Generic interrupts register */
> > +#define BMA400_GEN1INT_CONFIG0      0x3f
> > +#define BMA400_GEN2INT_CONFIG0      0x4A
> > +#define BMA400_GEN_CONFIG1_OFF      0x01
> > +#define BMA400_GEN_CONFIG2_OFF      0x02
> > +#define BMA400_GEN_CONFIG3_OFF      0x03
> > +#define BMA400_GEN_CONFIG31_OFF     0x04
> > +#define BMA400_INT_GEN1_MSK         BIT(2)
> > +#define BMA400_INT_GEN2_MSK         BIT(3)
> > +#define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
> > +
> >  /*
> >   * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
> >   * converting to micro values for +-2g range.
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index b6c79cfabaa4..226a5f63d1a6 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -79,6 +79,7 @@ struct bma400_data {
> >  	int steps_enabled;
> >  	bool step_event_en;
> >  	bool activity_event_en;
> > +	u8 generic_event_en;
> >  	/* Correct time stamp alignment */
> >  	struct {
> >  		__le16 buff[3];
> > @@ -188,6 +189,25 @@ static const struct iio_event_spec bma400_activity_event = {
> >  	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> >  };
> >  
> > +static const struct iio_event_spec bma400_accel_event[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_MAG,
> > +		.dir = IIO_EV_DIR_FALLING,
> > +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> > +				       BIT(IIO_EV_INFO_PERIOD) |
> > +				       BIT(IIO_EV_INFO_HYSTERESIS) |
> > +				       BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > +	{
> > +		.type = IIO_EV_TYPE_MAG,
> > +		.dir = IIO_EV_DIR_RISING,
> > +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> > +				       BIT(IIO_EV_INFO_PERIOD) |
> > +				       BIT(IIO_EV_INFO_HYSTERESIS) |
> > +				       BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > +};
> > +
> >  #define BMA400_ACC_CHANNEL(_index, _axis) { \
> >  	.type = IIO_ACCEL, \
> >  	.modified = 1, \
> > @@ -207,6 +227,8 @@ static const struct iio_event_spec bma400_activity_event = {
> >  		.storagebits = 16,	\
> >  		.endianness = IIO_LE,	\
> >  	},				\
> > +	.event_spec = bma400_accel_event,			\
> > +	.num_event_specs = ARRAY_SIZE(bma400_accel_event)	\
> >  }
> >  
> >  #define BMA400_ACTIVITY_CHANNEL(_chan2) {	\
> > @@ -954,6 +976,17 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
> >  	struct bma400_data *data = iio_priv(indio_dev);
> >  
> >  	switch (chan->type) {
> > +	case IIO_ACCEL:
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			return FIELD_GET(BMA400_INT_GEN1_MSK,
> > +					 data->generic_event_en);
> > +		case IIO_EV_DIR_FALLING:
> > +			return FIELD_GET(BMA400_INT_GEN2_MSK,
> > +					 data->generic_event_en);
> > +		default:
> > +			return -EINVAL;
> > +		}
> >  	case IIO_STEPS:
> >  		return data->step_event_en;
> >  	case IIO_ACTIVITY:
> > @@ -970,8 +1003,74 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
> >  {
> >  	int ret;
> >  	struct bma400_data *data = iio_priv(indio_dev);
> > +	int reg, msk, value, field_value;
> >  
> >  	switch (chan->type) {
> > +	case IIO_ACCEL:
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			reg = BMA400_GEN1INT_CONFIG0;
> > +			msk = BMA400_INT_GEN1_MSK;
> > +			value = 2;
> > +			field_value = FIELD_PREP(BMA400_INT_GEN1_MSK, state);
> 
> Hopefully you can use msk in here and the compiler can tell it's constant...

field_value = FIELD_PREP(msk, state); 
is this the fix for error reported by kernel test robot?

> 
> > +			break;
> > +		case IIO_EV_DIR_FALLING:
> > +			reg = BMA400_GEN2INT_CONFIG0;
> > +			msk = BMA400_INT_GEN2_MSK;
> > +			value = 0;
> > +			field_value = FIELD_PREP(BMA400_INT_GEN2_MSK, state);
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		mutex_lock(&data->mutex);
> > +		/* Enabling all axis for interrupt evaluation */
> > +		ret = regmap_write(data->regmap, reg, 0xF8);
> > +		if (ret) {
> > +			mutex_unlock(&data->mutex);
> > +			return ret;
> > +		}
> > +
> > +		/* OR combination of all axis for interrupt evaluation */
> > +		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF,
> > +				   value);
> > +		if (ret) {
> > +			mutex_unlock(&data->mutex);
> > +			return ret;
> > +		}
> > +
> > +		/* Initial value to avoid interrupts while enabling*/
> > +		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
> > +				   0x0A);
> > +		if (ret) {
> > +			mutex_unlock(&data->mutex);
> > +			return ret;
> > +		}
> > +
> > +		/* Initial duration value to avoid interrupts while enabling*/
> > +		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF,
> > +				   0x0F);
> > +		if (ret) {
> > +			mutex_unlock(&data->mutex);
> > +			return ret;
> > +		}
> > +
> > +		ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> > +					 msk, field_value);
> > +		if (ret) {
> > +			mutex_unlock(&data->mutex);
> > +			return ret;
> > +		}
> > +
> > +		ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
> > +					 msk, field_value);
> > +		mutex_unlock(&data->mutex);
> > +		if (ret)
> > +			return ret;
> 
> This whole stack or mutex_unlock() error handling is a good hint that you should
> just factor out this case as a separate function then you can use a goto to
> deal with the unlock cleanly.

Sure, I will fix the error handling in the proper way in the next patch.

> 
> > +
> > +		set_mask_bits(&data->generic_event_en, msk, field_value);
> > +		return 0;
> >  	case IIO_STEPS:
> >  		mutex_lock(&data->mutex);
> >  		if (!data->steps_enabled) {
> > @@ -1028,6 +1127,118 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
> >  	}
> >  }
> >  
> > +static int get_gen_config_reg(enum iio_event_direction dir)
> > +{
> > +	switch (dir) {
> > +	case IIO_EV_DIR_FALLING:
> > +		return BMA400_GEN2INT_CONFIG0;
> > +	case IIO_EV_DIR_RISING:
> > +		return BMA400_GEN1INT_CONFIG0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int bma400_read_event_value(struct iio_dev *indio_dev,
> > +				   const struct iio_chan_spec *chan,
> > +				   enum iio_event_type type,
> > +				   enum iio_event_direction dir,
> > +				   enum iio_event_info info,
> > +				   int *val, int *val2)
> > +{
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +	u8 reg, duration[2];
> > +
> > +	reg = get_gen_config_reg(dir);
> > +	if (reg < 0)
> > +		return -EINVAL;
> > +
> > +	*val2 = 0;
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		mutex_lock(&data->mutex);
> > +		ret = regmap_read(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
> > +				  val);
> > +		mutex_unlock(&data->mutex);
> > +		if (ret)
> > +			return ret;
> > +		return IIO_VAL_INT;
> > +	case IIO_EV_INFO_PERIOD:
> > +		mutex_lock(&data->mutex);
> > +		ret = regmap_bulk_read(data->regmap,
> > +				       reg + BMA400_GEN_CONFIG3_OFF,
> > +				       duration, sizeof(duration));
> > +		mutex_unlock(&data->mutex);
> > +		if (ret)
> > +			return ret;
> > +		*val = get_unaligned_be16(duration);
> 
> As well as dma safety question, you could just have used a __be16 for
> duration then you can use be16_to_cpu() as you know it is aligned.

For dma safety, do I need to allocate memory by using local kmalloc() or
I can use __be16 local variable for regmap_bulk_read()?

> 
> > +		return IIO_VAL_INT;
> > +	case IIO_EV_INFO_HYSTERESIS:
> > +		mutex_lock(&data->mutex);
> > +		ret = regmap_read(data->regmap, reg, val);
> > +		mutex_unlock(&data->mutex);
> > +		if (ret)
> > +			return ret;
> > +		*val = FIELD_GET(BMA400_GEN_HYST_MSK, *val);
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int bma400_write_event_value(struct iio_dev *indio_dev,
> > +				    const struct iio_chan_spec *chan,
> > +				    enum iio_event_type type,
> > +				    enum iio_event_direction dir,
> > +				    enum iio_event_info info,
> > +				    int val, int val2)
> > +{
> > +	struct bma400_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +	u8 reg, duration[2];
> > +
> > +	reg = get_gen_config_reg(dir);
> > +	if (reg < 0)
> > +		return -EINVAL;
> > +
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		if (val < 1 || val > 255)
> > +			return -EINVAL;
> > +
> > +		mutex_lock(&data->mutex);
> > +		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
> > +				   val);
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	case IIO_EV_INFO_PERIOD:
> > +		if (val < 1 || val > 65535)
> > +			return -EINVAL;
> > +
> > +		put_unaligned_be16(val, duration);
> > +
> > +		mutex_lock(&data->mutex);
> > +		ret = regmap_bulk_write(data->regmap,
> > +					reg + BMA400_GEN_CONFIG3_OFF,
> > +					duration, sizeof(duration));
> 
> I can't remember if we are safe or not with bulk_writes but at least
> in theory we might not be and should be using a dma safe buffer.

Here also for regmap_bulk_write() can I allocate the memory locally by using
kmalloc().

> 
> Also locking not necessary in various places in here.

I will fix the locking in all the patches in the next series.

> 
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	case IIO_EV_INFO_HYSTERESIS:
> > +		if (val < 0 || val > 3)
> > +			return -EINVAL;
> > +
> > +		mutex_lock(&data->mutex);
> > +		ret = regmap_update_bits(data->regmap, reg,
> > +					 BMA400_GEN_HYST_MSK,
> > +					 FIELD_PREP(BMA400_GEN_HYST_MSK, val));
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> 

Thank you,
Jagath
