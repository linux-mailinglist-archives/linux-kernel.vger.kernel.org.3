Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E43485B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiAEWKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:10:50 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:54012 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244988AbiAEWIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:08:44 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:58414)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5ESW-00Dedm-DM; Wed, 05 Jan 2022 15:08:40 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:49816 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5ESM-00BfDb-JM; Wed, 05 Jan 2022 15:08:34 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Barret Rhoden <brho@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220105212828.197013-1-brho@google.com>
        <20220105212828.197013-4-brho@google.com>
Date:   Wed, 05 Jan 2022 16:05:59 -0600
In-Reply-To: <20220105212828.197013-4-brho@google.com> (Barret Rhoden's
        message of "Wed, 5 Jan 2022 16:28:28 -0500")
Message-ID: <874k6h7s8o.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5ESM-00BfDb-JM;;;mid=<874k6h7s8o.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18DoukBPd+s/ngfCYWPj270qSJarSKqIoI=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XM_B_Investor,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_B_Investor BODY: Commonly used business phishing phrases
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Barret Rhoden <brho@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 562 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.73
        (0.3%), extract_message_metadata: 6 (1.1%), get_uri_detail_list: 2.5
        (0.4%), tests_pri_-1000: 4.2 (0.7%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 80 (14.3%), check_bayes:
        79 (14.0%), b_tokenize: 11 (1.9%), b_tok_get_all: 10 (1.7%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 53 (9.4%), b_finish: 0.79
        (0.1%), tests_pri_0: 438 (77.8%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.60 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 3/3] prlimit: do not grab the tasklist_lock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> Unnecessarily grabbing the tasklist_lock can be a scalability bottleneck
> for workloads that also must grab the tasklist_lock for waiting,
> killing, and cloning.
>
> The tasklist_lock was grabbed to protect tsk->sighand from disappearing
> (becoming NULL).  tsk->signal was already protected by holding a
> reference to tsk.
>
> update_rlimit_cpu() assumed tsk->sighand != NULL.  With this commit, it
> attempts to lock_task_sighand().  However, this means that
> update_rlimit_cpu() can fail.  This only happens when a task is exiting.
> Note that during exec, sighand may *change*, but it will not be NULL.
>
> Prior to this commit, the do_prlimit() ensured that update_rlimit_cpu()
> would not fail by read locking the tasklist_lock and checking tsk->sighand
> != NULL.
>
> If update_rlimit_cpu() fails, there may be other tasks that are not
> exiting that share tsk->signal.  We need to run update_rlimit_cpu() on
> one of them.   We can't "back out" the new rlim - once we unlocked
> task_lock(group_leader), the rlim is essentially changed.
>
> The only other caller of update_rlimit_cpu() is
> selinux_bprm_committing_creds().  It has tsk == current, so
> update_rlimit_cpu() cannot fail (current->sighand cannot disappear
> until current exits).
>
> This change resulted in a 14% speedup on a microbenchmark where parents
> kill and wait on their children, and children getpriority, setpriority,
> and getrlimit.
>
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  include/linux/posix-timers.h   |  2 +-
>  kernel/sys.c                   | 32 +++++++++++++++++++++-----------
>  kernel/time/posix-cpu-timers.c | 12 +++++++++---
>  3 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
> index 5bbcd280bfd2..9cf126c3b27f 100644
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -253,7 +253,7 @@ void posix_cpu_timers_exit_group(struct task_struct *task);
>  void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
>  			   u64 *newval, u64 *oldval);
>  
> -void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
> +int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
>  
>  void posixtimer_rearm(struct kernel_siginfo *info);
>  #endif
> diff --git a/kernel/sys.c b/kernel/sys.c
> index fb2a5e7c0589..073ae9db192f 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1432,13 +1432,7 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
>  			return -EPERM;
>  	}
>  
> -	/* protect tsk->signal and tsk->sighand from disappearing */
> -	read_lock(&tasklist_lock);
> -	if (!tsk->sighand) {
> -		retval = -ESRCH;
> -		goto out;
> -	}
> -
> +	/* Holding a refcount on tsk protects tsk->signal from disappearing. */
>  	rlim = tsk->signal->rlim + resource;
>  	task_lock(tsk->group_leader);
>  	if (new_rlim) {
> @@ -1467,10 +1461,26 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
>  	 */
>  	if (!retval && new_rlim && resource == RLIMIT_CPU &&
>  	    new_rlim->rlim_cur != RLIM_INFINITY &&
> -	    IS_ENABLED(CONFIG_POSIX_TIMERS))
> -		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
> -out:
> -	read_unlock(&tasklist_lock);
> +	    IS_ENABLED(CONFIG_POSIX_TIMERS)) {
> +		if (update_rlimit_cpu(tsk, new_rlim->rlim_cur)) {
> +			/*
> +			 * update_rlimit_cpu can fail if the task is exiting.
> +			 * We already set the task group's rlim, so we need to
> +			 * update_rlimit_cpu for some other task in the process.
> +			 * If all of the tasks are exiting, then we don't need
> +			 * to update_rlimit_cpu.
> +			 */
> +			struct task_struct *t_i;
> +
> +			rcu_read_lock();
> +			for_each_thread(tsk, t_i) {
> +				if (!update_rlimit_cpu(t_i, new_rlim->rlim_cur))
> +					break;
> +			}
> +			rcu_read_unlock();
> +		}

I look at this and I ask can't we do this better?

Because you are right that if the thread you landed on is exiting this
is a problem.  It is only a problem for prlimit64, as all of the rest
of the calls to do_prlimit happen from current so you know they are not
exiting.

I think the simple solution is just:
	update_rlimit_cpu(tsk->group_leader)

As the group leader is guaranteed to be the last thread of the thread
group to be processed in release_task, and thus the last thread with a
sighand.  Nothing needs to be done if it does not have a sighand.

How does that sound?

> +	}
> +
>  	return retval;
>  }

Eric
