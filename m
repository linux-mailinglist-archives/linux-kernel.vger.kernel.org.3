Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1994D13D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345487AbiCHJvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbiCHJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:51:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1873C711
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646733021; x=1678269021;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q1WD9jEKMGkl9loUYEwg1FNSLh7xLsSgC4IkJp8EUho=;
  b=bDjueb9047bOocEt5pnxETpmpp7c6u6sXkeDeDQWb554pbaNV61WGMp/
   B1K+LMb9rAJ/tzFr9CUUeIKZgmwt1KiU/vTSJS7Z9iYrBrb75890UXTZh
   mM5/E7bTfoE/edKS7Rk/8cIQ8lTnPiSAZaUqxyBmcbpwn4NJI/NTuYKq5
   Q8Sg6+R6AmF6o04JfNIERjetA3cplGLI5Ax0Ivi4vxjmO+MUGkrlnJaCq
   x8hmAt7VaSrEBWHhb63peYGhQqBuDPytYz3dPXoUCzO3XI50e6eGbiSj5
   wMNTufCnZFUL31poYKut6E5xMqIiIXim7VvV5/EL6O2V+fYCuIIaHjh9i
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254833866"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254833866"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="495396972"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 01:50:18 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRWTx-0001Dr-P7; Tue, 08 Mar 2022 09:50:17 +0000
Date:   Tue, 8 Mar 2022 17:50:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [ammarfaizi2-block:powerpc/linux/next-test 142/143]
 arch/powerpc/kernel/prom_init.c:3302:22: warning: no previous prototype for
 'prom_init'
Message-ID: <202203081701.3LJH6Dgc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block powerpc/linux/next-test
head:   0a448e06d10e149bf5ed23202d49246b6c4cf77b
commit: 21dad3fa76176d992e8ddf3f49ad0866a5424da5 [142/143] powerpc: Move C prototypes out of asm-prototypes.h
config: powerpc-randconfig-r014-20220308 (https://download.01.org/0day-ci/archive/20220308/202203081701.3LJH6Dgc-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/21dad3fa76176d992e8ddf3f49ad0866a5424da5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block powerpc/linux/next-test
        git checkout 21dad3fa76176d992e8ddf3f49ad0866a5424da5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/kernel/prom_init.c:3302:22: warning: no previous prototype for 'prom_init' [-Wmissing-prototypes]
    3302 | unsigned long __init prom_init(unsigned long r3, unsigned long r4,
         |                      ^~~~~~~~~


vim +/prom_init +3302 arch/powerpc/kernel/prom_init.c

6a9c930bd7751b Ram Pai        2019-08-19  3296  
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3297  /*
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3298   * We enter here early on, when the Open Firmware prom is still
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3299   * handling exceptions and the MMU hash table for us.
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3300   */
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3301  
9b6b563c0d2d25 Paul Mackerras 2005-10-06 @3302  unsigned long __init prom_init(unsigned long r3, unsigned long r4,
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3303  			       unsigned long pp,
549e8152de8039 Paul Mackerras 2008-08-30  3304  			       unsigned long r6, unsigned long r7,
549e8152de8039 Paul Mackerras 2008-08-30  3305  			       unsigned long kbase)
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3306  {	
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3307  	unsigned long hdr;
9b6b563c0d2d25 Paul Mackerras 2005-10-06  3308  

:::::: The code at line 3302 was first introduced by commit
:::::: 9b6b563c0d2d25ecc3111916031aa7255543fbfb powerpc: Merge in the ppc64 version of the prom code.

:::::: TO: Paul Mackerras <paulus@samba.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
