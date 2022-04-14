Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644A3501684
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiDNPA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346237AbiDNN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:56:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E0B0A70;
        Thu, 14 Apr 2022 06:46:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 21so6471091edv.1;
        Thu, 14 Apr 2022 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8971MOMZxe8ny/GbZyrl9W3T/ga8R+8j2kZQrMH59YY=;
        b=VYSEPCPdidBLauO5Wo9kny4AC5GPOq1kV3qgrR05UiNdJNZFy+Ly+Fs/4ODbYQUYo9
         ZzGWKaahTO52NP+gta5HFse3u7r3MW4BHh/BhVbu7i6S8G00b1aNXFQ6L7v709h4yREW
         Rzff2SHB0AxSg3thExjDZ6dd5V84600P/3wwxUGi4voiqd1/ndHuCQ9DNWZHRxm9g3r4
         +bLjBb18OS3VGGZ1U6fBqH9e/EEyNdMt9n3iwCV865VJbLm6qmFWMG1sx/FcFG5JpJkY
         UzFmTYV4DLMSVsBu4iLkvAADMQlS6tFm0kogL67zc36zWwlfBU+8+KbvD5M86vL1nR4+
         xVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8971MOMZxe8ny/GbZyrl9W3T/ga8R+8j2kZQrMH59YY=;
        b=Wx6k4njRos4DGfy4qn+knjborJKyLsn0PlvzTaImO6Nt/3zUMFLq6sJoTKmkXF/ijG
         Lbk9cYHocBsHQbP6BY+nQYFtVPrDZpO+Lhcb7guDKwO3gvbBa3kQoqv6WuVB9m/wTP9H
         xclWsMozelBvm9Vu4zZTqBRyHVm/QFu73SJo8FlP89K3anCKia6/iSRkoHRhyGwXTwMX
         yEqgnpIdx6lOEPPYsxaYLGih5+gMgOnWQWUrSO3SfPFMt/tRzBaZw3eNT7L19aCC7otu
         K6k5YzsR3Z1ZyNKEHdJAUaYBsEBK6su6YThR1KJigmRJZJtMeklE/wh5yov89LtcQv7q
         J6rw==
X-Gm-Message-State: AOAM5315iPnjwtbfzgIKXpTg4wfDxfveGEPZwhYG+H9/ll7dV6YwH+fF
        2ZNLiRNoL+6S9XRLzDN1sWsVvzNlI4uTx3bOGXw=
X-Google-Smtp-Source: ABdhPJylfPV678F4xdZmfc1hw6sU/WM4TROFlt3eNeAuggaOYOkrMV1UHEQRqSaCKp+O/eP8yn/eeOKXd7ddj+14m3U=
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id
 c17-20020a05640227d100b004191b024a04mr3037825ede.218.1649943971848; Thu, 14
 Apr 2022 06:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
 <20220413094011.185269-3-cosmin.tanislav@analog.com> <CAHp75VfzX8u45J3634yN5p-QTeT7w0Bos27OxeWOsb3MQ2VRVw@mail.gmail.com>
 <80196942-4c33-7625-3945-86ce5b7b347f@gmail.com>
In-Reply-To: <80196942-4c33-7625-3945-86ce5b7b347f@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Apr 2022 16:45:35 +0300
Message-ID: <CAHp75VfAjvJz2KHYfDM+-8D+hSBtdKJm521EBY3VgCfUsAgt8Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] iio: adc: ad4130: add AD4130 driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 2:06 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> On 4/13/22 18:41, Andy Shevchenko wrote:
> > On Wed, Apr 13, 2022 at 1:41 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:

...

> >> +#define AD4130_8_NAME                  "ad4130-8"
> >
> > What the meaning of -8 ? Is it number of channels? Or is it part of
> > the official model (part number)? Can we see, btw, Datasheet: tag with
> > a corresponding link in the commit message?
>
> That's just the name specified in the datasheet. I honestly don't have
> much of an idea about why it is like that. Also, I already put the
> datasheet in the .yaml documentation.

That's cool!

> Do you really also want it
> in each commit message too?

No, just in this one.

...

> >> +#define AD4130_RESET_CLK_COUNT         64
> >> +#define AD4130_RESET_BUF_SIZE          (AD4130_RESET_CLK_COUNT / 8)
> >
> > To be more precise shouldn't the above need to have DIV_ROUND_UP() ?
>
> Does it look like 64 / 8 needs any rounding?

Currently no, but if someone puts 63 there or 65, what would be the outcome?
OTOH, you may add a static assert to guarantee that CLK_COUNT is multiple of 8.

...

> >> +#define AD4130_FREQ_FACTOR             1000000000ull
> >> +#define AD4130_DB3_FACTOR              1000
> >
> > Ditto.
>
> AD4130_DB3_FACTOR is unit-less. In the datasheet, the relation between
> sampling frequency and 3db frequency is represented as a 0.xyz value,
> hence why the db3_div values and 1000 factor.

