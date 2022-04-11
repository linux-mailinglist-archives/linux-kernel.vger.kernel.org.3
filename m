Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3D4FC545
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349724AbiDKTtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiDKTtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:49:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC4C329A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649706416; x=1681242416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ir2NIVvvnTNgKnGMmdSyj+0GhpxbCTN2HPFDqTd5SeE=;
  b=P+j/hwhQ+/0hGVT2u9sX6AyvnL1yg1tnDq8kT5WVBgXsmG1lnz3CDlEg
   ucvXdx+QAcss57nMhN4T3X5TIOSdY5W9JzEBmL3BvJz6GbfSOhuQUjsVi
   zMcziI4DuI3bAxxTyerq77s/VRlV43AgfQWK/A7cKgot50wE7gwhw1npi
   ZHB+pYWnixcVhYglGRdQQkesE+eTuAZYrPiHvRsL/eHP4Xi5zv4gvnnoc
   HV0w3hARmqLuIov2kSTZMqFxk3Px1H0UqNvUhaTX5xCaeCrJHanSnt0cm
   uVPIAl2L2bim2inQGV7KhwBJK9+hZRKzldtIFsbaoGbGcKwZdg5st2WWV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261048747"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261048747"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 12:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="611114413"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2022 12:46:42 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndzzl-00027x-BC;
        Mon, 11 Apr 2022 19:46:41 +0000
Date:   Tue, 12 Apr 2022 03:46:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 46/48] include/linux/module.h:131:49: error:
 redefinition of '__inittest'
Message-ID: <202204120330.GKLJmA9r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   c196e3b15cddb539135de6a3c6bcf32b89213b4c
commit: cb7e9edf8651c8c3a50dcba57659fac27bf30e3d [46/48] tty: serial: allow COMPILE_TEST for some drivers
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220412/202204120330.GKLJmA9r-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=cb7e9edf8651c8c3a50dcba57659fac27bf30e3d
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout cb7e9edf8651c8c3a50dcba57659fac27bf30e3d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/platform_device.h:13,
                    from drivers/tty/serial/pic32_uart.c:12:
>> include/linux/module.h:131:49: error: redefinition of '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/module.h:112:41: note: in expansion of macro 'module_init'
     112 | #define core_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/tty/serial/pic32_uart.c:782:1: note: in expansion of macro 'core_initcall'
     782 | core_initcall(pic32_late_console_init);
         | ^~~~~~~~~~~~~
   include/linux/module.h:131:49: note: previous definition of '__inittest' with type 'int (*(void))(void)'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/module.h:127:41: note: in expansion of macro 'module_init'
     127 | #define console_initcall(fn)            module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/tty/serial/pic32_uart.c:769:1: note: in expansion of macro 'console_initcall'
     769 | console_initcall(pic32_console_init);
         | ^~~~~~~~~~~~~~~~
>> include/linux/module.h:133:13: error: redefinition of 'init_module'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/module.h:112:41: note: in expansion of macro 'module_init'
     112 | #define core_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/tty/serial/pic32_uart.c:782:1: note: in expansion of macro 'core_initcall'
     782 | core_initcall(pic32_late_console_init);
         | ^~~~~~~~~~~~~
   include/linux/module.h:133:13: note: previous definition of 'init_module' with type 'int(void)'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/module.h:127:41: note: in expansion of macro 'module_init'
     127 | #define console_initcall(fn)            module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/tty/serial/pic32_uart.c:769:1: note: in expansion of macro 'console_initcall'
     769 | console_initcall(pic32_console_init);
         | ^~~~~~~~~~~~~~~~
>> include/linux/module.h:131:49: error: redefinition of '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/module.h:116:41: note: in expansion of macro 'module_init'
     116 | #define arch_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/tty/serial/pic32_uart.c:939:1: note: in expansion of macro 'arch_initcall'
     939 | arch_initcall(pic32_uart_init);
         | ^~~~~~~~~~~~~
   include/linux/module.h:131:49: note: previous definition of '__inittest' with type 'int (*(void))(void)'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/module.h:112:41: note: in expansion of macro 'module_init'
     112 | #define core_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/tty/serial/pic32_uart.c:782:1: note: in expansion of macro 'core_initcall'
     782 | core_initcall(pic32_late_console_init);
         | ^~~~~~~~~~~~~
>> include/linux/module.h:133:13: error: redefinition of 'init_module'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/module.h:116:41: note: in expansion of macro 'module_init'
     116 | #define arch_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/tty/serial/pic32_uart.c:939:1: note: in expansion of macro 'arch_initcall'
     939 | arch_initcall(pic32_uart_init);
         | ^~~~~~~~~~~~~
   include/linux/module.h:133:13: note: previous definition of 'init_module' with type 'int(void)'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/module.h:127:41: note: in expansion of macro 'module_init'
     127 | #define console_initcall(fn)            module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/tty/serial/pic32_uart.c:769:1: note: in expansion of macro 'console_initcall'
     769 | console_initcall(pic32_console_init);
         | ^~~~~~~~~~~~~~~~


vim +/__inittest +131 include/linux/module.h

0fd972a7d91d6e Paul Gortmaker 2015-05-01  128  
0fd972a7d91d6e Paul Gortmaker 2015-05-01  129  /* Each module must use one module_init(). */
0fd972a7d91d6e Paul Gortmaker 2015-05-01  130  #define module_init(initfn)					\
1f318a8bafcfba Arnd Bergmann  2017-02-01 @131  	static inline initcall_t __maybe_unused __inittest(void)		\
0fd972a7d91d6e Paul Gortmaker 2015-05-01  132  	{ return initfn; }					\
cf68fffb66d60d Sami Tolvanen  2021-04-08 @133  	int init_module(void) __copy(initfn)			\
cf68fffb66d60d Sami Tolvanen  2021-04-08  134  		__attribute__((alias(#initfn)));		\
cf68fffb66d60d Sami Tolvanen  2021-04-08  135  	__CFI_ADDRESSABLE(init_module, __initdata);
0fd972a7d91d6e Paul Gortmaker 2015-05-01  136  

:::::: The code at line 131 was first introduced by commit
:::::: 1f318a8bafcfba9f0d623f4870c4e890fd22e659 modules: mark __inittest/__exittest as __maybe_unused

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Jessica Yu <jeyu@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
