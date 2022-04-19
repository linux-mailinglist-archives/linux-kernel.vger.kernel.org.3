Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F450622F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbiDSCiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiDSCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:37:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD0BE15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650335715; x=1681871715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/dj95LQS+m9Y5Z6+lCt7fVFVp2F0MwsWR2VKegZkPm0=;
  b=UJ8vgXI8NvvQKCP00WcRudIQEJ8BPfC3gBYnn/dtYGKa8llDV5rCzYP5
   NzJVOslb+9g0OwCnEkAvEt1f3xHFiaGqaFqlSgrKy9YBd8+jF0owz/fao
   jjncBGu1obC4IIjCWVoifLlawHYmdaWLHNAxSF65OIXXadcGZr9hkt0nU
   VowXmWMdF3VmMS2yvzOIDZ4zVXR9Q5+Vk8JeYnYHBehCoW6LCMbDy7kHp
   SHlTvRfksveJVxMUgn7q08sU+j5M/wTzKFTrcZS7X9ElqKR1Wc80HAaCb
   2yEGXgt5x0B4xvdoXcmC978wz9Qw3ZVenBYN/cNcJSCdnpSs776/cvvKp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350106664"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="350106664"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="860421227"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Apr 2022 19:35:14 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngdhx-0005Dg-Ms;
        Tue, 19 Apr 2022 02:35:13 +0000
Date:   Tue, 19 Apr 2022 10:34:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1637/2356] kernel/entry/kvm.c:15:4: error:
 implicit declaration of function 'clear_notify_signal' is invalid in C99
Message-ID: <202204191041.z5pcMgFP-lkp@intel.com>
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
commit: 7056b88fee812761b8c015f328951fa1f7522a75 [1637/2356] headers/deps: syscalls: Optimize <linux/syscalls.h> dependencies
config: x86_64-randconfig-a014-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191041.z5pcMgFP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=7056b88fee812761b8c015f328951fa1f7522a75
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 7056b88fee812761b8c015f328951fa1f7522a75
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/entry/kvm.c:15:4: error: implicit declaration of function 'clear_notify_signal' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           clear_notify_signal();
                           ^
   1 error generated.


vim +/clear_notify_signal +15 kernel/entry/kvm.c

935ace2fb5cc49 Thomas Gleixner   2020-07-22   8  
935ace2fb5cc49 Thomas Gleixner   2020-07-22   9  static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
935ace2fb5cc49 Thomas Gleixner   2020-07-22  10  {
935ace2fb5cc49 Thomas Gleixner   2020-07-22  11  	do {
935ace2fb5cc49 Thomas Gleixner   2020-07-22  12  		int ret;
935ace2fb5cc49 Thomas Gleixner   2020-07-22  13  
7c5d8fa6fbb12a Eric W. Biederman 2022-02-09  14  		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
7c5d8fa6fbb12a Eric W. Biederman 2022-02-09 @15  			clear_notify_signal();
7c5d8fa6fbb12a Eric W. Biederman 2022-02-09  16  			if (task_work_pending(current))
7c5d8fa6fbb12a Eric W. Biederman 2022-02-09  17  				task_work_run();
7c5d8fa6fbb12a Eric W. Biederman 2022-02-09  18  		}
12db8b690010cc Jens Axboe        2020-10-26  19  
935ace2fb5cc49 Thomas Gleixner   2020-07-22  20  		if (ti_work & _TIF_SIGPENDING) {
935ace2fb5cc49 Thomas Gleixner   2020-07-22  21  			kvm_handle_signal_exit(vcpu);
935ace2fb5cc49 Thomas Gleixner   2020-07-22  22  			return -EINTR;
935ace2fb5cc49 Thomas Gleixner   2020-07-22  23  		}
935ace2fb5cc49 Thomas Gleixner   2020-07-22  24  
935ace2fb5cc49 Thomas Gleixner   2020-07-22  25  		if (ti_work & _TIF_NEED_RESCHED)
935ace2fb5cc49 Thomas Gleixner   2020-07-22  26  			schedule();
935ace2fb5cc49 Thomas Gleixner   2020-07-22  27  
3c532798ec96b6 Jens Axboe        2020-10-03  28  		if (ti_work & _TIF_NOTIFY_RESUME)
03248addadf1a5 Eric W. Biederman 2022-02-09  29  			resume_user_mode_work(NULL);
935ace2fb5cc49 Thomas Gleixner   2020-07-22  30  
935ace2fb5cc49 Thomas Gleixner   2020-07-22  31  		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
935ace2fb5cc49 Thomas Gleixner   2020-07-22  32  		if (ret)
935ace2fb5cc49 Thomas Gleixner   2020-07-22  33  			return ret;
935ace2fb5cc49 Thomas Gleixner   2020-07-22  34  
6ce895128b3bff Mark Rutland      2021-11-29  35  		ti_work = read_thread_flags();
935ace2fb5cc49 Thomas Gleixner   2020-07-22  36  	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
935ace2fb5cc49 Thomas Gleixner   2020-07-22  37  	return 0;
935ace2fb5cc49 Thomas Gleixner   2020-07-22  38  }
935ace2fb5cc49 Thomas Gleixner   2020-07-22  39  

:::::: The code at line 15 was first introduced by commit
:::::: 7c5d8fa6fbb12a3f0eefe8762bfede508e147cb3 task_work: Decouple TIF_NOTIFY_SIGNAL and task_work

:::::: TO: Eric W. Biederman <ebiederm@xmission.com>
:::::: CC: Eric W. Biederman <ebiederm@xmission.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
