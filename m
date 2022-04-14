Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E961550183A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbiDNQG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349699AbiDNP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:57:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BAA1117;
        Thu, 14 Apr 2022 08:38:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bh17so10795042ejb.8;
        Thu, 14 Apr 2022 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+m5adT567zqprh7f9s0omABbCf6PKSkE6Ew93ecezw=;
        b=Ot4sc8uBEOGt8+xaWCm0Xn/ZpKN3HmP631Z3qflhTmHESnuTckWj/XO7eE/qldpjTC
         hJ1gabD9scQlLSsN0y3ArbrWU5ippRVsiOjcktG9Y7hUJqJMl1G4k6gRCYIoqDfZ1/qP
         T62EU7q6UvlPtFaUqjvxU2RHjoXdexqUEYyaJIDgDBxyEJb+V5cHaf+KIP9HYuBcy6Ff
         L9c9r4hzUvAgkp6bhD4O5sQawv/odGs4tEWj65PoPhnMW7uiG3XyKbCZMWW3hjHbC3cs
         ObNRnD5GZmEQ81Mg59BFAUud0NVMtEVfxs+jv4s6KZJksac2/OhQFjK2wfDOQrPg7vg1
         T4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+m5adT567zqprh7f9s0omABbCf6PKSkE6Ew93ecezw=;
        b=uySmtZjnangnz9Z8eEGyAuq0PHbjlKeBFQckPjO/A95oEXC3UDBw1D6EGMCrbYHdfh
         m11UaWUGYYYR4uY2GozilRd+wiK0oNBDFxkHF75pCFuGDkfp3Q92LIF/DMxUGwll91zF
         rMs/kKzF5xQRKWyiaLwUIeJ6XIt7ITLl8CT3KCahd7m+ucZ80jsg0+ExA8/YbYnqlwoG
         Um1gUwgEupNC2H/ZFhcBFSEcF8vYoc+ThtfMujLrtzJavauWqhcjkzZk17jAKUBBgtGw
         G//p3/oexwOmwUoOUIA/6MqiASYfNYqgZgVtj+p9oKYyNU9gb4NyvDRlZ1YOXabXonPE
         phtA==
X-Gm-Message-State: AOAM531p7O+VHNGGfU7ODiKfTvxGt80V7FlGKLmT0sP4+4CC2sHwdviS
        3TU0BjJSJ5K5JgA+1ZUDWsdtPolPjeAKRAzQUlI=
X-Google-Smtp-Source: ABdhPJyexSq+meEI+mCST7Vrc1i8ZOw2okSBPE0svB7hPOBvbw6tRUtryZGGUcnCMy+Xx/I1IyUpm5OpuuQ5tiZ1uhw=
X-Received: by 2002:a17:906:1692:b0:6e8:d245:44a9 with SMTP id
 s18-20020a170906169200b006e8d24544a9mr2827768ejd.639.1649950713929; Thu, 14
 Apr 2022 08:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
 <20220413094011.185269-3-cosmin.tanislav@analog.com> <CAHp75VfzX8u45J3634yN5p-QTeT7w0Bos27OxeWOsb3MQ2VRVw@mail.gmail.com>
 <80196942-4c33-7625-3945-86ce5b7b347f@gmail.com> <CAHp75VfAjvJz2KHYfDM+-8D+hSBtdKJm521EBY3VgCfUsAgt8Q@mail.gmail.com>
 <0823cf19-60b5-3050-0e26-04b87a7ce5c0@gmail.com>
In-Reply-To: <0823cf19-60b5-3050-0e26-04b87a7ce5c0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Apr 2022 18:37:57 +0300
Message-ID: <CAHp75VeYX_ZWZPEUwpfaSGUGCayCaMapS-5MHhgT1r17Fqqoeg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 5:53 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> On 4/14/22 16:45, Andy Shevchenko wrote:
> > On Thu, Apr 14, 2022 at 2:06 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >> On 4/13/22 18:41, Andy Shevchenko wrote:
> >>> On Wed, Apr 13, 2022 at 1:41 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:

...

> >>>> +#define AD4130_RESET_CLK_COUNT         64
> >>>> +#define AD4130_RESET_BUF_SIZE          (AD4130_RESET_CLK_COUNT / 8)
> >>>
> >>> To be more precise shouldn't the above need to have DIV_ROUND_UP() ?
> >>
> >> Does it look like 64 / 8 needs any rounding?
> >
> > Currently no, but if someone puts 63 there or 65, what would be the outcome?
> > OTOH, you may add a static assert to guarantee that CLK_COUNT is multiple of 8.
> >
>
> No one will. 64 is defined in the datasheet and will never change. I'm
> not gonna do anything about it. Actually, I can do something about it.
> Remove AD4130_RESET_CLK_COUNT and only define AD4130_RESET_BUF_SIZE as
> 8.

