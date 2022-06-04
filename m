Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8096553D68F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiFDLbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 07:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiFDLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 07:31:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E8131DFC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654342294; x=1685878294;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e58AskxeH6n+D+Qb+ATLfjf27/n+6wms9cJMfi3VBrU=;
  b=E7//nWWKmBYKCYyXkVFkarAOqvMvfPxHVb8vcWb8MQjy5ASIJT60xoS/
   +aP/1FOo17MMbGhjrYNDqYtBT5eNePzi8LJ3NVcx+jrsxFa5BeCaeKRkB
   Du/dv7G5okoqZqmfuwGG9rFRXL4M2xTt861t1L5pzZy8VXNZ8OuBlZBHZ
   ORrz+qFVCSVaN2QgmD9eSyJnGlBObWne7hhrL3H84bNDAJxyIKQfFr7+M
   N9oy49C0IY+8a+7aTr8BAVFGMTu1u41ALCeKcchPgWjqoKray4ZdVh52o
   IVASjuZo3ZLBizk3yt8+dtpJJCnGGL3N52hVhaWReco5taFEzwOa+H6rb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="275224728"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="275224728"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 04:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="607842891"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Jun 2022 04:31:33 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxS0C-000Akb-IM;
        Sat, 04 Jun 2022 11:31:32 +0000
Date:   Sat, 4 Jun 2022 19:30:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.18-esp32 39/45]
 include/linux/mtd/xip.h:68:2: warning: #warning "missing IRQ and timer
 primitives for XIP MTD support"
Message-ID: <202206041901.y4FClYBn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.18-esp32
head:   137adeae90088411fe27a1be624afd8336542302
commit: 91e595b15206abdfdc74585230f5c11ff7e1c3ab [39/45] WIP: xtensa: add XIP-aware MTD support
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220604/202206041901.y4FClYBn-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/91e595b15206abdfdc74585230f5c11ff7e1c3ab
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.18-esp32
        git checkout 91e595b15206abdfdc74585230f5c11ff7e1c3ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/mtd/chips/ fs/ kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/mtd/chips/cfi_probe.c:16:
>> include/linux/mtd/xip.h:68:2: warning: #warning "missing IRQ and timer primitives for XIP MTD support" [-Wcpp]
      68 | #warning "missing IRQ and timer primitives for XIP MTD support"
         |  ^~~~~~~
>> include/linux/mtd/xip.h:69:2: warning: #warning "some of the XIP MTD support code will be disabled" [-Wcpp]
      69 | #warning "some of the XIP MTD support code will be disabled"
         |  ^~~~~~~
>> include/linux/mtd/xip.h:70:2: warning: #warning "your system will therefore be unresponsive when writing or erasing flash" [-Wcpp]
      70 | #warning "your system will therefore be unresponsive when writing or erasing flash"
         |  ^~~~~~~
--
   In file included from include/linux/mtd/cfi.h:16,
                    from drivers/mtd/chips/cfi_cmdset_0002.c:39:
>> include/linux/mtd/xip.h:68:2: warning: #warning "missing IRQ and timer primitives for XIP MTD support" [-Wcpp]
      68 | #warning "missing IRQ and timer primitives for XIP MTD support"
         |  ^~~~~~~
>> include/linux/mtd/xip.h:69:2: warning: #warning "some of the XIP MTD support code will be disabled" [-Wcpp]
      69 | #warning "some of the XIP MTD support code will be disabled"
         |  ^~~~~~~
>> include/linux/mtd/xip.h:70:2: warning: #warning "your system will therefore be unresponsive when writing or erasing flash" [-Wcpp]
      70 | #warning "your system will therefore be unresponsive when writing or erasing flash"
         |  ^~~~~~~
   drivers/mtd/chips/cfi_cmdset_0002.c: In function 'xip_udelay':
>> drivers/mtd/chips/cfi_cmdset_0002.c:1070:34: warning: variable 'start' set but not used [-Wunused-but-set-variable]
    1070 |         unsigned long suspended, start = xip_currtime();
         |                                  ^~~~~
>> drivers/mtd/chips/cfi_cmdset_0002.c:1070:23: warning: variable 'suspended' set but not used [-Wunused-but-set-variable]
    1070 |         unsigned long suspended, start = xip_currtime();
         |                       ^~~~~~~~~
--
   In file included from drivers/mtd/chips/cfi_cmdset_0001.c:33:
>> include/linux/mtd/xip.h:68:2: warning: #warning "missing IRQ and timer primitives for XIP MTD support" [-Wcpp]
      68 | #warning "missing IRQ and timer primitives for XIP MTD support"
         |  ^~~~~~~
>> include/linux/mtd/xip.h:69:2: warning: #warning "some of the XIP MTD support code will be disabled" [-Wcpp]
      69 | #warning "some of the XIP MTD support code will be disabled"
         |  ^~~~~~~
>> include/linux/mtd/xip.h:70:2: warning: #warning "your system will therefore be unresponsive when writing or erasing flash" [-Wcpp]
      70 | #warning "your system will therefore be unresponsive when writing or erasing flash"
         |  ^~~~~~~
   drivers/mtd/chips/cfi_cmdset_0001.c: In function 'xip_wait_for_operation':
>> drivers/mtd/chips/cfi_cmdset_0001.c:1148:40: warning: variable 'start' set but not used [-Wunused-but-set-variable]
    1148 |         unsigned long usec, suspended, start, done;
         |                                        ^~~~~
>> drivers/mtd/chips/cfi_cmdset_0001.c:1148:29: warning: variable 'suspended' set but not used [-Wunused-but-set-variable]
    1148 |         unsigned long usec, suspended, start, done;
         |                             ^~~~~~~~~


vim +68 include/linux/mtd/xip.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  67  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @68  #warning "missing IRQ and timer primitives for XIP MTD support"
^1da177e4c3f41 Linus Torvalds 2005-04-16 @69  #warning "some of the XIP MTD support code will be disabled"
^1da177e4c3f41 Linus Torvalds 2005-04-16 @70  #warning "your system will therefore be unresponsive when writing or erasing flash"
^1da177e4c3f41 Linus Torvalds 2005-04-16  71  

:::::: The code at line 68 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
