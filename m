Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8A64796EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhLQWPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:15:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:27467 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhLQWPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639779320; x=1671315320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X8eShf1Wur1dpMvrqV7WfMjesp5eh5jJBzscUU0uP9c=;
  b=ZPkmc1+y4rmnsXJxP9ZB5RHWyq+y/DPubLENaZUChXGuxxmZ94SbzmfR
   UGNXsrp51NjzQN0qtWn4Iw2bYhPfLLfCRLHKuGxL0qx8w3hONSNzQtLCm
   UPea0lBx/CGGK1zJ9V//jb2PCZR2lroJI3+vlcde+jOAt6UBlP8PoTPEG
   RwuoiRH1XmEXGaOuYMGo9ym5yWTvsL4/JBCMz4QFXaHSfvkqwcWE0wy66
   B7XxJy4nk/xB4hbtMgncsJnH7XbHeiexP1qqIPfalqsfM0Qwy2NZlcbX9
   85Uyk1qQBusUs8jqzq3cfPKXwxbD1bZeJP2v5Bwu2yn+qGJew6afYsLYf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237383472"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237383472"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:15:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="615710871"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2021 14:15:18 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myLVV-0005G0-NV; Fri, 17 Dec 2021 22:15:17 +0000
Date:   Sat, 18 Dec 2021 06:14:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 73/152] arch/x86/kvm/vmx/main.c:25:14:
 error: expression is not assignable
Message-ID: <202112180628.1QbsHNOz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 3545bcde2d72e4b5b5f16571788aac0ddb5f49a5 [73/152] KVM: TDX: Add KVM TDX system-wide initialization and teardown
config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211218/202112180628.1QbsHNOz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/3545bcde2d72e4b5b5f16571788aac0ddb5f49a5
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 3545bcde2d72e4b5b5f16571788aac0ddb5f49a5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kvm/vmx/main.c:25:14: error: expression is not assignable
                   enable_tdx = false;
                   ~~~~~~~~~~ ^
   1 error generated.


vim +25 arch/x86/kvm/vmx/main.c

    15	
    16	static __init int vt_hardware_setup(void)
    17	{
    18		int ret;
    19	
    20		ret = vmx_hardware_setup();
    21		if (ret)
    22			return ret;
    23	
    24		if (enable_tdx && tdx_hardware_setup(&vt_x86_ops))
  > 25			enable_tdx = false;
    26		return 0;
    27	}
    28	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
