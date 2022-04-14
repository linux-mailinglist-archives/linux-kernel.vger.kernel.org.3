Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350C1500BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbiDNLJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242508AbiDNLJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:09:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E78A75E46;
        Thu, 14 Apr 2022 04:06:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so9340161ejd.5;
        Thu, 14 Apr 2022 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h6li49GO+Yuu8/Gu2RI9P4F8EHFsoe8mNrfNFsBoaEQ=;
        b=J3YiI/Aduboip8Fe/28g3PUO0GxjjT1udJyJ+kDkob1fp32qgS0b45o4jIC5YyhP87
         QIt8pk1VLkhLgU5BfghAJVunD1smiKzrQ427WKNHjrwtrYdUzc0q7/t4DkP/Dm8+JLsL
         WiaaNaxfsB0C2TTN3/mxf5v2/wDPBb51uuUYpACeI3ScRNdXCBkjDH9jxN0gLlmkZSXU
         KYm27G3sBbT3LIzRF6LZFF/30/G9x63iLchy2dfpRkPWnAo2LFxQPhe11D+YDY6APiZa
         WT7MVck1Cml+wdKJmVPPCc2oj0DuzGPO2jglwGgNY0zr16ruflQrEDQUGKRNFVNs4a1z
         DIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h6li49GO+Yuu8/Gu2RI9P4F8EHFsoe8mNrfNFsBoaEQ=;
        b=YWVd19RAL6z8VeVv7M4qq4l4BNSmclDSPQ1wpeYX/p4tiqjY7zlUvNqbfZ3owO0KVk
         0UpX8J5fhD8h3NX4DVnJ2uGcw5NFyeHdzOvKRGP8HGwIWnEoCtvs6AVVcVsQCaHtFwnj
         zUaoCMD4lUdIz3QidymmcWMrdJtr4SIjgpuEL/78kbUKatdzAQN2nh5wN+ywGnRT5wiA
         GoI017/QVFp5CoBn1jtWJiXE3L406Ul0tTgD+0793nVqQ2L9bljEk5IpF0NgH4xtFPJ1
         j1wsqRTyVYp8K1AWRjE29g1Npy7IsZuKZYspAjTWmmPzPExY2QH7J5Rh4aD1Ic7kuake
         OuYQ==
X-Gm-Message-State: AOAM530QrS2UKoIU96FArVyTSgX0Ch1nK5aDQSfIIduQk93QWid6atyP
        G8dlcP2FTqtScyPuH6JiJsk=
X-Google-Smtp-Source: ABdhPJwzG01/rI+lB+WNrI4o/gRYNsXqeU+tovc3Necnl1+JDkWbcxz+TUTkCiPGGL+vawI5WStPUg==
X-Received: by 2002:a17:906:d54e:b0:6db:b241:c0e2 with SMTP id cr14-20020a170906d54e00b006dbb241c0e2mr1771665ejc.724.1649934417588;
        Thu, 14 Apr 2022 04:06:57 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm871029edt.70.2022.04.14.04.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 04:06:57 -0700 (PDT)
Message-ID: <80196942-4c33-7625-3945-86ce5b7b347f@gmail.com>
Date:   Thu, 14 Apr 2022 14:06:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 3/3] iio: adc: ad4130: add AD4130 driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
 <20220413094011.185269-3-cosmin.tanislav@analog.com>
 <CAHp75VfzX8u45J3634yN5p-QTeT7w0Bos27OxeWOsb3MQ2VRVw@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75VfzX8u45J3634yN5p-QTeT7w0Bos27OxeWOsb3MQ2VRVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/22 18:41, Andy Shevchenko wrote:
> On Wed, Apr 13, 2022 at 1:41 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
> 
> ...
> 
>> +#define AD4130_8_NAME                  "ad4130-8"
> 
> What the meaning of -8 ? Is it number of channels? Or is it part of
> the official model (part number)? Can we see, btw, Datasheet: tag with
> a corresponding link in the commit message?
> 

That's just the name specified in the datasheet. I honestly don't have
much of an idea about why it is like that. Also, I already put the
datasheet in the .yaml documentation. Do you really also want it
in each commit message too?

> 
>> +#define AD4130_RESET_CLK_COUNT         64
>> +#define AD4130_RESET_BUF_SIZE          (AD4130_RESET_CLK_COUNT / 8)
> 
> To be more precise shouldn't the above need to have DIV_ROUND_UP() ?
> 

Does it look like 64 / 8 needs any rounding?

> ...
> 
>> +#define AD4130_FREQ_FACTOR             1000000000ull
>> +#define AD4130_DB3_FACTOR              1000
> 
> Ditto.

AD4130_DB3_FACTOR is unit-less. In the datasheet, the relation between
sampling frequency and 3db frequency is represented as a 0.xyz value,
hence why the db3_div values and 1000 factor.

