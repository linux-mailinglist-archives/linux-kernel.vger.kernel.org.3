Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19484681F7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 03:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384093AbhLDCZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 21:25:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:36201 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1384063AbhLDCZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 21:25:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="297886869"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="297886869"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 18:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="501402023"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Dec 2021 18:22:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtKh2-000IL3-9Q; Sat, 04 Dec 2021 02:22:28 +0000
Date:   Sat, 4 Dec 2021 10:22:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:linkage/alias-rework 2/5] arch/arm/lib/changebit.S:12: Error:
 expected comma after ".L____sym_entry__"
Message-ID: <202112041027.FWIrD9ar-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
head:   237447148f41ca99a7b980037060b7a6f3afe535
commit: dbe2bc2de12ab4111bff3d58a16583777168b4c7 [2/5] linkage: add SYM_FUNC_{LOCAL_,}ALIAS()
config: arm-randconfig-r013-20211203 (https://download.01.org/0day-ci/archive/20211204/202112041027.FWIrD9ar-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=dbe2bc2de12ab4111bff3d58a16583777168b4c7
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark linkage/alias-rework
        git checkout dbe2bc2de12ab4111bff3d58a16583777168b4c7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/lib/changebit.S: Assembler messages:
>> arch/arm/lib/changebit.S:12: Error: expected comma after ".L____sym_entry__"
--
   arch/arm/lib/clearbit.S: Assembler messages:
>> arch/arm/lib/clearbit.S:12: Error: expected comma after ".L____sym_entry__"
--
   arch/arm/lib/setbit.S: Assembler messages:
>> arch/arm/lib/setbit.S:12: Error: expected comma after ".L____sym_entry__"
--
   arch/arm/lib/testchangebit.S: Assembler messages:
>> arch/arm/lib/testchangebit.S:12: Error: expected comma after ".L____sym_entry__"
--
   arch/arm/lib/testclearbit.S: Assembler messages:
>> arch/arm/lib/testclearbit.S:12: Error: expected comma after ".L____sym_entry__"
--
   arch/arm/lib/testsetbit.S: Assembler messages:
>> arch/arm/lib/testsetbit.S:12: Error: expected comma after ".L____sym_entry__"


vim +12 arch/arm/lib/changebit.S

c36ef4b1762302 Will Deacon 2011-11-23 @12  bitop	_change_bit, eor

:::::: The code at line 12 was first introduced by commit
:::::: c36ef4b1762302a493c6cb754073bded084700e2 ARM: 7171/1: unwind: add unwind directives to bitops assembly macros

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
