Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658A354FBA3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382246AbiFQQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFQQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:54:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D441ED;
        Fri, 17 Jun 2022 09:54:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fu3so9862026ejc.7;
        Fri, 17 Jun 2022 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSt3LrzgFcD+YdW3BwQVvoaLeU41rd1AP4Ip8zTtDqc=;
        b=SlP1pkUKUrW5ybdwtrxH1PpgNTbsnSEHyO8jGuviKkg1OiVuqEhYc/fzM6tIu0c8jS
         ef8b5eL8gQyB/sAOeBzBP9U1zZVKmC+A9FXilfvSplzYQjZgShOAgugldDmEsdZFxHwR
         I8Xog09XyuvpsjgODLpEmCkO3VqPyh3cT+UweZWska4lPh610rBNlu0MELIX0CnjUfwa
         5PvAY1YUPUwR1SgzFdGsFUk1KFKeMbci8ePe8zIKFy61yOLFEwZYZk+0QCxo2bi/lhKj
         B4F6t/HSRzl0EIHWaiCTNcpBfdYYhEPjlvY0am0FM5RW8ehda8NujIx+7KUk6vTqmACM
         IPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSt3LrzgFcD+YdW3BwQVvoaLeU41rd1AP4Ip8zTtDqc=;
        b=X9QiBetDb4FJZgOCmSY8Jy7o91ZD6y8wqM/kOpc7wXbA+gFoA3QwleISH7/BHBEq+j
         xqZCSFz59ibOJhcyhgrougBUsDIAsAvp4PP3SoRx7USNc2/K+Qs8DEsWuQScOLKHbI7b
         lGpCL/gOIMGDauiNsyhJl+IeSceCIY6qwKDyOgf93mKanb+goe97mZuN5i/65BeioCTG
         LNxxD7Lcwn4dnIH+aJZj+PFU/k5c0RcM63UOdZEnwohTYwD+oZN0YoCWlH+n/Ti6o56e
         8vaVWGF1BnbIF9QBP3hhDZp588CG1grZQDUHEUvCYrVbPEayq4q0mjtq6IdauKlY/mMW
         ipSg==
X-Gm-Message-State: AJIora+6pVIbSoZITQgXJYI2KWGykh4rVCUQysB4zrflovT+IxwRR9Hl
        gMQHP85/SNYDFeRTIvV/GBZ7OSShC7H6yxSC3TQ=
X-Google-Smtp-Source: AGRyM1uH3xkkaNRL2YB0jmqdw7nIbIjlvpkg7HbTGzwEtj453kt0upgJuFaIBE0/nZM6zLd+D9/iIszJ3oRrGXwIiGA=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr10144363ejb.639.1655484892267; Fri, 17
 Jun 2022 09:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
 <20220616104211.9257-3-ddrokosov@sberdevices.ru> <CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com>
 <20220616170218.dihjli46spimozeg@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75VdEY9z_0=sAkKOico9JKYPOX6yqnoetiW49oFHm+SeUoQ@mail.gmail.com> <20220617142239.wq43wjdxdc2cq37r@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220617142239.wq43wjdxdc2cq37r@CAB-WSD-L081021.sigma.sbrf.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Jun 2022 18:54:14 +0200
Message-ID: <CAHp75Vfix_cnnyvfv5xsS1_x_PKS2VLDgc6-QA26Pi_U-c21AA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Jun 17, 2022 at 4:22 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> On Thu, Jun 16, 2022 at 08:38:46PM +0200, Andy Shevchenko wrote:
> > On Thu, Jun 16, 2022 at 7:02 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> > > On Thu, Jun 16, 2022 at 02:18:52PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Jun 16, 2022 at 12:42 PM Dmitry Rokosov
> > > > <DDRokosov@sberdevices.ru> wrote:

...

> > > > > +       wait_ms = (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
> > > >
> > > > This looks very odd from a physics perspective: sec * sec * sec == sec ?!
> > > >
> > > > Perhaps you meant some HZ* macros from units.h?
> > >
> > > I suppose because of UHZ calculation I have to use NANO instead of
> > > USEC_PER_SEC in the following line:
> > >
> > >         freq_uhz = msa311_odr_table[odr].val * USEC_PER_SEC +
> > >                    msa311_odr_table[odr].val2;
> > >
> > > But below line is right from physics perspective. 1sec = 1/Hz, so
> > > msec = (USEC_PER_SEC / freq_uhz) * MSEC_PER_SEC:

I believe the first one should be HZ_PER_MHZ, then it will be fine.

> > >         wait_ms = (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
> > >
> > > Or do you mean that I should change MSEC_PER_SEC to just MILLI?
> >
> > 1 / Hz = 1 sec. That's how physics defines it. Try to figure out what
> > you meant by above multiplications / divisions and come up with the
> > best that fits your purposes.
>
> From my point of view, I've already implemented the best way to calculate
> how much time I need to wait for the next data chunk based on ODR Hz
> value :-)
>
> ODR value from the table has val integer part and val2 in microHz.
> By this line we calculate microHz conversion to take into account val2
> part:
>
>     freq_uhz = msa311_odr_table[odr].val * USEC_PER_SEC +
>                msa311_odr_table[odr].val2;
>
> By the next line we try to calculate miliseconds for msleep() from ODR
> microHz value:
>
>     wait_ms = (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
>
> (USEC_PER_SEC / freq_uhz) => seconds

> seconds * MSEC_PER_SEC => milliseconds>

> USEC_PER_SEC and MSEC_PER_SEC are just coefficients, they are not
> measured in "seconds" units.

Nope, it's a mistake. Those multipliers imply the unit. The rest are
the numbers. See above how to fix this (as far as I can tell).

...

> > > > > +                       if (err) {
> > > > > +                               dev_err(dev, "cannot update freq (%d)\n", err);
> > > > > +                               goto failed;
> > > > > +                       }
> > > >
> > > > Why is this inside the loop and more important under lock? Also you
> > > > may cover the initial error code by this message when moving it out of
> > > > the loop and lock.
> > > >
> > > > Ditto for other code snippets in other function(s) where applicable.
> > >
> > > Yes, I can move dev_err() outside of loop. But all ODR search loop
> > > should be under lock fully, because other msa311 operations should not
> > > be executed when we search proper ODR place.
> >
> > I didn't suggest getting rid of the lock.

> Sorry, I didn't get you... But I fully agree with you about dev_err()
> movement.

Yes, that's what I'm talking about. The dev_err() should be outside of
critical section, for example:

  mutex_unlock();
  if (ret) {
    dev_err(...);
    return ret;
  }
  ...
  return 0;

-- 
With Best Regards,
Andy Shevchenko
