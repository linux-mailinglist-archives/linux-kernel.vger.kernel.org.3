Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324E94BF3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiBVIbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiBVIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:31:09 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D4B157234
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645518645; x=1677054645;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=p/uQG9xFm7ykKXUfDUkdJBF+6OfW00wuzETwMOs/iqg=;
  b=Zmad2E/yLc2Q/Glw4sGoWO/1v+oInXZCwQ4knMgcr/aa9pWqm4v9NNKU
   c3gie+ZMc5fdTyep1A1x32r0QwtE1cucO3kRBhd+d/tld6Y+TQNsTVjoz
   nuUlhAeHhfu03KsyEeo0IMSfsBtLojXi/nI/811mTc/prg0ZDpwG+naQS
   Ov3a/MeG3rsIfF59p9DLVj1gmDgEudFVDLJ1KRjgR80DHSZQ6YpbGJbNw
   lIJGLrbXdvQz5RPeYfSyjfhlCqMp5KurA6rjQJ/tgG+vGC55T7slnvb32
   33W2JJ5wT7cB+pwG5iQiIX4aYoSbK1qWYvKEsP+Z6oW/O5oPRyLCYorgX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="312386723"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="312386723"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:30:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="547641849"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.31.219]) ([10.255.31.219])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:30:43 -0800
Subject: Re: [kbuild-all] Re: [paulmck-rcu:dev.2022.02.17a 73/73] make[3]: ***
 No rule to make target 'kernel/rcu/typesafe.o', needed by
 'kernel/rcu/built-in.a'.
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202202220308.TNib9D2v-lkp@intel.com>
 <20220221214736.GE4285@paulmck-ThinkPad-P17-Gen-1>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <b481fd02-7b4f-7752-8852-d1a61b4916f1@intel.com>
Date:   Tue, 22 Feb 2022 16:30:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220221214736.GE4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/2022 5:47 AM, Paul E. McKenney wrote:
> On Tue, Feb 22, 2022 at 03:05:27AM +0800, kernel test robot wrote:
>> Hi Paul,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.02.17a
>> head:   f5b2eaf791ebbd6af881947ab7c40ed70681e534
>> commit: f5b2eaf791ebbd6af881947ab7c40ed70681e534 [73/73] EXP torture: Add tests demoing SLAB_TYPESAFE_BY_RCU
>> config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202220308.TNib9D2v-lkp@intel.com/config)
>> compiler: arceb-elf-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=f5b2eaf791ebbd6af881947ab7c40ed70681e534
>>          git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>>          git fetch --no-tags paulmck-rcu dev.2022.02.17a
>>          git checkout f5b2eaf791ebbd6af881947ab7c40ed70681e534
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> make[3]: *** No rule to make target 'kernel/rcu/typesafe.o', needed by 'kernel/rcu/built-in.a'.
>>     make[3]: Target '__build' not remade because of errors.
> 
> This is the only commit involving kernel/rcu/typesafe.o, so...
> 
> One the one hand, I do not plan to upstream this, so maybe it doesn't
> matter.
> 
> I have been building this using the rcutorture scripting for some time,
> same RCU-related .config as you are using.  But when I pulled it into
> a clone in a neighboring directory, it failed just as it did for you.
> The problem was that the update to kernel/rcu/Makefile somehow didn't
> come across, so this line was missing:
> 
> 	obj-$(CONFIG_RCU_TYPESAFE_TEST) += typesafe.o
> 
> Which of course explains the build failure.
> 
> I blew away that clone and re-cloned it.  And it still failed, both
> with "make" from the commandline and under rcutorture.
> 
> Hahahahahahaahaha!!!
> 
> I forgot "git add kernel/rcu/typesafe.c".
> 
> There is now a new typesafe.2022.02.21a tag with this file added.
> 
> Good catch!  That file happened to still be lying around.  The first
> "git reset --hard" would have destroyed.  Thank you!!!
> 
> And with that fixed, my clone now builds correctly.  Does this fix
> it for you?

Hi Paul,

I can't find the tag 'typesafe.2022.02.21a' from 
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/refs/tags

Best Regards,
Rong Chen

> 
> 							Thanx, Paul
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
