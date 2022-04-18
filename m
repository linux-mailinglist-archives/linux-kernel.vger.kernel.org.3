Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6F505BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbiDRPtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345653AbiDRPtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:49:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A632062
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650295235; x=1681831235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2l5Hs/av5CYW+PzqQ6g7t7SAbqQBkxBQtdtVt1h1x+w=;
  b=a1eaRnyvPA+3vkNbpWTwBQknQNn+pQ2k1vOu2pA+g7R9cQOcoKcu+73n
   7TksafEFNW68NI/p/kgvDDVhs0P7XmH+eIXouKLRcjRzwb1NAcVbiKwAx
   xIgQ4wuu+Ccxy8Xl3Y86wonRQe2s2KDPQBaEFJAAMvoJH1RWRJKqsHO6D
   0sCAs3BzaUY8RWMZOsz5p1dIi9m49S+1PBXWnhSH9TCyOrYtJRn5c7ePQ
   tjFEW/pNgK5lA9KXU+CPQ6tXd5CjX+Edy+iubOBhm/InqMb3YFGv8r3JG
   jJi0igGu0IXI1ctFDKp1cZc6i7NEM3C3wIpMG/im7VlDoyhFPo+OhkFOm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250843706"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="250843706"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 08:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="529600585"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2022 08:20:32 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngTB1-0004ji-L0;
        Mon, 18 Apr 2022 15:20:31 +0000
Date:   Mon, 18 Apr 2022 23:20:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: WARNING: modpost: vmlinux.o(.text+0xa47e1): Section mismatch in
 reference from the function __next_node() to the variable
 .init.data:numa_nodes_parsed
Message-ID: <202204182350.tOU3dyLx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: 277a20a498d30753f5d8a607dbf967bc163552c1 lib: add fast path for find_next_*_bit()
date:   12 months ago
config: x86_64-randconfig-a016-20220418 (https://download.01.org/0day-ci/archive/20220418/202204182350.tOU3dyLx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b27430f9f46b88bcd54d992debc8d72e131e1bd0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=277a20a498d30753f5d8a607dbf967bc163552c1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 277a20a498d30753f5d8a607dbf967bc163552c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xa47e1): Section mismatch in reference from the function __next_node() to the variable .init.data:numa_nodes_parsed
The function __next_node() references
the variable __initdata numa_nodes_parsed.
This is often because __next_node lacks a __initdata
annotation or the annotation of numa_nodes_parsed is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
