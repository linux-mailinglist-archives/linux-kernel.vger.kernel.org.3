Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783234D74EC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 12:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiCMLLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiCMLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 07:11:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4970F21E19
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647169798; x=1678705798;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aguLsOnyq0yLgPc+X0LVWMnYNOAs6i0m0YbcdLSg49w=;
  b=R7ePGPUU+FcjHTUMGftgu5r0SIM1TNasOB38vHtV0UQ6B8efPLb7+TOn
   dzjfKg9QUHkV4CevIZ9Yf75CSHG3oDERYYp28pt/jUre5UILYsZZLBTLF
   MZuVFDw8608OXTCe3ZKon5q3wiW2fvWxce72OwaE9ZScQC1j9NhtJtOiM
   87s/3TkZ+a+7PI6xCKIJJ3NHB9P8bumooVZOSrsKfoQzbeT0CMhZMiXUP
   2rAQJ9Qd5rfeTMHvd1Fyjz0AV6SP3/RtlI7gRhtgzLxoXYGn/05o7KTs5
   LPkCQfHiYdqJVu0c9AHxS6lmyrJRJ+ZWcoE4bQrcqiAuBi6CxMXziIGGV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="319087354"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="319087354"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 04:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="515078359"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2022 04:09:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTM6l-0008tU-Nd; Sun, 13 Mar 2022 11:09:55 +0000
Date:   Sun, 13 Mar 2022 19:09:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mhiramat:bootconfig/core 1/3] init/main.c:471:36: error: too many
 arguments to function call, expected single argument '_size', have 2
 arguments
Message-ID: <202203131946.cvmwTGeZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git bootconfig/core
head:   851eb04a13868ed61bd973f38e4fa9d741eef92e
commit: 5698b97b8004472839e402af5b4abbbf73755772 [1/3] bootconfig: Check the checksum before removing the bootconfig from initrd
config: hexagon-randconfig-r041-20220313 (https://download.01.org/0day-ci/archive/20220313/202203131946.cvmwTGeZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0467eb2cb7654c15ae366967ef35093c5724c416)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/commit/?id=5698b97b8004472839e402af5b4abbbf73755772
        git remote add mhiramat https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
        git fetch --no-tags mhiramat bootconfig/core
        git checkout 5698b97b8004472839e402af5b4abbbf73755772
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> init/main.c:471:36: error: too many arguments to function call, expected single argument '_size', have 2 arguments
           get_boot_config_from_initrd(NULL, NULL);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~       ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   init/main.c:315:22: note: 'get_boot_config_from_initrd' declared here
   static void * __init get_boot_config_from_initrd(u32 *_size)
                        ^
   init/main.c:766:20: warning: no previous prototype for function 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
   void __init __weak arch_post_acpi_subsys_init(void) { }
                      ^
   init/main.c:766:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_post_acpi_subsys_init(void) { }
   ^
   static 
   init/main.c:778:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:778:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
   init/main.c:780:20: warning: no previous prototype for function 'poking_init' [-Wmissing-prototypes]
   void __init __weak poking_init(void) { }
                      ^
   init/main.c:780:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak poking_init(void) { }
   ^
   static 
   3 warnings and 1 error generated.


vim +/_size +471 init/main.c

de462e5f107185 Masami Hiramatsu 2020-04-26  467  
2b7d2fe76f9c84 Cao jin          2021-03-11  468  static void __init setup_boot_config(void)
de462e5f107185 Masami Hiramatsu 2020-04-26  469  {
de462e5f107185 Masami Hiramatsu 2020-04-26  470  	/* Remove bootconfig data from initrd */
de462e5f107185 Masami Hiramatsu 2020-04-26 @471  	get_boot_config_from_initrd(NULL, NULL);
de462e5f107185 Masami Hiramatsu 2020-04-26  472  }
d8a953ddde5ec3 Masami Hiramatsu 2020-02-20  473  

:::::: The code at line 471 was first introduced by commit
:::::: de462e5f10718517bacf2f84c8aa2804567ef7df bootconfig: Fix to remove bootconfig data from initrd while boot

:::::: TO: Masami Hiramatsu <mhiramat@kernel.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
