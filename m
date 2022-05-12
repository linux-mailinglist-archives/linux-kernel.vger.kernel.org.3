Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3E5248F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347778AbiELJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245428AbiELJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:30:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EA62104
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652347826; x=1683883826;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AmsmpFRBZgBqbkKkYQ3mf0e5uEsOB80kwhJl/V+HQs8=;
  b=XC6eUCobkxQIXnlCDCbm7ycA1iuexuy+cP8jZjw5H+Do/j+4xrGrteAC
   u1uHBvv7AimAgh8VMVnVA1ZioYn78y/Tc1SkkEr/f94BlD0mE6dFCScD0
   N1HVJqx38VSbMOSxi4NLHUSb3YouTU1O/O19kEHCotIkfgmuJ5aW1rB37
   m+WQHGkRCxHre4bHjU0yWY4qtGNizWPbksqrYRNg4kYdCMLeOlDJl+ryy
   VXMTX/sBLQekjeTCIbyZimz5FFrNM/5mGZK+vEEmZRvu3ro0Ld0y57lyF
   zZDpsH/GJVeNz62sWQe566zeJ/ZdVmG6omSpkAE0/8jMDjT9ZTXBmY2wx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="270078122"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="270078122"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:30:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="566598847"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.14]) ([10.255.30.14])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:30:23 -0700
Subject: Re: [kbuild-all] Re:
 [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 146/150] kernel/futex.o:
 warning: objtool: futex_atomic_op_inuser()+0xb8: unreachable instruction
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@suse.de>
References: <202205120956.qLpGQurX-lkp@intel.com>
 <20220512081709.GD76023@worktop.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a088f55b-2dd1-d693-b09e-ea3c67398b8b@intel.com>
Date:   Thu, 12 May 2022 17:30:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220512081709.GD76023@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2022 4:17 PM, Peter Zijlstra wrote:
> On Thu, May 12, 2022 at 10:00:33AM +0800, kernel test robot wrote:
>> tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
>> head:   305e905f70311e1b49cc730931a19c3e364f4d8c
>> commit: 45dc9d706619a6814e4063d5431483f94badb5a1 [146/150] x86: Add straight-line-speculation mitigation
>> config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120956.qLpGQurX-lkp@intel.com/config)
>> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
>> reproduce (this is a W=1 build):
>>          # https://github.com/ammarfaizi2/linux-block/commit/45dc9d706619a6814e4063d5431483f94badb5a1
>>          git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>>          git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
>>          git checkout 45dc9d706619a6814e4063d5431483f94badb5a1
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> kernel/futex.o: warning: objtool: futex_atomic_op_inuser()+0xb8: unreachable instruction
>> --
>>>> mm/madvise.o: warning: objtool: madvise_behavior()+0x69: unreachable instruction
>> --
>>>> kernel/bpf/btf.o: warning: objtool: __btf_resolve_size()+0x72: unreachable instruction
> 
> Would it be possible for the robot to include the output of this script:

Hi Peter,

Thanks for your advice, we'll support it asap.

Best Regards,
Rong Chen

> 
>    https://lkml.kernel.org/r/3eb3f091fd6bd9caba50392ceab98ce756804f3b.1650578171.git.jpoimboe@redhat.com
> 
> for each objtool warning it gives (as run on vmlinux.o):
> 
>    $ ./scripts/objdump-func build-output/vmlinux.o futex_atomic_op_inuser
>    $ ./scripts/objdump-func build-output/vmlinux.o madvise_behavior
>    $ ./scripts/objdump-func build-output/vmlinux.o __btf_resolve_size
> 
> etc.. that would make it easier to see what the problem is without
> having to reproduce the build.
> 
> A super wild guess; but try this commit:
> 
>    1ffbe4e935f9 ("objtool: Default ignore INT3 for unreachable")
> 
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
