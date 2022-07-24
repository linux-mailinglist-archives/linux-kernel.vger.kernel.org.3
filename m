Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE52157F30B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 06:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiGXEie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 00:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXEi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 00:38:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AE113F63
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 21:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658637508; x=1690173508;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LAMSg4BphBKAvKpfg6LubH54lsHd1waIVA1UK9I/ClQ=;
  b=T8NPAKjU82bQUqYUJBOIoM/CZmEM6n/+VoZdPNLboHEtzhmdmcHBA8g2
   V3sSc8Xhx1Ys+tWI8vRiM9Jlk5lspc797eZH5OdEEYwhOpwIXukc/PeDs
   roSvzmAUtB0GqgWjEaLov8N7YyneYGtqoCe1VahVREEiTVmxFi3SNrD+K
   a7vJD/bLJa9ZtLuxp9zVG7+pphw4aZe0l15fW5It6eAZq82Os3bD8WB4W
   afSTF+cXMcUNAtkHz8GNBr2EvbI+FkyuB6H1XQGdewOlDn6kreX0NiLuo
   hfaZS/UInrT6HvwQAGdjVYl9Tq0nk7H91b8NaCBdGGFzGZBpFC5RMneMs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="313255912"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="313255912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 21:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="741465440"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2022 21:38:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFTNq-0003Xt-0H;
        Sun, 24 Jul 2022 04:38:26 +0000
Date:   Sun, 24 Jul 2022 12:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: drivers/message/fusion/mptctl.c:1494:9: warning: 'strncpy' specified
 bound 12 equals destination size
Message-ID: <202207241206.1sEV4rEU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: e37b3dd063a1a68e28a7cfaf77c84c472112e330 s390: enable KCSAN
date:   12 months ago
config: s390-randconfig-r033-20220721 (https://download.01.org/0day-ci/archive/20220724/202207241206.1sEV4rEU-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e37b3dd063a1a68e28a7cfaf77c84c472112e330
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e37b3dd063a1a68e28a7cfaf77c84c472112e330
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/message/fusion/

If you fix the issue, kindly add following tag where applicable
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
   In function 'mptctl_readtest',
       inlined from '__mptctl_ioctl.isra' at drivers/message/fusion/mptctl.c:661:10:
>> drivers/message/fusion/mptctl.c:1494:9: warning: 'strncpy' specified bound 12 equals destination size [-Wstringop-truncation]
    1494 |         strncpy (karg.product, ioc->prod_name, MPT_PRODUCT_LENGTH);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +1494 drivers/message/fusion/mptctl.c

^1da177e4c3f415 Linus Torvalds  2005-04-16  1459  
^1da177e4c3f415 Linus Torvalds  2005-04-16  1460  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
^1da177e4c3f415 Linus Torvalds  2005-04-16  1461  /* MPT IOCTL Test function.
^1da177e4c3f415 Linus Torvalds  2005-04-16  1462   *
^1da177e4c3f415 Linus Torvalds  2005-04-16  1463   * Outputs:	None.
^1da177e4c3f415 Linus Torvalds  2005-04-16  1464   * Return:	0 if successful
^1da177e4c3f415 Linus Torvalds  2005-04-16  1465   *		-EFAULT if data unavailable
^1da177e4c3f415 Linus Torvalds  2005-04-16  1466   *		-ENODEV  if no such device/adapter
^1da177e4c3f415 Linus Torvalds  2005-04-16  1467   */
^1da177e4c3f415 Linus Torvalds  2005-04-16  1468  static int
28d76df18f0ad5b Dan Carpenter   2020-01-14  1469  mptctl_readtest (MPT_ADAPTER *ioc, unsigned long arg)
^1da177e4c3f415 Linus Torvalds  2005-04-16  1470  {
^1da177e4c3f415 Linus Torvalds  2005-04-16  1471  	struct mpt_ioctl_test __user *uarg = (void __user *) arg;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1472  	struct mpt_ioctl_test	 karg;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1473  
^1da177e4c3f415 Linus Torvalds  2005-04-16  1474  	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_test))) {
29dd3609f2fc70e Eric Moore      2007-09-14  1475  		printk(KERN_ERR MYNAM "%s@%d::mptctl_readtest - "
^1da177e4c3f415 Linus Torvalds  2005-04-16  1476  			"Unable to read in mpt_ioctl_test struct @ %p\n",
^1da177e4c3f415 Linus Torvalds  2005-04-16  1477  				__FILE__, __LINE__, uarg);
^1da177e4c3f415 Linus Torvalds  2005-04-16  1478  		return -EFAULT;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1479  	}
^1da177e4c3f415 Linus Torvalds  2005-04-16  1480  
09120a8cd38dbdb Prakash, Sathya 2007-07-24  1481  	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_readtest called.\n",
09120a8cd38dbdb Prakash, Sathya 2007-07-24  1482  	    ioc->name));
^1da177e4c3f415 Linus Torvalds  2005-04-16  1483  	/* Fill in the data and return the structure to the calling
^1da177e4c3f415 Linus Torvalds  2005-04-16  1484  	 * program
^1da177e4c3f415 Linus Torvalds  2005-04-16  1485  	 */
^1da177e4c3f415 Linus Torvalds  2005-04-16  1486  
^1da177e4c3f415 Linus Torvalds  2005-04-16  1487  #ifdef MFCNT
^1da177e4c3f415 Linus Torvalds  2005-04-16  1488  	karg.chip_type = ioc->mfcnt;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1489  #else
^1da177e4c3f415 Linus Torvalds  2005-04-16  1490  	karg.chip_type = ioc->pcidev->device;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1491  #endif
^1da177e4c3f415 Linus Torvalds  2005-04-16  1492  	strncpy (karg.name, ioc->name, MPT_MAX_NAME);
^1da177e4c3f415 Linus Torvalds  2005-04-16  1493  	karg.name[MPT_MAX_NAME-1]='\0';
^1da177e4c3f415 Linus Torvalds  2005-04-16 @1494  	strncpy (karg.product, ioc->prod_name, MPT_PRODUCT_LENGTH);
^1da177e4c3f415 Linus Torvalds  2005-04-16  1495  	karg.product[MPT_PRODUCT_LENGTH-1]='\0';
^1da177e4c3f415 Linus Torvalds  2005-04-16  1496  
^1da177e4c3f415 Linus Torvalds  2005-04-16  1497  	/* Copy the data from kernel memory to user memory
^1da177e4c3f415 Linus Torvalds  2005-04-16  1498  	 */
^1da177e4c3f415 Linus Torvalds  2005-04-16  1499  	if (copy_to_user((char __user *)arg, &karg, sizeof(struct mpt_ioctl_test))) {
29dd3609f2fc70e Eric Moore      2007-09-14  1500  		printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_readtest - "
^1da177e4c3f415 Linus Torvalds  2005-04-16  1501  			"Unable to write out mpt_ioctl_test struct @ %p\n",
29dd3609f2fc70e Eric Moore      2007-09-14  1502  			ioc->name, __FILE__, __LINE__, uarg);
^1da177e4c3f415 Linus Torvalds  2005-04-16  1503  		return -EFAULT;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1504  	}
^1da177e4c3f415 Linus Torvalds  2005-04-16  1505  
^1da177e4c3f415 Linus Torvalds  2005-04-16  1506  	return 0;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1507  }
^1da177e4c3f415 Linus Torvalds  2005-04-16  1508  

:::::: The code at line 1494 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
