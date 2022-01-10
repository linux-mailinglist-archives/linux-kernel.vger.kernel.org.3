Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659764896B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbiAJKue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:50:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:46750 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233569AbiAJKud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641811833; x=1673347833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ejkBuwR81cytvrRwzRnnXKKiSkZBTi6DsE8lbqvRHd0=;
  b=ApxYPEI+ZgDUX46zsb0yCg1Hf1qDgYv14WYHv0V26rs5lnXylWKIyYSg
   A8awRkTvzD0aq1/FFBlqqxzJx8/k5va4VfvXyNGKt4GjaQE5xoAz46rQ9
   QOMZBwNmUKPjOzFTAHqUokV4uwmIo0DDcMKlmvtCB5M0rOcV4fyJIQDP8
   OhXhG0y4n8LjGn0uWQKUFypMxH2TNM3+gWk0C20/KIN8xG6xEjbhqzwsF
   IshhFFdN1YktOJYO5l/xEOyxf2Lfr4fCKlgmtQDEyp13x/At5RixJkcxb
   5Q/SNxTtNUhN9m7JID0XyFj7APOXz14FQWx0GCslM/0hdXj2c0ADgDnGw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="303941801"
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="303941801"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 02:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="557948010"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2022 02:50:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6sFy-0002uo-Mf; Mon, 10 Jan 2022 10:50:30 +0000
Date:   Mon, 10 Jan 2022 18:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2018/2375] arch/mips/ralink/bootrom.c:34:19:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before
 'bootrom_setup'
Message-ID: <202201101856.jfl5AsHo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   391ce485ced0e47bf8d2ce8bc32bb87887e16656
commit: 8e681df39108b99bab14c70b640024589fa9fa7b [2018/2375] headers/deps: fs: Optimize <linux/seq_file.h> dependencies
config: mips-vocore2_defconfig (https://download.01.org/0day-ci/archive/20220110/202201101856.jfl5AsHo-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=8e681df39108b99bab14c70b640024589fa9fa7b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 8e681df39108b99bab14c70b640024589fa9fa7b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/ralink/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> arch/mips/ralink/bootrom.c:34:19: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'bootrom_setup'
      34 | static int __init bootrom_setup(void)
         |                   ^~~~~~~~~~~~~
>> arch/mips/ralink/bootrom.c:40:1: warning: data definition has no type or storage class
      40 | postcore_initcall(bootrom_setup);
         | ^~~~~~~~~~~~~~~~~
>> arch/mips/ralink/bootrom.c:40:1: error: type defaults to 'int' in declaration of 'postcore_initcall' [-Werror=implicit-int]
>> arch/mips/ralink/bootrom.c:40:1: warning: parameter names (without types) in function declaration
   arch/mips/ralink/bootrom.c:27:37: warning: 'bootrom_file_ops' defined but not used [-Wunused-const-variable=]
      27 | static const struct file_operations bootrom_file_ops = {
         |                                     ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +34 arch/mips/ralink/bootrom.c

7a1a44c909fcb4 John Crispin       2013-05-21  33  
389500696810f5 Christophe JAILLET 2020-05-31 @34  static int __init bootrom_setup(void)
7a1a44c909fcb4 John Crispin       2013-05-21  35  {
4c90de4dd33d90 Greg Kroah-Hartman 2019-01-22  36  	debugfs_create_file("bootrom", 0444, NULL, NULL, &bootrom_file_ops);
7a1a44c909fcb4 John Crispin       2013-05-21  37  	return 0;
7a1a44c909fcb4 John Crispin       2013-05-21  38  }
7a1a44c909fcb4 John Crispin       2013-05-21  39  
7a1a44c909fcb4 John Crispin       2013-05-21 @40  postcore_initcall(bootrom_setup);

:::::: The code at line 34 was first introduced by commit
:::::: 389500696810f5aa8fc1fe6f375b9dabd111e1d6 MIPS: ralink: bootrom: mark a function as __init to save some memory

:::::: TO: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
:::::: CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
