Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E974FAB37
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiDJAoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiDJAok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:44:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD4B7F2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649551349; x=1681087349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0WJIf8XPFuyqhdKsqgs377YTUwVfq7NscT15tIFF8hQ=;
  b=TNrcqvbw2LSGsO3PLMnlzpg51WBqI6DndwdKybKOvw0MoSWRwzmpmxRi
   3nQfl3ZctbU/A5iJkzfFl72OgtQV6OB/Ic6lWoM0jEpTtK65vwJb5xi4c
   fpLlVMyIB0Aa6wEYNi/2PTj1pgxZy5qkuC9dyYYIwy+++gDgpiFWMx1wt
   YH/LZaAmMb1floY1V9L8pIFrKmIYgijME+tqejysCDlAdrWQbDCYKpGwG
   8haOEmsFiPd4NEMhwHJ+KlF/DNGHj46NdvtQ8vkSn2UaAhUEdw4XaYC2H
   2aqFzzzWRO8gfNqjwi5CPe6p20K4yopoyilkKiq+ncdoVM9wloX1lX5rS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="242515506"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="242515506"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 17:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="852775704"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2022 17:42:27 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndLes-0000WV-Rg;
        Sun, 10 Apr 2022 00:42:26 +0000
Date:   Sun, 10 Apr 2022 08:41:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Scull <ascull@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: arch/arm64/kvm/hyp/vhe/switch.c:217:17: warning: no previous
 prototype for 'hyp_panic'
Message-ID: <202204100857.FCfpGSu4-lkp@intel.com>
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

Hi Andrew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e1f700ebd6bea293abe3c7e2807b252018efde01
commit: f79e616f27ab6cd74deb0995a8eead3d1c9d65af KVM: arm64: Use BUG and BUG_ON in nVHE hyp
date:   1 year ago
config: arm64-randconfig-r002-20220410 (https://download.01.org/0day-ci/archive/20220410/202204100857.FCfpGSu4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f79e616f27ab6cd74deb0995a8eead3d1c9d65af
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f79e616f27ab6cd74deb0995a8eead3d1c9d65af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/hyp/vhe/switch.c:217:17: warning: no previous prototype for 'hyp_panic' [-Wmissing-prototypes]
     217 | void __noreturn hyp_panic(void)
         |                 ^~~~~~~~~
   arch/arm64/kvm/hyp/vhe/switch.c:227:17: warning: no previous prototype for 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
     227 | asmlinkage void kvm_unexpected_el2_exception(void)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> arch/arm64/kvm/hyp/nvhe/switch.c:264:17: warning: no previous prototype for 'hyp_panic' [-Wmissing-prototypes]
     264 | void __noreturn hyp_panic(void)
         |                 ^~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:286:17: warning: no previous prototype for 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
     286 | asmlinkage void kvm_unexpected_el2_exception(void)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hyp_panic +217 arch/arm64/kvm/hyp/vhe/switch.c

09cf57eba30424 David Brazdil 2020-06-25  216  
6a0259ed29bba8 Andrew Scull  2020-09-15 @217  void __noreturn hyp_panic(void)
09cf57eba30424 David Brazdil 2020-06-25  218  {
09cf57eba30424 David Brazdil 2020-06-25  219  	u64 spsr = read_sysreg_el2(SYS_SPSR);
09cf57eba30424 David Brazdil 2020-06-25  220  	u64 elr = read_sysreg_el2(SYS_ELR);
96d389ca10110d Rob Herring   2020-10-28  221  	u64 par = read_sysreg_par();
09cf57eba30424 David Brazdil 2020-06-25  222  
6a0259ed29bba8 Andrew Scull  2020-09-15  223  	__hyp_call_panic(spsr, elr, par);
09cf57eba30424 David Brazdil 2020-06-25  224  	unreachable();
09cf57eba30424 David Brazdil 2020-06-25  225  }
e9ee186bb735bf James Morse   2020-08-21  226  

:::::: The code at line 217 was first introduced by commit
:::::: 6a0259ed29bba83653a36fabcdf6b06aecd78596 KVM: arm64: Remove hyp_panic arguments

:::::: TO: Andrew Scull <ascull@google.com>
:::::: CC: Marc Zyngier <maz@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
