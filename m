Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F044F2256
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiDEFCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiDEFCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:02:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570C315705
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649134788; x=1680670788;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8+0bRNnHeq3JDydnNumtljIA9OYcrLxonDmjdgyGOGs=;
  b=LbmO75CEf+N8C/6srA58L9UqfANXRVJrt1o3csLxdi4YI6YjD9jDApte
   3G0M//B0EYEoPbebIUM88ldDnnttsikLvsEOfjYkoLolxn5W01fRfyeqf
   z9BCbqz6v9lh2D1fHJT1yqz4qS12+tAb33SVf80FtVwRJJWqM6SiFKHbZ
   sIB9nbjaOyY5ukjzP9mGw+SE7ZL23KVMmtkuta2S83nzTC2xEboEp+GnC
   r3/dmmyi57IzQjsOHCMQmuq0nkkgB3jHWofbXjWI7pLTX6Oozlg64p3+x
   LDM/wyUZON0Lmm2xzkBwr4KDdcXKmgGfR+zVUS2cZlFp6Cy8tha0QvNcA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="240601559"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="240601559"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 21:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="523848679"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2022 21:59:44 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbbI8-0002e9-8Q;
        Tue, 05 Apr 2022 04:59:44 +0000
Date:   Tue, 5 Apr 2022 12:58:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/message/fusion/mptctl.c:1492:9: warning: 'strncpy' output
 may be truncated copying 31 bytes from a string of length 31
Message-ID: <202204051248.mIuzvPFX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
date:   4 months ago
config: arm64-randconfig-r002-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051248.mIuzvPFX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd03762ab608e058c8f390ad9cf667e490089796
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/message/fusion/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/message/fusion/mptctl.c: In function 'mptctl_do_mpt_command':
   drivers/message/fusion/mptctl.c:1823:27: warning: variable 'config_frame' set but not used [-Wunused-but-set-variable]
    1823 |                 Config_t *config_frame;
         |                           ^~~~~~~~~~~~
   drivers/message/fusion/mptctl.c:2003:34: warning: variable 'pScsiTm' set but not used [-Wunused-but-set-variable]
    2003 |                 SCSITaskMgmt_t  *pScsiTm;
         |                                  ^~~~~~~
   drivers/message/fusion/mptctl.c: In function 'mptctl_hp_hostinfo':
   drivers/message/fusion/mptctl.c:2329:33: warning: variable 'retval' set but not used [-Wunused-but-set-variable]
    2329 |         int                     retval;
         |                                 ^~~~~~
   drivers/message/fusion/mptctl.c: In function 'mptctl_readtest':
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