> 
>> +enum ad4130_fifo_mode {
>> +       AD4130_FIFO_MODE_DISABLED = 0b00,
>> +       AD4130_FIFO_MODE_WATERMARK = 0b01,
>> +};
>> +
>> +enum ad4130_mode {
>> +       AD4130_MODE_CONTINUOUS = 0b0000,
>> +       AD4130_MODE_IDLE = 0b0100,
>> +};
> 
> 0b?! Hmm... Not that this is bad, just not so usual :-)
> 

I always use 0b to be consistent with the datasheet values which are
represented in binary. I think it makes it easier to not mess up
when initially translating the datasheet into code and later when
cross-checking with the datasheet.

> 
>> +struct ad4130_filter_config {
>> +       enum ad4130_filter_mode         filter_mode;
>> +       unsigned int                    odr_div;
>> +       unsigned int                    fs_max;
>> +       unsigned int                    db3_div;
>> +       enum iio_available_type         samp_freq_avail_type;
>> +       int                             samp_freq_avail_len;
>> +       int                             samp_freq_avail[3][2];
>> +       enum iio_available_type         db3_freq_avail_type;
>> +       int                             db3_freq_avail_len;
>> +       int                             db3_freq_avail[3][2];
> 
> These 3:s can be defined?
>
I could define IIO_AVAIL_RANGE_LEN and IIO_AVAIL_SINGLE_LEN and then
define another IIO_AVAIL_LEN that is the max between the two.
But that's just over-complicating it, really.

> ...
> 
> 
>> +static int ad4130_get_reg_size(struct ad4130_state *st, unsigned int reg,
>> +                              unsigned int *size)
>> +{
> 
>> +       if (reg >= ARRAY_SIZE(ad4130_reg_size))
>> +               return -EINVAL;
> 
> When this condition is true?

When the user tries reading a register from direct_reg_access
that hasn't had its size defined.

> 
>> +       regmap_update_bits(st->regmap, AD4130_REG_IO_CONTROL, mask,
>> +                          value ? mask : 0);
> 
> One line?
> 
> No error check?
> 

I actually can't think of a scenario where this would fail. It doesn't
if the chip is not even connected.

> 
>> +       if (setup_info->enabled_channels)
>> +               return -EINVAL;
> 
> -EBUSY?
> 

Eh, I don't think so. It would be pretty impossible for the code to hit
this if statement, taking into account the ad4130_find_slot() logic.
I could as well not have it at all.

> 
>> +static void ad4130_freq_to_fs(enum ad4130_filter_mode filter_mode,
>> +                             int val, int val2, unsigned int *fs, bool db3)
>> +{
>> +       const struct ad4130_filter_config *filter_config =
>> +               &ad4130_filter_configs[filter_mode];
>> +       unsigned long long dividend, divisor;
>> +       int temp;
>> +
>> +       dividend = filter_config->fs_max * filter_config->odr_div *
>> +                  (val * AD4130_FREQ_FACTOR + val2);
>> +       divisor = AD4130_MAX_ODR * AD4130_FREQ_FACTOR;
>> +
>> +       if (db3) {
>> +               dividend *= AD4130_DB3_FACTOR;
>> +               divisor *= filter_config->db3_div;
>> +       }
>> +
>> +       temp = AD4130_FS_MIN + filter_config->fs_max -
>> +              DIV64_U64_ROUND_CLOSEST(dividend, divisor);
>> +
>> +       if (temp < AD4130_FS_MIN)
>> +               temp = AD4130_FS_MIN;
>> +       else if (temp > filter_config->fs_max)
>> +               temp = filter_config->fs_max;
>> +
>> +       *fs = temp;
> 
> Would be nice to put a comment explaining the math behind this code.
> 
>> +}
>> +
>> +static void ad4130_fs_to_freq(enum ad4130_filter_mode filter_mode,
>> +                             unsigned int fs, int *val, int *val2, bool db3)
>> +{
>> +       const struct ad4130_filter_config *filter_config =
>> +               &ad4130_filter_configs[filter_mode];
>> +       unsigned int dividend, divisor;
>> +       u64 temp;
>> +
>> +       dividend = (filter_config->fs_max - fs + AD4130_FS_MIN) *
>> +                  AD4130_MAX_ODR;
>> +       divisor = filter_config->fs_max * filter_config->odr_div;
>> +
>> +       if (db3) {
>> +               dividend *= filter_config->db3_div;
>> +               divisor *= AD4130_DB3_FACTOR;
>> +       }
>> +
>> +       temp = div_u64(dividend * AD4130_FREQ_FACTOR, divisor);
>> +       *val = div_u64_rem(temp, AD4130_FREQ_FACTOR, val2);
> 
> 
> Ditto.
> 
I'll see what I can come up with.

> 
>> + out:
> 
> out_unlock: ?
> Ditto for similar cases.

There's a single label in the function, and there's a mutex being
taken, and, logically, the mutex must be released on the exit path.
It's clear what the label is for to me.

> 
>> +               *val = st->bipolar ? -(1 << (chan->scan_type.realbits - 1)) : 0;
> 
> Hmm... It seems like specific way to have a sign_extended, or actually
> reduced) mask.
> Can you rewrite it with the (potential)UB-free approach?
> 
> (Note, that if realbits == 32, this will have a lot of fun in
> accordance with C standard.)
> 

Can you elaborate on this? The purpose of this statement is to shift the
results so that, when bipolar configuration is enabled, the raw value is
offset with 1 << (realbits - 1) towards negative.

For the 24bit chips, 0x800000 becomes 0x000000.

Maybe you misread it as left shift on a negative number? The number
is turned negative only after the shift...

> ...
> 
>> +               *vals = (int *)st->scale_tbls[setup_info->ref_sel];
> 
> Can we get rid of casting here and in the similar cases?
> 

I feel like scale_tbls is best defined as an array of two-element
arrays. Because its type is IIO_VAL_FRACTIONAL.
But obviously the IIO framework can't take this case into account by
itself, so we cast it so it receives what it wants.

> 
>> +
>> +       if (val > AD4130_FIFO_SIZE)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Always set watermark to a multiple of the number of enabled channels
>> +        * to avoid making the FIFO unaligned.
>> +        */
>> +       eff = rounddown(val, st->num_enabled_channels);
>> +
>> +       mutex_lock(&st->lock);
>> +
>> +       ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
>> +                                AD4130_WATERMARK_MASK,
>> +                                FIELD_PREP(AD4130_WATERMARK_MASK,
>> +                                           ad4130_watermark_reg_val(eff)));
> 
> Temporary variable for mask?
> 

You mean for value?

> 
>> +static int ad4130_get_ref_voltage(struct ad4130_state *st,
>> +                                 enum ad4130_ref_sel ref_sel,
>> +                                 unsigned int *ref_uv)
>> +{
>> +       struct device *dev = &st->spi->dev;
>> +       int ret;
>> +
>> +       switch (ref_sel) {
>> +       case AD4130_REF_REFIN1:
>> +               ret = regulator_get_voltage(st->regulators[2].consumer);
>> +               break;
>> +       case AD4130_REF_REFIN2:
>> +               ret = regulator_get_voltage(st->regulators[3].consumer);
>> +               break;
>> +       case AD4130_REF_AVDD_AVSS:
>> +               ret = regulator_get_voltage(st->regulators[0].consumer);
>> +               break;
>> +       case AD4130_REF_REFOUT_AVSS:
> 
>> +               if (!st->int_ref_en) {
>> +                       ret = -EINVAL;
>> +                       break;
>> +               }
>> +
>> +               ret = st->int_ref_uv;
>> +               break;
> 
> Can be one if-else instead.
> 
>> +       default:
>> +               ret = -EINVAL;
>> +               break;
>> +       }
>> +
>> +       if (ret <= 0)
> 
> = 0 ?! Can you elaborate, please, this case taking into account below?
> 

I guess I just did it because voltage = 0 doesn't make sense and would
make scale be 0.0.


>> +               return dev_err_probe(dev, ret, "Cannot use reference %u\n",
>> +                                    ref_sel);
>> +
>> +       if (ref_uv)
>> +               *ref_uv = ret;
>> +
>> +       return 0;
>> +}
> 

> 
>> +       fwnode_property_read_u32(child, "adi,excitation-pin-0",
>> +                                &chan_info->iout0);
> 
> No default and/or error check?
> 
> ...
> 
>> +       fwnode_property_read_u32(child, "adi,excitation-pin-1",
>> +                                &chan_info->iout1);
> 
> Ditto.

Default is 0, just like the register defaults.

> 
> ...
> 
>> +static int ad4130_parse_fw_children(struct iio_dev *indio_dev)
>> +{
>> +       struct ad4130_state *st = iio_priv(indio_dev);
>> +       struct device *dev = &st->spi->dev;
>> +       struct fwnode_handle *child;
>> +       int ret;
>> +
>> +       indio_dev->channels = st->chans;
>> +
>> +       device_for_each_child_node(dev, child) {
>> +               ret = ad4130_parse_fw_channel(indio_dev, child);
>> +               if (ret)
>> +                       break;
>> +       }
> 
>> +       fwnode_handle_put(child);
> 
> There is no need to put fwnode if child is NULL. Moreover, the above
> pattern might be percepted wrongly, i.e. one may think that
> fwnode_handle_put() is a must after a loop.
> 

fwnode_handle_put already checks if the child is NULL. Why do the same
check twice?

> 
> Can you explain why regmap locking is needed?
> 

Am I supposed to set .disable_locking = true since SPI has its own
locking?
