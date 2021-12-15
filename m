Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB029475F72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhLORhR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Dec 2021 12:37:17 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:49148 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhLORhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:37:03 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:35836)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mxYD7-00Gzk2-5X; Wed, 15 Dec 2021 10:37:01 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42252 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mxYD6-00F8Dq-19; Wed, 15 Dec 2021 10:37:00 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202112140949.Uq5sFKR1-lkp@intel.com>
        <87k0g7t7ry.fsf@email.froward.int.ebiederm.org>
        <2af5f2f0-b2db-35e3-2d7a-7fa512db19af@intel.com>
        <8735mutqvz.fsf@email.froward.int.ebiederm.org>
        <db094a6d-48d6-7641-b8c3-fc338bd779b0@intel.com>
Date:   Wed, 15 Dec 2021 11:36:23 -0600
In-Reply-To: <db094a6d-48d6-7641-b8c3-fc338bd779b0@intel.com> (Rong Chen's
        message of "Wed, 15 Dec 2021 13:22:21 +0800")
Message-ID: <87czlxsrc8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1mxYD6-00F8Dq-19;;;mid=<87czlxsrc8.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/lV0X34FlYM7z/GWcs7Yku8qgHXGn0v0E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_00,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,
        T_TooManySym_05,T_XMDrugObfuBody_08,XMSubLong,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0047]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rong Chen <rong.a.chen@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 559 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.07
        (0.2%), extract_message_metadata: 24 (4.4%), get_uri_detail_list: 3.5
        (0.6%), tests_pri_-1000: 33 (5.8%), tests_pri_-950: 1.62 (0.3%),
        tests_pri_-900: 1.36 (0.2%), tests_pri_-90: 103 (18.5%), check_bayes:
        101 (18.1%), b_tokenize: 11 (2.0%), b_tok_get_all: 10 (1.7%),
        b_comp_prob: 5 (0.9%), b_tok_touch_all: 70 (12.5%), b_finish: 1.10
        (0.2%), tests_pri_0: 368 (65.8%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.79 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 9 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [kbuild-all] Re: [ebiederm-user-namespace:signal-for-v5.17 4/12] arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_opcodes()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rong Chen <rong.a.chen@intel.com> writes:

> On 12/15/21 12:48, Eric W. Biederman wrote:
>> Rong Chen <rong.a.chen@intel.com> writes:
>>
>>> On 12/15/21 01:29, Eric W. Biederman wrote:
>>>> kernel test robot <lkp@intel.com> writes:
>>>>
>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
>>>>> head:   6b1248798eb6f6d5285db214299996ecc5dc1e6b
>>>>> commit: 0e25498f8cd43c1b5aa327f373dd094e9a006da7 [4/12] exit: Add and use make_task_dead.
>>>>> config: x86_64-randconfig-a011-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140949.Uq5sFKR1-lkp@intel.com/config)
>>>>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>>>>> reproduce (this is a W=1 build):
>>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=0e25498f8cd43c1b5aa327f373dd094e9a006da7
>>>>>           git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
>>>>>           git fetch --no-tags ebiederm-user-namespace signal-for-v5.17
>>>>>           git checkout 0e25498f8cd43c1b5aa327f373dd094e9a006da7
>>>>>           # save the config file to linux build tree
>>>>>           mkdir build_dir
>>>>>           make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ kernel/ lib/kunit/
>>>>>
>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>
>>>>> All warnings (new ones prefixed by >>):
>>>>>
>>>>>>> lib/kunit/kunit-example-test.o: warning: objtool: .text.unlikely: unexpected end of section
>>>>> --
>>>>>>> arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_opcodes()
>>>> I am confused.  This change patches objtool to rename
>>>> rewind_stack_and_do_exit to rewind_stack_and_make_dead in the list
>>>> global_noreturns in tools/objtool/check.c
>>>>
>>>> There is no other change to oops_end other than that renaming.
>>>>
>>>> Did the robot somehow mange to run an old version of objtool while
>>>> building and this get this error?
>>>>
>>>> I tried and I am not currently able to reproduce this error.  Do you
>>>> have any additional pointers on how I might reproduce this?
>>> Hi Eric,
>>>
>>> The reproduce step in report based on a full build, I can reproduce
>>> the warnings with the below command:
>>>
>>>    make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>> Any chance you could do "make arch/x86/kernel/dumpstack.s" and send it
>> to me?
>
> $ make O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/dumpstack.s
> make[1]: Entering directory '/mnt/memdrive/linux/build_dir'
>   GEN     Makefile
>   CALL    ../scripts/checksyscalls.sh
>   CALL    ../scripts/atomic/check-atomics.sh
>   DESCEND objtool
>   CC      arch/x86/kernel/dumpstack.s
> make[1]: Leaving directory '/mnt/memdrive/linux/build_dir'
>
> $ make O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/
> make[1]: Entering directory '/mnt/memdrive/linux/build_dir'
>   GEN     Makefile
>   CALL    ../scripts/checksyscalls.sh
>   CALL    ../scripts/atomic/check-atomics.sh
>   DESCEND objtool
>   CC      arch/x86/kernel/dumpstack.o
> arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls
> through to next function show_opcodes()
>   AR      arch/x86/kernel/built-in.a
> make[1]: Leaving directory '/mnt/memdrive/linux/build_dir'

Thanks.  What I was actually hoping for was the assembly code of
oops_end so I could understand the objtool error.

I have tracked it down now.  I accidentally deleted a comma, which
caused C string concatenation which merged two symbols together,
and caused this warning.

What an annoying typo.

Eric
