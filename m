Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127B45574B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiFWIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiFWIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:00:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A3447389
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655971251; x=1687507251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8UTosm5kmpwnazx0Z7uDYyVGA3n9PMg53aPK1RogWQk=;
  b=kHca/r5kK3vcfZq2pv3k/u0ZGFFICJ59h0AX0SqbSzLU2CVXac6XPlCG
   nCBZ6cum/PLaHVNmhYlUn0LI6PBnvEjU67u4Nj4a0aYaLGU05CEfXK3NN
   eM55upFq+4rEXkzhgsuUEssHa4noPi6fxMwAKbDxLu8D7L7kH8O7uwu+o
   85hI6jIOMzH90iajKQdQkcax1YzYZAGDVeq4qZRf8j/RF6DvV5QFq7wMM
   TBUw2CORqTuwd6TnDn9nrafO2xcosE3nvx99GTwHGqOOeZld6XaDDAlEV
   m+9CsXzBjUUWB+nKW87ZFRq4e6Z5aHzC7qC5DGU4oTOP4KqG8icLKB/D7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263689170"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="263689170"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 01:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="615491255"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jun 2022 01:00:23 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4HlH-0000uo-2J;
        Thu, 23 Jun 2022 08:00:23 +0000
Date:   Thu, 23 Jun 2022 15:59:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 38/49] include/linux/memregion.h:19:6: warning: no
 previous prototype for function 'memregion_free'
Message-ID: <202206231541.NNhh1JGy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
commit: e4b2a6ac46c3288f73b88e0aa69afd2a815930d7 [38/49] cxl/region: Add region creation support
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220623/202206231541.NNhh1JGy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 46be5faaf03466c3751f8a2882bef5a217e15926)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=e4b2a6ac46c3288f73b88e0aa69afd2a815930d7
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout e4b2a6ac46c3288f73b88e0aa69afd2a815930d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/cxl/core/port.c:4:
>> include/linux/memregion.h:19:6: warning: no previous prototype for function 'memregion_free' [-Wmissing-prototypes]
   void memregion_free(int id)
        ^
   include/linux/memregion.h:19:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void memregion_free(int id)
   ^
   static 
   1 warning generated.


vim +/memregion_free +19 include/linux/memregion.h

a6c7f4c6aea5f4 Dan Williams 2019-11-06  10  
33dd70752cd76f Dan Williams 2019-11-06  11  #ifdef CONFIG_MEMREGION
33dd70752cd76f Dan Williams 2019-11-06  12  int memregion_alloc(gfp_t gfp);
33dd70752cd76f Dan Williams 2019-11-06  13  void memregion_free(int id);
33dd70752cd76f Dan Williams 2019-11-06  14  #else
33dd70752cd76f Dan Williams 2019-11-06  15  static inline int memregion_alloc(gfp_t gfp)
33dd70752cd76f Dan Williams 2019-11-06  16  {
33dd70752cd76f Dan Williams 2019-11-06  17  	return -ENOMEM;
33dd70752cd76f Dan Williams 2019-11-06  18  }
33dd70752cd76f Dan Williams 2019-11-06 @19  void memregion_free(int id)

:::::: The code at line 19 was first introduced by commit
:::::: 33dd70752cd76f4d883a165a674f13121a4155ed lib: Uplevel the pmem "region" ida to a global allocator

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
