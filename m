Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7312D493A21
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349057AbiASMOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:14:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:26037 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234677AbiASMO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642594469; x=1674130469;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JoykHqTRCK3NznH7cESEkZESjiRiipnRIDgctDCMhxM=;
  b=JuWpfG30WrkfXReNvnogolhpBm/FeJ1S8JAoPqnAkZmMOHvdkq2hrhzb
   KcPB4Cd94NRESdef5uiVhfW6ZCjnfYds9kMUQfQ8V54VdgI3Z1MOZeFIF
   NkZKRDfFckr4Hb3pe27U89PoRbZpsz6WIRPk39OewFm5lvEeeEBGU2OUK
   VeaE/p12jmxKRJhSAWETKP6l5JWam5JhKG3ji6tgbxhBmeSKnYL3kr5zA
   y0CdxkoCVEi86l+7kMDOQPb3SgcclhhcLcJb57gkwXBmzADkqxWp6ho0f
   YaWeG6oVjzZv14ONr5Qoc3004nBkqIUi8AaIleahKxterckZUC45Sw0op
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="245248966"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="245248966"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 04:14:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="693757771"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Jan 2022 04:14:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA9r8-000DW1-UJ; Wed, 19 Jan 2022 12:14:26 +0000
Date:   Wed, 19 Jan 2022 20:13:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/mctp/af_mctp.c:259:6: error: unexpected token, expected comma
Message-ID: <202201192005.O7wDT8RE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
commit: 99ce45d5e7dbde399997a630f45ac9f654fa4bcc mctp: Implement extended addressing
date:   3 months ago
config: mips-randconfig-r003-20220118 (https://download.01.org/0day-ci/archive/20220119/202201192005.O7wDT8RE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=99ce45d5e7dbde399997a630f45ac9f654fa4bcc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 99ce45d5e7dbde399997a630f45ac9f654fa4bcc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/cxl/ mm// net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mctp/af_mctp.c:259:6: error: unexpected token, expected comma
           if (get_user(len, optlen))
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
>> net/mctp/af_mctp.c:259:6: error: invalid operand for instruction
           if (get_user(len, optlen))
               ^
   arch/mips/include/asm/uaccess.h:138:33: note: expanded from macro 'get_user'
           access_ok(__p, sizeof(*__p)) ? __get_user((x), __p) :           \
                                          ^
   arch/mips/include/asm/uaccess.h:224:23: note: expanded from macro '__get_user'
                   __get_data_asm((x), user_lw, __gu_ptr);                 \
                                       ^
   <inline asm>:4:10: note: instantiated into assembly here
           lwe $2, 0($20)
                   ^
   2 errors generated.


vim +259 net/mctp/af_mctp.c

   249	
   250	static int mctp_getsockopt(struct socket *sock, int level, int optname,
   251				   char __user *optval, int __user *optlen)
   252	{
   253		struct mctp_sock *msk = container_of(sock->sk, struct mctp_sock, sk);
   254		int len, val;
   255	
   256		if (level != SOL_MCTP)
   257			return -EINVAL;
   258	
 > 259		if (get_user(len, optlen))
   260			return -EFAULT;
   261	
   262		if (optname == MCTP_OPT_ADDR_EXT) {
   263			if (len != sizeof(int))
   264				return -EINVAL;
   265			val = !!msk->addr_ext;
   266			if (copy_to_user(optval, &val, len))
   267				return -EFAULT;
   268			return 0;
   269		}
   270	
   271		return -EINVAL;
   272	}
   273	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
