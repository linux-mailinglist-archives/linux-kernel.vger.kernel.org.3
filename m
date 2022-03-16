Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24884DAD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346808AbiCPJW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353461AbiCPJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:22:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594BE652F2;
        Wed, 16 Mar 2022 02:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cZoOhn7yksZ8A8Ig5DEqI3AypkEzFO+D55ijtno6Otk=; b=V0APTf9IbANRluXADviIieoO8p
        q6L3r0Ume1BQ7Zi5zlj2GPo51tIQH2MvAGlfWWO5zBScWlcPEJMhChUF3CtLgzct+qBX4F6+UAtGV
        Vwo5at3Qg7SUJxlt3BIjKg/ZsIr8xH9G6fG7dju4FYQPLdJs6DUd9wKxyNXc2iZsOOhnzLsdkM/kT
        bKvfxNkg7O6QCCCbLPfVCOfMKyvjP2P1PJQ/Gavhb/VMO8Wk732t1iJTSL9XHqWHhMO0SAJ0NZVem
        aBIhRr+AxjCH1KRNQeyobSZeLdnhVhcN2eJF9OICwdf/JX7x78nqVP1LSmFsohCLYbaMkuUSuP/af
        N6Lu0DGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPqH-001V17-Mq; Wed, 16 Mar 2022 09:21:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA31B30007E;
        Wed, 16 Mar 2022 10:21:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 731602D602535; Wed, 16 Mar 2022 10:21:15 +0100 (CET)
Date:   Wed, 16 Mar 2022 10:21:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jui-Tse Huang <juitse.huang@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Chun-Hung Tseng <henrybear327@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Randy Dunlap <rdunlap@infradead.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Yiwei Lin <s921975628@gmail.com>
Subject: Re: [PATCH v3] docs/scheduler: Introduce the doc of load average
Message-ID: <YjGsCyS0t/+pdzZh@hirez.programming.kicks-ass.net>
References: <20220315140857.41697-1-juitse.huang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315140857.41697-1-juitse.huang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:08:57PM +0800, Jui-Tse Huang wrote:
> The load average is one of a common as well as easy observed statistic
> provied by Linux, but still not well documented, which makes the numbers

I'm really not sure what the target audience is; and I hate you're
making me read rst garbage. For someone trying to make changes to
load_avg.c this document is pure confusion, for a user trying to make
sense of that number, I would imagine much the same.

> that users observes from the output of top, htop or other system
> monitoring application are only numbers. This patch gives a discussion
> on how Linux calculates the load average as well as what metrics are
> concerned while calculating the load average.
> 
> The discussion flow is divided into several parts:
> 1. The expression used to get the load average.
> 2. Why Linux choose such average method from the other.
> 2. The meaning of each term in the expression.
> 3. The metrics, that is, the type of tasks that will be covered in the
>    calculation.
> 4. A brief explanation over the fixed-point nubmer since the weights
>    defined in the Linux kernel are based on it.
> 
> Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> Co-Developed-by: Yiwei Lin <s921975628@gmail.com>
> 
> ---
> 
> v3:
>   - Fix typo (Randy Dunlap)
>   - Add further reading that links to Brendan Gregg's blog
> 
> v2:
>   - Fix typo (Chun-Hung Tseng) 
> 
>  Documentation/scheduler/index.rst        |  1 +
>  Documentation/scheduler/load-average.rst | 82 ++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
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
> index 000000000000..27ce6cbae5f4
> --- /dev/null
> +++ b/Documentation/scheduler/load-average.rst
> @@ -0,0 +1,82 @@
> +============
> +Load Average
> +============
> +
> +The load average, provided by common operating systems, indicates the average
> +number of system load over a period of time.  In Linux, it shows the average
> +number of tasks running and waiting for CPU time. The following expression is
> +used in Linux to update the load average::
> +
> +                / 0                                      , if t = 0
> +    load_{t} = |
> +                \ load_{t - 1} * exp + active * (1 - exp), otherwise


Easier to follow is:

	load_{0} = 0
	load_{t+1} = load_{t} * exp + active * (1 - exp)

> +The expression represents the exponential moving average of the historical
> +loading of the system. There are several reasons that Linux kernel chooses
> +exponential moving average from other similar average equations such as simple
> +moving average or cumulative moving average:
> +
> +#. The exponential moving average consumes fixed memory space, while the simple
> +   moving average has O(n) space complexity where n is the number of timeslices
> +   within a given interval.
> +#. The exponential moving average not only applies a higher weight to the most
> +   recent record but also declines the weight exponentially, which makes the
> +   resulting load average reflect the situation of the current system. Neither
> +   the simple moving average nor cumulative moving average has this feature.
> +
> +In the expression, the load_{t} indicates the calculated load average at the
> +given time t.

> +The active is the most recent recorded system load. In Linux, the system load

That's inaccurate at best, active is not the load, since you just gave a
definition of load. As such, load is a function of time and active.

Also, stop saying in Linux, you're reading the Linux documentation this
is a given.

> +means the number of tasks in the state of TASK_RUNNING or TASK_UNINTERRUPTIBLE
> +of the entire system. Tasks with TASK_UNINTERRUPTIBLE state are usually waiting
> +for disk I/O or holding an uninterruptible lock, which is considered as a part
> +of system resource, thus, Linux kernel covers them while calculating the load
> +average.

This is inacurate, consider TASK_NOLOAD.

> +The exp means the weight applied to the previous report of load average, while
> +(1 - exp) is the weight applied to the most recently recorded system load.

I get really itchy from statements like this; either you can read a
formula or you can't, stuff like this doesn't help much in either case.

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

What page, this is a non-paginated document. Also, you're repeating
yourself.

> +Due to the security issue, the weights are defined as fixed-point numbers based

This is complete nonsense

> +on the unsigned integer rather than floating-pointing numbers. The introduction
> +of the fixed-point number keeps the FPU away from the calculation process. Since
> +the precision of the fixed-point used in the Linux kernel is 11 bits, a
> +fixed-point can be converted to a floating-point by dividing it by 2048, as in
> +the expressions shown bellow::
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

I don't think this is the place to explain fixed point arithmetic. The
consumer of load_avg doesn't need the know, the developer looking at
loadavg.c will have *MUCH* bigger problems.

> +The load average will be updated every 5 seconds. Each time the scheduler_tick()
> +be called, the function calc_global_load_tick() will also be invoked, which
> +makes the active of each CPU core be calculated and be merged globally. Finally,
> +the load average will be updated with that global active.

That's wishful thinking, have you read loadavg.c ?

> +
> +As a user, the load average can be observed via top, htop, or other system
> +monitor application, or more directly, by the following command::
> +
> +    $ cat /proc/loadavg
> +
> +Further Reading
> +---------------
> +The explanation and analysis done by Brendan Gregg on `his blog
> +<https://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html>`_.

That blogpost is actually useful, unlike most of what you've written
here. Why not only link that and leave out the rest?
