Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9597352FA86
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 12:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348906AbiEUJvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348744AbiEUJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 05:51:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB70BDF48;
        Sat, 21 May 2022 02:51:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 2so1098244iou.5;
        Sat, 21 May 2022 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MhyK27iRMOtNP6NnjU1K4GzwhpyaVdtefAx5nQlLYA=;
        b=Nt9Vs8N6GrYKUV15IRXo4SYanrBxqkbdDJrbvChn4AlIen/QA6HlO2OsvSK2WmQ83p
         Zn7NR268qJJKNrxy1uiwPam9sG3X+KfvKaReNbRdZSEUD0Mi5UnHv4+ZsMzlQgLUVWK2
         BWEsesxXzwKwwTcKIk73uJDgg4o3wIvT3x0F8FPcX2EakLWewrLrfNU4m9oO4kbL3uhQ
         MLzxFF2LaRgwznlndYBXJ+n+eG9gd5B1AAxsBTVuI4BklzuxC5Mql8mDRVELEClGuWJT
         2e2tc8X7L3jP8bEEqVKNSflDTYOgoUpgd+lh6lLRq6Er0PSPXVLdIO9mFRg+TDMGSgZ6
         YHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MhyK27iRMOtNP6NnjU1K4GzwhpyaVdtefAx5nQlLYA=;
        b=CrvWSW9q55vJeIZoYGB9+z+Bjj0Asb39C3UpEAijbCy4RYeVz8UFbcON2IFI2JHt8a
         94AiceiujOZuJdhY2dbqYGYhfAGG8x/4JJE157jhz8RlaGmz5rAjugjBjJSH+Ynq7Y61
         Cjnoe7QWh8C8kKRLkGQb9zvMc3CuyN/bj3fwz25YVxA8LnwrWYUYdvTk6c4hiC4P0IBy
         lFYtc1VVYOBnA4dlBYo2nhrmKnfjNgSk9e18ZsvpZI7/AQW8aH9FEt9n3fzpRW2DaIou
         y0hjaKDFuwLrSsXoNqJZcPwvy8amUKp36YCnVzK01RHR+N8+XakzvNFvsP+cZTfi0kXA
         Uwpg==
X-Gm-Message-State: AOAM530qexaJuX8X84JaFW8VY+hLbnjr0Le45L1tctBCsMAJcdnKxsm8
        zrByn8ZMrJB0JYF6VDKWm0gfk9flP+Ww4vaLDqA=
X-Google-Smtp-Source: ABdhPJwWYvDVGd59OGW3xaIvzgRFZYhH7yQz2wUnXWxbkp7JM6DDVUCYy7OGxXnQdHO2iFBOlV1bzW/50YNtKxRf8Y8=
X-Received: by 2002:a6b:7845:0:b0:64c:9acc:9f1a with SMTP id
 h5-20020a6b7845000000b0064c9acc9f1amr6615723iop.103.1653126667331; Sat, 21
 May 2022 02:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-1-linux.amoon@gmail.com> <20220515064126.1424-2-linux.amoon@gmail.com>
 <6a6ed76a-50fa-2b05-896e-8936d3c3f597@linaro.org> <CANAwSgTMwKhn6QDcoOXcSVgUqLGq1W6X4QvcSRHT-JSVfOe0rA@mail.gmail.com>
 <39336391-8882-b2cb-058f-18f59dcc90d3@linaro.org>
In-Reply-To: <39336391-8882-b2cb-058f-18f59dcc90d3@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 21 May 2022 15:20:51 +0530
Message-ID: <CANAwSgT0Vmq4D9nRNc9h=xXxjmN_wXjbhwjj4btX+4SkXePkrw@mail.gmail.com>
Subject: Re: [PATCHv2 1/6] thermal: exynos: Enable core tmu hardware clk flag
 on exynos platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
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

Hi Krzysztof,

