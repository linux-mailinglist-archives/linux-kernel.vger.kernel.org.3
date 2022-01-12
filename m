Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7CB48C716
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354599AbiALPUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:20:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:32301 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354581AbiALPUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642000817; x=1673536817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h8ls+oVuaFbFTtUpRnfkoRc16g9QZfj/QoL+F0BHQ/Q=;
  b=gIYzdRXftac/nT0kIxy1HeflFRV5swZ4etPn5GhMd0SXZ/vv8daoNPk0
   2B/6YsN5Mevsj3Zw47wKtbLycywnc3QOm3hMqKvcCaWtV475fD6A7f0mO
   hFQh772wSqmlsApWY9X0Csx2wqzd4r/qOVsVFhYnibzOgBV1pMGTJvdMk
   HlmcvgdcuXeCGgLkVheSv+MJH15lM7F72WRUnkHlPg4Wl5L1KVxMn80um
   szkNlJ5gWuv6xYw3Aezcwgygk8Z/2V1JZlVkfQTJ7xbKCPoaNfDqnbOmy
   J1JJNkMIV5cadYS99xcI5zA8+xUyBSeT6B3ym2vwykDlb6rSouy3M716r
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="242573323"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="242573323"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 07:19:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="576575950"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jan 2022 07:19:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7fPm-00060T-TQ; Wed, 12 Jan 2022 15:19:54 +0000
Date:   Wed, 12 Jan 2022 23:19:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [dlemoal-libata:for-next 85/106] drivers/ata/ahci_st.c:233:34:
 warning: unused variable 'st_ahci_match'
Message-ID: <202201122335.B7ADTynl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

First bad commit (maybe != root cause):

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git for-next
head:   7914e9624dd7ce17d3d3b1dcd6c3fe5d366b228c
commit: 3e7a673b5674512efdcd9ec5ff154ee697c3f7ef [85/106] ata: ahci_st: add compile test support
config: hexagon-buildonly-randconfig-r005-20220112 (https://download.01.org/0day-ci/archive/20220112/202201122335.B7ADTynl-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?id=3e7a673b5674512efdcd9ec5ff154ee697c3f7ef
        git remote add dlemoal-libata git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
        git fetch --no-tags dlemoal-libata for-next
        git checkout 3e7a673b5674512efdcd9ec5ff154ee697c3f7ef
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/ata/ahci_st.c:233:34: warning: unused variable 'st_ahci_match' [-Wunused-const-variable]
   static const struct of_device_id st_ahci_match[] = {
                                    ^
   1 warning generated.


vim +/st_ahci_match +233 drivers/ata/ahci_st.c

76884cb2f7da52 Lee Jones    2014-02-26  232  
09de99db23df55 Kiran Padwal 2014-07-22 @233  static const struct of_device_id st_ahci_match[] = {
76884cb2f7da52 Lee Jones    2014-02-26  234  	{ .compatible = "st,ahci", },
76884cb2f7da52 Lee Jones    2014-02-26  235  	{},
76884cb2f7da52 Lee Jones    2014-02-26  236  };
76884cb2f7da52 Lee Jones    2014-02-26  237  MODULE_DEVICE_TABLE(of, st_ahci_match);
76884cb2f7da52 Lee Jones    2014-02-26  238  

:::::: The code at line 233 was first introduced by commit
:::::: 09de99db23df55c7415d110f6c62281dedd77384 ahci: st: Make of_device_id array const

:::::: TO: Kiran Padwal <kiran.padwal21@gmail.com>
:::::: CC: Tejun Heo <tj@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
