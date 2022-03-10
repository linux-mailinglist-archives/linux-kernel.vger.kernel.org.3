Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F44D3EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiCJBwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCJBwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:52:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510AA127D64
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:51:13 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cx5so3937742pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 17:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a43JXffTaoy98ONRIz/S/0hLw+CsbgOwmABQ+O/JH5s=;
        b=bGFGhwyCIT03kwNrrFtC2dNZR90VERfwIAUu/aPEHwlgG2a4s4vysGYwsTC9WuFors
         upz9C0CmzR9xQybE7o/otqnlMKqkHtniYNlwUvNDispEH/4ERLpzlZ4jiXqBF4eFdjoL
         laGqan6Hta/0GxonhhgF8JGthSY5uxER+tGbgRNjD3vYaxa9nTCa5BR2M3oOB3BgOmxo
         GDUbGCUyPDA8Z96zRxKLH0K5yaGVtTTPr+na03MVbTmD5ykIjJbpNDxoLX9OEH1huMqF
         f3wGFaqIGrzOfxgGRLS8vd5kFKo0RTexoJWAJKF9Asqojbl5soBdag/2sFzqN2Df2xu7
         t0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a43JXffTaoy98ONRIz/S/0hLw+CsbgOwmABQ+O/JH5s=;
        b=OZ6acO/NnXDVd+Qn2z0PxH/fy6vnu8TvYEUgeDk5il/MbDHKxgmP2faDQxBsilMbTE
         hFOojDwM01Vwgi4zE0Jd7Ue0cEBoKWJvANScqKkr+j9rICBtVBjGB/6Z0l1uUwQrTvCm
         S06QmstB/9EuqTi270Ls8mnN5/iGu4VX0r7cf6wzlr0DOcI2Mv0e48qVh5CUFxO9oHz8
         wgbBFmOA9zFKk/bbaWX4Qo+xhPs3bItitCvkkTEeqNsS3bo3bgmpsO/G5yiOj5H4ywUl
         ZFOw70hJdnChshR21+JdFcbkLwgopEBnHSXD+fiBXORGT5t5YpxDzRLxp54Wg8Y+PH/R
         4tcg==
X-Gm-Message-State: AOAM53397uFr6N8LFtshgeqSMIZU5ph+kM8WdRXtWbrtKrLSpbEzhLDc
        tJXTVkeS3ithhiKJ1vZxP53ram0ryM0uZA==
X-Google-Smtp-Source: ABdhPJxBHDRkiSTi6ulVvPNzy+e+HAN/eakPs38iOZFv+HWRRBNsOIVqtuNJ/Rdl0DJrdypbDq7d5Q==
X-Received: by 2002:a17:902:e80d:b0:151:e043:a2c3 with SMTP id u13-20020a170902e80d00b00151e043a2c3mr2610116plg.64.1646877072686;
        Wed, 09 Mar 2022 17:51:12 -0800 (PST)
Received: from [10.4.168.26] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id l9-20020a655609000000b0037589f4337dsm3595129pgs.78.2022.03.09.17.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 17:51:11 -0800 (PST)
Message-ID: <815937e3-7d67-9808-b704-d59af5e1f5a7@bytedance.com>
Date:   Thu, 10 Mar 2022 09:51:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [External] Re: next/master bisection: baseline.login on qemu_i386
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, kernelci-results@groups.io,
        bot@kernelci.org, linux-kernel@vger.kernel.org,
        gtucker@collabora.com
References: <6228a7a7.1c69fb81.85abc.005f@mx.google.com>
 <YijZiapwew8Gnilg@sirena.org.uk>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YijZiapwew8Gnilg@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/10 12:44 上午, Mark Brown wrote:
> On Wed, Mar 09, 2022 at 05:12:07AM -0800, KernelCI bot wrote:
> 
> The KernelCI bisection bot found that commit dc6e0818bc9a0336d9a
> ("sched/cpuacct: Optimize away RCU read lock") has been causing boot
> failures for i386 qemu systems running a defconfig with debug options
> added in -next.  The system comes up to userspace but the shell is
> unresponsive, most other architectures and configs (including i386
> without debug options) seem fine.
> 
> I've left the full bisection report including links to logs below, you
> can also see a full overview of the baseline tests for -next today at:
> 
>     https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20220309/plan/baseline/

Hi Mark, thanks for the bisection report. I've send a fix patch[1] for review.

[1] https://lore.kernel.org/lkml/20220305034103.57123-1-zhouchengming@bytedance.com/

