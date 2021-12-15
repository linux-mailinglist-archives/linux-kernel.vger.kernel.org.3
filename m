Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1ED4751C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbhLOEtW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Dec 2021 23:49:22 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38892 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhLOEtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:49:20 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:55648)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mxMEB-00FT0F-NB; Tue, 14 Dec 2021 21:49:19 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:59552 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mxME9-00CZ9e-3J; Tue, 14 Dec 2021 21:49:19 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202112140949.Uq5sFKR1-lkp@intel.com>
        <87k0g7t7ry.fsf@email.froward.int.ebiederm.org>
        <2af5f2f0-b2db-35e3-2d7a-7fa512db19af@intel.com>
Date:   Tue, 14 Dec 2021 22:48:32 -0600
In-Reply-To: <2af5f2f0-b2db-35e3-2d7a-7fa512db19af@intel.com> (Rong Chen's
        message of "Wed, 15 Dec 2021 09:35:43 +0800")
Message-ID: <8735mutqvz.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1mxME9-00CZ9e-3J;;;mid=<8735mutqvz.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/YgnsCOvPnJZVmeWkLiprg0pftoJSZ+qI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_05,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,
        T_TooManySym_05,XMSubLong,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0115]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Rong Chen <rong.a.chen@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1910 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 5 (0.3%), b_tie_ro: 3.7 (0.2%), parse: 1.17
        (0.1%), extract_message_metadata: 14 (0.7%), get_uri_detail_list: 2.9
        (0.2%), tests_pri_-1000: 4.8 (0.3%), tests_pri_-950: 1.04 (0.1%),
        tests_pri_-900: 0.80 (0.0%), tests_pri_-90: 1541 (80.6%), check_bayes:
        1531 (80.1%), b_tokenize: 7 (0.3%), b_tok_get_all: 8 (0.4%),
        b_comp_prob: 2.2 (0.1%), b_tok_touch_all: 1510 (79.1%), b_finish: 0.98
        (0.1%), tests_pri_0: 327 (17.1%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 2.6 (0.1%), poll_dns_idle: 0.27 (0.0%), tests_pri_10:
        2.6 (0.1%), tests_pri_500: 9 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [kbuild-all] Re: [ebiederm-user-namespace:signal-for-v5.17 4/12] arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_opcodes()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rong Chen <rong.a.chen@intel.com> writes:

> On 12/15/21 01:29, Eric W. Biederman wrote:
>> kernel test robot <lkp@intel.com> writes:
>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
>>> head:   6b1248798eb6f6d5285db214299996ecc5dc1e6b
>>> commit: 0e25498f8cd43c1b5aa327f373dd094e9a006da7 [4/12] exit: Add and use make_task_dead.
>>> config: x86_64-randconfig-a011-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140949.Uq5sFKR1-lkp@intel.com/config)
>>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>>> reproduce (this is a W=1 build):
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=0e25498f8cd43c1b5aa327f373dd094e9a006da7
>>>          git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
>>>          git fetch --no-tags ebiederm-user-namespace signal-for-v5.17
>>>          git checkout 0e25498f8cd43c1b5aa327f373dd094e9a006da7
>>>          # save the config file to linux build tree
>>>          mkdir build_dir
>>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ kernel/ lib/kunit/
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> lib/kunit/kunit-example-test.o: warning: objtool: .text.unlikely: unexpected end of section
>>> --
>>>>> arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_opcodes()
>> I am confused.  This change patches objtool to rename
>> rewind_stack_and_do_exit to rewind_stack_and_make_dead in the list
>> global_noreturns in tools/objtool/check.c
>>
>> There is no other change to oops_end other than that renaming.
>>
>> Did the robot somehow mange to run an old version of objtool while
>> building and this get this error?
>>
>> I tried and I am not currently able to reproduce this error.  Do you
>> have any additional pointers on how I might reproduce this?
>
> Hi Eric,
>
> The reproduce step in report based on a full build, I can reproduce
> the warnings with the below command:
>
>   make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

Any chance you could do "make arch/x86/kernel/dumpstack.s" and send it
to me?

I want to see what code is in your oops_end.

It really does not make sense that simply renaming a function would
trigger this error.

I did a full build (on debian 10 with gcc-8.3.0) and I did not manage to
reproduce this.  In a bit I will try with a newer debian and see if I
can get the issue to reproduce.  Still it does not make sense to me
that a simple rename would trigger this error.

Eric

