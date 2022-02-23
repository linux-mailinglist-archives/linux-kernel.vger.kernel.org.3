Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7C4C0A34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiBWD2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiBWD2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:28:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83212672
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645586895; x=1677122895;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aXsvb76kxe1f0vtbpAwHxd95aWtlNMa7DirL39W8X0s=;
  b=S1QFoymF9fhH7ljsMepTU5Wbyn2mOmt52QzwphTWurxQCWvKi6W8/Xt9
   vPtml1JMNooZ4A54zzdazbB230hkPZ0Q7LunlbdapRAXIlLkWEl3n4GCG
   6ducL2fmBR/on3VHMySbdTVq6UUUBDI4kgX1ujVTGa2UYDSFf6ZOeRETj
   FGnaEm+cC8L2/9o30I5LwnfoGrWz9smXjvJVbp3NYOj9RZzQZd4ChD4nc
   TJqESbgWiTalgH8jp+FGuny/Dnhyqj93az8wlOUZcjCA6uB6/rkBsToBl
   mgJlAoppT1u8Hs89hpJQFXKbbS15ZJCZdQFQy3DvGUWa+9uugG9aXnxRQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="276489347"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="276489347"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 19:28:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="548052217"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Feb 2022 19:28:13 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMiK5-0000w0-8k; Wed, 23 Feb 2022 03:28:13 +0000
Date:   Wed, 23 Feb 2022 11:27:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1839/2324] arch/mips/ath25/devices.h:36:10:
 error: implicit declaration of function 'smp_processor_id'
Message-ID: <202202231135.jSEszXqu-lkp@intel.com>
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
head:   7d9efc989eceed6a8fa475a186880ec4a1ad54a3
commit: 03d4ee3eff69c2a68c1717afc5a08d1142af6a57 [1839/2324] headers/deps: mm: Optimize <linux/node.h> dependencies
config: mips-ath25_defconfig (https://download.01.org/0day-ci/archive/20220223/202202231135.jSEszXqu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=03d4ee3eff69c2a68c1717afc5a08d1142af6a57
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 03d4ee3eff69c2a68c1717afc5a08d1142af6a57
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/ath25/early_printk.c:14:
>> arch/mips/ath25/devices.h:36:10: error: implicit declaration of function 'smp_processor_id' [-Werror,-Wimplicit-function-declaration]
           return (current_cpu_data.cputype == CPU_4KEC);
                   ^
   arch/mips/include/asm/cpu-info.h:120:35: note: expanded from macro 'current_cpu_data'
   #define current_cpu_data cpu_data[smp_processor_id()]
                                     ^
   1 error generated.


vim +/smp_processor_id +36 arch/mips/ath25/devices.h

1ac91b1f686e9d Sergey Ryazanov 2014-10-29  33  
43cc739fd98b8c Sergey Ryazanov 2014-10-29  34  static inline bool is_ar2315(void)
43cc739fd98b8c Sergey Ryazanov 2014-10-29  35  {
43cc739fd98b8c Sergey Ryazanov 2014-10-29 @36  	return (current_cpu_data.cputype == CPU_4KEC);
43cc739fd98b8c Sergey Ryazanov 2014-10-29  37  }
43cc739fd98b8c Sergey Ryazanov 2014-10-29  38  

:::::: The code at line 36 was first introduced by commit
:::::: 43cc739fd98b8c517ad45756d869f866e746ba04 MIPS: ath25: add common parts

:::::: TO: Sergey Ryazanov <ryazanov.s.a@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
