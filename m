Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580A655720D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiFWEp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiFWDcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:32:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719373584F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655955134; x=1687491134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jOkCtpbuEJT/Vuqqr4aviFH679caqLuKCExfcdjRY0g=;
  b=LYQxSjQiWkgu/SsztZXrd0KdrCxZpA6rr+Q7vccMLOLydeGEJrmSri5b
   s768bVXTJ6xNVDdtYT0qzcBtKQXXvxPLl2W3azSILSapNNJpmoZO7YkrU
   MFlrf2b7lqAwJkS0xwLmQPXbEzvk0nQH+/PhUP2YwhtQieHZGPnz159fm
   yOqcC5/crj+jdBQ1l6u7IMLqGzFo1u1lKnNQZVQC7u4Oq3mlID0bl6M3T
   ZIznSrBVKE+qcJyFn1D3Y6DMzDI5cYlnQQML/LRc7Ma2lvTgHffXPIFkt
   SwUTfCjBlnQ+fOAeJDeN7vCJUFrnXOCdOeJU+MMm6Q60evUUzeizQYMca
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="279381152"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="279381152"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 20:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="715667282"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 20:32:12 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4DZj-0000e5-Jg;
        Thu, 23 Jun 2022 03:32:11 +0000
Date:   Thu, 23 Jun 2022 11:31:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [ammarfaizi2-block:powerpc/linux/next-test 1/8]
 arch/powerpc/platforms/powermac/setup.c:324:6: error: no previous prototype
 for function 'note_scsi_host'
Message-ID: <202206231107.7Ic0kET5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block powerpc/linux/next-test
head:   612d6fddf359556217a89c3e42a6c3a6475e2e1d
commit: 113fe88eed53af08800f54a03e463636105831e0 [1/8] powerpc: Don't include asm/setup.h in asm/machdep.h
config: powerpc-g5_defconfig (https://download.01.org/0day-ci/archive/20220623/202206231107.7Ic0kET5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/113fe88eed53af08800f54a03e463636105831e0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block powerpc/linux/next-test
        git checkout 113fe88eed53af08800f54a03e463636105831e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/platforms/powermac/setup.c:324:6: error: no previous prototype for function 'note_scsi_host' [-Werror,-Wmissing-prototypes]
   void note_scsi_host(struct device_node *node, void *host)
        ^
   arch/powerpc/platforms/powermac/setup.c:324:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void note_scsi_host(struct device_node *node, void *host)
   ^
   static 
   1 error generated.


vim +/note_scsi_host +324 arch/powerpc/platforms/powermac/setup.c

14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  322  
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  323  #ifdef CONFIG_SCSI
405861a0429113 arch/powerpc/platforms/powermac/setup.c      Li Yang        2007-05-23 @324  void note_scsi_host(struct device_node *node, void *host)
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  325  {
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  326  }
9b6b563c0d2d25 arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-10-06  327  EXPORT_SYMBOL(note_scsi_host);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  328  #endif
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras 2005-09-26  329  

:::::: The code at line 324 was first introduced by commit
:::::: 405861a0429113f8e426092af09dd05ec6209410 [POWERPC] Fix Section mismatch warnings

:::::: TO: Li Yang <leoli@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
