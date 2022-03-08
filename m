Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF24D13D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345461AbiCHJvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbiCHJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:51:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583553FBC5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646733020; x=1678269020;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=47Y/uMIK+UT5vxYHGMt1dhGHgAiN21Uf7HdKP+JT3f0=;
  b=LueaPHBQe4HOQMdA0y3oggf2/r6ooH0/TzpYk64l4NO8e05b+Zj40tUL
   Ns6H4F0URWaaHheckeA0y8EBvmLuRzHKS7/5RkQ7sjnv2fb/2ZU9GCnH8
   xsuS5KrQgUDfH4Q+jdouaiouQ+cRrD7GB+ug73kS5TiFPbO+GUxmoNbwS
   dr2YFN0/nS45DJFUTGNx592s8CTByGxxsHT/SbOVcyyxE2UbUiYc2wriz
   FQsWb3LsrK59fNGogPuVhjbeV1oAeqtIQBBRC+LAIxuP/r29Ee4IZQB1t
   G2scHtQ3Atar+6QJdZaFQvrWfHfJCZPPfiUqtdpApT7tznHjYOofTjBas
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="235252205"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="235252205"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="577939045"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2022 01:50:18 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRWTx-0001Dt-PX; Tue, 08 Mar 2022 09:50:17 +0000
Date:   Tue, 8 Mar 2022 17:50:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:sb_iostats 5/12] include/linux/percpu_counter.h:122:31:
 error: incompatible types when assigning to type 'struct percpu_counter'
 from type 's64' {aka 'long long int'}
Message-ID: <202203081741.vFnZtCst-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux sb_iostats
head:   e0cfb03c7706e5f555c4c7568d5575b0c12ce1c0
commit: f459e7283ed5d3be5fe79aa7a49e45333dac08d0 [5/12] lib/percpu_counter: add helpers for arrays of counters
config: arm-randconfig-r015-20220307 (https://download.01.org/0day-ci/archive/20220308/202203081741.vFnZtCst-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/amir73il/linux/commit/f459e7283ed5d3be5fe79aa7a49e45333dac08d0
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il sb_iostats
        git checkout f459e7283ed5d3be5fe79aa7a49e45333dac08d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sched/user.h:7,
                    from include/linux/cred.h:17,
                    from include/linux/sched/signal.h:10,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from arch/arm/kernel/asm-offsets.c:12:
   include/linux/percpu_counter.h: In function 'percpu_counters_init':
>> include/linux/percpu_counter.h:122:31: error: incompatible types when assigning to type 'struct percpu_counter' from type 's64' {aka 'long long int'}
     122 |                 counters[i] = amount;
         |                               ^~~~~~
   make[2]: *** [scripts/Makefile.build:121: arch/arm/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +122 include/linux/percpu_counter.h

   115	
   116	static inline int percpu_counters_init(struct percpu_counter counters[],
   117					       int num, s64 amount, gfp_t gfp)
   118	{
   119		int i;
   120	
   121		for (i = 0; i < num; i++)
 > 122			counters[i] = amount;
   123		return 0;
   124	}
   125	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
