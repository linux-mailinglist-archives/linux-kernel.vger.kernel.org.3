Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E69474971
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhLNR3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:29:53 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:56336 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhLNR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:29:53 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:58034)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mxBcd-008v9o-8i; Tue, 14 Dec 2021 10:29:51 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57450 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mxBcc-00FFmx-8Q; Tue, 14 Dec 2021 10:29:50 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
In-Reply-To: <202112140949.Uq5sFKR1-lkp@intel.com> (kernel test robot's
        message of "Tue, 14 Dec 2021 10:03:44 +0800")
References: <202112140949.Uq5sFKR1-lkp@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 14 Dec 2021 11:29:05 -0600
Message-ID: <87k0g7t7ry.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mxBcc-00FFmx-8Q;;;mid=<87k0g7t7ry.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19h0VNo5s8nXykDpXipJKp9T2J51HuZjQY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=8.0 tests=ALL_TRUSTED,BAYES_00,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,
        T_TooManySym_05,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0004]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;kernel test robot <lkp@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 419 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 10 (2.4%), parse: 0.96
        (0.2%), extract_message_metadata: 17 (4.2%), get_uri_detail_list: 2.1
        (0.5%), tests_pri_-1000: 17 (4.1%), tests_pri_-950: 1.45 (0.3%),
        tests_pri_-900: 1.43 (0.3%), tests_pri_-90: 84 (20.0%), check_bayes:
        81 (19.4%), b_tokenize: 8 (1.8%), b_tok_get_all: 6 (1.4%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 61 (14.5%), b_finish: 1.13
        (0.3%), tests_pri_0: 265 (63.2%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 4.8 (1.1%), poll_dns_idle: 0.47 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 14 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [ebiederm-user-namespace:signal-for-v5.17 4/12] arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_opcodes()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
> head:   6b1248798eb6f6d5285db214299996ecc5dc1e6b
> commit: 0e25498f8cd43c1b5aa327f373dd094e9a006da7 [4/12] exit: Add and use make_task_dead.
> config: x86_64-randconfig-a011-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140949.Uq5sFKR1-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=0e25498f8cd43c1b5aa327f373dd094e9a006da7
>         git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
>         git fetch --no-tags ebiederm-user-namespace signal-for-v5.17
>         git checkout 0e25498f8cd43c1b5aa327f373dd094e9a006da7
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ kernel/ lib/kunit/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> lib/kunit/kunit-example-test.o: warning: objtool: .text.unlikely: unexpected end of section
> --
>>> arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_opcodes()

I am confused.  This change patches objtool to rename
rewind_stack_and_do_exit to rewind_stack_and_make_dead in the list
global_noreturns in tools/objtool/check.c

There is no other change to oops_end other than that renaming.

Did the robot somehow mange to run an old version of objtool while
building and this get this error?

I tried and I am not currently able to reproduce this error.  Do you
have any additional pointers on how I might reproduce this?

Eric
