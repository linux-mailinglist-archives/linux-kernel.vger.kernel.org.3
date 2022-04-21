Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D7650A2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389475AbiDUOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389503AbiDUOkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:40:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC140A07
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650551854; x=1682087854;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DsPJo/C0ybgqsg0hBbD7oY+lO1N2A92sGm7qEPTNZW0=;
  b=HbQvEX6rkqj5V0R13ps+oXmIBOIy7SYt6kDxue3xJQZjK9bn5K6qCOBN
   FEKJu558rvoh5I4I5n1I+U1XTdKG95zTm/HPLWA/S/uf1znV2hqVpkFZw
   xYeV9qg9L+gYbGCsz8YA+HU61vwDnhymxvStCdjj2xxU9jvwa4E16ntKC
   v6sc90FBSP/IAeCniagjxPNyolMgT3MLqFTxvR1Df25rnECnvtb4HYDC1
   RJmyvPwww1lz1+BXyhzMC4emP9KSGPXwCAoIbWucTXRiyvh+owpBRVmiI
   9iDw9aHlLrmOm+1vMG1gfor7azBBk0hNE6n0c4MItBGV3n698K4MFskOo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246263223"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="246263223"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="593677144"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2022 07:37:20 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhXvs-0008U6-3Q;
        Thu, 21 Apr 2022 14:37:20 +0000
Date:   Thu, 21 Apr 2022 22:37:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/ipv4/arp.c:1412:36: warning: unused variable 'arp_seq_ops'
Message-ID: <202204212201.GQb844HH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yajun,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: e968b1b3e9b86c4751faea019a5d340fee9e9142 arp: Remove #ifdef CONFIG_PROC_FS
date:   5 months ago
config: hexagon-randconfig-r045-20220420 (https://download.01.org/0day-ci/archive/20220421/202204212201.GQb844HH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e968b1b3e9b86c4751faea019a5d340fee9e9142
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e968b1b3e9b86c4751faea019a5d340fee9e9142
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/ipv4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ipv4/arp.c:1412:36: warning: unused variable 'arp_seq_ops' [-Wunused-const-variable]
   static const struct seq_operations arp_seq_ops = {
                                      ^
   1 warning generated.


vim +/arp_seq_ops +1412 net/ipv4/arp.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  1411  
f690808e17925f Stephen Hemminger 2007-03-12 @1412  static const struct seq_operations arp_seq_ops = {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1413  	.start	= arp_seq_start,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1414  	.next	= neigh_seq_next,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1415  	.stop	= neigh_seq_stop,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1416  	.show	= arp_seq_show,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1417  };
^1da177e4c3f41 Linus Torvalds    2005-04-16  1418  

:::::: The code at line 1412 was first introduced by commit
:::::: f690808e17925fc45217eb22e8670902ecee5c1b [NET]: make seq_operations const

:::::: TO: Stephen Hemminger <shemminger@linux-foundation.org>
:::::: CC: David S. Miller <davem@sunset.davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
