Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F9552A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 07:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345059AbiFUFQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 01:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbiFUFQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:16:57 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D579D1F2D9;
        Mon, 20 Jun 2022 22:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655788617; x=1687324617;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NQsdVX/cu2mEhJrl6OeYqgtiNmwh4Fd5m1PQ7x7SfeU=;
  b=TW6pNeJ3329KB44L4GqmINRiH7DB0uVp2S2YQEGwZfnVSp8MrOyY978b
   jqYxdQBGRbNhxjwtlim6Z8x0IeI7RwMMbb4MEpqiTlvAfyn8Vwdybph7Q
   b1Qtuo8UAXZC0JYVvQ45L9pdkjb/MkZ/XOTCJqBEQQqGqCHh4BD0USAoI
   k=;
Received: from ironmsg03-sd.qualcomm.com ([10.53.140.143])
  by alexa-out.qualcomm.com with ESMTP; 20 Jun 2022 22:16:57 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 22:10:45 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 22:10:43 -0700
Message-ID: <08975b5a-8367-9492-4964-7946ff9c3e27@quicinc.com>
Date:   Tue, 21 Jun 2022 10:40:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 1/3] rcutorture: Update rcutorture.fwd_progress help
 text
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>
References: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
 <20220620221757.3839212-1-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620221757.3839212-1-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2022 3:47 AM, Paul E. McKenney wrote:
> This commit updates the rcutorture.fwd_progress help text to say that
> it is the number of forward-progress kthreads to spawn rather than the
> old enable/disable functionality.  While in the area, make the list of
> torture-test parameters easier to read by taking advantage of 100 columns.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

>   kernel/rcu/rcutorture.c | 53 ++++++++++++++---------------------------
>   1 file changed, 18 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 7120165a93426..6f47d1490c4f5 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -75,62 +75,45 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
>   
>   torture_param(int, extendables, RCUTORTURE_MAX_EXTEND,
>   	      "Extend readers by disabling bh (1), irqs (2), or preempt (4)");
> -torture_param(int, fqs_duration, 0,
> -	      "Duration of fqs bursts (us), 0 to disable");
> +torture_param(int, fqs_duration, 0, "Duration of fqs bursts (us), 0 to disable");
>   torture_param(int, fqs_holdoff, 0, "Holdoff time within fqs bursts (us)");
>   torture_param(int, fqs_stutter, 3, "Wait time between fqs bursts (s)");
> -torture_param(int, fwd_progress, 1, "Test grace-period forward progress");
> +torture_param(int, fwd_progress, 1, "Number of grace-period forward progress tasks (0 to disable)");
>   torture_param(int, fwd_progress_div, 4, "Fraction of CPU stall to wait");
> -torture_param(int, fwd_progress_holdoff, 60,
> -	      "Time between forward-progress tests (s)");
> -torture_param(bool, fwd_progress_need_resched, 1,
> -	      "Hide cond_resched() behind need_resched()");
> +torture_param(int, fwd_progress_holdoff, 60, "Time between forward-progress tests (s)");
> +torture_param(bool, fwd_progress_need_resched, 1, "Hide cond_resched() behind need_resched()");
>   torture_param(bool, gp_cond, false, "Use conditional/async GP wait primitives");
>   torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
> -torture_param(bool, gp_normal, false,
> -	     "Use normal (non-expedited) GP wait primitives");
> +torture_param(bool, gp_normal, false, "Use normal (non-expedited) GP wait primitives");
>   torture_param(bool, gp_poll, false, "Use polling GP wait primitives");
>   torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
>   torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
>   torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
> -torture_param(int, n_barrier_cbs, 0,
> -	     "# of callbacks/kthreads for barrier testing");
> +torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testing");
>   torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
>   torture_param(int, nreaders, -1, "Number of RCU reader threads");
> -torture_param(int, object_debug, 0,
> -	     "Enable debug-object double call_rcu() testing");
> +torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
>   torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
> -torture_param(int, onoff_interval, 0,
> -	     "Time between CPU hotplugs (jiffies), 0=disable");
> +torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
>   torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
>   torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
> -torture_param(int, read_exit_delay, 13,
> -	      "Delay between read-then-exit episodes (s)");
> -torture_param(int, read_exit_burst, 16,
> -	      "# of read-then-exit bursts per episode, zero to disable");
> +torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
> +torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
>   torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
>   torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
>   torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
> -torture_param(int, stall_cpu_holdoff, 10,
> -	     "Time to wait before starting stall (s).");
> -torture_param(bool, stall_no_softlockup, false,
> -	     "Avoid softlockup warning during cpu stall.");
> +torture_param(int, stall_cpu_holdoff, 10, "Time to wait before starting stall (s).");
> +torture_param(bool, stall_no_softlockup, false, "Avoid softlockup warning during cpu stall.");
>   torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
>   torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
> -torture_param(int, stall_gp_kthread, 0,
> -	      "Grace-period kthread stall duration (s).");
> -torture_param(int, stat_interval, 60,
> -	     "Number of seconds between stats printk()s");
> +torture_param(int, stall_gp_kthread, 0, "Grace-period kthread stall duration (s).");
> +torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
>   torture_param(int, stutter, 5, "Number of seconds to run/halt test");
>   torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
> -torture_param(int, test_boost_duration, 4,
> -	     "Duration of each boost test, seconds.");
> -torture_param(int, test_boost_interval, 7,
> -	     "Interval between boost tests, seconds.");
> -torture_param(bool, test_no_idle_hz, true,
> -	     "Test support for tickless idle CPUs");
> -torture_param(int, verbose, 1,
> -	     "Enable verbose debugging printk()s");
> +torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
> +torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
> +torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
> +torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>   
>   static char *torture_type = "rcu";
>   module_param(torture_type, charp, 0444);
