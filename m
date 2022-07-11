Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC07457057A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiGKOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGKOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:23:15 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC732EDF;
        Mon, 11 Jul 2022 07:23:14 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c9b70c382so50534607b3.6;
        Mon, 11 Jul 2022 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f193NtTpTpydXyi+JhLs+H7/IffFTZ75c2ZMxvJdUk8=;
        b=R3QQxSi778PbDji+j6k2GI2PCd/Y+DzSUv+/DXwwkHp4+EbuKTjMLLJm+xSE7kPmQn
         SkNieU73l5Y4R6jxJdgYqURcj5uG8slaZq71mU3SEpMDPqPfrD7Y/le5Me9GB9A9v/n4
         G2HXPWRhJsTbfGV5dH2szryeSJuIOhPRsWCBR8LbEgauRAARDHMuCubVVW5E9yp4aswe
         P6FVU9mJ3Pyboh/JKZVoudT037Nf/QbkM/KLcohTqdj96SH04sWW7U8XZX4KepPGX0d4
         tvF3218o9o4nnfO5C3Hi8nUqY0DUsaKOlDIT8hjKsa0PEQQCIQrRNz6LTRnemz8WJYBJ
         anRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f193NtTpTpydXyi+JhLs+H7/IffFTZ75c2ZMxvJdUk8=;
        b=l5+V1AuSssAwO+Vbo8+Zo8MNnc3HU0tZd+rVgkOHYRUi3PCOpClCXKtnNdXwOB9wF+
         pwiluubZutqFx39wYPYEDQg3jbfbbive65J6rolFYodo+9uhqNfXkNzxyMxDkdOizEAc
         Can/3LJyQihrR3aPx2zhAlyQVr3BldDCmrenWyGIO7j/hDbwBIwHghU0zhluydFVrbYm
         ily4pWoeM008WsugfQKs9Z++w1QMWZGKPSV3K43XtMYjhVo9T+5G23kVRaOh+28Mfhh/
         apDHmeYt1cFHoFx7dUVWdq9H1Ok2f2vX2DUMuKBnCjj3tKdbSqfrfz5moGccjGxSnlc7
         ZySA==
X-Gm-Message-State: AJIora9s5DuOBZzA7q3u+uc+waBqzCXLqevnA5gaS0mhjlDGsn2LzGAQ
        +ETz4Zk+qE2k6YGFO9b9R207cLYpb2HkXIhu8afGthPyNe4Mhg==
X-Google-Smtp-Source: AGRyM1vyrNzKqO3Ifz5KIwIgFC5W5PBNO0pSYuxaOgPZzbIjIpiIe6KEL54iONqpjVmkmdcCsFx84sUnB4CUVc3UA9A=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr19390206ywa.277.1657549393693; Mon, 11
 Jul 2022 07:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220711112900.61363-1-shreeya.patel@collabora.com>
 <20220711112900.61363-3-shreeya.patel@collabora.com> <CAHp75Vf3NDsep5_819=e8yrna_AGh5cew=fs+hHe1q8LCa-PyA@mail.gmail.com>
 <c90e7334-5921-886b-2f9c-869fb55216ca@collabora.com> <CAHp75Vf=FOt+N6azar5gifvig8FL4sS3LX1kO8CzNCh2yOk-DQ@mail.gmail.com>
 <68de450f-da22-02e3-e863-7e17582ee03f@collabora.com>
In-Reply-To: <68de450f-da22-02e3-e863-7e17582ee03f@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 16:22:37 +0200
Message-ID: <CAHp75VcMsa+s9Lrp6fF_nzJ9RgsVnbCCDjvLW=-hdFpAs69pgA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: light: Add support for ltrf216a sensor
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com
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

On Mon, Jul 11, 2022 at 4:04 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> On 7/11/22 16:41, Andy Shevchenko wrote:
> > On Mon, Jul 11, 2022 at 3:39 PM Shreeya Patel
> > <shreeya.patel@collabora.com> wrote:
> >> On 11/07/22 18:36, Andy Shevchenko wrote:
> >>> On Mon, Jul 11, 2022 at 1:30 PM Shreeya Patel

...

> >>>> +static const struct regmap_config ltrf216a_regmap_config = {
> >>>> +       .name = LTRF216A_DRV_NAME,
> >>>> +       .reg_bits = 8,
> >>>> +       .val_bits = 8,
> >>>> +       .max_register = LTRF216A_MAX_REG,
> >>> Why do you use regmap locking? What for?
> >>
> >> Why do we want to skip the internal locking if it doesn't bring any
> >> benefits?
> >
> > Can you elaborate on the "no benefits" part, please?
>
> Since the regmap's lock will never be contended, thus it's free to keep

I'm skeptical about "free" here. My concerns are:
1) grosser code base;
2) slower code flow (even nop takes time to process).

> using it. If later on we will need to change the driver's code such that
> the lock will become needed, then we won't need to bother with
> re-enabling it. The comment to the driver's mutex states clearly that
> it's intended to protect the cached value.
>
> Hence what is point in disabling the regmap's lock? There are very few
> drivers that disable the regmap's lock and most of them do that for the
> good reason.

Most of the drivers that have its own lock _and_ regmap lock took the
locking scheme wrong. It is 101 when writing a driver to have a clear
picture of what lock protects what data (or I/O).

Even if lock is _almost_ free, it's still required to provide
understanding of how each of the locks is being used in the code.

That said, the main point of my review comment is to make the author
think about it, or just elaborate if it has been thought through
already.

-- 
With Best Regards,
Andy Shevchenko
