Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2C5AB867
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIBSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIBSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:39:01 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED37883E2;
        Fri,  2 Sep 2022 11:39:00 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x5so2138843qtv.9;
        Fri, 02 Sep 2022 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=f8Lo6s5cYCeKgTcqKpSELWdXg3AuzkYKun3u5MU/k/U=;
        b=hMWa7AByuX/kCqdyvO9V43nK37LvjnBUeACqhKSmH04hU45/R7SSRy5uBsXpx9Idl9
         xsQjRaeW45WFt2yLXqAz8zqwUo3JkXsqPB9/0v208+Ov+z6Yf3xT29hvX2U3+6nYs/0S
         P4BWtWjfm9CMLumm9DeZiN6wxE5YZJbLkeQffwP0XzxHQxe/NMQ0Wo6ADacvXwk4G4kG
         O60K7M+Fe6P3dWUH3jImmAUacgumi0qnCVRi9LVT9meQyCB2ktdt2QtWOb3I+iFNgP2f
         JZZmXlx1RjQcX5LjSSAa5YvhBUyhUrhm9AOZ3TvYmTHNsUkG15EnL13daG7laPjEwkcj
         uTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=f8Lo6s5cYCeKgTcqKpSELWdXg3AuzkYKun3u5MU/k/U=;
        b=s1p9T45EzZ7zzL9OHLRxjwXTvxL+AEhf6uLCFMYjP7sO74C3OhGjgSDanaLLYGSt7B
         otBpxtut7GMLMJ+j/RFQA3bZM1QQ1/NsAhb9m76NujxvrJetRh91DRp1noxHBv2+aUM3
         zn9LhgSBIM6RF9dVG/L5FELEaNI75piDh2Ytt2nznUVtFt1vtUbUFWtlh2SBWrSsbxO4
         MRuiRHvuhz4cWH4xE9UVlqDnun8D1KmmqNrAgCGTS5Qfh4CpObuLhjZ3N+BhGykS9Ffo
         rpEdzszg7K+eTVgG90+R68Tti9B8m4ZsHHu1vp9oaYtWlmKwFBs7c1GYQo9RMepnt2Z7
         9PqQ==
X-Gm-Message-State: ACgBeo21eFt8rSQuJWjAfeapNfSrGr3nACUAJVGsnaKMD5/gi7ETJ7uZ
        C2FLXqHNSFjejJGlTHbrgzarfrj0GpWeQBeinUaeWTA2nfY=
X-Google-Smtp-Source: AA6agR6B8SJbUaGsNAIZi3LkSflXhd2O/YwCNpTvRUUD2ELXsv6+x0S5QlJ78ehztCME2jTJ/WxrpkPUxQY6Le3O3EE=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr29248087qta.429.1662143939459; Fri, 02
 Sep 2022 11:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220902131258.3316367-1-cmo@melexis.com> <CAHp75VdOHDHUVhVXj4L-6ZV25mTWTeO3s3EJQVgLxknXHKRUMg@mail.gmail.com>
 <CAKv63ut0rtTFh3XdF3oR6fxQSLzNkFRS+HPPOY8Xp4LX0OY4Tg@mail.gmail.com>
In-Reply-To: <CAKv63ut0rtTFh3XdF3oR6fxQSLzNkFRS+HPPOY8Xp4LX0OY4Tg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 21:38:23 +0300
Message-ID: <CAHp75VfJMpf3GeOryt9cH6-tK48BB8ZcfuGxhXovObBanDcc7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Sep 2, 2022 at 8:59 PM Crt Mori <cmo@melexis.com> wrote:
> On Fri, 2 Sept 2022 at 17:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Sep 2, 2022 at 4:13 PM <cmo@melexis.com> wrote:

For future replies, please remove unnecessary context when replying
(I'm wasting my time for that)!

...

> > > +static int mlx90632_wakeup(struct mlx90632_data *data);
> >
> > Can we avoid forward declaration? (I don't even see how it is used
> > among dozens of lines of below code in the patch)
> >
> This is existing function that I did not want to move upwards. Should
> I have just moved it rather?

Yes, move it in the preparatory (separate) patch.

...

> > > +       s32 ret = 0;
> >
> > Assignment is not needed, use 'return 0;' directly. Ditto for all
> > cases like this.
> >
> This is used, because when powerstatus is not equal to sleep_step it
> returns, otherwise the ret is changed in the function.

Please, read what I have suggested.

> > > +       if (data->powerstatus != MLX90632_PWR_STATUS_SLEEP_STEP) {
> > > +               ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> > > +                                       MLX90632_CFG_PWR_MASK,
> > > +                                       MLX90632_PWR_STATUS_SLEEP_STEP);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +
> > > +               data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
> > > +       }
> > > +       return ret;

For your convenience...

    return 0;

...here.

Or do you state that ret can be a positive number? In such cases,
elaboration is required.

...

> > > +       reg = MLX90632_EE_RR(reg) >> 8;
> >
> > This makes it harder to understand the semantics of reg, can we simply
> > unite this line with the below?
> >
> I find it easier to have it split but I can make one long statement.
> > > +       return MLX90632_MEAS_MAX_TIME >> reg;

If so, you need another variable with better naming to show what is in it.

...

> > > +       ret = regmap_read_poll_timeout(data->regmap, MLX90632_REG_STATUS,
> > > +                                      reg_status,
> > > +                                      ((reg_status & MLX90632_STAT_BUSY) == 0),
> >
> > Too many parentheses
> >
> I like the outer parentheses it shows that it is a break condition. I
> have same in another function in this file.

It's not a Lisp, we don't need to pollute code with unneeded obstacles.

> > > +                                      10000, 100 * 10000);

...

> > > +       if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> > > +               return mlx90632_pwr_set_sleep_step(data->regmap);
> >
> > > +       else
> >
> > Redundant.
> >
> No, the powermode changes among the type.

Yes. 'else' keyword is always redundant in the

  if (...)
    return / break / continue / goto
  else

cases.

> > > +               return mlx90632_pwr_continuous(data->regmap);

...

> > > +static int __maybe_unused mlx90632_pm_runtime_suspend(struct device *dev)
> >
> > No __maybe_unused, use pm_ptr() / pm_sleep_ptr() below.
> >
> Care to explain a bit more about this? I just followed what other
> drivers have...

And other drivers have what I said, but it's a new feature.
If you run `git log --no-merges --grep 'pm_ptr' -- drivers/iio
include/linux/` and read the history it will explain the case.

-- 
With Best Regards,
Andy Shevchenko