On Wed, 18 May 2022 at 12:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/05/2022 20:42, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > On Sun, 15 May 2022 at 15:22, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 15/05/2022 08:41, Anand Moon wrote:
> >>> Use clk_prepare_enable api to enable tmu internal hardware clock
> >>> flag on, use clk_disable_unprepare to disable the clock.
> >>>
> >>> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>
> >> Here as well you ignored my first comment:
> >> https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#mbfc57b40a7ed043dd4d4890bedb6bad8240058cd
> >>
> >> "This is not valid reason to do a change. What is clk_summary does not
> >> really matter. Your change has negative impact on power consumption as
> >> the clock stays enabled all the time. This is not what we want... so
> >> please explain it more - why you need the clock to be enabled all the
> >> time? What is broken (clk_summary is not broken in this case)?"
> >>

This was just to update my knowledge on what is missing in the driver.

> I don't understand how all this is relevant to the Exynos TMU driver.
> You paste some COMMON_CLK framework links, but this is just a framework.
> It has nothing to do with Exynos TMU.
>
> Since we are making circles, let's make it clearer. Answer these simple
> questions:
> 1. Is Exynos TMU driver operating correctly or not correctly?

Yes Exynos TMU clk is getting initialized, but not incorrect order.
within the exynos tmu driver we call
   exynos_tmu_probe
        ---> clk_prepare
   exynos_tmu_initialize
       ---> clk_enable
which is seem to work but it does not enable the clk in total.

But if we call *clk_prepare_enable* in  exynos_tmu_probe we enable the
clk correctly.

*Note:* This current patch is missing the clean-up in
exynos_tmu_initialize function.

>
> 2. If incorrectly, how is the incorrectness visible?

See before the change in Exynos 5422
$ sudo cat /sys/kernel/debug/clk/clk_summary | grep tmu
                         tmu_gpu       0        2        0    66600000
         0     0  50000         N
                         tmu          0        6        0    66600000
      0     0  50000         N

$ sudo cat /sys/kernel/debug/clk/clk_summary | grep tmu
                         tmu_gpu       2        2        0    66600000
         0     0  50000         Y
                         tmu          6        6        0    66600000
      0     0  50000         Y

After the changes, the internal tmu clk internal hardware flag is set to 'Y'
* hence I mention this in the commit message.*

Before the patch
# cat /sys/kernel/debug/clk/tmu/clk_enable_count
0
# cat /sys/kernel/debug/clk/tmu_gpu/clk_enable_count
0

After the patch
# cat /sys/kernel/debug/clk/tmu/clk_enable_count
6
 # cat /sys/kernel/debug/clk/tmu_gpu/clk_enable_count
2

> How can we trigger and see the issue?

We can trigger or see the issue but enable clk trace feature,
for example trace clk_enable, clk_prepare clk_enable_complete

I don't know how to trace clk during clk initialization
but I will try to find out more about this.

>
> 3. If it operates correctly, maybe it is operating in nonoptimal way?
>
Few new things we could set in this TMU driver which control the internal timing

SAMPLING_INTERVAL  - sample interval
COUNTER_VALUE0      - Timing control of T_EN_TEMP_SEN on/off timing
COUNTER_VALUE1      - Timing control of CLK_SENSE on/off timing

> 4. If it is not optimal, then what states are not optimal and when?

We could drop the unnecessary clk_enable and clk_disable as we don't check
the return value of the function and it just toggles the clock which
does not look optimal.

Since CLK_SENSE internally has a timer to on/off and control the PMU operations.

Look at following functions we could drop this
exynos_get_temp , exynos_tmu_control and exynos_tmu_set_emulation.

>
> In any case you commit fails to explain WHY you are doing it. I
> explained you this over the years several times and after these several
> times you still do not like to answer that simple question. This is
> pointless. You receive feedback and keep it ignored...
>

Some time is a bit hard for me to explain the feature changes in a
crisp clean way.
I will try to correct myself on this. Please try to understand this I am
just trying to improve the code.

> Always, always please explain why this change is needed.
Ok.

>
> Best regards,
> Krzysztof

Thanks & Regards


-Anand