It would be better, indeed. And to whom it may concern you may add a
comment explaining how 8 is derived.

...

> >>>> +       if (reg >= ARRAY_SIZE(ad4130_reg_size))
> >>>> +               return -EINVAL;
> >>>
> >>> When this condition is true?
> >>
> >> When the user tries reading a register from direct_reg_access
> >> that hasn't had its size defined.
> >
> > But how is it possible? Is the reg parameter taken directly from the user?
> >
>
> Users can write whatever they want to direct_reg_access. Unless I add
> max_register to the regmap_config, the register that the user selects
> will just be passed to our reg_read and reg_write callbacks.
>
> Then it will be checked against the register size table.

Thanks, I got it.

...

> >>>> + out:
> >>>
> >>> out_unlock: ?
> >>> Ditto for similar cases.
> >>
> >> There's a single label in the function, and there's a mutex being
> >> taken, and, logically, the mutex must be released on the exit path.
> >> It's clear what the label is for to me.
> >
> > Wasn't clear to me until I went to the end of each of them (who
> > guarantees that's the case for all of them?).
>
> Let's hope other people looking at that code will be able to figure out
> what that label does then.

OK. Let the maintainer decide.

...

> >>>> +               *val = st->bipolar ? -(1 << (chan->scan_type.realbits - 1)) : 0;
> >>>
> >>> Hmm... It seems like specific way to have a sign_extended, or actually
> >>> reduced) mask.
> >>> Can you rewrite it with the (potential)UB-free approach?
> >>>
> >>> (Note, that if realbits == 32, this will have a lot of fun in
> >>> accordance with C standard.)
> >>
> >> Can you elaborate on this? The purpose of this statement is to shift the
> >> results so that, when bipolar configuration is enabled, the raw value is
> >> offset with 1 << (realbits - 1) towards negative.
> >>
> >> For the 24bit chips, 0x800000 becomes 0x000000.
> >>
> >> Maybe you misread it as left shift on a negative number? The number
> >> is turned negative only after the shift...
> >
> > 1 << 31 is UB in accordance with the C standard.
> >
> > And the magic above seems to me the opposite to what sign_extend()
> > does. Maybe even providing a general function for sign_comact() or so
> > (you name it) would be also nice to have.
>
> I'm not trying to comact (I guess you meant compact) the sign of any
> value. Please try to understand what is written in there. It's not
> magic. If the chip is 24bit, and it's set up as bipolar, the raw value
> must be offset by -0x800000, to account for 0x800000 being the
> zero-scale value. For 16 bits, it's 0x8000.

Yes, you shift zero offset to some value. I see that in several
drivers, so I think it would be nice to have a macro for that
somewhere in math.h. But it can be done later on.

...

> >>>> +       ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
> >>>> +                                AD4130_WATERMARK_MASK,
> >>>> +                                FIELD_PREP(AD4130_WATERMARK_MASK,
> >>>> +                                           ad4130_watermark_reg_val(eff)));
> >>>
> >>> Temporary variable for mask?
> >>
> >> You mean for value?
> >
> >        mask = AD4130_WATERMARK_MASK;
> >
> >        ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
> >                                 mask, FIELD_PREP(mask,
> > ad4130_watermark_reg_val(eff)));
>
> Please bother reading the macro definition next-time. The mask argument
> to FIELD_PREP must be a compile-time constant.

Yes, it needs to be u32_encode_bits(), but in any case it's up to you,
it's not anyhow a critical change.

...

> >>>> +       if (ret <= 0)
> >>>
> >>> = 0 ?! Can you elaborate, please, this case taking into account below?
> >>>
> >>
> >> I guess I just did it because voltage = 0 doesn't make sense and would
> >> make scale be 0.0.
> >
> > Again, what's the meaning of having it in the conjunction with
> > dev_err_probe() call?
> >
> >>>> +               return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> >>>> +                                    ref_sel);
> >
> > It's confusing. I believe you need two different messages if you want
> > to handle the 0 case.
>
> Why would I? The chip can't possibly use regulators with a voltage of 0,
> right? Or dummy regulators, since these return negative. I think it's
> fine as it is.

Confusing part is what dev_err_probe() prints here when ret == 0.


--
With Best Regards,
Andy Shevchenko
