Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9618950854E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377395AbiDTKBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377369AbiDTKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:01:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4B83BF93
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650448698; x=1681984698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bOUtaX+PmECQ0swx/YCy7MNyYYwADHZzf3NqKuRbRqk=;
  b=A+dWGWCPiO7ogU+0yvE62NQg6z2Bgs4JiaCY1PX8915TQCRRAIPa0pfg
   OZcQ+WluLBAn2jfcQyYTyaNQ03Mjez+219fUtFUYpNRVK6Q0+aoBgpr9m
   LJ5Gtu0Dv9yur/YYKSwdwa0bl1Rmqgwd7VS7EMmrXr7aBlBqKMFBEc/Kt
   537EwL6QfwqXfZ3xSeKMwDrxZ4BEpDU7cOFAe1klyOberO7HDVMggzVsb
   8k9SUvUiDmtotJrfiLsy1V/py386rkDaSV11EHmOSodHUf3ipo/gx0tM6
   kzDl6otMBXFeKuZkIVoEEEhZpRtuK/713tVivPOrb4pd7otV34/MF0jcz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="264161920"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="264161920"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 02:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="647607880"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2022 02:58:17 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh76G-0006qs-Gv;
        Wed, 20 Apr 2022 09:58:16 +0000
Date:   Wed, 20 Apr 2022 17:57:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:stackleak/rework 7/7] arch/arm64/kernel/entry-common.c:273:13:
 error: implicit declaration of function 'on_thread_stack'; did you mean
 'on_task_stack'?
Message-ID: <202204201732.3XJvzeVZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git stackleak/rework
head:   3ff9898bf29634c068fe32a93656ca6685cad126
commit: 3ff9898bf29634c068fe32a93656ca6685cad126 [7/7] arm64: remove unused stackleak helpers
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220420/202204201732.3XJvzeVZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=3ff9898bf29634c068fe32a93656ca6685cad126
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark stackleak/rework
        git checkout 3ff9898bf29634c068fe32a93656ca6685cad126
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/entry-common.c: In function 'do_interrupt_handler':
>> arch/arm64/kernel/entry-common.c:273:13: error: implicit declaration of function 'on_thread_stack'; did you mean 'on_task_stack'? [-Werror=implicit-function-declaration]
     273 |         if (on_thread_stack())
         |             ^~~~~~~~~~~~~~~
         |             on_task_stack
   cc1: some warnings being treated as errors


vim +273 arch/arm64/kernel/entry-common.c

33a3581a76f3a3 Mark Rutland 2021-06-07  267  
064dbfb4169141 Mark Rutland 2021-06-07  268  static void do_interrupt_handler(struct pt_regs *regs,
064dbfb4169141 Mark Rutland 2021-06-07  269  				 void (*handler)(struct pt_regs *))
064dbfb4169141 Mark Rutland 2021-06-07  270  {
26dc129342cfc1 Mark Rutland 2021-10-19  271  	struct pt_regs *old_regs = set_irq_regs(regs);
26dc129342cfc1 Mark Rutland 2021-10-19  272  
064dbfb4169141 Mark Rutland 2021-06-07 @273  	if (on_thread_stack())
064dbfb4169141 Mark Rutland 2021-06-07  274  		call_on_irq_stack(regs, handler);
064dbfb4169141 Mark Rutland 2021-06-07  275  	else
064dbfb4169141 Mark Rutland 2021-06-07  276  		handler(regs);
26dc129342cfc1 Mark Rutland 2021-10-19  277  
26dc129342cfc1 Mark Rutland 2021-10-19  278  	set_irq_regs(old_regs);
064dbfb4169141 Mark Rutland 2021-06-07  279  }
064dbfb4169141 Mark Rutland 2021-06-07  280  

:::::: The code at line 273 was first introduced by commit
:::::: 064dbfb4169141943ec7d9dbfd02974dd008f2ce arm64: entry: convert IRQ+FIQ handlers to C

:::::: TO: Mark Rutland <mark.rutland@arm.com>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
