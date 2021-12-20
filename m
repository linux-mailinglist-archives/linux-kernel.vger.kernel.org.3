Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5501947A4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 06:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhLTF7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 00:59:17 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34700 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhLTF7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 00:59:16 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:34638)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzBhZ-006dMV-FK; Sun, 19 Dec 2021 22:59:13 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:60214 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzBhY-00GgKZ-0F; Sun, 19 Dec 2021 22:59:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Alexey Gladkov <legion@kernel.org>, Yu Zhao <yuzhao@google.com>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <YZV7Z+yXbsx9p3JN@fixkernel.com>
        <875ysptfgi.fsf@email.froward.int.ebiederm.org>
        <YZa4YbcOyjtD3+pL@fixkernel.com>
        <87k0h5rxle.fsf@email.froward.int.ebiederm.org>
        <YZ6zXEZf9qHLFyIp@fixkernel.com> <YaBxzDGyWxU/836N@fixkernel.com>
Date:   Sun, 19 Dec 2021 23:58:41 -0600
In-Reply-To: <YaBxzDGyWxU/836N@fixkernel.com> (Qian Cai's message of "Fri, 26
        Nov 2021 00:34:04 -0500")
Message-ID: <8735mnakby.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mzBhY-00GgKZ-0F;;;mid=<8735mnakby.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/i5m39/w9z3yfj25x+T+tm7KVnWHxWY00=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0966]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Qian Cai <quic_qiancai@quicinc.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 823 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (1.5%), b_tie_ro: 10 (1.3%), parse: 1.03
        (0.1%), extract_message_metadata: 13 (1.6%), get_uri_detail_list: 1.98
        (0.2%), tests_pri_-1000: 5 (0.6%), tests_pri_-950: 1.32 (0.2%),
        tests_pri_-900: 1.16 (0.1%), tests_pri_-90: 403 (49.0%), check_bayes:
        390 (47.4%), b_tokenize: 8 (1.0%), b_tok_get_all: 10 (1.2%),
        b_comp_prob: 2.9 (0.4%), b_tok_touch_all: 364 (44.3%), b_finish: 1.14
        (0.1%), tests_pri_0: 370 (44.9%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 3.2 (0.4%), poll_dns_idle: 1.32 (0.2%), tests_pri_10:
        2.9 (0.4%), tests_pri_500: 10 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: BUG: KASAN: use-after-free in dec_rlimit_ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <quic_qiancai@quicinc.com> writes:

> On Wed, Nov 24, 2021 at 04:49:19PM -0500, Qian Cai wrote:
>> Hmm, I don't know if that or it is just this platfrom is lucky to trigger
>> the race condition quickly, but I can't reproduce it on x86 so far. I am
>> Cc'ing a few arm64 people to see if they have spot anything I might be
>> missing. The original bug report is here:
>> 
>> https://lore.kernel.org/lkml/YZV7Z+yXbsx9p3JN@fixkernel.com/
>
> Okay, I am finally able to reproduce this on x86_64 with the latest
> mainline as well by setting CONFIG_USER_NS and KASAN on the top of
> defconfig (I did not realize it did not select CONFIG_USER_NS in the first
> place). Anyway, it still took less than 5-minute by running:
>
> $ trinity -C 48

It took me a while to get to the point of reproducing this but I can
confirm I see this with 2 core VM, running 5.16.0-rc4.

Running trinity 2019.06 packaged in debian 11.

I didn't watch so I don't know if it was 5 minutes but I do know it took
less than an hour.

Now I am puzzled why there are not other reports of problems.

Now to start drilling down to figure out why the user namespace was
freed early.
----

The failure I got looked like:
> BUG: KASAN: use-after-free in dec_rlimit_ucounts+0x7b/0xb0
> Read of size 8 at addr ffff88800b7dd018 by task trinity-c3/67982
> 
> CPU: 1 PID: 67982 Comm: trinity-c3 Tainted: G  O 5.16.0-rc4 #1
> Hardware name: Xen HVM domU, BIOS 4.8.5-35.fc25 08/25/2021
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x48/0x5e
>  print_address_descrtion.constprop.0+0x1f/0x140
>  ? dec_rlimit_ucounts+0x7b/0xb0
>  ? dec_rlimit_ucounts+0x7b/0xb0
>  kasan_report.cold+0x7f/0xe0
>  ? _raw_spin_lock+0x7f/0x11b
>  ? dec_rlimit_ucounts+0x7b/0xb0
>  dec_rlimit_ucounts+0x7b/0xb0
>  mqueue_evict_inode+0x417/0x590
>  ? perf_trace_global_dirty_state+0x350/0x350
>  ? __x64_sys_mq_unlink+0x250/0x250
>  ? _raw_spin_lock_bh+0xe0/0xe0
>  ? _raw_spin_lock_bh+0xe0/0xe0
>  evict+0x155/0x2a0
>  __x64_sys_mq_unlink+0x1a7/0x250
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f0505ebc9b9
> Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 00 0f 1f 44 00 00 48 89 ....
> 
> Allocated by task 67717
> Freed by task 6027
> 
> The buggy address belongs to the object at ffff88800b7dce38
>  which belongs to the cache user_namespace of size 600
> The buggy address is located 480 bytes inside of
>  600-byte region [ffff88800b7dce38, ffff88800b7dd090]
> The buggy address belongs to the page:
> 
> trinity: Detected kernel tainting. Last seed was 1891442794

Eric
