Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE834DA999
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353601AbiCPFSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244521AbiCPFSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:18:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4065BE6D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647407847; x=1678943847;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w8iJ2sWnY/apWTZBfEbJmkh/L8mm0lNnZAlpbnG2gk4=;
  b=kEMb0rRwyLwZsS5hmd7GtE7UegyzsfIT1Rr6twn2BfvOITctinU23L4Q
   ZEYskPRPIcKxqkvso0NMwBN14MRfq50F9nU0uWI7wTBBjMVTPvCSxuY2T
   8xcoXO2eMJFFr9uOgvIdPETMuBOklWVkwsa5Fsek4Mo1Nwslw0rIUCSD9
   /qMfnYBwDODliYuo2fexIphzK5AhqEZhUm18GGSGs0pJg3u4wwOxVhXyd
   PZWdR4XnR/xuboAhtOI1JtUxaLZ8k2gIdqy2FHKK4+KXU3f9T7COn3XUS
   4YAjThWRu7jaIHAZ3uNsxCGMWm0EBkRtK/Q8fo/Acux5c3/ekgbTMbSvL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256684997"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256684997"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 22:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="540758097"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2022 22:17:26 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUM2H-000C1R-AU; Wed, 16 Mar 2022 05:17:25 +0000
Date:   Wed, 16 Mar 2022 13:16:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:nfsd-courteous-server 31/41] include/linux/fs.h:1340:13:
 sparse: sparse: function 'locks_owner_has_blockers' with external linkage
 has definition
Message-ID: <202203161339.iou7bfaC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux nfsd-courteous-server
head:   df7704ec9804486aa3f3888fca582467a796ab2d
commit: ec6ec997faf8e90bef09f6e0376a157659a492c6 [31/41] fs/lock: add helper locks_owner_has_blockers to check for blockers
config: h8300-randconfig-s032-20220313 (https://download.01.org/0day-ci/archive/20220316/202203161339.iou7bfaC-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=ec6ec997faf8e90bef09f6e0376a157659a492c6
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel nfsd-courteous-server
        git checkout ec6ec997faf8e90bef09f6e0376a157659a492c6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/pinctrl/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/pinctrl/mediatek/pinctrl-mt6397.c: note: in included file (through include/linux/seq_file.h, include/linux/pinctrl/pinctrl.h):
>> include/linux/fs.h:1340:13: sparse: sparse: function 'locks_owner_has_blockers' with external linkage has definition
   include/linux/fs.h:1340:13: sparse: sparse: symbol 'locks_owner_has_blockers' was not declared. Should it be static?
--
   drivers/pinctrl/mediatek/pinctrl-mtk-common.c: note: in included file (through include/linux/seq_file.h, include/linux/pinctrl/pinctrl.h, include/linux/gpio/driver.h):
>> include/linux/fs.h:1340:13: sparse: sparse: function 'locks_owner_has_blockers' with external linkage has definition
   include/linux/fs.h:1340:13: sparse: sparse: symbol 'locks_owner_has_blockers' was not declared. Should it be static?
--
   drivers/pinctrl/mediatek/mtk-eint.c: note: in included file (through include/linux/seq_file.h, include/linux/pinctrl/pinctrl.h, include/linux/gpio/driver.h):
>> include/linux/fs.h:1340:13: sparse: sparse: function 'locks_owner_has_blockers' with external linkage has definition
   include/linux/fs.h:1340:13: sparse: sparse: symbol 'locks_owner_has_blockers' was not declared. Should it be static?
   drivers/pinctrl/mediatek/mtk-eint.c: note: in included file (through include/linux/io.h, include/linux/irq.h, include/linux/gpio/driver.h):
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/pinctrl/mediatek/mtk-eint.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] b
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   drivers/pinctrl/mediatek/mtk-eint.c: note: in included file (through include/linux/io.h, include/linux/irq.h, include/linux/gpio/driver.h):
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/pinctrl/mediatek/mtk-eint.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] b
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   drivers/pinctrl/mediatek/mtk-eint.c: note: in included file (through include/linux/io.h, include/linux/irq.h, include/linux/gpio/driver.h):
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/pinctrl/mediatek/mtk-eint.c: note: in included file (through arch/h8300/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] b
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]
   drivers/pinctrl/mediatek/mtk-eint.c: note: in included file (through include/linux/io.h, include/linux/irq.h, include/linux/gpio/driver.h):
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression

vim +/locks_owner_has_blockers +1340 include/linux/fs.h

  1336	
  1337	struct files_struct;
  1338	static inline void show_fd_locks(struct seq_file *f,
  1339				struct file *filp, struct files_struct *files) {}
> 1340	extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
  1341				fl_owner_t owner)
  1342	{
  1343		return false;
  1344	}
  1345	#endif /* !CONFIG_FILE_LOCKING */
  1346	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
