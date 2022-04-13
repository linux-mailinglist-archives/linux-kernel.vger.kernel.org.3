Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA74FFA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiDMPtt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Apr 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiDMPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:49:46 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC2D66214
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:47:23 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59624)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nefDF-0062ZF-FB; Wed, 13 Apr 2022 09:47:21 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:60598 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nefDD-00FrVt-4O; Wed, 13 Apr 2022 09:47:20 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, <keescook@chromium.org>,
        <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
        <elver@google.com>, <legion@kernel.org>, <oleg@redhat.com>,
        <brauner@kernel.org>
References: <aff07d75-622c-9bab-863c-0917c79da3c4@huawei.com>
        <fff65bc3-0b73-3c5e-0f31-bd5404f75353@huawei.com>
        <e70b350e-abfc-7f8d-4590-d18801a9a722@huawei.com>
Date:   Wed, 13 Apr 2022 10:47:12 -0500
In-Reply-To: <e70b350e-abfc-7f8d-4590-d18801a9a722@huawei.com> (Zhang Qiao's
        message of "Wed, 13 Apr 2022 09:56:29 +0800")
Message-ID: <87ilrd2dfj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nefDD-00FrVt-4O;;;mid=<87ilrd2dfj.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX183uWT3/BdaXd5sHej2Mh09utR4YSt9oPM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Zhang Qiao <zhangqiao22@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 919 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.1%), b_tie_ro: 9 (1.0%), parse: 1.23 (0.1%),
         extract_message_metadata: 16 (1.8%), get_uri_detail_list: 4.7 (0.5%),
        tests_pri_-1000: 5 (0.6%), tests_pri_-950: 1.38 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 209 (22.7%), check_bayes:
        202 (22.0%), b_tokenize: 18 (1.9%), b_tok_get_all: 77 (8.3%),
        b_comp_prob: 4.0 (0.4%), b_tok_touch_all: 99 (10.8%), b_finish: 1.07
        (0.1%), tests_pri_0: 653 (71.0%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 3.7 (0.4%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        3.1 (0.3%), tests_pri_500: 14 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Question about kill a process group
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Qiao <zhangqiao22@huawei.com> writes:

> Gentle ping. Any comments on this problem?

Is fork12 a new test?

Is there a real world use case that connects to this?

How many children are being created in this test?  Several million?

I would like to blame this on the old issue that tasklist_lock being
a global lock.  Given the number of child processes (as many as can be
created) I don't think we are hurt much by using a global lock.  The
problem for solubility is that we have a lock.

Fundamentally there must be a lock taken to maintain the parent's
list of children.

I only see SIGQUIT being called once in the parent process so that
should not be an issue.

There is a minor issue in fork12 that it calls exit(0) instead of
_exit(0) in the children.  Not the problem you are dealing with
but it does look like it can be a distraction.

I suspect the issue really is the thundering hurd of a million+
processes synchronizing on a single lock.

I don't think this is a hard lockup, just a global slow down.
I expect everything will eventually exit.


To do something about this is going to take a deep and fundamental
redesign of how we maintain process lists to handle a parent
with millions of children well.

Is there any real world reason to care about this case?  Without
real world motivation I am inclined to just note that this is
something that is handled poorly, and leave it as is.

Eric

>
> 在 2022/4/2 10:22, Zhang Qiao 写道:
>> ping...
>> 
>> Any suggestions for this problem？
>> 
>> thank!
>> Qiao
>> 
>> 
>> 在 2022/3/29 16:07, Zhang Qiao 写道:
>>> hello everyone,
>>>
>>> I got a hradlockup panic when run the ltp syscall testcases.
>>>
>>> 348439.713178] NMI watchdog: Watchdog detected hard LOCKUP on cpu 32
>>> [348439.713236] irq event stamp: 0
>>> [348439.713237] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>>> [348439.713238] hardirqs last disabled at (0): [<ffffffff87cd1ea5>] copy_process+0x7f5/0x2160
>>> [348439.713239] softirqs last  enabled at (0): [<ffffffff87cd1ea5>] copy_process+0x7f5/0x2160
>>> [348439.713240] softirqs last disabled at (0): [<0000000000000000>] 0x0
>>> [348439.713241] CPU: 32 PID: 1151212 Comm: fork12 Kdump: loaded Tainted: G S                5.10.0+ #1
>>> [348439.713242] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 3.35 10/20/2016
>>> [348439.713243] RIP: 0010:queued_write_lock_slowpath+0x4d/0x80
>>> [348439.713245] RSP: 0018:ffffa3a6bed4fe60 EFLAGS: 00000006
>>> [348439.713246] RAX: 0000000000000500 RBX: ffffffff892060c0 RCX: 00000000000000ff
>>> [348439.713247] RDX: 0000000000000500 RSI: 0000000000000100 RDI: ffffffff892060c0
>>> [348439.713248] RBP: ffffffff892060c4 R08: 0000000000000001 R09: 0000000000000000
>>> [348439.713249] R10: ffffa3a6bed4fde8 R11: 0000000000000000 R12: ffff96dfd3b68001
>>> [348439.713250] R13: ffff96dfd3b68000 R14: ffff96dfd3b68c38 R15: ffff96e2cf1f51c0
>>> [348439.713251] FS:  0000000000000000(0000) GS:ffff96edbc200000(0000) knlGS:0000000000000000
>>> [348439.713252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [348439.713253] CR2: 0000000000416ea0 CR3: 0000002d91812004 CR4: 00000000001706e0
>>> [348439.713254] Call Trace:
>>> [348439.713255]  do_raw_write_lock+0xa9/0xb0
>>> [348439.713256]  _raw_write_lock_irq+0x5a/0x70
>>> [348439.713256]  do_exit+0x429/0xd00
>>> [348439.713257]  do_group_exit+0x39/0xb0
>>> [348439.713258]  __x64_sys_exit_group+0x14/0x20
>>> [348439.713259]  do_syscall_64+0x33/0x40
>>> [348439.713260]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [348439.713260] RIP: 0033:0x7f59295a7066
>>> [348439.713261] Code: Unable to access opcode bytes at RIP 0x7f59295a703c.
>>> [348439.713262] RSP: 002b:00007fff0afeac38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>>> [348439.713264] RAX: ffffffffffffffda RBX: 00007f5929694530 RCX: 00007f59295a7066
>>> [348439.713265] RDX: 0000000000000002 RSI: 000000000000003c RDI: 0000000000000002
>>> [348439.713266] RBP: 0000000000000002 R08: 00000000000000e7 R09: ffffffffffffff80
>>> [348439.713267] R10: 0000000000000002 R11: 0000000000000246 R12: 00007f5929694530
>>> [348439.713268] R13: 0000000000000001 R14: 00007f5929697f68 R15: 0000000000000000
>>> [348439.713269] Kernel panic - not syncing: Hard LOCKUP
>>> [348439.713270] CPU: 32 PID: 1151212 Comm: fork12 Kdump: loaded Tainted: G S                5.10.0+ #1
>>> [348439.713272] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 3.35 10/20/2016
>>> [348439.713272] Call Trace:
>>> [348439.713273]  <NMI>
>>> [348439.713274]  dump_stack+0x77/0x97
>>> [348439.713275]  panic+0x10c/0x2fb
>>> [348439.713275]  nmi_panic+0x35/0x40
>>> [348439.713276]  watchdog_hardlockup_check+0xeb/0x110
>>> [348439.713277]  __perf_event_overflow+0x52/0xf0
>>> [348439.713278]  handle_pmi_common+0x21a/0x320
>>> [348439.713286]  intel_pmu_handle_irq+0xc9/0x1b0
>>> [348439.713287]  perf_event_nmi_handler+0x24/0x40
>>> [348439.713288]  nmi_handle+0xc3/0x2a0
>>> [348439.713289]  default_do_nmi+0x49/0xf0
>>> [348439.713289]  exc_nmi+0x146/0x160
>>> [348439.713290]  end_repeat_nmi+0x16/0x55
>>> [348439.713291] RIP: 0010:queued_write_lock_slowpath+0x4d/0x80
>>> [348439.713293] RSP: 0018:ffffa3a6bed4fe60 EFLAGS: 00000006
>>> [348439.713295] RAX: 0000000000000500 RBX: ffffffff892060c0 RCX: 00000000000000ff
>>> [348439.713296] RDX: 0000000000000500 RSI: 0000000000000100 RDI: ffffffff892060c0
>>> [348439.713296] RBP: ffffffff892060c4 R08: 0000000000000001 R09: 0000000000000000
>>> [348439.713297] R10: ffffa3a6bed4fde8 R11: 0000000000000000 R12: ffff96dfd3b68001
>>> [348439.713298] R13: ffff96dfd3b68000 R14: ffff96dfd3b68c38 R15: ffff96e2cf1f51c0
>>> [348439.713300]  </NMI>
>>> [348439.713301]  do_raw_write_lock+0xa9/0xb0
>>> [348439.713302]  _raw_write_lock_irq+0x5a/0x70
>>> [348439.713303]  do_exit+0x429/0xd00
>>> [348439.713303]  do_group_exit+0x39/0xb0
>>> [348439.713304]  __x64_sys_exit_group+0x14/0x20
>>> [348439.713305]  do_syscall_64+0x33/0x40
>>> [348439.713306]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [348439.713307] RIP: 0033:0x7f59295a7066
>>> [348439.713308] Code: Unable to access opcode bytes at RIP 0x7f59295a703c.
>>>
>>>
>>> when analyzing vmcore, i notice lots of fork12 processes are waiting for tasklist read lock or write
>>> lock (see the attachment file all_cpu_stacks.log)，and every fork12 process(belongs to the same
>>> process group) call kill(0, SIGQUIT) in their signal handler()[1], it will traverse all the processes in the
>>> same process group and send signal to them one by one, which is a very time-costly work and hold tasklist
>>> read lock long time. At the same time, other processes will exit after receive signal, they try to get
>>> the tasklist write lock at exit_notify().
>>>
>>> [1] fork12 testcase: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fork/fork12.c
>>>
>>> some processes call kill(0, SIGQUIT), wait for tasklist read lock:
>>>
>>>  #5 [ffff972a9b16fd78] native_queued_spin_lock_slowpath at ffffffff9931ed47
>>>  #6 [ffff972a9b16fd78] queued_read_lock_slowpath at ffffffff99320a58
>>>  #7 [ffff972a9b16fd90] do_wait at ffffffff992bc17d
>>>  #8 [ffff972a9b16fdd0] kernel_wait4 at ffffffff992bd88d
>>>  #9 [ffff972a9b16fe58] __do_sys_wait4 at ffffffff992bd9e5
>>> #10 [ffff972a9b16ff30] do_syscall_64 at ffffffff9920432d
>>> #11 [ffff972a9b16ff50] entry_SYSCALL_64_after_hwframe at ffffffff99c000ad
>>>
>>> As the same time, some processes are exiting, wait for tasklist write lock:
>>>
>>>  #5 [ffff972aa49a7e60] native_queued_spin_lock_slowpath at ffffffff9931ecb0
>>>  #6 [ffff972aa49a7e60] queued_write_lock_slowpath at ffffffff993209e4
>>>  #7 [ffff972aa49a7e78] do_raw_write_lock at ffffffff99320834
>>>  #8 [ffff972aa49a7e88] do_exit at ffffffff992bcd78
>>>  #9 [ffff972aa49a7f00] do_group_exit at ffffffff992bd719
>>> #10 [ffff972aa49a7f28] __x64_sys_exit_group at ffffffff992bd7a4
>>> #11 [ffff972aa49a7f30] do_syscall_64 at ffffffff9920432d
>>> #12 [ffff972aa49a7f50] entry_SYSCALL_64_after_hwframe at ffffffff99c000ad
>>>
>>> In this scenario,there are lots of process are waiting for tasklist read lock or the tasklist
>>> write lock, so they will queue. if the wait queue is long enough, it might cause a hardlockup issue when a
>>> process wait for taking the write lock at exit_notify().
>>>
>>> I tried to solve this problem by avoiding traversing the process group multiple times when kill(0, xxxx)
>>> is called multiple times form the same process group, but it doesn't look like a good solution.
>>>
>>> Is there any good idea for fixing this problem ?
>>>
>>> Thanks!
>>>
>>> Qiao
>>> .
>>>
>> .
>> 
