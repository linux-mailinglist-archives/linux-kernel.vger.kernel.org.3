Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2544BA015
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiBQMZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:25:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiBQMZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:25:04 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4DB2AE07D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645100690; x=1676636690;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=evOFZE+hh5TqcN4Ay9LZSmgI4BU09Ah2EtjKEB7JYtg=;
  b=VgFdssScRe4GUU78IbTgFCXSvjoBFbr+fnD4BeQYl931kX+Nc2K9YXJo
   H8WGDrt001Sju/6z8Jz4FdMLDUrh1FOTXu6CVUes9vC88pTkgOjHPSZcZ
   MEPpx9nFmzrK8xqtsiRm9wtj6PPQXyeIjLfeziXcKXkXaiauh8Sg+0SgO
   HU3WZjImBNu4cUM4u0EJBTkp+RxwEmk56FCLahQig8wI/ReuGoevOeG1+
   7n5KR76qhh0DaDvvEQ7Dhv2P3VtUTEJkC5USRnMCH+Efhajl0B/r00OTO
   wa3VK14thtBmQxa7mvH6hehJTtjsbFrr0U5DJ7TfKxrxLrLv7fM7lxvyJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250597981"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="250597981"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 04:24:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="545567227"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2022 04:24:49 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKfq4-0000Aw-EB; Thu, 17 Feb 2022 12:24:48 +0000
Date:   Thu, 17 Feb 2022 20:23:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous
 prototype for 'ixp4xx_pci_write'
Message-ID: <202202172055.BVOB1ugQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
commit: d5d9f7ac58ea1041375a028f143ca5784693ea86 ARM/ixp4xx: Make NEED_MACH_IO_H optional
date:   8 months ago
config: arm-randconfig-r012-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172055.BVOB1ugQ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5d9f7ac58ea1041375a028f143ca5784693ea86
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d5d9f7ac58ea1041375a028f143ca5784693ea86
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/mach-ixp4xx/common-pci.c:94:5: warning: no previous prototype for 'ixp4xx_pci_read_errata' [-Wmissing-prototypes]
      94 | int ixp4xx_pci_read_errata(u32 addr, u32 cmd, u32* data)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-ixp4xx/common-pci.c:121:5: warning: no previous prototype for 'ixp4xx_pci_read_no_errata' [-Wmissing-prototypes]
     121 | int ixp4xx_pci_read_no_errata(u32 addr, u32 cmd, u32* data)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous prototype for 'ixp4xx_pci_write' [-Wmissing-prototypes]
     143 | int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
         |     ^~~~~~~~~~~~~~~~


vim +/ixp4xx_pci_write +143 arch/arm/mach-ixp4xx/common-pci.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  142  
^1da177e4c3f41 Linus Torvalds  2005-04-16 @143  int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
^1da177e4c3f41 Linus Torvalds  2005-04-16  144  {    
^1da177e4c3f41 Linus Torvalds  2005-04-16  145  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds  2005-04-16  146  	int retval = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  147  
bd31b85960a7fc Thomas Gleixner 2009-07-03  148  	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  149  
^1da177e4c3f41 Linus Torvalds  2005-04-16  150  	*PCI_NP_AD = addr;
^1da177e4c3f41 Linus Torvalds  2005-04-16  151  
^1da177e4c3f41 Linus Torvalds  2005-04-16  152  	/* set up the write */
^1da177e4c3f41 Linus Torvalds  2005-04-16  153  	*PCI_NP_CBE = cmd;
^1da177e4c3f41 Linus Torvalds  2005-04-16  154  
^1da177e4c3f41 Linus Torvalds  2005-04-16  155  	/* execute the write by writing to NP_WDATA */
^1da177e4c3f41 Linus Torvalds  2005-04-16  156  	*PCI_NP_WDATA = data;
^1da177e4c3f41 Linus Torvalds  2005-04-16  157  
^1da177e4c3f41 Linus Torvalds  2005-04-16  158  	if(check_master_abort())
^1da177e4c3f41 Linus Torvalds  2005-04-16  159  		retval = 1;
^1da177e4c3f41 Linus Torvalds  2005-04-16  160  
bd31b85960a7fc Thomas Gleixner 2009-07-03  161  	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  162  	return retval;
^1da177e4c3f41 Linus Torvalds  2005-04-16  163  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  164  

:::::: The code at line 143 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
