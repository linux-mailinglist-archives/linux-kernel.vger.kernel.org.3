Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9594822FF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 10:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhLaJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 04:23:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:12597 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhLaJXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 04:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640942631; x=1672478631;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m/ZWwdpwFSD3RXBuK5m304XzMdG44W7CK1OgKD20WBI=;
  b=HLk+S36TvBSNsiBwW9P55ju/MpkPpmqtYJqO8eON+tnZjvuhrLsme0PS
   haMlNV74iYVkKYEJ7GvaK0xNuwiq5/3R+oFWoyUDxHdji0Kcc254ppnDz
   2fugr2szLYkGiciTMuvKdgaDjrCKBT92tlYRRdiJEvMr0X5bRXNL5vANF
   9ThZpyXxu1RlepbUQ5vJJ3axpM9YdxpNCH+8UCpzld2Q25oIUnEvGi8DJ
   vXl3BSREW4eJs6eVIFx1nqa/yl5eC9F5t16Q4z7muwd5NBkg+CdGxCY53
   wREFbxxDa32fY2MnyRXWogqW/s53O0lIWFzJ46aOB0tmBpLJdSIYsnkMT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="328126427"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="328126427"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 01:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="470906358"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2021 01:23:50 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3E8b-000B8K-Dh; Fri, 31 Dec 2021 09:23:49 +0000
Date:   Fri, 31 Dec 2021 17:23:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 30/42]
 drivers/irqchip/irq-riscv-imsic.c:142:30: warning: variable 'global' set but
 not used
Message-ID: <202112311701.yUVrwIaS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   6fa93cde61f5f84422bd3f97b9db6e2406a344dd
commit: 608f1fa0b6d8185a467e90300c3279f63214e7b7 [30/42] irqchip: Add RISC-V incoming MSI controller driver
config: riscv-randconfig-r042-20211231 (https://download.01.org/0day-ci/archive/20211231/202112311701.yUVrwIaS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7cd109b92c72855937273a6c8ab19016fbe27d33)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/608f1fa0b6d8185a467e90300c3279f63214e7b7
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 608f1fa0b6d8185a467e90300c3279f63214e7b7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-riscv-imsic.c:142:30: warning: variable 'global' set but not used [-Wunused-but-set-variable]
           struct imsic_global_config *global;
                                       ^
   drivers/irqchip/irq-riscv-imsic.c:138:22: warning: unused function 'imsic_cpu_page_virt' [-Wunused-function]
   static void __iomem *imsic_cpu_page_virt(unsigned int cpu,
                        ^
   2 warnings generated.


vim +/global +142 drivers/irqchip/irq-riscv-imsic.c

   137	
   138	static void __iomem *imsic_cpu_page_virt(unsigned int cpu,
   139						 unsigned int guest_index)
   140	{
   141		struct imsic_handler *handler = per_cpu_ptr(&imsic_handlers, cpu);
 > 142		struct imsic_global_config *global;
   143		struct imsic_local_config *local;
   144	
   145		if (!handler || !handler->priv)
   146			return NULL;
   147		local = &handler->local;
   148		global = &handler->priv->global;
   149	
   150		return local->msi_va + (guest_index * IMSIC_MMIO_PAGE_SZ);
   151	}
   152	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