But does the above mean MILLI or KILO? Similar for the FREQ factor.

...

> >> +       int                             samp_freq_avail_len;
> >> +       int                             samp_freq_avail[3][2];

> >> +       int                             db3_freq_avail_len;
> >> +       int                             db3_freq_avail[3][2];
> >
> > These 3:s can be defined?
> >
> I could define IIO_AVAIL_RANGE_LEN and IIO_AVAIL_SINGLE_LEN and then
> define another IIO_AVAIL_LEN that is the max between the two.
> But that's just over-complicating it, really.

I was talking only about 3:s (out array). IIRC I saw 3 hard coded in
the driver, but not sure if its meaning is the same. Might be still
good to define.

...

> >> +       if (reg >= ARRAY_SIZE(ad4130_reg_size))
> >> +               return -EINVAL;
> >
> > When this condition is true?
>
> When the user tries reading a register from direct_reg_access
> that hasn't had its size defined.

But how is it possible? Is the reg parameter taken directly from the user?

...

> >> +       regmap_update_bits(st->regmap, AD4130_REG_IO_CONTROL, mask,
> >> +                          value ? mask : 0);
> >
> > One line?
> >
> > No error check?
>
> I actually can't think of a scenario where this would fail. It doesn't
> if the chip is not even connected.

Why to check errors in many other cases then? Be consistent one way or
the other.

...

> >> +       if (setup_info->enabled_channels)
> >> +               return -EINVAL;
> >
> > -EBUSY?
> >
>
> Eh, I don't think so. It would be pretty impossible for the code to hit
> this if statement, taking into account the ad4130_find_slot() logic.
> I could as well not have it at all.

If it's a dead code, we do not want it.

...

> >> + out:
> >
> > out_unlock: ?
> > Ditto for similar cases.
>
> There's a single label in the function, and there's a mutex being
> taken, and, logically, the mutex must be released on the exit path.
> It's clear what the label is for to me.

Wasn't clear to me until I went to the end of each of them (who
guarantees that's the case for all of them?).

...

> >> +               *val = st->bipolar ? -(1 << (chan->scan_type.realbits - 1)) : 0;
> >
> > Hmm... It seems like specific way to have a sign_extended, or actually
> > reduced) mask.
> > Can you rewrite it with the (potential)UB-free approach?
> >
> > (Note, that if realbits == 32, this will have a lot of fun in
> > accordance with C standard.)
>
> Can you elaborate on this? The purpose of this statement is to shift the
> results so that, when bipolar configuration is enabled, the raw value is
> offset with 1 << (realbits - 1) towards negative.
>
> For the 24bit chips, 0x800000 becomes 0x000000.
>
> Maybe you misread it as left shift on a negative number? The number
> is turned negative only after the shift...

1 << 31 is UB in accordance with the C standard.

And the magic above seems to me the opposite to what sign_extend()
does. Maybe even providing a general function for sign_comact() or so
(you name it) would be also nice to have.

...

> >> +       ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
> >> +                                AD4130_WATERMARK_MASK,
> >> +                                FIELD_PREP(AD4130_WATERMARK_MASK,
> >> +                                           ad4130_watermark_reg_val(eff)));
> >
> > Temporary variable for mask?
>
> You mean for value?

      mask = AD4130_WATERMARK_MASK;

      ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
                               mask, FIELD_PREP(mask,
ad4130_watermark_reg_val(eff)));

...

> >> +       if (ret <= 0)
> >
> > = 0 ?! Can you elaborate, please, this case taking into account below?
> >
>
> I guess I just did it because voltage = 0 doesn't make sense and would
> make scale be 0.0.

Again, what's the meaning of having it in the conjunction with
dev_err_probe() call?

> >> +               return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> >> +                                    ref_sel);

It's confusing. I believe you need two different messages if you want
to handle the 0 case.

...

> >> +static int ad4130_parse_fw_children(struct iio_dev *indio_dev)
> >> +{
> >> +       struct ad4130_state *st = iio_priv(indio_dev);
> >> +       struct device *dev = &st->spi->dev;
> >> +       struct fwnode_handle *child;
> >> +       int ret;
> >> +
> >> +       indio_dev->channels = st->chans;
> >> +
> >> +       device_for_each_child_node(dev, child) {
> >> +               ret = ad4130_parse_fw_channel(indio_dev, child);
> >> +               if (ret)
> >> +                       break;
> >> +       }
> >
> >> +       fwnode_handle_put(child);
> >
> > There is no need to put fwnode if child is NULL. Moreover, the above
> > pattern might be percepted wrongly, i.e. one may think that
> > fwnode_handle_put() is a must after a loop.
> >
>
> fwnode_handle_put already checks if the child is NULL. Why do the same
> check twice?

Exactly my point. Why do you check it twice?

...

> > Can you explain why regmap locking is needed?

> Am I supposed to set .disable_locking = true since SPI has its own
> locking?

You tell me. I have no idea of what the locking schema is being used
in your code.

-- 
With Best Regards,
Andy Shevchenko
