Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634345779A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 04:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiGRCcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 22:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRCcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:32:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D311A26
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:32:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so16845010pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=xlbbCZRIaGdn36DTZr6+SN9Rl75VJXXUnbsT0ZBkay4=;
        b=fmrhVZ4ugSw0IzxbGSrMuisNQ7QD80llHIi8B5JGaMk1HBtYblY9xyAU7XKalo1OOM
         W6NHgIiZgbIC2L5ueTDv2t64RaGf3ol+sI39ZbaWB83EV6Iu/lE983+PgF3MAdE0wicZ
         jz98yots/tw4XmzYoDxzoHCDFpxVDv5gS40k8K1VzKpAytKBjwOnXlylXqF0vfmeG24/
         K/zhAHn27r6be9ZmpIfEGq/vg79kFc98jvb7axx3Q1ejF2c1hff1Yi6FZ3QGBbiVz2N5
         vWAB6ch4Zw0CFWLZVQNW2qni7IJ0G77T2z6gJCsv/tnkvSCBrbGeAMjmREtIl8IcmZYg
         kRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xlbbCZRIaGdn36DTZr6+SN9Rl75VJXXUnbsT0ZBkay4=;
        b=RajnIWc+KZrc3vblLHivNDxYNCY5fuj9yOtJjlMC5ThNcxxgmEodvrFj85azbtuq3G
         nCL2QU5gFAmDnZq2Et7h5T80ZLhF9YkVM6xL2OkhZuioIJb7RMbdzMh1RwQlf/UW/y1f
         T2d5GGi5RT0GVSYnM2+F5yLGmD4IHDPg2it8oHjA61VMsLcYR+0lYzXI0sbBrRH6mYd8
         Fs21xbyYl5QREv1M8h5GcobTbBkq2YSXbHnHnWcZU/tNc63qefK73A8gCIZ2egZO5a5+
         qEUHe2jWxMRy0KEnDxmiBDEFnxizyO7BL9N1R1ekmfCgVdz9tcCdpNbVvJvYaBg/Zxy/
         p76Q==
X-Gm-Message-State: AJIora+D91lDY7Kd2HvyXPiLcDZn5c7NabrE1uyDQjsotp3nIQmnmtbK
        SxrwkUCD1M1nXcNuFTIHDocNSw==
X-Google-Smtp-Source: AGRyM1sJrzOzlNaasgbKuuzhS/qLqw53YMCRPXPpodCKte494pyBT53HBAUhr6OXNm57+r4b8Biv0Q==
X-Received: by 2002:a17:90b:3890:b0:1f0:2abb:e7d1 with SMTP id mu16-20020a17090b389000b001f02abbe7d1mr36493070pjb.158.1658111566683;
        Sun, 17 Jul 2022 19:32:46 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id h29-20020aa796dd000000b0052a198c2046sm8029561pfq.203.2022.07.17.19.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 19:32:46 -0700 (PDT)
Message-ID: <5f6dc0a9-02ef-5bd2-d864-ab4b2c4c4820@bytedance.com>
Date:   Mon, 18 Jul 2022 10:32:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2] sched/fair: Remove unused parameter idle of
 _nohz_idle_balance()
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220710101910.8413-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20220710101910.8413-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


gentle ping.

On 2022/7/10 Hao Jia wrote:
> Commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB")
> has been merged. The parameter idle of _nohz_idle_balance()
> is not used anymore so we can remove it.
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Hi Peter,
The patch got Reviewed-by from Vincent.
If you have time, please review the patch.

Regards,
Hao

> ---
>   kernel/sched/fair.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77b2048a9326..8d4be2a95e37 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10682,8 +10682,7 @@ static bool update_nohz_stats(struct rq *rq)
>    * can be a simple update of blocked load or a complete load balance with
>    * tasks movement depending of flags.
>    */
> -static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> -			       enum cpu_idle_type idle)
> +static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
>   {
>   	/* Earliest time when we have to do rebalance again */
>   	unsigned long now = jiffies;
> @@ -10798,7 +10797,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>   	if (idle != CPU_IDLE)
>   		return false;
>   
> -	_nohz_idle_balance(this_rq, flags, idle);
> +	_nohz_idle_balance(this_rq, flags);
>   
>   	return true;
>   }
> @@ -10818,7 +10817,7 @@ void nohz_run_idle_balance(int cpu)
>   	 * (ie NOHZ_STATS_KICK set) and will do the same.
>   	 */
>   	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
> -		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
> +		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
>   }
>   
>   static void nohz_newidle_balance(struct rq *this_rq)
