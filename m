Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FBB4BF0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiBVEJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 23:09:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiBVEIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 23:08:49 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB3E6D867
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 20:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645502895; x=1677038895;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sIg6rHCpyaGgX3nasthW2UeeCFofFiz4fYa70nm7zjQ=;
  b=m7eCJKBmuQcxn8uomzOdHrru9/7F7pK54uOEJegiiTskL0rxqe+pezso
   kyESP8M6WiRHX/uvSqsN1gUNdQ6fhOZwp8xQor7l8NToEdJEVJFiZ8xHS
   /S8RujfCdz7dklfSF4dNPnJ4m75Lq7u3zaqBFZ11NLt2w5UX5iONFEoEN
   yun1IGKFhu6u3+BahZEW8kpqD246O2eHOVIs8hJqZP97x9j0oI8gemZJ/
   HSiJH5vqweLa7p38pk6I9WNOk1o5vmFC8R/B2CDyiSyB2941Rl6AA9gPT
   H5WmUSPA2Npr3aTKk/ZHAekRCUmMl0GvLxsYm3ndMmXKOF2YQ/PorIEkl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="249186967"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="249186967"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 20:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="542804030"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2022 20:07:51 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMMSs-0002JC-CG; Tue, 22 Feb 2022 04:07:50 +0000
Date:   Tue, 22 Feb 2022 12:07:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2011/2541]
 drivers/infiniband/ulp/srp/ib_srp.c:75:9: warning:
 'DEFINE_DYNAMIC_DEBUG_METADATA' macro redefined
Message-ID: <202202221244.iiBnlXUy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   601144c0da5edfa67a9654158370da19c67e17e2
commit: 851f9d758cf215ebf131c634c6ec7bf12e91f19f [2011/2541] headers/deps: Optimize <linux/jump_label.h>, remove the <linux/atomic_api.h> inclusion in the CONFIG_JUMP_LABEL=y case
config: i386-randconfig-a012-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221244.iiBnlXUy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=851f9d758cf215ebf131c634c6ec7bf12e91f19f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 851f9d758cf215ebf131c634c6ec7bf12e91f19f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/infiniband/ulp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/ulp/srp/ib_srp.c:75:9: warning: 'DEFINE_DYNAMIC_DEBUG_METADATA' macro redefined [-Wmacro-redefined]
   #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
           ^
   include/linux/dynamic_debug.h:90:9: note: previous definition is here
   #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)                \
           ^
>> drivers/infiniband/ulp/srp/ib_srp.c:76:9: warning: 'DYNAMIC_DEBUG_BRANCH' macro redefined [-Wmacro-redefined]
   #define DYNAMIC_DEBUG_BRANCH(descriptor) false
           ^
   include/linux/dynamic_debug.h:125:9: note: previous definition is here
   #define DYNAMIC_DEBUG_BRANCH(descriptor) \
           ^
   2 warnings generated.


vim +/DEFINE_DYNAMIC_DEBUG_METADATA +75 drivers/infiniband/ulp/srp/ib_srp.c

aef9ec39c47f0c Roland Dreier   2005-11-02  73  
1a1faf7a8a251d Bart Van Assche 2016-11-21  74  #if !defined(CONFIG_DYNAMIC_DEBUG)
1a1faf7a8a251d Bart Van Assche 2016-11-21 @75  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
1a1faf7a8a251d Bart Van Assche 2016-11-21 @76  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
1a1faf7a8a251d Bart Van Assche 2016-11-21  77  #endif
1a1faf7a8a251d Bart Van Assche 2016-11-21  78  

:::::: The code at line 75 was first introduced by commit
:::::: 1a1faf7a8a251d134d375b7783a614ee79e932f2 IB/srp: Fix CONFIG_DYNAMIC_DEBUG=n build

:::::: TO: Bart Van Assche <bart.vanassche@sandisk.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
