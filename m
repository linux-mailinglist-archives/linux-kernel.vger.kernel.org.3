Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5B55ABEDC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 14:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiICMGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 08:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiICMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 08:06:17 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20867434B
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 05:06:14 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so11129294fac.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uy6b604W6fPaKBQUMKEMdXcHLnIEaX4Dt4TqfHX1c5o=;
        b=Xg6epoTbQ6LvJIss0GUUMax4qm/ljJ+FA8Bb6m0daylOP6wi6huZxYeNDIJ0MHRW8a
         Vhknw3kpS37z11USHL5oknH8I5Y6e5xefbrDTm9NNd0vOp80YyrXrzoVXEIh3eM1LLP1
         LSSz06ugyyiAuQgUOwXFa+SmLv6HxVtriZ3hxZQ3ftTEItwjLx7aE5S7BZkoJi1Qsxvc
         o5Zv8tkfi3CNMfjzpuFHHWiLU6xkoL/cHIxy9aoj5X7ftruD55jyN0WJwo7U1YPMvgpQ
         x8/pIdBFZoWiCdSXrozLRFWufg7H2kkQDqPPze2lhizyrYMdnpcxIo2XWj/CdZ0z+4ha
         TBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uy6b604W6fPaKBQUMKEMdXcHLnIEaX4Dt4TqfHX1c5o=;
        b=dcgkgI+eN4huXGV9ldYcIqgUrf1ViOVo7j5wPxVW1jlOBvRqwH9NsYAEwVXpAL0Zpi
         fUp7Q61VhxWUEQd4GAgEYQFdA4y02gqRgndjvFmpyS/nXtSg/IJEFmR5jhl+USVViySm
         HKKSWFJ/XEUhDMWp0Yju/EacHdWeP9cBSzfL6YYZLyGuezTqud0O0dv9OzpgOpS+Ibxg
         opFTgD4c9ilkwXNeNugHc+FC+/EcxiVyYoSxQVJ0eeEIbUwKHzOdD1Htn1q48nHgRgYn
         A+wa+WzUuh7NVMMkPFDjFQmAzVMeu2+5vwXS4rkUFfZd/vphwoZdxN4eZSJ7u8acTYr3
         2YzQ==
X-Gm-Message-State: ACgBeo08MaslTZGjkZtsPzjYBAF13qh1a9fYH66O23qz2St4+unnis3s
        xn5IUAzhzh0uF/28ANoiN7BDvdEZGTg8BU7cDrwYqw==
X-Google-Smtp-Source: AA6agR4bm7j3g8DW0HLMGctDD4s5gdb3iwsUqNW1GTNBe0naylGwNiOVUtNtINzwcvenxERaHlGBtsxMZgguG3a3EAg=
X-Received: by 2002:a05:6808:21a6:b0:344:beb5:1fb1 with SMTP id
 be38-20020a05680821a600b00344beb51fb1mr3756947oib.175.1662206774175; Sat, 03
 Sep 2022 05:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220902131258.3316367-1-cmo@melexis.com> <CAHp75VdOHDHUVhVXj4L-6ZV25mTWTeO3s3EJQVgLxknXHKRUMg@mail.gmail.com>
 <CAKv63ut0rtTFh3XdF3oR6fxQSLzNkFRS+HPPOY8Xp4LX0OY4Tg@mail.gmail.com> <CAHp75VfJMpf3GeOryt9cH6-tK48BB8ZcfuGxhXovObBanDcc7w@mail.gmail.com>
In-Reply-To: <CAHp75VfJMpf3GeOryt9cH6-tK48BB8ZcfuGxhXovObBanDcc7w@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Sat, 3 Sep 2022 14:05:38 +0200
Message-ID: <CAKv63us6OLg8ahdbKvd8c4x9-Ri4aDwNvgc_oov7wZnSBmJGVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sept 2022 at 20:39, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Fri, Sep 2, 2022 at 8:59 PM Crt Mori <cmo@melexis.com> wrote:
> > On Fri, 2 Sept 2022 at 17:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Sep 2, 2022 at 4:13 PM <cmo@melexis.com> wrote:
> > > > +       if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> > > > +               return mlx90632_pwr_set_sleep_step(data->regmap);
> > >
> > > > +       else
> > >
> > > Redundant.
> > >
> > No, the powermode changes among the type.
>
> Yes. 'else' keyword is always redundant in the
>
>   if (...)
>     return / break / continue / goto
>   else
>
> cases.
>
In this case current power mode of the sensor is halt, so the else is
needed to set it to continuous mode, which means I can't just remove
the else here because this statement restores the power mode before
this function was entered (and changed powermode for the setup).

> > > > +               return mlx90632_pwr_continuous(data->regmap);
>
> ...
>
> > > > +static int __maybe_unused mlx90632_pm_runtime_suspend(struct device *dev)
> > >
> > > No __maybe_unused, use pm_ptr() / pm_sleep_ptr() below.
> > >
> > Care to explain a bit more about this? I just followed what other
> > drivers have...
>
> And other drivers have what I said, but it's a new feature.
> If you run `git log --no-merges --grep 'pm_ptr' -- drivers/iio
> include/linux/` and read the history it will explain the case.
>
Thanks for the hint.
