Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D058247379D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbhLMWev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:34:51 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:38562 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbhLMWed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:34:33 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:45134)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwttw-007zvI-4D; Mon, 13 Dec 2021 15:34:32 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:59454 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwttv-00CWgI-0z; Mon, 13 Dec 2021 15:34:31 -0700
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
References: <20211213220401.1039578-1-brho@google.com>
Date:   Mon, 13 Dec 2021 16:34:04 -0600
In-Reply-To: <20211213220401.1039578-1-brho@google.com> (Barret Rhoden's
        message of "Mon, 13 Dec 2021 17:04:01 -0500")
Message-ID: <8735mww2w3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mwttv-00CWgI-0z;;;mid=<8735mww2w3.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ilNAxJXurZ5jl8Voq6UpIBODNwxZ0rS0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_Investor,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_B_Investor BODY: Commonly used business phishing phrases
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Barret Rhoden <brho@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 475 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.1%), b_tie_ro: 9 (1.9%), parse: 1.10 (0.2%),
         extract_message_metadata: 3.9 (0.8%), get_uri_detail_list: 1.71
        (0.4%), tests_pri_-1000: 4.0 (0.9%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 0.96 (0.2%), tests_pri_-90: 163 (34.3%), check_bayes:
        161 (34.0%), b_tokenize: 7 (1.5%), b_tok_get_all: 7 (1.5%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 141 (29.8%), b_finish: 0.84
        (0.2%), tests_pri_0: 267 (56.2%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.58 (0.1%), tests_pri_10:
        2.5 (0.5%), tests_pri_500: 13 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] rlimits: do not grab tasklist_lock for do_prlimit on current
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> The tasklist_lock can be a scalability bottleneck.  For current tasks,
> we don't need the tasklist_lock to protect tsk->sighand or tsk->signal.
> If non-current callers become a bottleneck, we could use
> lock_task_sighand().

Do you have any numbers?  As the entire point of this change is
performance it would be good to see how the performance changes.

Especially as a read_lock should not be too bad as it allows sharing,
nor do I expect reading or writing the rlimit values to be particularly
frequent.  So some insight into what kinds of userspace patterns make
this a problem would be nice.

This change is a bit scary as it makes taking a lock conditional and
increases the probability of causing a locking mistake.

If you are going to make this change I would say that do_prlimit should
become static and taking the tasklist_lock should move into prlimit64.


Looking a little closer it looks like that update_rlimit_cpu should use
lock_task_sighand, and once lock_task_sighand is used there is actually
no need for the tasklist_lock at all.  As holding the reference to tsk
guarantees that tsk->signal remains valid.

So I completely agree there are cleanups that can happen in this area.
Please make those and show numbers in how they improve things, instead
of making the code worse with a conditional lock.

Eric


> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  kernel/sys.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 8fdac0d90504..e56d1ae910af 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1576,7 +1576,8 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
>  	}
>  
>  	/* protect tsk->signal and tsk->sighand from disappearing */
> -	read_lock(&tasklist_lock);
> +	if (tsk != current)
> +		read_lock(&tasklist_lock);
>  	if (!tsk->sighand) {
>  		retval = -ESRCH;
>  		goto out;
> @@ -1611,7 +1612,8 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
>  	     IS_ENABLED(CONFIG_POSIX_TIMERS))
>  		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
>  out:
> -	read_unlock(&tasklist_lock);
> +	if (tsk != current)
> +		read_unlock(&tasklist_lock);
>  	return retval;
>  }
