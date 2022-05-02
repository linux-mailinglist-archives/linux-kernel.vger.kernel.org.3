Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90B5169A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357375AbiEBD7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357349AbiEBD7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:59:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB019012
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 20:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651463757; x=1682999757;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4eu+YYafPCeC83ogm9bZGptZ3P8ts1WwR0yPc3wVl2U=;
  b=chjqOT1pp2qPENODd0ApsROnLKop0PdH7dLTTTWH7L8n1ba2yv1dd/ub
   2RJUjb1iPs+NNDMTANhPYE70Jqd2QIJakHgVAL1uuN+gngbxEvTLYTvZW
   q8F7Oe3gD+oSdAy30dYTJ5Dgle7ifiCT/3BOprR1cbqm4mIXvbTM/h8Pz
   1xrQ6P0XDYb7LQpGl8tnxmMOvkUA/Y8a2/W4pDhays2zEbg2M2vxTZ2BW
   EsIsBnWJw+rH8+QHjkXA1plQ8ktp6XSIc0HW0tu4mijrGaVhF0szS5rQ3
   FdT68Qycdj2m+76I7UlNZuFzRmeNFB6fBb8qxXG3GOZo4JVPdH6meYPbz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="264700928"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="264700928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 20:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="707445021"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 May 2022 20:55:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlNAB-0009G3-ST;
        Mon, 02 May 2022 03:55:55 +0000
Date:   Mon, 2 May 2022 11:55:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/kernel/irq.c:51:12: sparse: sparse: symbol
 '__pcpu_scope_irq_stack_ptr' was not declared. Should it be static?
Message-ID: <202205021155.rWXuHh4K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
commit: 9c46929e7989efacc1dd0a1dd662a839897ea2b6 ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems
date:   5 months ago
config: arm-randconfig-s031-20220502 (https://download.01.org/0day-ci/archive/20220502/202205021155.rWXuHh4K-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9c46929e7989efacc1dd0a1dd662a839897ea2b6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9c46929e7989efacc1dd0a1dd662a839897ea2b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ drivers/scsi/lpfc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm/kernel/irq.c:51:12: sparse: sparse: symbol '__pcpu_scope_irq_stack_ptr' was not declared. Should it be static?

vim +/__pcpu_scope_irq_stack_ptr +51 arch/arm/kernel/irq.c

9974f857768e4e Ard Biesheuvel  2021-10-05  46  
4a2581a080098c Thomas Gleixner 2006-07-01 @47  unsigned long irq_err_count;
^1da177e4c3f41 Linus Torvalds  2005-04-16  48  
d4664b6c987f80 Ard Biesheuvel  2021-10-05  49  #ifdef CONFIG_IRQSTACKS
d4664b6c987f80 Ard Biesheuvel  2021-10-05  50  
d4664b6c987f80 Ard Biesheuvel  2021-10-05 @51  asmlinkage DEFINE_PER_CPU_READ_MOSTLY(u8 *, irq_stack_ptr);
d4664b6c987f80 Ard Biesheuvel  2021-10-05  52  

:::::: The code at line 51 was first introduced by commit
:::::: d4664b6c987f80338407889c1e3f3abe7e16be94 ARM: implement IRQ stacks

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
