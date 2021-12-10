Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9446F836
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhLJBGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:06:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:61504 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhLJBGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639098154; x=1670634154;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KJE7IagQRxNc0oIZVnRDcK4EFK/gUFJ+R9PnhENs4kA=;
  b=PLA4N2TvsMIYzi4rnPKXON2c0S0HjZLbZssvrdYY3z/44r53d6yoOFio
   qzqSsJd18x2cLeabBnhmLPeT77MRwiO8lhcSCsMzlZW8qWaCC5pOp5CjW
   aLZdc9pGgLlbMljLk5YMNMNQ8JqesRUZUdCOQclvNcPADW/V+9xiOP7+i
   iPGVYM2HOLjuXvEV7xkpZT84gFdFAuoCwiWUXEX4kwFoarwZfew+BP+C7
   KHm/NAPg9Y2ItjpADAby/7Q9z20yxjSXgnRPn2gKahCEGVm1YSA0N83DI
   nOU4J3tlNoTt4Ne7iv6Vym9XZmbdGa9rn6CMtQNivmirl9zYuY/pcVyOZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301624544"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="301624544"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="601930812"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2021 17:01:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvUIG-0002Zm-43; Fri, 10 Dec 2021 01:01:48 +0000
Date:   Fri, 10 Dec 2021 09:01:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap-new 12/14] ERROR: modpost: "set_cpu_present"
 [drivers/firmware/qcom-scm.ko] undefined!
Message-ID: <202112100847.jmgH4zhW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-new
head:   445f716432d8aa33e726b27c170a4896339c4957
commit: 22372a541637e963e514abf3e69a4193fd4027bd [12/14] present_cpu
config: ia64-randconfig-r013-20211209 (https://download.01.org/0day-ci/archive/20211210/202112100847.jmgH4zhW-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/22372a541637e963e514abf3e69a4193fd4027bd
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-new
        git checkout 22372a541637e963e514abf3e69a4193fd4027bd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "set_cpu_present" [drivers/firmware/qcom-scm.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
