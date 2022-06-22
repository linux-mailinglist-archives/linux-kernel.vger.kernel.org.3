Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71ED55530F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377483AbiFVSOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359064AbiFVSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:14:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95263C709
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655921646; x=1687457646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kWllMF9oZEgWO456YfAB4Nn12pwMbxEk0EnZ7zp587k=;
  b=M5xsPx3qK7ovH7whY+vpYmplypSuyKNgkkWwrYGBsSfIpw9C2C7fFNpR
   DRy7J4dhBcopc/A5HGU6FDV08iF0Y6k5drFHujKREPpQkxWYyGZrJId4i
   S7JblaJWCgbIVR5zNCEN976oOT/aNRBqvqbm6k+F1y0QAKaESQ4YvbZEE
   2C02SoZsR0zH+fq6qc6ROX1QhiRb2jaAfGcUJQRnFn0cSFedNgsoaorSc
   oN8cv6N7A/YDqONj7j0XpCKAvIFE7zOvHesYDEfVmbDVIjmtPuLL+xMdj
   /yKZFSe4LboXuA80VY9ht2gxyjlOlZABzWHYrMHJeMoaeAwxXfhntYowk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280543615"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="280543615"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="588286532"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2022 10:47:56 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o44SJ-0001XX-DB;
        Wed, 22 Jun 2022 17:47:55 +0000
Date:   Thu, 23 Jun 2022 01:46:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: [jirislaby:lto 32/45] arch/x86/kernel/paravirt.c:123:15: warning: no
 previous prototype for function 'native_steal_clock'
Message-ID: <202206230120.YLCB69tS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git lto
head:   8047611082d70c5263114fabce8c80a4c3d251fa
commit: b2efc66d269d1bb2b1b2a8aac7e873ed266678ba [32/45] x86/paravirt/lto: Export native_steal_clock
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220623/202206230120.YLCB69tS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=b2efc66d269d1bb2b1b2a8aac7e873ed266678ba
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby lto
        git checkout b2efc66d269d1bb2b1b2a8aac7e873ed266678ba
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/paravirt.c:123:15: warning: no previous prototype for function 'native_steal_clock' [-Wmissing-prototypes]
   __visible u64 native_steal_clock(int cpu)
                 ^
   arch/x86/kernel/paravirt.c:123:11: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible u64 native_steal_clock(int cpu)
             ^
             static 
   1 warning generated.


vim +/native_steal_clock +123 arch/x86/kernel/paravirt.c

   122	
 > 123	__visible u64 native_steal_clock(int cpu)
   124	{
   125		return 0;
   126	}
   127	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
