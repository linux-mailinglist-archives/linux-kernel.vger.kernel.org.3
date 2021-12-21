Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6646647C529
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbhLURoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:44:12 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:46370 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhLURoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:44:11 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:42078)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzjBK-003rMf-7T; Tue, 21 Dec 2021 10:44:10 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:54442 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzjBI-00HXW0-Sq; Tue, 21 Dec 2021 10:44:09 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211221231611.785b74cf@canb.auug.org.au>
Date:   Tue, 21 Dec 2021 11:44:02 -0600
In-Reply-To: <20211221231611.785b74cf@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 21 Dec 2021 23:16:11 +1100")
Message-ID: <875yrh7t0d.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mzjBI-00HXW0-Sq;;;mid=<875yrh7t0d.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oYvphKpbGitcm8wW+4EsRngH9CcAlGDY=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4740]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Stephen Rothwell <sfr@canb.auug.org.au>
X-Spam-Relay-Country: 
X-Spam-Timing: total 557 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (1.6%), b_tie_ro: 8 (1.4%), parse: 1.21 (0.2%),
        extract_message_metadata: 14 (2.6%), get_uri_detail_list: 1.76 (0.3%),
        tests_pri_-1000: 5 (0.9%), tests_pri_-950: 1.35 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 90 (16.2%), check_bayes:
        89 (15.9%), b_tokenize: 7 (1.3%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 68 (12.2%), b_finish: 0.98
        (0.2%), tests_pri_0: 245 (43.9%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 165 (29.6%), tests_pri_10:
        3.0 (0.5%), tests_pri_500: 183 (32.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux-next: run time warning after merge of the userns tree
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> [I am just guessing at the userns tree.]

It is.  This is a real brown paper bag bug.  Somehow I got the sense
of the test wrong and did not notice the warning in my own testing.

The fix is just:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0404a8c572a1..ee222b89c692 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9425,7 +9425,7 @@ void __init sched_init(void)
         * if we want to avoid special-casing it in code that deals with per-CPU
         * kthreads.
         */
-       WARN_ON(set_kthread_struct(current));
+       WARN_ON(!set_kthread_struct(current));
 
        /*
         * Make us the idle thread. Technically, schedule() should not be


I will get that fixed in my for-next branch shortly.



>
> My qemu boot test of a powerpc pseries_le_defconfig kernel produced
> this warning:
>
>   SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>   ftrace: allocating 33453 entries in 13 pages
>   ftrace: allocated 13 pages with 3 groups
>   trace event string verifier disabled
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:9469 sched_init+0x45c/0x4f4
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper Not tainted 5.16.0-rc6 #2
>   NIP:  c000000002027c98 LR: c000000002027c94 CTR: 0000000000000000
>   REGS: c00000000278bb80 TRAP: 0700   Not tainted  (5.16.0-rc6)
>   MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 84000220  XER: 00000000
>   CFAR: c00000000016c1fc IRQMASK: 1 
>   GPR00: c000000002027c94 c00000000278be20 c00000000278d300 0000000000000001 
>   GPR04: c000000000f88788 c000000002865d98 c000000007070680 0000000000000001 
>   GPR08: 000000007dae0000 c000000007070630 0000000000000000 0000000000000001 
>   GPR12: 0000000000000000 c000000002970000 0000000000000000 0000000000000000 
>   GPR16: 0000000002bf00d0 c0000000027c1f38 c00000000017e510 c000000002867f00 
>   GPR20: c0000000025306b8 c00000000017b520 c00000000017b200 c0000000028682b8 
>   GPR24: 0000000000000400 0000000000000000 c0000000027c2470 c0000000027b3a00 
>   GPR28: c0000000021af900 0000000000000800 0000000000000000 c00000007fc8f900 
>   NIP [c000000002027c98] sched_init+0x45c/0x4f4
>   LR [c000000002027c94] sched_init+0x458/0x4f4
>   Call Trace:
>   [c00000000278be20] [c000000002027c94] sched_init+0x458/0x4f4 (unreliable)
>   [c00000000278bed0] [c000000002004200] start_kernel+0x53c/0x8cc
>   [c00000000278bf90] [c00000000000d39c] start_here_common+0x1c/0x600
>   Instruction dump:
>   90ea0188 f92a0180 3d22fffb 39291890 39490050 7d005028 31080001 7d00512d 
>   40c2fff4 e86d0908 4a144499 60000000 <0b030000> a08d0008 e86d0908 4bfff849 
>   ---[ end trace 0000000000000000 ]---
>
> Exposed by commit
>
>   40966e316f86 ("kthread: Ensure struct kthread is present for all kthreads")
