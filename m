Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B344751E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhLOFW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:22:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:60572 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239861AbhLOFW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639545746; x=1671081746;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ut1Q/Z+F1qkXD5SI3hngsNT+FiBiMeYWIbrufPg5mKI=;
  b=VNQ2eromDdWcoioC06wrqVBWDadyzZIJqFjsjHALBhMhyIc76TlDC2oT
   rNjqhiV6fnX9uHKLBUgZhBTH3KZ5SXED3kcJCYH7jpQh5hJ0CBYbxOXiO
   Yyw2tG9KaiJ5bxQP/G9HcisL10aaP2hQB2UlTvhd/nQWQk1xg+s++xr6F
   Rqbjyb3PhWw+bThM6X4cmuG7ic0xU16dflxpLXnX6il03OSyrSGR8g8u8
   1X1g8q3eKi/BIoJ5myCHDg8Xhi4LVPq/9+CWTPaa6G1+DZFGkVbZhxlcN
   vcgkH1FXgEE9Uryp9BfNA/bfEIMbSAXxsq6dDc28cLsxsbCE1tlre1HMm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="238964380"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="238964380"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 21:22:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518608275"
Received: from rongch2-desk.sh.intel.com (HELO [10.239.159.175]) ([10.239.159.175])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 21:22:24 -0800
Message-ID: <db094a6d-48d6-7641-b8c3-fc338bd779b0@intel.com>
Date:   Wed, 15 Dec 2021 13:22:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [kbuild-all] Re: [ebiederm-user-namespace:signal-for-v5.17 4/12]
 arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to
 next function show_opcodes()
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202112140949.Uq5sFKR1-lkp@intel.com>
 <87k0g7t7ry.fsf@email.froward.int.ebiederm.org>
 <2af5f2f0-b2db-35e3-2d7a-7fa512db19af@intel.com>
 <8735mutqvz.fsf@email.froward.int.ebiederm.org>
From:   Rong Chen <rong.a.chen@intel.com>
In-Reply-To: <8735mutqvz.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/21 12:48, Eric W. Biederman wrote:
> Rong Chen <rong.a.chen@intel.com> writes:
>
>> On 12/15/21 01:29, Eric W. Biederman wrote:
>>> kernel test robot <lkp@intel.com> writes:
>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
>>>> head:   6b1248798eb6f6d5285db214299996ecc5dc1e6b
>>>> commit: 0e25498f8cd43c1b5aa327f373dd094e9a006da7 [4/12] exit: Add and use make_task_dead.
>>>> config: x86_64-randconfig-a011-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140949.Uq5sFKR1-lkp@intel.com/config)
>>>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>>>> reproduce (this is a W=1 build):
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=0e25498f8cd43c1b5aa327f373dd094e9a006da7
>>>>           git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
>>>>           git fetch --no-tags ebiederm-user-namespace signal-for-v5.17
>>>>           git checkout 0e25498f8cd43c1b5aa327f373dd094e9a006da7
>>>>           # save the config file to linux build tree
>>>>           mkdir build_dir
>>>>           make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ kernel/ lib/kunit/
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>>> lib/kunit/kunit-example-test.o: warning: objtool: .text.unlikely: unexpected end of section
>>>> --
>>>>>> arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_opcodes()
>>> I am confused.  This change patches objtool to rename
>>> rewind_stack_and_do_exit to rewind_stack_and_make_dead in the list
>>> global_noreturns in tools/objtool/check.c
>>>
>>> There is no other change to oops_end other than that renaming.
>>>
>>> Did the robot somehow mange to run an old version of objtool while
>>> building and this get this error?
>>>
>>> I tried and I am not currently able to reproduce this error.  Do you
>>> have any additional pointers on how I might reproduce this?
>> Hi Eric,
>>
>> The reproduce step in report based on a full build, I can reproduce
>> the warnings with the below command:
>>
>>    make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> Any chance you could do "make arch/x86/kernel/dumpstack.s" and send it
> to me?

$ make O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/dumpstack.s
make[1]: Entering directory '/mnt/memdrive/linux/build_dir'
   GEN     Makefile
   CALL    ../scripts/checksyscalls.sh
   CALL    ../scripts/atomic/check-atomics.sh
   DESCEND objtool
   CC      arch/x86/kernel/dumpstack.s
make[1]: Leaving directory '/mnt/memdrive/linux/build_dir'

$ make O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/
make[1]: Entering directory '/mnt/memdrive/linux/build_dir'
   GEN     Makefile
   CALL    ../scripts/checksyscalls.sh
   CALL    ../scripts/atomic/check-atomics.sh
   DESCEND objtool
   CC      arch/x86/kernel/dumpstack.o
arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through 
to next function show_opcodes()
   AR      arch/x86/kernel/built-in.a
make[1]: Leaving directory '/mnt/memdrive/linux/build_dir'

Best Regards,
Rong Chen

>
> I want to see what code is in your oops_end.
>
> It really does not make sense that simply renaming a function would
> trigger this error.
>
> I did a full build (on debian 10 with gcc-8.3.0) and I did not manage to
> reproduce this.  In a bit I will try with a newer debian and see if I
> can get the issue to reproduce.  Still it does not make sense to me
> that a simple rename would trigger this error.
>
> Eric
>

