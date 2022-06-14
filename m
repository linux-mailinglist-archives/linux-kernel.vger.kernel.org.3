Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE7E54B429
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346244AbiFNPEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343942AbiFNPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:04:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D241314
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655219067; x=1686755067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZbtSecF7AFAR9pnM3UZmnuxGPmxJcY7k5Hwk4CsZ3Kw=;
  b=NPZElZKOyME+QQi6XYWQrPTDVjaj/y3D4LC6d9F10IU/1GZCCT+rDZTS
   0Vvwzk2GQ04IReGjzWD3PYVMI+ds1egh7VaSmhuJgYWCneZ5s5Orn5Fzs
   PRCwvjGTUoMK8EbLpFgL/nrKKjWzQSHr5QU18Cu3qRfLMyfRFvouhdJEH
   ORk7rRhL0/+Hv/QGC2BwkGmKLY4YG/Mw1eHIPs3ZiEbLNDSZV2DCN6q38
   UD8JMZdFuxltl0tnRmft05Vp1gMvC2eUH7/zNMmI7maXR+UvZYhWlvDgJ
   ocI/OQnmpzc0OJNVI3z4n6LpXvHYE9isq/GtggZqj9iM5/zmO/umNqCWD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279359596"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279359596"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="558379340"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2022 08:03:35 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o184t-000M17-8R;
        Tue, 14 Jun 2022 15:03:35 +0000
Date:   Tue, 14 Jun 2022 23:03:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/powernv/opal-fadump.h:138:25: sparse: sparse:
 cast from restricted __be64
Message-ID: <202206142217.Y5HsfbXB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: b74196af372f7cb4902179009265fe63ac81824f powerpc/fadump: Fix fadump to work with a different endian capture kernel
date:   7 weeks ago
config: powerpc64-randconfig-s032-20220613 (https://download.01.org/0day-ci/archive/20220614/202206142217.Y5HsfbXB-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b74196af372f7cb4902179009265fe63ac81824f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b74196af372f7cb4902179009265fe63ac81824f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kvm/ arch/powerpc/platforms/powernv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/powerpc/platforms/powernv/opal-fadump.c: note: in included file:
>> arch/powerpc/platforms/powernv/opal-fadump.h:138:25: sparse: sparse: cast from restricted __be64

vim +138 arch/powerpc/platforms/powernv/opal-fadump.h

   123	
   124	static inline void opal_fadump_read_regs(char *bufp, unsigned int regs_cnt,
   125						 unsigned int reg_entry_size,
   126						 bool cpu_endian,
   127						 struct pt_regs *regs)
   128	{
   129		struct hdat_fadump_reg_entry *reg_entry;
   130		u64 val;
   131		int i;
   132	
   133		memset(regs, 0, sizeof(struct pt_regs));
   134	
   135		for (i = 0; i < regs_cnt; i++, bufp += reg_entry_size) {
   136			reg_entry = (struct hdat_fadump_reg_entry *)bufp;
   137			val = (cpu_endian ? be64_to_cpu(reg_entry->reg_val) :
 > 138			       (u64)(reg_entry->reg_val));
   139			opal_fadump_set_regval_regnum(regs,
   140						      be32_to_cpu(reg_entry->reg_type),
   141						      be32_to_cpu(reg_entry->reg_num),
   142						      val);
   143		}
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
