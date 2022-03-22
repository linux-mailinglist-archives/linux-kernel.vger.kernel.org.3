Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD614E36C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiCVClP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiCVClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:41:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A21BEB8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647916786; x=1679452786;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MVRDQpXXQf7bjaR/Df+5U5lgjPu0P+yUN0qIYsAb4ws=;
  b=OHV1xId+PKpUDxockPGadV+OKPKPvLdUpoefX2JJZGimsmWEyUOWKN3g
   EeGDJRrPNpqoWMiKUPwfs0ZPCNaaHeTi8HfYMBb75ou7Sl9Q9Dqy3E8j9
   f7qESuOtW9u3685txB1xjvKesSYtRowDfnJetyVQTZs7gxMW0n4RbgJ/Q
   KUg5LNYLNi3sI+M//kvTKThHzQGsp7llLinflSEErrCkRYvz13EKlxnpc
   GVDHQ5eadyIYixUHws4ZVdMoNRmhx+kZ4wZ+HbEJZQtAE+Qhh8UaBBVJL
   tBAY16Zj8NSL8HCaiwNnfXAJP3m3f7QNJ1uN+FMHvqQJxeypSgUa5zbDA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="320907263"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="320907263"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 19:39:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="716742214"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.60]) ([10.255.30.60])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 19:39:44 -0700
Subject: Re: [tip:sched/core] BUILD SUCCESS
 3387ce4d8a5f2956fab827edf499fe6780e83faa
To:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
References: <6238fde0.Qe5umewxqwiDe2GE%lkp@intel.com>
 <YjkHkb7joeu5GCto@dev-arch.thelio-3990X>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <24dd031a-8ea7-5f01-4d80-3fb30d212c8a@intel.com>
Date:   Tue, 22 Mar 2022 10:39:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YjkHkb7joeu5GCto@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2022 7:17 AM, Nathan Chancellor wrote:
> Hello,
> 
> On Tue, Mar 22, 2022 at 06:36:16AM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
>> branch HEAD: 3387ce4d8a5f2956fab827edf499fe6780e83faa  headers/prep: Fix header to build standalone: <linux/psi.h>
>>
>> elapsed time: 730m
>>
>> configs tested: 114
>> configs skipped: 3
>>
>> The following configs have been built successfully.
>> More configs may be tested in the coming days.
>>
>> gcc tested configs:
> ...
>> arm                              allyesconfig
>> arm                              allmodconfig
> 
> This caught my eye due to my earlier report:
> 
> https://lore.kernel.org/r/YjiddAnoCCz7Tbt3@dev-arch.thelio-3990X/
> 
> Are you sure these configurations built sucessfully?
> 
> 
> $ git show -s
> commit 3387ce4d8a5f2956fab827edf499fe6780e83faa
> Author: Ingo Molnar <mingo@kernel.org>
> Date:   Mon Mar 21 11:05:50 2022 +0100
> 
>      headers/prep: Fix header to build standalone: <linux/psi.h>
>      
>      Add the <linux/cgroup-defs.h> dependency to <linux/psi.h>, because
>      cgroup_move_task() will dereference 'struct css_set'.
>      
>      ( Only older toolchains are affected, due to variations in
>        the implementation of rcu_assign_pointer() et al. )
>      
>      Cc: Peter Zijlstra <peterz@infradead.org>
>      Cc: Linus Torvalds <torvalds@linux-foundation.org>
>      Reported-by: Sachin Sant <sachinp@linux.ibm.com>
>      Reported-by: Andrew Morton <akpm@linux-foundation.org>
>      Reported-by: Borislav Petkov <bp@alien8.de>
>      Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- allmodconfig kernel/sched/
> In file included from kernel/sched/fair.c:52:
> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>     87 | # include <asm/paravirt_api_clock.h>
>        |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:288: kernel/sched/fair.o] Error 1
> In file included from kernel/sched/build_utility.c:52:
> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>     87 | # include <asm/paravirt_api_clock.h>
>        |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_utility.o] Error 1
> In file included from kernel/sched/build_policy.c:33:
> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>     87 | # include <asm/paravirt_api_clock.h>
>        |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_policy.o] Error 1
> In file included from kernel/sched/core.c:81:
> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>     87 | # include <asm/paravirt_api_clock.h>
>        |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> ...
> 
> I am curious to know how this error was not caught by these builds?
> Perhaps an old .config from a previous allmodconfig is being reused,
> rather than just running "make allmodconfig"? If that is the case, it
> seems like that methodology will miss out on new configuration options
> over time.
> 
> Cheers,
> Nathan
> 

Hi Nathan,

Thanks for your reminding, the problem commit is 4ff8f2ca6ccd 
("sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h 
dependencies"),
the bot has sent two build reports related to it:

   https://lore.kernel.org/all/202203152116.qphmikIZ-lkp@intel.com/
   https://lore.kernel.org/all/202203152144.uFQqgVUf-lkp@intel.com/

and more reports were stopped to avoid too many noise, like below one:

   tree: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
   head:   97add482e9033a9386baa8824fbea34d0cbfe663
   commit: 4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c [7191/13392] 
sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h 
dependencies
   :::::: branch date: 17 hours ago
   :::::: commit date: 3 weeks ago
   config: arm-randconfig-c002-20220317 (attached as .config)
   compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
   reproduce (this is a W=1 build):
           wget 
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
-O ~/bin/make.cross
           chmod +x ~/bin/make.cross
           # 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
           git remote add linux-next 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
           git fetch --no-tags linux-next master
           git checkout 4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
           # save the config file to linux build tree
           mkdir build_dir
           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 
make.cross O=build_dir ARCH=arm SHELL=/bin/bash kernel/

   If you fix the issue, kindly add following tag as appropriate
   Reported-by: kernel test robot <lkp@intel.com>

   All errors (new ones prefixed by >>):

      In file included from kernel/sched/core.c:79:
   >> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: 
No such file or directory
         87 | # include <asm/paravirt_api_clock.h>
            |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
      compilation terminated.


We'll adjust the strategy avoid blocking some important reports.

Best Regards,
Rong Chen
