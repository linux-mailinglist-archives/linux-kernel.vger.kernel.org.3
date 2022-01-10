Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD5489D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiAJQ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:26:40 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:58132 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbiAJQ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:26:40 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:49204)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6xVD-009LjY-KR; Mon, 10 Jan 2022 09:26:36 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:47318 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6xVC-005eir-3g; Mon, 10 Jan 2022 09:26:35 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        kernel test robot <lkp@intel.com>
References: <0f0408bb7fbf3187966a9bf19a98642a5d9669fe.1641225760.git.legion@kernel.org>
        <792dcae82bc228cd0bec1fa80ed4d2c9340b0f8f.1641296947.git.legion@kernel.org>
Date:   Mon, 10 Jan 2022 10:26:26 -0600
In-Reply-To: <792dcae82bc228cd0bec1fa80ed4d2c9340b0f8f.1641296947.git.legion@kernel.org>
        (Alexey Gladkov's message of "Tue, 4 Jan 2022 12:51:06 +0100")
Message-ID: <87tuebwo99.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n6xVC-005eir-3g;;;mid=<87tuebwo99.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18rr2GOYbq36H9qfHFpHcwhS06Mxte5yNU=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 847 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.4 (0.5%), b_tie_ro: 3.0 (0.4%), parse: 1.82
        (0.2%), extract_message_metadata: 13 (1.6%), get_uri_detail_list: 4.5
        (0.5%), tests_pri_-1000: 4.0 (0.5%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 79 (9.3%), check_bayes: 77
        (9.1%), b_tokenize: 16 (1.9%), b_tok_get_all: 13 (1.5%), b_comp_prob:
        3.7 (0.4%), b_tok_touch_all: 42 (4.9%), b_finish: 0.75 (0.1%),
        tests_pri_0: 662 (78.2%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 59 (7.0%), tests_pri_10:
        2.7 (0.3%), tests_pri_500: 74 (8.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] ipc: Store mqueue sysctls in the ipc namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> Right now, the mqueue sysctls take ipc namespaces into account in a
> rather hacky way. This works in most cases, but does not respect the
> user namespace.
>
> Within the user namespace, the user cannot change the /proc/sys/fs/mqueue/*
> parametres. This poses a problem in the rootless containers.
>
> To solve this I changed the implementation of the mqueue sysctls just
> like some other sysctls.
>
> Before this change:
>
> $ echo 5 | unshare -r -U -i tee /proc/sys/fs/mqueue/msg_max
> tee: /proc/sys/fs/mqueue/msg_max: Permission denied
> 5
>
> After this change:
>
> $ echo 5 | unshare -r -U -i tee /proc/sys/fs/mqueue/msg_max
> 5
>
> v2:
> * Fixed compilation problem if CONFIG_POSIX_MQUEUE_SYSCTL is not
>   specified.

Can you split this in two patches?

The first that converts mq_sysctl.c and ipc_sysctl.c to live in
a per ipc namespace sysctl set.  That will just be a bug-fix/cleanup
patch.  

The second that modifies the permissions to allow root in the ipc
namespace to change the parameters.  With that second patch
we can have the discussion about when it is valid to allow
the user namespace root that created the ipc namespace to be able
to set the sysctls.

A few more comments below.


> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  include/linux/ipc_namespace.h |  18 ++++-
>  ipc/mq_sysctl.c               | 137 ++++++++++++++++++++--------------
>  ipc/mqueue.c                  |  10 +--
>  ipc/namespace.c               |   6 ++
>  4 files changed, 106 insertions(+), 65 deletions(-)
>
> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> index b75395ec8d52..bcedc86a6f1d 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -10,6 +10,7 @@
>  #include <linux/ns_common.h>
>  #include <linux/refcount.h>
>  #include <linux/rhashtable-types.h>
> +#include <linux/sysctl.h>
>  
>  struct user_namespace;
>  
> @@ -63,6 +64,11 @@ struct ipc_namespace {
>  	unsigned int    mq_msg_default;
>  	unsigned int    mq_msgsize_default;
>  
> +#ifdef CONFIG_POSIX_MQUEUE_SYSCTL
> +	struct ctl_table_set	set;
> +	struct ctl_table_header *sysctls;
> +#endif
> +

Updating the code to handle all of the ipc sysctls should
remove the need for the #ifdef here.

>  	/* user_ns which owns the ipc ns */
>  	struct user_namespace *user_ns;
>  	struct ucounts *ucounts;
> @@ -169,14 +175,18 @@ static inline void put_ipc_ns(struct ipc_namespace *ns)
>  
>  #ifdef CONFIG_POSIX_MQUEUE_SYSCTL
>  
> -struct ctl_table_header;
> -extern struct ctl_table_header *mq_register_sysctl_table(void);
> +void retire_mq_sysctls(struct ipc_namespace *ns);
> +bool setup_mq_sysctls(struct ipc_namespace *ns);
>  
>  #else /* CONFIG_POSIX_MQUEUE_SYSCTL */
>  
> -static inline struct ctl_table_header *mq_register_sysctl_table(void)
> +static inline void retire_mq_sysctls(struct ipc_namespace *ns)
>  {
> -	return NULL;
> +}
> +
> +static inline bool setup_mq_sysctls(struct ipc_namespace *ns)
> +{
> +	return true;
>  }
>  
>  #endif /* CONFIG_POSIX_MQUEUE_SYSCTL */
> diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
> index 72a92a08c848..56afb0503296 100644
> --- a/ipc/mq_sysctl.c
> +++ b/ipc/mq_sysctl.c
> @@ -9,39 +9,9 @@
>  #include <linux/ipc_namespace.h>
>  #include <linux/sysctl.h>
>  
> -#ifdef CONFIG_PROC_SYSCTL
> -static void *get_mq(struct ctl_table *table)
> -{
> -	char *which = table->data;
> -	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
> -	which = (which - (char *)&init_ipc_ns) + (char *)ipc_ns;
> -	return which;
> -}
> -
> -static int proc_mq_dointvec(struct ctl_table *table, int write,
> -			    void *buffer, size_t *lenp, loff_t *ppos)
> -{
> -	struct ctl_table mq_table;
> -	memcpy(&mq_table, table, sizeof(mq_table));
> -	mq_table.data = get_mq(table);
> -
> -	return proc_dointvec(&mq_table, write, buffer, lenp, ppos);
> -}
> -
> -static int proc_mq_dointvec_minmax(struct ctl_table *table, int write,
> -		void *buffer, size_t *lenp, loff_t *ppos)
> -{
> -	struct ctl_table mq_table;
> -	memcpy(&mq_table, table, sizeof(mq_table));
> -	mq_table.data = get_mq(table);
> -
> -	return proc_dointvec_minmax(&mq_table, write, buffer,
> -					lenp, ppos);
> -}
> -#else
> -#define proc_mq_dointvec NULL
> -#define proc_mq_dointvec_minmax NULL
> -#endif
> +#include <linux/stat.h>
> +#include <linux/capability.h>
> +#include <linux/slab.h>
>  
>  static int msg_max_limit_min = MIN_MSGMAX;
>  static int msg_max_limit_max = HARD_MSGMAX;
> @@ -55,14 +25,14 @@ static struct ctl_table mq_sysctls[] = {
>  		.data		= &init_ipc_ns.mq_queues_max,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_mq_dointvec,
> +		.proc_handler	= proc_dointvec,
>  	},
>  	{
>  		.procname	= "msg_max",
>  		.data		= &init_ipc_ns.mq_msg_max,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_mq_dointvec_minmax,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &msg_max_limit_min,
>  		.extra2		= &msg_max_limit_max,
>  	},
> @@ -71,7 +41,7 @@ static struct ctl_table mq_sysctls[] = {
>  		.data		= &init_ipc_ns.mq_msgsize_max,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_mq_dointvec_minmax,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &msg_maxsize_limit_min,
>  		.extra2		= &msg_maxsize_limit_max,
>  	},
> @@ -80,7 +50,7 @@ static struct ctl_table mq_sysctls[] = {
>  		.data		= &init_ipc_ns.mq_msg_default,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_mq_dointvec_minmax,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &msg_max_limit_min,
>  		.extra2		= &msg_max_limit_max,
>  	},
> @@ -89,32 +59,89 @@ static struct ctl_table mq_sysctls[] = {
>  		.data		= &init_ipc_ns.mq_msgsize_default,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_mq_dointvec_minmax,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &msg_maxsize_limit_min,
>  		.extra2		= &msg_maxsize_limit_max,
>  	},
>  	{}
>  };
>  
> -static struct ctl_table mq_sysctl_dir[] = {
> -	{
> -		.procname	= "mqueue",
> -		.mode		= 0555,
> -		.child		= mq_sysctls,
> -	},
> -	{}
> -};
> +static struct ctl_table_set *
> +set_lookup(struct ctl_table_root *root)
> +{
> +	return &current->nsproxy->ipc_ns->set;
> +}
>  
> -static struct ctl_table mq_sysctl_root[] = {
> -	{
> -		.procname	= "fs",
> -		.mode		= 0555,
> -		.child		= mq_sysctl_dir,
> -	},
> -	{}
> +static int set_is_seen(struct ctl_table_set *set)
> +{
> +	return &current->nsproxy->ipc_ns->set == set;
> +}
> +
> +static int set_permissions(struct ctl_table_header *head, struct ctl_table *table)
> +{
> +	struct ipc_namespace *ns = container_of(head->set, struct ipc_namespace, set);
> +	int mode;
> +
> +	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
> +	if (ns_capable(ns->user_ns, CAP_SYS_RESOURCE))
> +		mode = (table->mode & S_IRWXU) >> 6;
> +	else
> +	/* Allow all others at most read-only access */
> +		mode = table->mode & S_IROTH;
> +	return (mode << 6) | (mode << 3) | mode;
> +}

As a cleanup/bug-fix  please don't implemenet set_permissions.  If you
don't the default permissions that we use today will apply.

> +static struct ctl_table_root set_root = {
> +	.lookup = set_lookup,
> +	.permissions = set_permissions,
>  };
>  
> -struct ctl_table_header *mq_register_sysctl_table(void)
> +bool setup_mq_sysctls(struct ipc_namespace *ns)
>  {
> -	return register_sysctl_table(mq_sysctl_root);
> +	struct ctl_table *tbl;
> +
> +	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
> +
> +	tbl = kmemdup(mq_sysctls, sizeof(mq_sysctls), GFP_KERNEL);
> +	if (tbl) {
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(mq_sysctls); i++) {
> +			if (tbl[i].data == &init_ipc_ns.mq_queues_max)
> +				tbl[i].data = &ns->mq_queues_max;
> +
> +			else if (tbl[i].data == &init_ipc_ns.mq_msg_max)
> +				tbl[i].data = &ns->mq_msg_max;
> +
> +			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_max)
> +				tbl[i].data = &ns->mq_msgsize_max;
> +
> +			else if (tbl[i].data == &init_ipc_ns.mq_msg_default)
> +				tbl[i].data = &ns->mq_msg_default;
> +
> +			else if (tbl[i].data == &init_ipc_ns.mq_msgsize_default)
> +				tbl[i].data = &ns->mq_msgsize_default;
> +			else
> +				tbl[i].data = NULL;
> +		}
> +
> +		ns->sysctls = __register_sysctl_table(&ns->set, "fs/mqueue", tbl);
> +	}
> +	if (!ns->sysctls) {
> +		kfree(tbl);
> +		retire_sysctl_set(&ns->set);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +void retire_mq_sysctls(struct ipc_namespace *ns)
> +{
> +	struct ctl_table *tbl;
> +
> +	tbl = ns->sysctls->ctl_table_arg;
> +	unregister_sysctl_table(ns->sysctls);
> +	retire_sysctl_set(&ns->set);
> +	kfree(tbl);
>  }
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 5becca9be867..1b4a3be71636 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -163,8 +163,6 @@ static void remove_notification(struct mqueue_inode_info *info);
>  
>  static struct kmem_cache *mqueue_inode_cachep;
>  
> -static struct ctl_table_header *mq_sysctl_table;
> -
>  static inline struct mqueue_inode_info *MQUEUE_I(struct inode *inode)
>  {
>  	return container_of(inode, struct mqueue_inode_info, vfs_inode);
> @@ -1713,8 +1711,10 @@ static int __init init_mqueue_fs(void)
>  	if (mqueue_inode_cachep == NULL)
>  		return -ENOMEM;
>  
> -	/* ignore failures - they are not fatal */
> -	mq_sysctl_table = mq_register_sysctl_table();
> +	if (!setup_mq_sysctls(&init_ipc_ns)) {
> +		pr_warn("sysctl registration failed\n");
> +		return -ENOMEM;
> +	}
>  
>  	error = register_filesystem(&mqueue_fs_type);
>  	if (error)
> @@ -1731,8 +1731,6 @@ static int __init init_mqueue_fs(void)
>  out_filesystem:
>  	unregister_filesystem(&mqueue_fs_type);
>  out_sysctl:
> -	if (mq_sysctl_table)
> -		unregister_sysctl_table(mq_sysctl_table);
>  	kmem_cache_destroy(mqueue_inode_cachep);
>  	return error;
>  }
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index ae83f0f2651b..f760243ca685 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -59,6 +59,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  	if (err)
>  		goto fail_put;
>  
> +	err = -ENOMEM;
> +	if (!setup_mq_sysctls(ns))
> +		goto fail_put;
> +
Please make this handle all ipc sysctls not just the mq sysctls.

>  	sem_init_ns(ns);
>  	msg_init_ns(ns);
>  	shm_init_ns(ns);
> @@ -125,6 +129,8 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>  	msg_exit_ns(ns);
>  	shm_exit_ns(ns);
>  
> +	retire_mq_sysctls(ns);
> +
>  	dec_ipc_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
>  	ns_free_inum(&ns->ns);

Eric
