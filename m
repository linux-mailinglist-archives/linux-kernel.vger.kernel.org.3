Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5834849441B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 01:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbiATARy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 19:17:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:7430 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344953AbiATARq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 19:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642637866; x=1674173866;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OBdLO0on8C7x30AeUyMMRxRwAmwTkaSoxmyAwkdvSM0=;
  b=mTqzpetgKwpcDiwFBht8MWucWUPFeOviWVIcDTJgbX30NQNleThT5zKP
   JN6f9b2tiwKWi2GJIOseMpix1XC6gbFFcKdWl5FKyLs2qJ2nRJ63Dsnut
   viGtYOLq+owQFlhOWpC/7p1PAe9puh8eM2r9NMMTmQYY+1u36NjodElQA
   +ghQzZuatHzBvy1rVhLHUi2sxQ6knAiBNApasbM2U1nMh8Buc28h9e3OU
   yBgIo17E7vlRUiakbbsuXm6fCVVHa6rW6Zg4DUR7pvyIBeUeBzMBWpHOW
   +9HyiKPWEBj0cJPUiPs3Te5q7fmTnkyHOVxs0gM97L1q54EpSw4L3CKX/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="245026692"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="245026692"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 16:17:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="694001440"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Jan 2022 16:17:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAL95-000Dqg-76; Thu, 20 Jan 2022 00:17:43 +0000
Date:   Thu, 20 Jan 2022 08:17:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/cxl/core/mbox.c:330:6: error: unexpected token, expected
 comma
Message-ID: <202201200842.QCcshg1P-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
commit: 4faf31b43468c58e2c8c91cc5fa26f08a6b733be cxl/mbox: Move mailbox and other non-PCI specific infrastructure to the core
date:   4 months ago
config: mips-randconfig-r003-20220118 (https://download.01.org/0day-ci/archive/20220120/202201200842.QCcshg1P-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4faf31b43468c58e2c8c91cc5fa26f08a6b733be
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4faf31b43468c58e2c8c91cc5fa26f08a6b733be
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/cxl/core/mbox.c:330:6: error: unexpected token, expected comma
           if (get_user(n_commands, &q->n_commands))
               ^
   arch/mips/include/asm/uaccess.h:138:33: note: expanded from macro 'get_user'
           access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
                                          ^
   arch/mips/include/asm/uaccess.h:224:23: note: expanded from macro '__get_user'
                   __get_data_asm((x), user_lw, __gu_ptr);                 \
                                       ^
   <inline asm>:3:10: note: instantiated into assembly here
           .set    eva
                      ^
>> drivers/cxl/core/mbox.c:330:6: error: invalid operand for instruction
           if (get_user(n_commands, &q->n_commands))
               ^
   arch/mips/include/asm/uaccess.h:138:33: note: expanded from macro 'get_user'
           access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
                                          ^
   arch/mips/include/asm/uaccess.h:224:23: note: expanded from macro '__get_user'
                   __get_data_asm((x), user_lw, __gu_ptr);                 \
                                       ^
   <inline asm>:4:10: note: instantiated into assembly here
           lwe $4, 0($16)
                   ^
   drivers/cxl/core/mbox.c:335:10: error: unexpected token, expected comma
                   return put_user(cxl_cmd_count, &q->n_commands);
                          ^
   arch/mips/include/asm/uaccess.h:112:33: note: expanded from macro 'put_user'
           access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
                                          ^
   arch/mips/include/asm/uaccess.h:177:18: note: expanded from macro '__put_user'
                   __put_data_asm(user_sw, __pu_ptr);                      \
                                  ^
   <inline asm>:3:10: note: instantiated into assembly here
           .set    eva
                      ^
   drivers/cxl/core/mbox.c:335:10: error: invalid operand for instruction
                   return put_user(cxl_cmd_count, &q->n_commands);
                          ^
   arch/mips/include/asm/uaccess.h:112:33: note: expanded from macro 'put_user'
           access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;  \
                                          ^
   arch/mips/include/asm/uaccess.h:177:18: note: expanded from macro '__put_user'
                   __put_data_asm(user_sw, __pu_ptr);                      \
                                  ^
   <inline asm>:4:10: note: instantiated into assembly here
           swe $3, 0($16)
                   ^
   4 errors generated.


vim +330 drivers/cxl/core/mbox.c

   319	
   320	int cxl_query_cmd(struct cxl_memdev *cxlmd,
   321			  struct cxl_mem_query_commands __user *q)
   322	{
   323		struct device *dev = &cxlmd->dev;
   324		struct cxl_mem_command *cmd;
   325		u32 n_commands;
   326		int j = 0;
   327	
   328		dev_dbg(dev, "Query IOCTL\n");
   329	
 > 330		if (get_user(n_commands, &q->n_commands))
   331			return -EFAULT;
   332	
   333		/* returns the total number if 0 elements are requested. */
   334		if (n_commands == 0)
   335			return put_user(cxl_cmd_count, &q->n_commands);
   336	
   337		/*
   338		 * otherwise, return max(n_commands, total commands) cxl_command_info
   339		 * structures.
   340		 */
   341		cxl_for_each_cmd(cmd) {
   342			const struct cxl_command_info *info = &cmd->info;
   343	
   344			if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
   345				return -EFAULT;
   346	
   347			if (j == n_commands)
   348				break;
   349		}
   350	
   351		return 0;
   352	}
   353	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
