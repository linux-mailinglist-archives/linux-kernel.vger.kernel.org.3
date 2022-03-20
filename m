Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76944E199E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 05:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiCTEYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 00:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiCTEYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 00:24:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77692DE6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 21:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647750177; x=1679286177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WTLFWEqeosb8lH+Hi260hgFz7tFyOK6/NMh25T9kJus=;
  b=hNIXX/ffGUw2lL5W6rNU+vfaeDBhJJrs3Dvv1jvo3v3kIXcF6m4b3jpX
   jIqGCso8vCe/C2Yhi7E8bAY+d0qmfl+G85Rza69AsrA96Xomg73LmBv+m
   LHDqCM6Pj1A2n2MELNLHT/TaFUUsSCKoTqac1yjAZCwUr0sASve7yNhqb
   E1c7g+Xrs7fxVms8/+ohKwUNEqYyMSHmCArDB6vm5l5WgN79USkVChdMD
   dbjgtYZjhGV0fPPglnTEJmQX217znHJxVLa3dps/SPO6LgZ4RuR9AIcuB
   FDPGB/i5kMm2z/0XQccqT2RhGHtKvIKrHZyCi0l/2kYoyl7pD5KEnKxvk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="257295345"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="257295345"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 21:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="600115199"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 19 Mar 2022 21:22:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVn5j-000GZD-2u; Sun, 20 Mar 2022 04:22:55 +0000
Date:   Sun, 20 Mar 2022 12:21:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: drivers/watchdog/rc32434_wdt.c:176:37: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202203201245.WYJq6i13-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34e047aa16c0123bbae8e2f6df33e5ecc1f56601
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   11 months ago
config: mips-randconfig-s032-20220319 (https://download.01.org/0day-ci/archive/20220320/202203201245.WYJq6i13-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/watchdog/rc32434_wdt.c:176:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__p @@     got char const * @@
   drivers/watchdog/rc32434_wdt.c:176:37: sparse:     expected char const [noderef] __user *__p
   drivers/watchdog/rc32434_wdt.c:176:37: sparse:     got char const *
   drivers/watchdog/rc32434_wdt.c:246:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/rc32434_wdt.c:246:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/rc32434_wdt.c:246:27: sparse:     got int ( * )( ... )

vim +176 drivers/watchdog/rc32434_wdt.c

03ec58568a3c66 Florian Fainelli 2008-02-25  163  
03ec58568a3c66 Florian Fainelli 2008-02-25  164  static ssize_t rc32434_wdt_write(struct file *file, const char *data,
03ec58568a3c66 Florian Fainelli 2008-02-25  165  				size_t len, loff_t *ppos)
03ec58568a3c66 Florian Fainelli 2008-02-25  166  {
03ec58568a3c66 Florian Fainelli 2008-02-25  167  	if (len) {
03ec58568a3c66 Florian Fainelli 2008-02-25  168  		if (!nowayout) {
03ec58568a3c66 Florian Fainelli 2008-02-25  169  			size_t i;
03ec58568a3c66 Florian Fainelli 2008-02-25  170  
03ec58568a3c66 Florian Fainelli 2008-02-25  171  			/* In case it was set long ago */
03ec58568a3c66 Florian Fainelli 2008-02-25  172  			expect_close = 0;
03ec58568a3c66 Florian Fainelli 2008-02-25  173  
03ec58568a3c66 Florian Fainelli 2008-02-25  174  			for (i = 0; i != len; i++) {
03ec58568a3c66 Florian Fainelli 2008-02-25  175  				char c;
03ec58568a3c66 Florian Fainelli 2008-02-25 @176  				if (get_user(c, data + i))
03ec58568a3c66 Florian Fainelli 2008-02-25  177  					return -EFAULT;
03ec58568a3c66 Florian Fainelli 2008-02-25  178  				if (c == 'V')
0af98d37e85e69 Phil Sutter      2009-02-08  179  					expect_close = 42;
03ec58568a3c66 Florian Fainelli 2008-02-25  180  			}
03ec58568a3c66 Florian Fainelli 2008-02-25  181  		}
0af98d37e85e69 Phil Sutter      2009-02-08  182  		rc32434_wdt_ping();
03ec58568a3c66 Florian Fainelli 2008-02-25  183  		return len;
03ec58568a3c66 Florian Fainelli 2008-02-25  184  	}
03ec58568a3c66 Florian Fainelli 2008-02-25  185  	return 0;
03ec58568a3c66 Florian Fainelli 2008-02-25  186  }
03ec58568a3c66 Florian Fainelli 2008-02-25  187  

:::::: The code at line 176 was first introduced by commit
:::::: 03ec58568a3c66cac4b23ff74db95c966a1521de [WATCHDOG] Add support for the IDT RC32434 watchdog

:::::: TO: Florian Fainelli <florian.fainelli@telecomint.eu>
:::::: CC: Wim Van Sebroeck <wim@iguana.be>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
