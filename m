Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A944D7B80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiCNHZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiCNHZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:25:24 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CE421808;
        Mon, 14 Mar 2022 00:24:14 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x200so28920727ybe.6;
        Mon, 14 Mar 2022 00:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVU4yjyHFIsoLQqX99m6dks/I1YjxJeajGkAN3rfbC0=;
        b=G7X+fjufED/sHmNcgMywOMc4IAYvMqqGH4lSwzN4jqB1Vgn21IkY2u2ppFy7bArRJP
         Zk4ae9Q6TrFZuWjWSji1KKY0xABtG42/RytMR4hPEssOxBhLeRs3NztzaNZ3J8Nw9ZW4
         qxkRAYpyZS0B0vD3ccBu50HQH0CWHjY0Nttme2ENzPSrySKOxHA8GDMxTqpi5rU26/8w
         DMNcNItPgKkxTEEmII8I8qbpbsfhDPJWnTOFatAP8mEdzPreia73T9mprCc2pxpYSw5R
         BXxJe+3N8o+qy+YdQowpS2v70DM8/V56FUQjxCoMgRnWcX7unF0Y+LoYCmB8sNTvYOEj
         XnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVU4yjyHFIsoLQqX99m6dks/I1YjxJeajGkAN3rfbC0=;
        b=WlKOCZrCFcVmShhUzJdn0Ec5QqXENwXu4CI0xqXfuMHJfaNKWhSxDqRI8t0JH8MxX2
         wznM+S9MyxQBmkCYxfge4YnenzcYx4dvdY6H0ulE7JWiPsXSa4Jd2rW65fsY09sPGKUE
         p7XURvbtuqoIiY72jy7UNVnPQcAt7KURRYC2/ZuboLhWu+vQ3scyfdy83DccZ/mQxk2X
         WqMlvvSRFaezBKLmOkbLMutVUPygSo6GfKCfYJH/BGBxWnj6FzAkWABA7zOWkzso+1ee
         1jIH8ECfIsnUhAWyB47EEfbQqg7ZiPkqAYiy6v9IwalEbwXkosz1SgAr+hZtIrso23kN
         8ERQ==
X-Gm-Message-State: AOAM53033YHI+AnKQqKtc2csrm352NRKOyoUz3jyYXcgapkTO+2zYNv7
        tQYww79CsUkOQM0mPI+wIFYA0BAf3UfTlNZr/1k=
X-Google-Smtp-Source: ABdhPJx5cqUJCvREwt97BrqISyK/AjrwYw4pDWHwDZg8KqLHD2V51R/QHv4BqcUPJN6h4hx8T9xEPJ3Tvv9t+pCuvSs=
X-Received: by 2002:a5b:986:0:b0:628:7e0a:c14c with SMTP id
 c6-20020a5b0986000000b006287e0ac14cmr16397164ybq.240.1647242653731; Mon, 14
 Mar 2022 00:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220314060304.95400-1-juitse.huang@gmail.com>
In-Reply-To: <20220314060304.95400-1-juitse.huang@gmail.com>
From:   Henry Tseng <henrybear327@gmail.com>
Date:   Mon, 14 Mar 2022 08:24:02 +0100
Message-ID: <CAA5xa-kH0eyP16DocXyy2=VdVQCBa6d+PRJbcHANHdpk3QnFJg@mail.gmail.com>
Subject: Re: [PATCH] docs/scheduler: Introduce the doc of load average
To:     Jui-Tse Huang <juitse.huang@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Beata Michalska <beata.michalska@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Yiwei Lin <s921975628@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe there is a typo in the document, as mentioned inline down below.

