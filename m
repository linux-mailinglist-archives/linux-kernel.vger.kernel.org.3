Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512E44CB3A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiCCAbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiCCAbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:31:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94E7E0AA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646267434; x=1677803434;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7igwOfSqrgKPo1nqD5B3D/AQ9vgqKBwAZH6KuUp2Qqg=;
  b=Lhf97gD/5JWLl45kmbRrTCf40hg08Ctuw0brgz608SbD3aofsublturI
   PWCWihl5z/5uq0gCzCgUqe3sV9ZkKH2OLN0RSBwWUA8k1s9c8a2e3iLZB
   j6KU42EpZj0wIqS0T6BIZFT0E63yFC6lOCUxEkOknWwfu/QM9r2M4rKvU
   SWf8FnyZaZK0HMu8I3ujiyFdw16DWE1/iA5eisqsqEwWe5c1GHWvckGkf
   up8DeQkYZSZOdoRDePOlMpf3p/vbGvKlsf/rXfr95FtXtn0+JLTBzY8e8
   VnbopLzl4WOetSE/6wl77bVWs51pVuVVAOUNzONfCW9+UJl7RPRUoRK6j
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233505301"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="233505301"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:30:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="551498329"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.173.202]) ([10.249.173.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:30:30 -0800
Subject: Re: [kbuild-all] Re: [paulmck-rcu:dev.2022.02.17a 73/73] make[3]: ***
 No rule to make target 'kernel/rcu/typesafe.o', needed by
 'kernel/rcu/built-in.a'.
To:     paulmck@kernel.org
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202202220308.TNib9D2v-lkp@intel.com>
 <20220221214736.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <b481fd02-7b4f-7752-8852-d1a61b4916f1@intel.com>
 <20220222145349.GH4285@paulmck-ThinkPad-P17-Gen-1>
 <19aa4b7f-d2ef-b94f-026e-1a0318f7f50c@intel.com>
 <20220302213812.GY4285@paulmck-ThinkPad-P17-Gen-1>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <f270b0e0-dcce-57f0-2661-d47245c65fd0@intel.com>
Date:   Thu, 3 Mar 2022 08:30:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220302213812.GY4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/2022 5:38 AM, Paul E. McKenney wrote:
> On Wed, Feb 23, 2022 at 06:14:52PM +0800, Chen, Rong A wrote:
>>
>>
>> On 2/22/2022 10:53 PM, Paul E. McKenney wrote:
>>> On Tue, Feb 22, 2022 at 04:30:40PM +0800, Chen, Rong A wrote:
>>>>
>>>>
>>>> On 2/22/2022 5:47 AM, Paul E. McKenney wrote:
>>>>> On Tue, Feb 22, 2022 at 03:05:27AM +0800, kernel test robot wrote:
>>>>>> Hi Paul,
>>>>>>
>>>>>> First bad commit (maybe != root cause):
>>>>>>
>>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.17a
>>>>>> head:   f5b2eaf791ebbd6af881947ab7c40ed70681e534
>>>>>> commit: f5b2eaf791ebbd6af881947ab7c40ed70681e534 [73/73] EXP torture: Add tests demoing SLAB_TYPESAFE_BY_RCU
>>>>>> config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202220308.TNib9D2v-lkp@intel.com/config)
>>>>>> compiler: arceb-elf-gcc (GCC) 11.2.0
>>>>>> reproduce (this is a W=1 build):
>>>>>>            wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>>            chmod +x ~/bin/make.cross
>>>>>>            # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=f5b2eaf791ebbd6af881947ab7c40ed70681e534
>>>>>>            git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>>>>>>            git fetch --no-tags paulmck-rcu dev.2022.02.17a
>>>>>>            git checkout f5b2eaf791ebbd6af881947ab7c40ed70681e534
>>>>>>            # save the config file to linux build tree
>>>>>>            mkdir build_dir
>>>>>>            COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash
>>>>>>
>>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>
>>>>>> All errors (new ones prefixed by >>):
>>>>>>
>>>>>>>> make[3]: *** No rule to make target 'kernel/rcu/typesafe.o', needed by 'kernel/rcu/built-in.a'.
>>>>>>       make[3]: Target '__build' not remade because of errors.
>>>>>
>>>>> This is the only commit involving kernel/rcu/typesafe.o, so...
>>>>>
>>>>> One the one hand, I do not plan to upstream this, so maybe it doesn't
>>>>> matter.
>>>>>
>>>>> I have been building this using the rcutorture scripting for some time,
>>>>> same RCU-related .config as you are using.  But when I pulled it into
>>>>> a clone in a neighboring directory, it failed just as it did for you.
>>>>> The problem was that the update to kernel/rcu/Makefile somehow didn't
>>>>> come across, so this line was missing:
>>>>>
>>>>> 	obj-$(CONFIG_RCU_TYPESAFE_TEST) += typesafe.o
>>>>>
>>>>> Which of course explains the build failure.
>>>>>
>>>>> I blew away that clone and re-cloned it.  And it still failed, both
>>>>> with "make" from the commandline and under rcutorture.
>>>>>
>>>>> Hahahahahahaahaha!!!
>>>>>
>>>>> I forgot "git add kernel/rcu/typesafe.c".
>>>>>
>>>>> There is now a new typesafe.2022.02.21a tag with this file added.
>>>>>
>>>>> Good catch!  That file happened to still be lying around.  The first
>>>>> "git reset --hard" would have destroyed.  Thank you!!!
>>>>>
>>>>> And with that fixed, my clone now builds correctly.  Does this fix
>>>>> it for you?
>>>>
>>>> Hi Paul,
>>>>
>>>> I can't find the tag 'typesafe.2022.02.21a' from https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/refs/tags
>>>
>>> That would be because I failed to push it out.  :-/
>>>
>>> Which I just now did, apologies for my confusion.
>>>
>>> 							Thanx, Paul
>>
>> Hi Paul,
>>
>> I have tested the tag, yes, it's fixed.
> 
> Very good, and thank you!
> 
> May I add your Tested-by?
> 
> 							Thanx, Paul
> 

Sure, Tested-by: "kernel test robot" <rong.a.chen@intel.com>

Best Regards,
Rong Chen
