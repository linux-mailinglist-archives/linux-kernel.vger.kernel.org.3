Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDA4BD2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 01:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245341AbiBTX7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:59:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbiBTX7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:59:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED3517D5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645401540; x=1676937540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aed045LtP8u/cW97/6g9NjDiOQa4JuZHiem6NPMOURQ=;
  b=LgRH5yw9NvE+V061FG+A98KrhAgLgl0jlS9O3cTmhxVSNKVwbVbiR7Xt
   5MUlTgj6SCUtm3pG5AZ2qmczXyLkt45Lr/zp49c2Z0AkrcJ9Z3Drljxrd
   KCiN/b+PpsMOzXmNqlfGFJBgErBrjNZ6C6+AzQ8gSoWvy1VjfR+Y+uQaY
   dF6CU0M0t2OB1ZndTCpM91vcYE9xyyeTfaLUqitbkZ7HiVObyZyYlf2Mp
   +ajfz8NuJoefHLVrZItORs5FPR8YBcxtzv69etKgoDy4hwhgF3Cwl52oK
   641+tqAMLar9jV9hJg2+Lw7xu3eQkn7J7ZsKoVfZWnVYgj8YUZiXHi1NI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="276000457"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="276000457"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="572924607"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Feb 2022 15:58:58 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLw6T-00012t-Pb; Sun, 20 Feb 2022 23:58:57 +0000
Date:   Mon, 21 Feb 2022 07:57:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 80/2574]
 include/linux/sched/per_task.h:48:11: fatal error: generated/asm-offsets.h:
 No such file or directory
Message-ID: <202202210712.NtyTe69D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: dae7a695f3f100fcb540047389fba6f9d80a6fb2 [80/2574] headers/deps: per_task: Add the per_task infrastructure for x86, arm64, sparc and MIPS
config: csky-buildonly-randconfig-r001-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210712.NtyTe69D-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=dae7a695f3f100fcb540047389fba6f9d80a6fb2
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout dae7a695f3f100fcb540047389fba6f9d80a6fb2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:12,
                    from arch/csky/kernel/asm-offsets.c:4:
>> include/linux/sched/per_task.h:48:11: fatal error: generated/asm-offsets.h: No such file or directory
      48 | # include <generated/asm-offsets.h>
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: arch/csky/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +48 include/linux/sched/per_task.h

    42	
    43	#ifndef __PER_TASK_GEN
    44	/*
    45	 * These offsets get generated via the scripts/gen-pertask.sh script,
    46	 * and the pertask rules in the top level Kbuild file:
    47	 */
  > 48	# include <generated/asm-offsets.h>
    49	#endif
    50	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
