Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB847A1F7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 20:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhLSTzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 14:55:21 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:59866 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhLSTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 14:55:20 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:58338)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mz2H8-000VSn-9P; Sun, 19 Dec 2021 12:55:18 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:44410 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mz2H6-00FYFI-0g; Sun, 19 Dec 2021 12:55:17 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        0day robot <lkp@intel.com>, lkp@lists.01.org,
        kernel test robot <oliver.sang@intel.com>
References: <87tufc1p2i.fsf@email.froward.int.ebiederm.org>
        <73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org>
Date:   Sun, 19 Dec 2021 13:54:40 -0600
In-Reply-To: <73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org>
        (Alexey Gladkov's message of "Fri, 17 Dec 2021 15:48:23 +0100")
Message-ID: <87lf0g9xq7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mz2H6-00FYFI-0g;;;mid=<87lf0g9xq7.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++s70avrnqQa/lC3NDg5pl+oR+zUYPTF4=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 947 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (1.2%), b_tie_ro: 10 (1.1%), parse: 1.54
        (0.2%), extract_message_metadata: 17 (1.8%), get_uri_detail_list: 6
        (0.6%), tests_pri_-1000: 5 (0.6%), tests_pri_-950: 1.40 (0.1%),
        tests_pri_-900: 1.14 (0.1%), tests_pri_-90: 97 (10.3%), check_bayes:
        93 (9.8%), b_tokenize: 33 (3.5%), b_tok_get_all: 14 (1.4%),
        b_comp_prob: 4.3 (0.5%), b_tok_touch_all: 36 (3.8%), b_finish: 2.2
        (0.2%), tests_pri_0: 792 (83.6%), check_dkim_signature: 1.19 (0.1%),
        check_dkim_adsp: 3.9 (0.4%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 13 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] ucounts: Split rlimit and ucount values and max values
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> Since the semantics of maximum rlimit values are different, it would be
> better not to mix ucount and rlimit values. This will prevent the error
> of using inc_count/dec_ucount for rlimit parameters.
>
> This patch also renames the functions to emphasize the lack of
> connection between rlimit and ucount.
>
> v2:
> - Fix the array-index-out-of-bounds that was found by the lkp project.

At a quick read through this looks good.

I will see about getting this into for-next so we can merge this for v5.17

Eric

>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  fs/exec.c                      |  2 +-
>  fs/proc/array.c                |  2 +-
>  include/linux/user_namespace.h | 35 +++++++++++++++++++++-------------
>  kernel/fork.c                  | 12 ++++++------
>  kernel/sys.c                   |  2 +-
>  kernel/ucount.c                | 24 ++++++++++-------------
>  kernel/user_namespace.c        | 10 +++++-----
>  7 files changed, 46 insertions(+), 41 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 537d92c41105..d3f769837058 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1877,7 +1877,7 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	 * whether NPROC limit is still exceeded.
>  	 */
>  	if ((current->flags & PF_NPROC_EXCEEDED) &&
> -	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> +	    is_rlimit_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
>  		retval = -EAGAIN;
>  		goto out_ret;
>  	}
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index ff869a66b34e..d3fa539c755e 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -274,7 +274,7 @@ static inline void task_sig(struct seq_file *m, struct task_struct *p)
>  		collect_sigign_sigcatch(p, &ignored, &caught);
>  		num_threads = get_nr_threads(p);
>  		rcu_read_lock();  /* FIXME: is this correct? */
> -		qsize = get_ucounts_value(task_ucounts(p), UCOUNT_RLIMIT_SIGPENDING);
> +		qsize = get_rlimit_value(task_ucounts(p), UCOUNT_RLIMIT_SIGPENDING);
>  		rcu_read_unlock();
>  		qlim = task_rlimit(p, RLIMIT_SIGPENDING);
>  		unlock_task_sighand(p, &flags);
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 33a4240e6a6f..45f09bec02c4 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -54,15 +54,17 @@ enum ucount_type {
>  	UCOUNT_FANOTIFY_GROUPS,
>  	UCOUNT_FANOTIFY_MARKS,
>  #endif
> +	UCOUNT_COUNTS,
> +};
> +
> +enum rlimit_type {
>  	UCOUNT_RLIMIT_NPROC,
>  	UCOUNT_RLIMIT_MSGQUEUE,
>  	UCOUNT_RLIMIT_SIGPENDING,
>  	UCOUNT_RLIMIT_MEMLOCK,
> -	UCOUNT_COUNTS,
> +	UCOUNT_RLIMIT_COUNTS,
>  };
>  
> -#define MAX_PER_NAMESPACE_UCOUNTS UCOUNT_RLIMIT_NPROC
> -
>  struct user_namespace {
>  	struct uid_gid_map	uid_map;
>  	struct uid_gid_map	gid_map;
> @@ -99,6 +101,7 @@ struct user_namespace {
>  #endif
>  	struct ucounts		*ucounts;
>  	long ucount_max[UCOUNT_COUNTS];
> +	long rlimit_max[UCOUNT_RLIMIT_COUNTS];
>  } __randomize_layout;
>  
>  struct ucounts {
> @@ -107,6 +110,7 @@ struct ucounts {
>  	kuid_t uid;
>  	atomic_t count;
>  	atomic_long_t ucount[UCOUNT_COUNTS];
> +	atomic_long_t rlimit[UCOUNT_RLIMIT_COUNTS];
>  };
>  
>  extern struct user_namespace init_user_ns;
> @@ -120,21 +124,26 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid);
>  struct ucounts * __must_check get_ucounts(struct ucounts *ucounts);
>  void put_ucounts(struct ucounts *ucounts);
>  
> -static inline long get_ucounts_value(struct ucounts *ucounts, enum ucount_type type)
> +static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_type type)
>  {
> -	return atomic_long_read(&ucounts->ucount[type]);
> +	return atomic_long_read(&ucounts->rlimit[type]);
>  }
>  
> -long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
> -bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
> -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
> -void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
> -bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
> +long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
> +bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type);
> +void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type);
> +bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long max);
> +
> +static inline long get_userns_rlimit_max(struct user_namespace *ns, enum rlimit_type type)
> +{
> +	return READ_ONCE(ns->rlimit_max[type]);
> +}
>  
> -static inline void set_rlimit_ucount_max(struct user_namespace *ns,
> -		enum ucount_type type, unsigned long max)
> +static inline void set_userns_rlimit_max(struct user_namespace *ns,
> +		enum rlimit_type type, unsigned long max)
>  {
> -	ns->ucount_max[type] = max <= LONG_MAX ? max : LONG_MAX;
> +	ns->rlimit_max[type] = max <= LONG_MAX ? max : LONG_MAX;
>  }
>  
>  #ifdef CONFIG_USER_NS
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3244cc56b697..fb68d56bcd7e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -836,13 +836,13 @@ void __init fork_init(void)
>  	init_task.signal->rlim[RLIMIT_SIGPENDING] =
>  		init_task.signal->rlim[RLIMIT_NPROC];
>  
> -	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
> +	for (i = 0; i < UCOUNT_COUNTS; i++)
>  		init_user_ns.ucount_max[i] = max_threads/2;
>  
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
> +	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
> +	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
> +	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
> +	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
>  
>  #ifdef CONFIG_VMAP_STACK
>  	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
> @@ -2053,7 +2053,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
>  #endif
>  	retval = -EAGAIN;
> -	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> +	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
>  		if (p->real_cred->user != INIT_USER &&
>  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>  			goto bad_fork_free;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 8fdac0d90504..2c86d245acd6 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -479,7 +479,7 @@ static int set_user(struct cred *new)
>  	 * for programs doing set*uid()+execve() by harmlessly deferring the
>  	 * failure to the execve() stage.
>  	 */
> -	if (is_ucounts_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
> +	if (is_rlimit_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
>  			new_user != INIT_USER &&
>  			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>  		current->flags |= PF_NPROC_EXCEEDED;
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 7b32c356ebc5..22070f004e97 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -87,10 +87,6 @@ static struct ctl_table user_table[] = {
>  	UCOUNT_ENTRY("max_fanotify_groups"),
>  	UCOUNT_ENTRY("max_fanotify_marks"),
>  #endif
> -	{ },
> -	{ },
> -	{ },
> -	{ },
>  	{ }
>  };
>  #endif /* CONFIG_SYSCTL */
> @@ -261,7 +257,7 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
>  	put_ucounts(ucounts);
>  }
>  
> -long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
> +long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
>  {
>  	struct ucounts *iter;
>  	long max = LONG_MAX;
> @@ -273,12 +269,12 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
>  			ret = LONG_MAX;
>  		else if (iter == ucounts)
>  			ret = new;
> -		max = READ_ONCE(iter->ns->ucount_max[type]);
> +		max = get_userns_rlimit_max(iter->ns, type);
>  	}
>  	return ret;
>  }
>  
> -bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
> +bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
>  {
>  	struct ucounts *iter;
>  	long new = -1; /* Silence compiler warning */
> @@ -292,7 +288,7 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
>  }
>  
>  static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
> -				struct ucounts *last, enum ucount_type type)
> +				struct ucounts *last, enum rlimit_type type)
>  {
>  	struct ucounts *iter, *next;
>  	for (iter = ucounts; iter != last; iter = next) {
> @@ -304,12 +300,12 @@ static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
>  	}
>  }
>  
> -void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type)
> +void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>  {
>  	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
>  }
>  
> -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>  {
>  	/* Caller must hold a reference to ucounts */
>  	struct ucounts *iter;
> @@ -322,7 +318,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
>  			goto unwind;
>  		if (iter == ucounts)
>  			ret = new;
> -		max = READ_ONCE(iter->ns->ucount_max[type]);
> +		max = get_userns_rlimit_max(iter->ns, type);
>  		/*
>  		 * Grab an extra ucount reference for the caller when
>  		 * the rlimit count was previously 0.
> @@ -341,16 +337,16 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
>  	return 0;
>  }
>  
> -bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long rlimit)
> +bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long rlimit)
>  {
>  	struct ucounts *iter;
>  	long max = rlimit;
>  	if (rlimit > LONG_MAX)
>  		max = LONG_MAX;
>  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> -		if (get_ucounts_value(iter, type) > max)
> +		if (get_rlimit_value(iter, type) > max)
>  			return true;
> -		max = READ_ONCE(iter->ns->ucount_max[type]);
> +		max = get_userns_rlimit_max(iter->ns, type);
>  	}
>  	return false;
>  }
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 6b2e3ca7ee99..b9f6729b4e5f 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -119,13 +119,13 @@ int create_user_ns(struct cred *new)
>  	ns->owner = owner;
>  	ns->group = group;
>  	INIT_WORK(&ns->work, free_user_ns);
> -	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
> +	for (i = 0; i < UCOUNT_COUNTS; i++) {
>  		ns->ucount_max[i] = INT_MAX;
>  	}
> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
> +	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
> +	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
> +	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
> +	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
>  	ns->ucounts = ucounts;
>  
>  	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
