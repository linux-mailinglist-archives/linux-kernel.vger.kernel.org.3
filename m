Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D268D5473AB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiFKKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiFKKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:22:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE5F20B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654942932; x=1686478932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=buMZVdJ8BGUT7xbz85AmyK6cpJHkEmZrdVd0CJQfm+M=;
  b=iQFH5gwOY/D2CM2nDbvhJ5qKqn7+0cA/SinwkIp2LhshZrljeTZ/S2AM
   g588ldTZUbrYCLRGbDQSTlWwfOlC2C2Knd0sG3/3KW5eV2jLuFQJDyAF4
   5FehfYQFuQLg1YYTn3CBDuATSNGdvSKxY5QnlRS8YkKulfXGdlIp2J4qf
   AxvUrVcvtUb7YLOOr4j32/yu4b6aqGTj6JOjY6Oe0HQ5PKOeO03ct0QIQ
   XuAAlDr8IhFjAszgGn74ySgFCjm2nyWzlbEWhRTVDFI41HITVo7VI3m2i
   /PFl37yI9ZNM556dfJghcBNjUf8n/8DM8t5oPu50k9CoxCQqun1NgTc2n
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="275391519"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="275391519"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 03:22:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="616843803"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2022 03:22:10 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzyFu-000InZ-4i;
        Sat, 11 Jun 2022 10:22:10 +0000
Date:   Sat, 11 Jun 2022 18:22:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/message/fusion/mptctl.c:1492:9: warning: 'strncpy' output
 may be truncated copying 31 bytes from a string of length 31
Message-ID: <202206111857.fA0M7H4s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0885eacdc81f920c3e0554d5615e69a66504a28d
commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
date:   6 months ago
config: arm64-randconfig-r013-20220611 (https://download.01.org/0day-ci/archive/20220611/202206111857.fA0M7H4s-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd03762ab608e058c8f390ad9cf667e490089796
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/message/fusion/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/message/fusion/mptctl.c: In function 'mptctl_hp_hostinfo':
   drivers/message/fusion/mptctl.c:2329:33: warning: variable 'retval' set but not used [-Wunused-but-set-variable]
    2329 |         int                     retval;
         |                                 ^~~~~~
   In function 'mptctl_readtest',
       inlined from '__mptctl_ioctl.isra' at drivers/message/fusion/mptctl.c:661:10:
>> drivers/message/fusion/mptctl.c:1492:9: warning: 'strncpy' output may be truncated copying 31 bytes from a string of length 31 [-Wstringop-truncation]
    1492 |         strncpy (karg.name, ioc->name, MPT_MAX_NAME);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +1492 drivers/message/fusion/mptctl.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  1459  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1460  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
^1da177e4c3f41 Linus Torvalds  2005-04-16  1461  /* MPT IOCTL Test function.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1462   *
^1da177e4c3f41 Linus Torvalds  2005-04-16  1463   * Outputs:	None.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1464   * Return:	0 if successful
^1da177e4c3f41 Linus Torvalds  2005-04-16  1465   *		-EFAULT if data unavailable
^1da177e4c3f41 Linus Torvalds  2005-04-16  1466   *		-ENODEV  if no such device/adapter
^1da177e4c3f41 Linus Torvalds  2005-04-16  1467   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1468  static int
28d76df18f0ad5 Dan Carpenter   2020-01-14  1469  mptctl_readtest (MPT_ADAPTER *ioc, unsigned long arg)
^1da177e4c3f41 Linus Torvalds  2005-04-16  1470  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  1471  	struct mpt_ioctl_test __user *uarg = (void __user *) arg;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1472  	struct mpt_ioctl_test	 karg;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1473  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1474  	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_test))) {
29dd3609f2fc70 Eric Moore      2007-09-14  1475  		printk(KERN_ERR MYNAM "%s@%d::mptctl_readtest - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  1476  			"Unable to read in mpt_ioctl_test struct @ %p\n",
^1da177e4c3f41 Linus Torvalds  2005-04-16  1477  				__FILE__, __LINE__, uarg);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1478  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1479  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  1480  
09120a8cd38dbd Prakash, Sathya 2007-07-24  1481  	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_readtest called.\n",
09120a8cd38dbd Prakash, Sathya 2007-07-24  1482  	    ioc->name));
^1da177e4c3f41 Linus Torvalds  2005-04-16  1483  	/* Fill in the data and return the structure to the calling
^1da177e4c3f41 Linus Torvalds  2005-04-16  1484  	 * program
^1da177e4c3f41 Linus Torvalds  2005-04-16  1485  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1486  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1487  #ifdef MFCNT
^1da177e4c3f41 Linus Torvalds  2005-04-16  1488  	karg.chip_type = ioc->mfcnt;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1489  #else
^1da177e4c3f41 Linus Torvalds  2005-04-16  1490  	karg.chip_type = ioc->pcidev->device;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1491  #endif
^1da177e4c3f41 Linus Torvalds  2005-04-16 @1492  	strncpy (karg.name, ioc->name, MPT_MAX_NAME);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1493  	karg.name[MPT_MAX_NAME-1]='\0';
^1da177e4c3f41 Linus Torvalds  2005-04-16  1494  	strncpy (karg.product, ioc->prod_name, MPT_PRODUCT_LENGTH);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1495  	karg.product[MPT_PRODUCT_LENGTH-1]='\0';
^1da177e4c3f41 Linus Torvalds  2005-04-16  1496  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1497  	/* Copy the data from kernel memory to user memory
^1da177e4c3f41 Linus Torvalds  2005-04-16  1498  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1499  	if (copy_to_user((char __user *)arg, &karg, sizeof(struct mpt_ioctl_test))) {
29dd3609f2fc70 Eric Moore      2007-09-14  1500  		printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_readtest - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  1501  			"Unable to write out mpt_ioctl_test struct @ %p\n",
29dd3609f2fc70 Eric Moore      2007-09-14  1502  			ioc->name, __FILE__, __LINE__, uarg);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1503  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1504  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  1505  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1506  	return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1507  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  1508  

:::::: The code at line 1492 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
