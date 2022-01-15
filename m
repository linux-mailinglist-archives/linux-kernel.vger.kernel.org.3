Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2448F358
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiAOAHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:07:52 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:40294 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiAOAHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:07:51 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:59370)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n8Wbk-00DMyZ-OK; Fri, 14 Jan 2022 17:07:48 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:35432 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n8Wbi-007vuP-E5; Fri, 14 Jan 2022 17:07:48 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <20220112134211.GA10024@xsang-OptiPlex-9020>
        <874k68pyag.fsf@email.froward.int.ebiederm.org>
        <20220113021704.GA18396@xsang-OptiPlex-9020>
Date:   Fri, 14 Jan 2022 18:07:39 -0600
In-Reply-To: <20220113021704.GA18396@xsang-OptiPlex-9020> (Oliver Sang's
        message of "Thu, 13 Jan 2022 10:17:04 +0800")
Message-ID: <87y23hkgj8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n8Wbi-007vuP-E5;;;mid=<87y23hkgj8.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/McjTzzKV4lUmYllqnij+TV0vdFPRhcvc=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2009]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oliver Sang <oliver.sang@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1477 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 13 (0.9%), b_tie_ro: 10 (0.7%), parse: 1.70
        (0.1%), extract_message_metadata: 15 (1.0%), get_uri_detail_list: 1.54
        (0.1%), tests_pri_-1000: 15 (1.0%), tests_pri_-950: 1.44 (0.1%),
        tests_pri_-900: 1.13 (0.1%), tests_pri_-90: 64 (4.3%), check_bayes: 62
        (4.2%), b_tokenize: 7 (0.5%), b_tok_get_all: 7 (0.5%), b_comp_prob:
        2.4 (0.2%), b_tok_touch_all: 42 (2.8%), b_finish: 0.95 (0.1%),
        tests_pri_0: 1343 (90.9%), check_dkim_signature: 0.65 (0.0%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 0.67 (0.0%), tests_pri_10:
        3.1 (0.2%), tests_pri_500: 15 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [ucounts]  59ec71575a:  will-it-scale.per_process_ops -10.3%
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Sang <oliver.sang@intel.com> writes:

> Hi Eric,
>
> On Wed, Jan 12, 2022 at 01:08:23PM -0600, Eric W. Biederman wrote:
>> kernel test robot <oliver.sang@intel.com> writes:
>> 
>> > Greeting,
>> >
>> > FYI, we noticed a -10.3% regression of will-it-scale.per_process_ops due to commit:
>> 
>> 
>> I am having a bit of a challenge reading this report.  Does the -10.3%
>> mean that will-it-scale.per_process_ops is performing 70873 operations
>> per second instead of 78995 aka -10.3% fewer operations per second?
>
> yes
>
>> 
>> The per-profile.self-cycles-pp.do_dec_rlimits_put_ucounts now takes +2.6
>> more cycles, and perf-profile.self.cycles.pp.inc_rlimit_get_ucounts now
>> takes +3.8 more cycles.
>> 
>> Which if I read this correctly is a regression report about two
>> functions taking 3 or 4 cycles more after the code was rearranged inside
>> of them.
>> 
>> Is that correct?  Is this a regression report saying those two functions
>> are taking a few cycles more which leads to
>> will-it-scale.per_process_ops not being able to perform as many
>> operations per second?
>
> yes
>
>> 
>> Given the change in the commit mentioned I think this is all down to a
>> bug fix causing the code to be rearranged and a compiler optimizations.
>> 
>> I don't see much room to do anything about this.
>
> got it. this is a bug fix. Thanks for explanation!

The big surprise is that we haven't seen performance regressions up
until this point as the ucount rlimit work was merged.

Unless we can spot something very silly that the compiler is doing
with code generation (and those 3 or 4 cycles suggests it is possible
the compiler is being silly) it is going to take some reorganizing
to improve the performance.

Eric
