Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAFC47DE15
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 04:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbhLWDcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 22:32:00 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:51410 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346118AbhLWDcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 22:32:00 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:51904)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0Epi-008mQA-SW; Wed, 22 Dec 2021 20:31:58 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:43610 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0Eph-006HOx-QK; Wed, 22 Dec 2021 20:31:58 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20211216102956.GC10708@xsang-OptiPlex-9020>
        <878rwjf9my.fsf@email.froward.int.ebiederm.org>
        <20211223024800.GA33629@xsang-OptiPlex-9020>
Date:   Wed, 22 Dec 2021 21:31:22 -0600
In-Reply-To: <20211223024800.GA33629@xsang-OptiPlex-9020> (Oliver Sang's
        message of "Thu, 23 Dec 2021 10:48:00 +0800")
Message-ID: <87sfukuhdh.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n0Eph-006HOx-QK;;;mid=<87sfukuhdh.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/bP7KqkrHmc5YMN/6vkzc3zmxAuqpZSGI=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4790]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oliver Sang <oliver.sang@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 431 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 10 (2.3%), parse: 0.79
        (0.2%), extract_message_metadata: 15 (3.5%), get_uri_detail_list: 1.72
        (0.4%), tests_pri_-1000: 25 (5.7%), tests_pri_-950: 1.17 (0.3%),
        tests_pri_-900: 0.97 (0.2%), tests_pri_-90: 121 (28.0%), check_bayes:
        119 (27.5%), b_tokenize: 6 (1.5%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 98 (22.8%), b_finish: 0.84
        (0.2%), tests_pri_0: 242 (56.3%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.9 (0.7%), poll_dns_idle: 0.64 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 9 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [kthread]  40966e316f: WARNING:at_kernel/sched/core.c:#sched_init
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Sang <oliver.sang@intel.com> writes:

> hi Eric,
>
> On Fri, Dec 17, 2021 at 11:01:41AM -0600, Eric W. Biederman wrote:
>> kernel test robot <oliver.sang@intel.com> writes:
>> 
>> > Greeting,
>> >
>> > FYI, we noticed the following commit (built with gcc-9):
>> >
>> > commit: 40966e316f86b8cfd83abd31ccb4df729309d3e7 ("kthread: Ensure struct kthread is present for all kthreads")
>> > https://git.kernel.org/cgit/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
>> >
>> > in testcase: trinity
>> > version: trinity-x86_64-608712d8-1_20211207
>> > with following parameters:
>> >
>> > 	runtime: 300s
>> >
>> > test-description: Trinity is a linux system call fuzz tester.
>> > test-url: http://codemonkey.org.uk/projects/trinity/
>> >
>> >
>> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>> >
>> > caused below changes (please refer to attached dmesg/kmsg for entire
>> > log/backtrace):
>> 
>> 
>> Ok. That is very weird.  I will dig into it.
>> 
>> Silly question is there anything in this testing to cause memory
>> allocations to fail early in boot?
>
> we didn't observe it. actually test could finish for both this
> commit (though with reported warning) and parent. the only diff seems
> the reported warning.
>
> cead18552660702a 40966e316f86b8cfd83abd31ccb
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :8          100%           8:8     dmesg.RIP:sched_init
>            :8          100%           8:8     dmesg.WARNING:at_kernel/sched/core.c:#sched_init
>
> but could you check in dmesg we attached in original report for any suspicous
> memory issue?
>
> or could you help check the config we used (also attached in original report)
> to see if we can make some changes then to expose the possible memory issue,
> in case our current config cannot capture? Thanks

This was my bad.  I have pushed the fix out now.  I had the test
backwards in the WARN_ON.

My apologies for the noise.

Eric
