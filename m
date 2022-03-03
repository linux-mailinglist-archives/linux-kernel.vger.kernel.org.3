Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB454CB7FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiCCHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiCCHig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:38:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9E519C0D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646293070; x=1677829070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HB61yXkPmQdTxTSlKFa6NqPmKexZP9FNPIVruIA5WtM=;
  b=gDIGPqla8ub5ACIun6qNW/eEvhmS+OgOYX8CZszRs5M/kHIpCdECdPFN
   LoZ3At4aGeVY1l/LPgEqaZomfOAsw4LpEpNPU/f/W4NJYaHlh1XliRerQ
   kyKqD8rje6PZYAnUw74CgUGw8hl5K5qz9gkELMS1wpLcnN4urhqtv2lJ2
   sxIqOiu0cOaDuuwpApAGD1IElKCA6Br/12hwkXkC8HZswwoIKC70RHRdS
   UJ+QZVbmWnF3iTtU9i/GrIv1bI+RAWPiQMOC1iP5Tv3vuyFC8riTztHWu
   2ovmS0OUbMzNrwfBicmXsc6Cc0gmMfXcLYTAIC0VrL0VAqav6UsAG9HVS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="237112728"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="237112728"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 23:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="493842235"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Mar 2022 23:37:47 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPg1z-0000H4-6Z; Thu, 03 Mar 2022 07:37:47 +0000
Date:   Thu, 3 Mar 2022 15:37:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lauri Kasanen <cand@gmx.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/n64/init.c:57:38: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202203031518.8QJvTAkB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5859a2b1991101d6b978f3feb5325dad39421f29
commit: baec970aa5ba11099ad7a91773350c91fb2113f0 mips: Add N64 machine type
date:   1 year, 1 month ago
config: mips-randconfig-s032-20220303 (https://download.01.org/0day-ci/archive/20220303/202203031518.8QJvTAkB-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=baec970aa5ba11099ad7a91773350c91fb2113f0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout baec970aa5ba11099ad7a91773350c91fb2113f0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/n64/

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
>> arch/mips/n64/init.c:57:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/n64/init.c:57:38: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/n64/init.c:57:38: sparse:     got unsigned int [usertype] *

vim +57 arch/mips/n64/init.c

    54	
    55	static void __init n64rdp_write_reg(const u8 reg, const u32 value)
    56	{
  > 57		__raw_writel(value, REG_BASE + reg);
    58	}
    59	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