> 
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> *                                                               *
>> * If you do send a fix, please include this trailer:            *
>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>> *                                                               *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>
>> next/master bisection: baseline.login on qemu_i386
>>
>> Summary:
>>   Start:      cb153b68ff91 Add linux-next specific files for 20220308
>>   Plain log:  https://storage.kernelci.org/next/master/next-20220308/i386/i386_defconfig+debug/gcc-10/lab-baylibre/baseline-qemu_i386.txt
>>   HTML log:   https://storage.kernelci.org/next/master/next-20220308/i386/i386_defconfig+debug/gcc-10/lab-baylibre/baseline-qemu_i386.html
>>   Result:     dc6e0818bc9a sched/cpuacct: Optimize away RCU read lock
>>
>> Checks:
>>   revert:     PASS
>>   verify:     PASS
>>
>> Parameters:
>>   Tree:       next
>>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>   Branch:     master
>>   Target:     qemu_i386
>>   CPU arch:   i386
>>   Lab:        lab-baylibre
>>   Compiler:   gcc-10
>>   Config:     i386_defconfig+debug
>>   Test case:  baseline.login
>>
>> Breaking commit found:
>>
>> -------------------------------------------------------------------------------
>> commit dc6e0818bc9a0336d9accf3ea35d146d72aa7a18
>> Author: Chengming Zhou <zhouchengming@bytedance.com>
>> Date:   Sun Feb 20 13:14:25 2022 +0800
>>
>>     sched/cpuacct: Optimize away RCU read lock
>>     
>>     Since cpuacct_charge() is called from the scheduler update_curr(),
>>     we must already have rq lock held, then the RCU read lock can
>>     be optimized away.
>>     
>>     And do the same thing in it's wrapper cgroup_account_cputime(),
>>     but we can't use lockdep_assert_rq_held() there, which defined
>>     in kernel/sched/sched.h.
>>     
>>     Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>     Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>     Link: https://lore.kernel.org/r/20220220051426.5274-2-zhouchengming@bytedance.com
>>
>> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
>> index 75c151413fda..9a109c6ac0e0 100644
>> --- a/include/linux/cgroup.h
>> +++ b/include/linux/cgroup.h
>> @@ -791,11 +791,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
>>  
>>  	cpuacct_charge(task, delta_exec);
>>  
>> -	rcu_read_lock();
>>  	cgrp = task_dfl_cgroup(task);
>>  	if (cgroup_parent(cgrp))
>>  		__cgroup_account_cputime(cgrp, delta_exec);
>> -	rcu_read_unlock();
>>  }
>>  
>>  static inline void cgroup_account_cputime_field(struct task_struct *task,
>> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
>> index 307800586ac8..f79f88456d72 100644
>> --- a/kernel/sched/cpuacct.c
>> +++ b/kernel/sched/cpuacct.c
>> @@ -337,12 +337,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>>  	unsigned int cpu = task_cpu(tsk);
>>  	struct cpuacct *ca;
>>  
>> -	rcu_read_lock();
>> +	lockdep_assert_rq_held(cpu_rq(cpu));
>>  
>>  	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
>>  		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
>> -
>> -	rcu_read_unlock();
>>  }
>>  
>>  /*
>> -------------------------------------------------------------------------------
>>
>>
>> Git bisection log:
>>
>> -------------------------------------------------------------------------------
>> git bisect start
>> # good: [ea4424be16887a37735d6550cfd0611528dbe5d9] Merge tag 'mtd/fixes-for-5.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
>> git bisect good ea4424be16887a37735d6550cfd0611528dbe5d9
>> # bad: [cb153b68ff91cbc434f3de70ac549e110543e1bb] Add linux-next specific files for 20220308
>> git bisect bad cb153b68ff91cbc434f3de70ac549e110543e1bb
>> # good: [1ce7aac49a7b73abbd691c6e6a1577a449d90bad] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>> git bisect good 1ce7aac49a7b73abbd691c6e6a1577a449d90bad
>> # bad: [08688e100b1b07ce178c1d3c6b9983e00cd85413] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>> git bisect bad 08688e100b1b07ce178c1d3c6b9983e00cd85413
>> # good: [3255b3a262be263864fcc5d5a239aebd1d0b2bb4] Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux
>> git bisect good 3255b3a262be263864fcc5d5a239aebd1d0b2bb4
>> # good: [983377cbb2ba7038a34b68f43788e78b34cb01d6] Merge branch 'pcmcia-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git
>> git bisect good 983377cbb2ba7038a34b68f43788e78b34cb01d6
>> # good: [71e306ad46cd73f05b9ba151161b4a3c1bd25e5d] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>> git bisect good 71e306ad46cd73f05b9ba151161b4a3c1bd25e5d
>> # bad: [a66320f041601309f1885bcb52e27e0c2f72079b] Merge branch into tip/master: 'core/core'
>> git bisect bad a66320f041601309f1885bcb52e27e0c2f72079b
>> # good: [9eb0c9821cf7efd5d18e2707caa01691c6d4fbf6] Merge branch into tip/master: 'x86/build'
>> git bisect good 9eb0c9821cf7efd5d18e2707caa01691c6d4fbf6
>> # bad: [49bef33e4b87b743495627a529029156c6e09530] sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race
>> git bisect bad 49bef33e4b87b743495627a529029156c6e09530
>> # good: [2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a] sched/fair: Improve consistency of allowed NUMA balance calculations
>> git bisect good 2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a
>> # good: [65e53f869e9f92a23593c66214b88e54fb190a13] sched/isolation: Fix housekeeping_mask memory leak
>> git bisect good 65e53f869e9f92a23593c66214b88e54fb190a13
>> # good: [99cf983cc8bca4adb461b519664c939a565cfd4d] sched/preempt: Add PREEMPT_DYNAMIC using static keys
>> git bisect good 99cf983cc8bca4adb461b519664c939a565cfd4d
>> # good: [6255b48aebfd4dff375e97fc8b075a235848db0b] Merge tag 'v5.17-rc5' into sched/core, to resolve conflicts
>> git bisect good 6255b48aebfd4dff375e97fc8b075a235848db0b
>> # bad: [dc6e0818bc9a0336d9accf3ea35d146d72aa7a18] sched/cpuacct: Optimize away RCU read lock
>> git bisect bad dc6e0818bc9a0336d9accf3ea35d146d72aa7a18
>> # good: [248cc9993d1cc12b8e9ed716cc3fc09f6c3517dd] sched/cpuacct: Fix charge percpu cpuusage
>> git bisect good 248cc9993d1cc12b8e9ed716cc3fc09f6c3517dd
>> # first bad commit: [dc6e0818bc9a0336d9accf3ea35d146d72aa7a18] sched/cpuacct: Optimize away RCU read lock
>> -------------------------------------------------------------------------------