On Mon, Mar 14, 2022 at 7:03 AM Jui-Tse Huang <juitse.huang@gmail.com> wrote:
>
> Load average is one of the common as well as easily observed statistics provided
> by Linux, but still not well documented, which makes the numbers that users
> observe from the output of top, htop or other system monitoring applications are
> only numbers. This patch discusses how Linux calculates the load average as well
> as what is concerned while calculating the load average.
>
> The discussion flow is divided into several parts:
> 1. The expression used to get the load average.
> 2. Why does Linux choose such an average method from the other.
> 2. The meaning of each term in the expression.
> 3. The type of tasks that will be covered in the calculation.
> 4. A brief explanation of the fixed-point number since the weights defined in
>    the Linux kernel are based on it.
>
> Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> Co-Developed-by: Yiwei Lin <s921975628@gmail.com>
>
> ---
>  Documentation/scheduler/index.rst        |  1 +
>  Documentation/scheduler/load-average.rst | 77 ++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/scheduler/load-average.rst
>
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> index 88900aabdbf7..bdc779b4190f 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -17,6 +17,7 @@ Linux Scheduler
>      sched-nice-design
>      sched-rt-group
>      sched-stats
> +    load-average
>
>      text_files
>
> diff --git a/Documentation/scheduler/load-average.rst b/Documentation/scheduler/load-average.rst
> new file mode 100644
> index 000000000000..1b55f8da4e16
> --- /dev/null
> +++ b/Documentation/scheduler/load-average.rst
> @@ -0,0 +1,77 @@
> +============
> +Load Average
> +============
> +
> +Load average is a basic statistic provided by almost all operating systems that
> +aims to report the usage of system hardware resources. In Linux kernel, the
> +load average is calculated via the following expression::
> +
> +                / 0                                      , if t = 0
> +    load_{t} = |
> +                \ laod_{t - 1} * exp + active * (1 - exp), otherwise
> +
> +The expression represents the exponential moving average of the historical
> +loading of the system. There are several reasons that Linux kernel chooses
> +exponential moving average from other similar average equations such as simple
> +moving average or cumulative moving average:
> +
> +#. The exponential moving average consumes fixed memory space, while the simple
> +   moving average has O(n) space complexity where n is the number of timeslice
> +   within a given interval.
> +#. The exponential moving average not only applies a higher weight to the most
> +   recent record but also declines the weight exponentially, which makes the
> +   resulting load average reflect the situation of the current system. Neither
> +   the simple moving average nor cumulative moving average has this feature.
> +
> +In the expression, the load_{t} in the expression indicates the calculated load
> +average at the given time t.
> +The active is the most recent recorded system load. In Linux, the system load
> +means the number of tasks in the state of TASK_RUNNING or TASK_UNINTERRUPTIBLE
> +of the entire system. Tasks with TASK_UNINTERRUPTIBLE state are usually waiting
> +for disk I/O or holding an uninterruptible lock, which is considered as a part
> +of system resource, thus, Linux kernel covers them while calculating the load
> +average.
> +The exp means the weight applied to the previous report of load average, while
> +(1 - exp) is the weight applied to the most recently recorded system load.
> +There are three different weights defined in the Linux kernel, in
> +include/linux/sched/loadavg.h, to perform statistics in various timescales::
> +
> +    // include/linux/sched/loadavg.h
> +    ...
> +    #define EXP_1    1884    /* 1/exp(5sec/1min) as fixed-point */
> +    #define EXP_5    2014    /* 1/exp(5sec/5min) */
> +    #define EXP_15   2037    /* 1/exp(5sec/15min) */
> +    ...
> +
> +According to the expression shown on the top of this page, the weight (exp)
> +controls how much of the last load load_{t - 1} will take place in the
> +calculation of current load, while (1 - exp) is the weight applied to the most
> +recent record of system load active.
> +
> +Due to the security issue, the weights are defined as fixed-point numbers based
> +on the unsigned integer rather than floating-pointing numbers. The introduction
> +of the fixed-point number keeps the FPU away from the calculation process. Since
> +the precession of the fixed-point used in the Linux kernel is 11 bits, a
> +fixed-point can be converted to a floating-point by dividing it by 2048, as the
> +expression shown below::
> +
> +    EXP_1  = 1884 / 2048 = 0.919922
> +    EXP_5  = 2014 / 2048 = 0.983398
> +    EXP_15 = 2037 / 2048 = 0.994629
> +
> +Which indicates the weights applied to active are::
> +
> +    (1 - EXP_1)  = (1 - 0.919922) = 0.080078
> +    (1 - EXP_5)  = (1 - 0.983398) = 0.016602
> +    (1 - EXP_15) = (1 - 0.994629) = 0.005371
> +
> +The load average will be updated every 5 seconds. Each time the scheduler_tick()
> +be called, the function calc_global_load_tick() will also be invoked, which
> +makes the active of each CPU core be calculated and be merged globally, finally,
> +the load average will be updated with that global active.
> +
> +As a user, the load average can be observed via top, htop, or other system
> +monitor application, or more directly, by the following command::
> +
> +    $ cat /proc/laodavg

Should be $ cat /proc/loadavg

> +
> --
> 2.25.1
>


-- 
Best wishes,
Henry
