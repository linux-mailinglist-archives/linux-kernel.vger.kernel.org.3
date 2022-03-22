Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7279B4E43FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiCVQP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbiCVQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:15:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A049279;
        Tue, 22 Mar 2022 09:13:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id u26so6690199eda.12;
        Tue, 22 Mar 2022 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZKPhR1x70y/sZDg5/4BqekgJgvTkjVvk6iAX32GL9k=;
        b=B6TELdrmvjikGo24OrZmJz/BJ4+3h7GvlZHPC2IEw8zvBaSNDQd/8nGojRPcLmbCak
         V4Ya+AnOxvZxL3dGDlt9stuyC9xHu7hkbJVLh8//B98iXJ76sLv6TPoulQlLPUja9vqv
         DFODWRlhPzGPk10pQDnX1Xj3Ej18QbxsxuFzzUuSFo20jeOkXT4ELhmGE2gK+2km3JSy
         RgHM+LPg7pzDjz1AiTWCfN32rr6McMSvPzxmBg9XzDU2N2QYoA+IOwKCBcCdXPzwkiDe
         tXRMv+PM4QnLC/utUK0aZS+1W3+iIH1QEJgz3xYmv9ySlHomP2Kdw96JYgQ8s7hqIAx7
         ypuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZKPhR1x70y/sZDg5/4BqekgJgvTkjVvk6iAX32GL9k=;
        b=px7ZsCsHyI2sbdJiv/ciz74oFS5E7SzYrI7SPaSy24ArSxztLslOl6B5qLv5Mbkmd1
         Q/HaH0NrZUV+cPyzlKwzV/4oqbKHUDD5HP7mbj/AvfkZdLx7O4L76+3HbGJiDAME3VHP
         i70V/nUstifnekf9bhRRmXkiBOIf4N/RMcpmNgUoOQwzAoKe0pmFOszV2R2D5SbB9sxJ
         e/d5bcIaQL5eJafj5atk+tZJHzMTEEX/Ir/Dit0EwbgU6PoZW0LDSomYvu9SD9KyqJTf
         tnYZcpns9dIZ0AsYtY/JpZHNuGCXdPaZgyIrhVLp0arK2Fcd70O2OM19w8RC/3N6Mhkx
         THSA==
X-Gm-Message-State: AOAM531Mol6ttW/hNdQ8PfOg0IszBSG8K6Bzf/1FmRnTxKgl6fIUT+fB
        8o6c572TXrpEoUHuauwYlFeLYGgiaTZvGYfnKac=
X-Google-Smtp-Source: ABdhPJzGF8dAH06zGlD0GD/PCXiN0fW7d5ibzEvsdSo2lrMJMUCLIl+Cr2ock3tpP0/kkd58YRs1CMpLSa+Q21P+EFk=
X-Received: by 2002:aa7:d390:0:b0:416:16ad:2483 with SMTP id
 x16-20020aa7d390000000b0041616ad2483mr30316315edq.122.1647965636470; Tue, 22
 Mar 2022 09:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
 <20220319181023.8090-4-jagathjog1996@gmail.com> <CAHp75VdB5q+Y2R46OO-kCKCkPY58YzyLNjN3PjJiQhTOgV4n2w@mail.gmail.com>
 <20220321222117.GD10058@jagath-PC> <CAHp75Vdp12bm+CHWun36b36Sui73zh0_wtY5YhEqVdNy4rUxVA@mail.gmail.com>
 <20220322154047.GA3677@jagath-PC>
In-Reply-To: <20220322154047.GA3677@jagath-PC>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Mar 2022 18:12:46 +0200
Message-ID: <CAHp75VfVzunDL3yTvzDvSPagjRBUCywtr0j82Bk-1atw6EwnmQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] iio: accel: bma400: Add triggered buffer support
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Tue, Mar 22, 2022 at 5:40 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> On Tue, Mar 22, 2022 at 10:54:53AM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 22, 2022 at 12:21 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > > On Mon, Mar 21, 2022 at 10:39:22AM +0200, Andy Shevchenko wrote:
> > > > On Sat, Mar 19, 2022 at 8:10 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:

...

> > > > A useless label. Moreover this raises a question: why is it okay to
> > > > always mark IRQ as handled?
> > > >
> > > > > +       return IRQ_HANDLED;
> > >
> > > Since I was not using top-half of the interrupt so I marked IRQ as handled
> > > even for error case in the handler.
> >
> > Yes, but why? Isn't it an erroneous state? Does it mean spurious
> > interrupt? Does it mean interrupt is unserviced?
>
> Sorry, even for erroneous state I was returning IRQ_HANDLED.
> As shown below, now for erroneous state and spurious interrupt I will return
> IRQ_NONE and for valid interrupt IRQ_HANDLED will be returned.
>
> Is below method is correct?

The thing is that I don't know. I am not familiar with this hardware.
So, you have to investigate and decide.

> static irqreturn_t bma400_interrupt(int irq, void *private)
> {
>        struct iio_dev *indio_dev = private;
>        struct bma400_data *data = iio_priv(indio_dev);
>        int ret;
>        __le16 status;
>
>        mutex_lock(&data->mutex);
>        ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
>                               sizeof(status));
>        mutex_unlock(&data->mutex);
>        if (ret)
>                return IRQ_NONE;

>        if (le16_to_cpu(status) & BMA400_INT_DRDY_MSK) {
>                iio_trigger_poll_chained(data->trig);
>                return IRQ_HANDLED;
>         }
>
>         return IRQ_NONE;

If you are going with this approach, try to handle errors first, i.e.

    if (...)
        return IRQ_NONE;
    ...
    return IRQ_HANDLED;

> }

-- 
With Best Regards,
Andy Shevchenko
