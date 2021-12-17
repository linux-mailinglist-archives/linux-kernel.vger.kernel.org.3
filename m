Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29143479245
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhLQRBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:01:52 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:40194 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhLQRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:01:50 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:39618)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1myGc9-00F4QN-49; Fri, 17 Dec 2021 10:01:49 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:39676 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1myGc7-008PnM-I4; Fri, 17 Dec 2021 10:01:48 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     kernel test robot <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20211216102956.GC10708@xsang-OptiPlex-9020>
Date:   Fri, 17 Dec 2021 11:01:41 -0600
In-Reply-To: <20211216102956.GC10708@xsang-OptiPlex-9020> (kernel test robot's
        message of "Thu, 16 Dec 2021 18:29:56 +0800")
Message-ID: <878rwjf9my.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1myGc7-008PnM-I4;;;mid=<878rwjf9my.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/4izyAnNpNnn9ME7g+2eFUG5FCcK/5Zts=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4891]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;kernel test robot <oliver.sang@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 477 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 22 (4.5%), b_tie_ro: 20 (4.2%), parse: 1.26
        (0.3%), extract_message_metadata: 25 (5.2%), get_uri_detail_list: 1.72
        (0.4%), tests_pri_-1000: 22 (4.6%), tests_pri_-950: 1.83 (0.4%),
        tests_pri_-900: 1.42 (0.3%), tests_pri_-90: 148 (31.1%), check_bayes:
        129 (26.9%), b_tokenize: 8 (1.6%), b_tok_get_all: 6 (1.4%),
        b_comp_prob: 3.0 (0.6%), b_tok_touch_all: 104 (21.8%), b_finish: 4.5
        (0.9%), tests_pri_0: 235 (49.3%), check_dkim_signature: 0.73 (0.2%),
        check_dkim_adsp: 17 (3.5%), poll_dns_idle: 1.66 (0.3%), tests_pri_10:
        3.2 (0.7%), tests_pri_500: 11 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [kthread]  40966e316f: WARNING:at_kernel/sched/core.c:#sched_init
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <oliver.sang@intel.com> writes:

> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 40966e316f86b8cfd83abd31ccb4df729309d3e7 ("kthread: Ensure struct kthread is present for all kthreads")
> https://git.kernel.org/cgit/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
>
> in testcase: trinity
> version: trinity-x86_64-608712d8-1_20211207
> with following parameters:
>
> 	runtime: 300s
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):


Ok. That is very weird.  I will dig into it.

Silly question is there anything in this testing to cause memory
allocations to fail early in boot?

Eric
