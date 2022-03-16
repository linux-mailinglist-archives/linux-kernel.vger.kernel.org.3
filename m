Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464804DAC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354419AbiCPINQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346256AbiCPINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:13:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDF5EBC7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647418321; x=1678954321;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zlp+LSssFAT2El9wGxaqoWjTlSWP91rOOyJp9gjyDOo=;
  b=S1kMigWXjTwnCubEzvH61tdjl1LXhUCQ6oq0GjyofKjF1F0DIUSZcydi
   u56lhQJh6RvREOg2Son9HkIDhcA+NOdqs4xxPuXeNUZfgSqJ7P870oten
   /pqRyOU3AwVLc4YFoUr93WVebkGX/2JtU5QHY1FtUP9qbUpveuCenXxk7
   qFQnDiWOuTDzpp3Rh3hXoFDDZl0GkKs+jNKfw51Wm4l/HW3lJtnuRl4Y4
   /pURu/CRTR5GiPCj3djJ7EDHyDieGfJ+kWtUYMpetV35KxIRnpjKDqhNY
   RzqwbLKbXOhJD94WYBhoU3OYT1Q4NC5k1nA76OJVeeYkfbCEwH31JkH2L
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256245199"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256245199"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 01:11:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="540808088"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.175.79]) ([10.249.175.79])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 01:11:33 -0700
Subject: Re: [kbuild-all] Re: [cel:nfsd-courteous-server 29/39]
 do_mounts.c:(.text+0x66): multiple definition of `locks_owner_has_blockers';
 init/main.o:main.c:(.text+0x0): first defined here
To:     dai.ngo@oracle.com, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
References: <202203130709.dYmfXVEC-lkp@intel.com>
 <3d22ac50-f13c-c2db-f5b7-dc229c3709f1@oracle.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <373bcbd9-6139-e9fa-cd86-124b706d16da@intel.com>
Date:   Wed, 16 Mar 2022 16:11:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3d22ac50-f13c-c2db-f5b7-dc229c3709f1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2022 1:02 AM, dai.ngo@oracle.com wrote:
> Hi,
> 
> On 3/12/22 3:38 PM, kernel test robot wrote:
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux 
>> nfsd-courteous-server
>> head:   ca4d8c00bb753707519f438e5286b2349af53054
>> commit: 3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa [29/39] fs/lock: add 
>> helper locks_owner_has_blockers to check for blockers
>> config: m68k-randconfig-r031-20220313 
>> (https://download.01.org/0day-ci/archive/20220313/202203130709.dYmfXVEC-lkp@intel.com/config) 
>>
>> compiler: m68k-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa 
>>
>>          git remote add cel 
>> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
>>          git fetch --no-tags cel nfsd-courteous-server
>>          git checkout 3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 
>> make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     m68k-linux-ld: init/do_mounts.o: in function 
>> `locks_owner_has_blockers':
>>>> do_mounts.c:(.text+0x66): multiple definition of 
>>>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>>>> defined here
> 
> I looked through all the functions listed as having multiple
> definition of `locks_owner_has_blockers' such as init/main.o:main.c,
> arch/x86/kernel/head32.c, init/do_mounts_rd.c and many others.
> None of these functions has 'locks_owner_has_blockers' defined.
> I think there is a problem with the tools that detects this
> error, can you help to verify?

Hi Dai,

Thanks for the response, please ignore the report, the warning is not 
first introduced by the commit as you can see the other warnings in 
below lines:

Best Regards,
Rong Chen

> 
>>     m68k-linux-ld: init/do_mounts_rd.o: in function 
>> `locks_owner_has_blockers':
>>     do_mounts_rd.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: init/do_mounts_initrd.o: in function 
>> `locks_owner_has_blockers':
>>     do_mounts_initrd.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: init/initramfs.o: in function 
>> `locks_owner_has_blockers':
>>     initramfs.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: init/init_task.o: in function 
>> `locks_owner_has_blockers':
>>     init_task.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/irq.o: in function 
>> `locks_owner_has_blockers':
>>     irq.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/module.o: in function 
>> `locks_owner_has_blockers':
>>     module.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/process.o: in function 
>> `locks_owner_has_blockers':
>>     process.c:(.text+0xe): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/ptrace.o: in function 
>> `locks_owner_has_blockers':
>>     ptrace.c:(.text+0x182): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/setup.o: in function 
>> `locks_owner_has_blockers':
>>     setup.c:(.text+0x102): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/signal.o: in function 
>> `locks_owner_has_blockers':
>>     signal.c:(.text+0x3a0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/sys_m68k.o: in function 
>> `locks_owner_has_blockers':
>>     sys_m68k.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/time.o: in function 
>> `locks_owner_has_blockers':
>>     time.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/traps.o: in function 
>> `locks_owner_has_blockers':
>>     traps.c:(.text+0x12): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/kernel/dma.o: in function 
>> `locks_owner_has_blockers':
>>     dma.c:(.text+0x62): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/mm/init.o: in function 
>> `locks_owner_has_blockers':
>>     init.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/coldfire/device.o: in function 
>> `locks_owner_has_blockers':
>>     device.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/coldfire/vectors.o: in function 
>> `locks_owner_has_blockers':
>>     vectors.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/coldfire/m5206.o: in function 
>> `locks_owner_has_blockers':
>>     m5206.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/coldfire/reset.o: in function 
>> `locks_owner_has_blockers':
>>     reset.c:(.text+0x14): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/coldfire/timers.o: in function 
>> `locks_owner_has_blockers':
>>     timers.c:(.text+0x56): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: arch/m68k/coldfire/gpio.o: in function 
>> `locks_owner_has_blockers':
>>     gpio.c:(.text+0x26): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/fork.o: in function `locks_owner_has_blockers':
>>     fork.c:(.text+0x6b4): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/exec_domain.o: in function 
>> `locks_owner_has_blockers':
>>     exec_domain.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/panic.o: in function 
>> `locks_owner_has_blockers':
>>     panic.c:(.text+0x1d6): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/cpu.o: in function `locks_owner_has_blockers':
>>     cpu.c:(.text+0x296): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/exit.o: in function `locks_owner_has_blockers':
>>     exit.c:(.text+0x948): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/softirq.o: in function 
>> `locks_owner_has_blockers':
>>     softirq.c:(.text+0x12e): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/resource.o: in function 
>> `locks_owner_has_blockers':
>>     resource.c:(.text+0x6de): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/sysctl.o: in function 
>> `locks_owner_has_blockers':
>>     sysctl.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/capability.o: in function 
>> `locks_owner_has_blockers':
>>     capability.c:(.text+0x288): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/ptrace.o: in function 
>> `locks_owner_has_blockers':
>>     ptrace.c:(.text+0x474): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/signal.o: in function 
>> `locks_owner_has_blockers':
>>     signal.c:(.text+0x9cc): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/sys.o: in function `locks_owner_has_blockers':
>>     sys.c:(.text+0xdd4): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/umh.o: in function `locks_owner_has_blockers':
>>     umh.c:(.text+0x47a): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/workqueue.o: in function 
>> `locks_owner_has_blockers':
>>     workqueue.c:(.text+0x1e40): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/pid.o: in function `locks_owner_has_blockers':
>>     pid.c:(.text+0xc6): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/task_work.o: in function 
>> `locks_owner_has_blockers':
>>     task_work.c:(.text+0x24): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/extable.o: in function 
>> `locks_owner_has_blockers':
>>     extable.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/params.o: in function 
>> `locks_owner_has_blockers':
>>     params.c:(.text+0x998): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/kthread.o: in function 
>> `locks_owner_has_blockers':
>>     kthread.c:(.text+0x6c0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/nsproxy.o: in function 
>> `locks_owner_has_blockers':
>>     nsproxy.c:(.text+0x1fc): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/notifier.o: in function 
>> `locks_owner_has_blockers':
>>     notifier.c:(.text+0x12c): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/ksysfs.o: in function 
>> `locks_owner_has_blockers':
>>     ksysfs.c:(.text+0x180): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/cred.o: in function `locks_owner_has_blockers':
>>     cred.c:(.text+0x11a): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/reboot.o: in function 
>> `locks_owner_has_blockers':
>>     reboot.c:(.text+0x1d2): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/groups.o: in function 
>> `locks_owner_has_blockers':
>>     groups.c:(.text+0x32): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/sched/core.o: in function 
>> `locks_owner_has_blockers':
>>     core.c:(.text+0x918): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/sched/loadavg.o: in function 
>> `locks_owner_has_blockers':
>>     loadavg.c:(.text+0x38): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/sched/clock.o: in function 
>> `locks_owner_has_blockers':
>>     clock.c:(.text+0x0): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>     m68k-linux-ld: kernel/sched/cputime.o: in function 
>> `locks_owner_has_blockers':
>>     cputime.c:(.text+0x76): multiple definition of 
>> `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first 
>> defined here
>>
>> ---
>> 0-DAY CI Kernel Test Service
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
