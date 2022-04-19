Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4802A50634A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348291AbiDSEgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbiDSEgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:36:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C7927CD9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650342808; x=1681878808;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yqgEaacmiI1pt6jr6PJUeWBZacRPPc+PyFzOb1qFXZ8=;
  b=ZYa7NVvjLjRa3Shpm5LI7aI1Nup36wVwnORmc7pejlOpSc3/ZqtZiRf/
   D1lAjeI4yTa8O2aAVj/3J6ZsHhbtA5foH7Z/VyqlXTvMUotlm11PGNhBR
   E9bIVKVcRU9rxDxWIOG10+slUywMViCsuSwq28lnxZp/7u0G5ehY+ip27
   tI6ISB3+BaE2xDJb1RkD2mHk/hs6pPL/lHsa4FEtTHr/4BxZ0YSkjnC2D
   Lv/ONMbgd3lQTD86oq88BbDkTWrviDaBMdXsj31bJlWH/1V6rUFTBykcE
   zOFiX4C4o4mme4fyilMRlsW9OJpGj2qCycbVBL++HqJaQmNzZHaZvcR1R
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262532178"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="262532178"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="561574691"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Apr 2022 21:33:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngfYK-0005Lk-1U;
        Tue, 19 Apr 2022 04:33:24 +0000
Date:   Tue, 19 Apr 2022 12:32:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1496/2356]
 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:956:22: warning:
 assignment to 'struct task_struct *' from 'int' makes pointer from integer
 without a cast
Message-ID: <202204191227.MN9RvyB5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 87052c4c3bbc437e628c8d687fd5133d135333d0 [1496/2356] headers/deps: fs: Optimize <linux/fs.h> header dependencies
config: x86_64-randconfig-a001-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191227.MN9RvyB5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=87052c4c3bbc437e628c8d687fd5133d135333d0
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 87052c4c3bbc437e628c8d687fd5133d135333d0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/ arch/x86/kernel/cpu/mtrr/ drivers/bus/mhi/host/ drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/amdkfd/ drivers/hwmon/pmbus/ drivers/infiniband/sw/siw/ drivers/net/can/spi/mcp251xfd/ drivers/spi/ mm/ sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c: In function 'criu_resume':
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:2458:15: error: implicit declaration of function 'find_get_pid'; did you mean 'find_get_page'? [-Werror=implicit-function-declaration]
    2458 |         pid = find_get_pid(args->pid);
         |               ^~~~~~~~~~~~
         |               find_get_page
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:2458:13: warning: assignment to 'struct pid *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2458 |         pid = find_get_pid(args->pid);
         |             ^
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:2467:9: error: implicit declaration of function 'put_pid'; did you mean 'put_pid_ns'? [-Werror=implicit-function-declaration]
    2467 |         put_pid(pid);
         |         ^~~~~~~
         |         put_pid_ns
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c: In function 'kfd_lookup_process_by_pid':
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:956:24: error: implicit declaration of function 'get_pid_task'; did you mean 'get_cpu_mask'? [-Werror=implicit-function-declaration]
     956 |                 task = get_pid_task(pid, PIDTYPE_PID);
         |                        ^~~~~~~~~~~~
         |                        get_cpu_mask
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:956:22: warning: assignment to 'struct task_struct *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     956 |                 task = get_pid_task(pid, PIDTYPE_PID);
         |                      ^
   cc1: some warnings being treated as errors


vim +956 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c

abb208a8d490ba Felix Kuehling    2017-11-27  945  
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  946  /* This increments the process->ref counter. */
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  947  struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid)
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  948  {
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  949  	struct task_struct *task = NULL;
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  950  	struct kfd_process *p    = NULL;
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  951  
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  952  	if (!pid) {
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  953  		task = current;
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  954  		get_task_struct(task);
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  955  	} else {
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11 @956  		task = get_pid_task(pid, PIDTYPE_PID);
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  957  	}
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  958  
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  959  	if (task) {
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  960  		p = find_process(task, true);
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  961  		put_task_struct(task);
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  962  	}
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  963  
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  964  	return p;
011bbb03024f5a Rajneesh Bhardwaj 2021-01-11  965  }
6ae2784114c037 Alex Sierra       2020-04-01  966  

:::::: The code at line 956 was first introduced by commit
:::::: 011bbb03024f5a22dc04eba370f9296f0cb83502 drm/amdkfd: CRIU Implement KFD resume ioctl

:::::: TO: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
