Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354404A9277
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356708AbiBDCww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:52:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:9693 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345674AbiBDCwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643943171; x=1675479171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZKwTxoNn2ACVfVR4zMieX6gLP1h91YrIo9hiHwaUoNQ=;
  b=E7DqVT1BgutdQIb5ujHZ8892rxqGkm2wZYQNR05ELJhWOwfTmhjGb6oY
   TvI7kYW0ajJ9QuDWsOwXhml4lzTzWsDRChzbys61IJWFCcNKqKb8vUzei
   6jYJnZmesoE3TioeF/DKuwsmcglPJZtQjY1/juLMi/74taCwwwkyRcGkZ
   snEcO1g+PTFXbMYnY/anrnVLCkvbW2e/OqwwCqoy6tedI7sQH+Q8rQm4W
   HdINUbtzAnPKOWQZY3q0GPvZ9n6rINiILHA6cNvRBSSli9G220ZI33EGc
   cgRcBAtVxOCKHGTlVk3ScQq0n5rsQ7DJokQNUD5R3NXOiGxrn25olC2Js
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228272453"
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="228272453"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 18:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="631570011"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Feb 2022 18:52:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFoiO-000X2a-Vu; Fri, 04 Feb 2022 02:52:48 +0000
Date:   Fri, 4 Feb 2022 10:52:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     YunQiang Su <yunqiang.su@cipunited.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/../../../../lib/ashldi3.c:9:19: warning:
 no previous prototype for '__ashldi3'
Message-ID: <202202041004.sFUBmVAX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1f2cfdd349b7647f438c1e552dc1b983da86d830
commit: 31b2f3dc851c65fee288612432c4fc956f1a264e MIPS: enable both vmlinux.gz.itb and vmlinuz for generic
date:   5 weeks ago
config: mips-ci20_defconfig (https://download.01.org/0day-ci/archive/20220204/202202041004.sFUBmVAX-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31b2f3dc851c65fee288612432c4fc956f1a264e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 31b2f3dc851c65fee288612432c4fc956f1a264e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/mips/boot/compressed/ashldi3.c:2:
>> arch/mips/boot/compressed/../../../../lib/ashldi3.c:9:19: warning: no previous prototype for '__ashldi3' [-Wmissing-prototypes]
       9 | long long notrace __ashldi3(long long u, word_type b)
         |                   ^~~~~~~~~


vim +/__ashldi3 +9 arch/mips/boot/compressed/../../../../lib/ashldi3.c

b35cd9884fa5d8 Palmer Dabbelt 2017-05-23  8  
b35cd9884fa5d8 Palmer Dabbelt 2017-05-23 @9  long long notrace __ashldi3(long long u, word_type b)

:::::: The code at line 9 was first introduced by commit
:::::: b35cd9884fa5d81c9d5e7f57c9d03264ae2bd835 lib: Add shared copies of some GCC library routines

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
