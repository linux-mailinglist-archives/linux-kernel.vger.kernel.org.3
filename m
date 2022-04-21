Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07285097F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385063AbiDUGrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385059AbiDUGqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:46:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A91215839
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523374; x=1682059374;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c4IkYSZXLCjXG4g7tl7kyeRPolu7AVMDtR8tvivn94U=;
  b=IcY4PIK04JrhqrpGZImBG8A3MK9RURELDIPZZvgiaXUu+jsboUxohofu
   bNtu3jIOEW6z0+k6Cjtgk8etJJr/EeE3XdYrmJQw3iGaE50OeS0aHlSuy
   kMpafnkbym/UOTHz+JUQAoPQfn/K8zjfEDYV+8o3qEzYsLBUAGICi6J7M
   Glhc5W52wQtjgxhs8ar0UK6ygFfayJV0HYPKOQIUzGjNzB7XZspqjcBr5
   +opppeZ/Ib4WnlQDQHb/Vh1bMS7NxgiiiFZWigzxZ67tGs+rGKccX2MO7
   O8L02eo0Y/QSU/CL3YWP3Q8gJBUlPmLERKUGShCxy7JnBs7rGiEShKzHi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264429185"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264429185"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="530131478"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Apr 2022 23:42:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQWg-0007zo-GO;
        Thu, 21 Apr 2022 06:42:50 +0000
Date:   Thu, 21 Apr 2022 14:42:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 408/2579] kernel/bpf/core.c:63:6: warning:
 no previous prototype for 'bpf_jit_dump'
Message-ID: <202204210436.0BDJbqN7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: e4ad6815a1dd068fce426ddb025055ac7f698a29 [408/2579] headers/uninline: Uninline multi-use function: bpf_jit_dump()
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220421/202204210436.0BDJbqN7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=e4ad6815a1dd068fce426ddb025055ac7f698a29
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout e4ad6815a1dd068fce426ddb025055ac7f698a29
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/pci/ fs/crypto/ kernel/bpf/ lib/ net/ipv6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:63:6: warning: no previous prototype for 'bpf_jit_dump' [-Wmissing-prototypes]
      63 | void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
         |      ^~~~~~~~~~~~
   kernel/bpf/core.c:1655:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1655 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/bpf_jit_dump +63 kernel/bpf/core.c

    62	
  > 63	void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
    64	{
    65		pr_err("flen=%u proglen=%u pass=%u image=%pK from=%s pid=%d\n", flen,
    66		       proglen, pass, image, current->comm, task_pid_nr(current));
    67	
    68		if (image)
    69			print_hex_dump(KERN_ERR, "JIT code: ", DUMP_PREFIX_OFFSET,
    70				       16, 1, image, proglen, false);
    71	}
    72	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
