Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6549C4E2642
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbiCUMYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244291AbiCUMYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:24:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326F1667EA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647865367; x=1679401367;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HlvIvSnaoFM8HxswpNY6X3N/4FByJgJM9xX5fWMsj68=;
  b=bycYWsrT5XI6dn3MkOWL9JD0JWuEkZCzFIoi0+9Gy36KM1pZ3XT3DrE4
   x2GFbV+YbDwJCc88YPyz03ILKxjZI2Jc4INSn9j6bdjxVuxg4HQcRQjjB
   xrpwXAqhAOuXJgWVLRMn7fYuaIZWCq7vbn1LnJBr/0SBLG5FStQNuNEa7
   MMQq8cznnjiXSYLMpEcIVvhvuQBAcuFkL2uP5MHcPUZNW4GrH7kQCsCiz
   e0D06pUg1KFCA685B07K86GRv/xXunfjT4yfg/mFazTpRI88Y4VNlnVlj
   h5VaKmqkmSv12/Z7S2TYMncbzuvA7V5uKhaVoqdAvQecBRl2tVnHIoJJg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="256355025"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="256355025"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="518416086"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2022 05:22:45 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWH3d-000HpA-87; Mon, 21 Mar 2022 12:22:45 +0000
Date:   Mon, 21 Mar 2022 20:22:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 297/319] arch/arm/mach-rpc/ecard.c:464:6:
 warning: no previous prototype for 'ecard_enablefiq'
Message-ID: <202203212052.jkUE9g2Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   a05da846ebd6cdac01b4c4fded4bada67bec84f0
commit: eb3e40ad488df724d8440148bebd35728feed3f8 [297/319] scsi: ufs: Make the config_scaling_param calls type safe
config: arm-rpc_defconfig (https://download.01.org/0day-ci/archive/20220321/202203212052.jkUE9g2Z-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/eb3e40ad488df724d8440148bebd35728feed3f8
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next
        git checkout eb3e40ad488df724d8440148bebd35728feed3f8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-rpc/ drivers/net/ethernet/i825xx/ drivers/scsi/arm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-rpc/ecard.c:464:6: warning: no previous prototype for 'ecard_enablefiq' [-Wmissing-prototypes]
     464 | void ecard_enablefiq(unsigned int fiqnr)
         |      ^~~~~~~~~~~~~~~
>> arch/arm/mach-rpc/ecard.c:480:6: warning: no previous prototype for 'ecard_disablefiq' [-Wmissing-prototypes]
     480 | void ecard_disablefiq(unsigned int fiqnr)
         |      ^~~~~~~~~~~~~~~~
--
>> arch/arm/mach-rpc/irq.c:73:13: warning: no previous prototype for 'rpc_init_irq' [-Wmissing-prototypes]
      73 | void __init rpc_init_irq(void)
         |             ^~~~~~~~~~~~
--
>> arch/arm/mach-rpc/time.c:73:13: warning: no previous prototype for 'ioctime_init' [-Wmissing-prototypes]
      73 | void __init ioctime_init(void)
         |             ^~~~~~~~~~~~
>> arch/arm/mach-rpc/time.c:91:13: warning: no previous prototype for 'ioc_timer_init' [-Wmissing-prototypes]
      91 | void __init ioc_timer_init(void)
         |             ^~~~~~~~~~~~~~
--
>> drivers/scsi/arm/cumana_2.c:299:13: warning: no previous prototype for 'cumanascsi_2_info' [-Wmissing-prototypes]
     299 | const char *cumanascsi_2_info(struct Scsi_Host *host)
         |             ^~~~~~~~~~~~~~~~~
--
>> drivers/scsi/arm/eesox.c:384:13: warning: no previous prototype for 'eesoxscsi_info' [-Wmissing-prototypes]
     384 | const char *eesoxscsi_info(struct Scsi_Host *host)
         |             ^~~~~~~~~~~~~~
--
>> drivers/scsi/arm/powertec.c:187:13: warning: no previous prototype for 'powertecscsi_info' [-Wmissing-prototypes]
     187 | const char *powertecscsi_info(struct Scsi_Host *host)
         |             ^~~~~~~~~~~~~~~~~
--
>> drivers/scsi/arm/fas216.c:886: warning: expecting prototype for fas216_disconnected_intr(). Prototype was for fas216_disconnect_intr() instead
   drivers/scsi/arm/fas216.c:1318: warning: Function parameter or member 'start' not described in 'fas216_send_messageout'
>> drivers/scsi/arm/fas216.c:2277: warning: expecting prototype for fas216_noqueue_command(). Prototype was for fas216_noqueue_command_lck() instead
   drivers/scsi/arm/fas216.c:2359: warning: Function parameter or member 'info' not described in 'fas216_find_command'
>> drivers/scsi/arm/fas216.c:2359: warning: expecting prototype for fas216_do_abort(). Prototype was for fas216_find_command() instead


vim +/ecard_enablefiq +464 arch/arm/mach-rpc/ecard.c

^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  463  
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16 @464  void ecard_enablefiq(unsigned int fiqnr)
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  465  {
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  466  	ecard_t *ec = slot_to_ecard(fiqnr);
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  467  
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  468  	if (ec) {
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  469  		if (!ec->ops)
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  470  			ec->ops = &ecard_default_ops;
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  471  
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  472  		if (ec->claimed && ec->ops->fiqenable)
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  473  			ec->ops->fiqenable(ec, fiqnr);
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  474  		else
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  475  			printk(KERN_ERR "ecard: rejecting request to "
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  476  				"enable FIQs for %d\n", fiqnr);
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  477  	}
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  478  }
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  479  
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16 @480  void ecard_disablefiq(unsigned int fiqnr)
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  481  {
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  482  	ecard_t *ec = slot_to_ecard(fiqnr);
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  483  
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  484  	if (ec) {
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  485  		if (!ec->ops)
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  486  			ec->ops = &ecard_default_ops;
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  487  
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  488  		if (ec->ops->fiqdisable)
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  489  			ec->ops->fiqdisable(ec, fiqnr);
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  490  	}
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  491  }
^1da177e4c3f41 arch/arm/kernel/ecard.c Linus Torvalds 2005-04-16  492  

:::::: The code at line 464 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
