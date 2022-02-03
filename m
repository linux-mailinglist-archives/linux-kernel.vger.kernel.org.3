Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55F34A7F60
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbiBCGp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:45:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:3176 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234826AbiBCGpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643870755; x=1675406755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zAmfP+5ZWHA1BLU4rcpgLRkWbVOTBkVKF+ZrH11coeY=;
  b=VDHB4jnn0iCIVlwOiTCYz/jDW4gcNLjDv+uVoQN+ATGIzRCOYeQJPesN
   dhN36+LxcIMR65XGjritY8CnUiSTC76vszzXuGmoEoicH/zBr/N4dffwI
   I/2qkZh8Krji5mhGFCM7zKLY7znPDvr3YU6GHfgt1GG+wZZCpcl5v6Rv9
   8vmY71bKNJxoOxzybaqVETCtaK7Xp+Tf+WrqchcNkT8tS5RkkiIF+0iEE
   Qkf3ljVgKyHP530PerZkvP4bmKYECXQ+TCYBrEUiAv35Bnl+JrN527urz
   a6voVs8rHh8T9mNo7K/vu24r/5fAY7mJ38bQAwUpD5epSxXAroDuH/3xQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="245681879"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="245681879"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 22:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="483135096"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 22:45:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFVsP-000Vl6-35; Thu, 03 Feb 2022 06:45:53 +0000
Date:   Thu, 3 Feb 2022 14:45:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harita Chilukuri <harita.chilukuri@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [mchinth:sep_socwatch_linux_5_15 2/2]
 drivers/platform/x86/socwatch/sw_telem.c:635: warning: This comment starts
 with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202202031432.pIU8AcPB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_15
head:   3af50f40725e78c505cbf840fb0be424c2f33e5e
commit: 3af50f40725e78c505cbf840fb0be424c2f33e5e [2/2] Pull socwatch driver to intel-next 5.15
config: i386-randconfig-a011-20220131 (https://download.01.org/0day-ci/archive/20220203/202202031432.pIU8AcPB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/mchinth/linux/commit/3af50f40725e78c505cbf840fb0be424c2f33e5e
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_15
        git checkout 3af50f40725e78c505cbf840fb0be424c2f33e5e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/sepdk/pax/ drivers/platform/x86/sepdk/sep/ drivers/platform/x86/socwatch/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/x86/socwatch/sw_telem.c:334: warning: Function parameter or member 'addrs' not described in 'setup_telem'
   drivers/platform/x86/socwatch/sw_telem.c:376: warning: Function parameter or member 'events' not described in 'get_or_set_id'
   drivers/platform/x86/socwatch/sw_telem.c:376: warning: Function parameter or member 'unit_idx' not described in 'get_or_set_id'
   drivers/platform/x86/socwatch/sw_telem.c:376: warning: Function parameter or member 'id' not described in 'get_or_set_id'
   drivers/platform/x86/socwatch/sw_telem.c:437: warning: Cannot understand  * @returns timestamp (1st entry of SSRAM)
    on line 437 - I thought it was a doc line
>> drivers/platform/x86/socwatch/sw_telem.c:635: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Configurs events + starts counters
>> drivers/platform/x86/socwatch/sw_telem.c:858: warning: expecting prototype for sw_available_telem(). Prototype was for sw_telem_available() instead
--
>> drivers/platform/x86/socwatch/sw_ops_provider.c:830: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Decide if the socperf interface is available for use


vim +635 drivers/platform/x86/socwatch/sw_telem.c

688e338c753b33c Faycal Benmlih 2019-04-23 @635   * Configurs events + starts counters

:::::: The code at line 635 was first introduced by commit
:::::: 688e338c753b33c023de3b774f7347effbf537a4 Platform/x86: Update SoCWatch driver code to 2.10

:::::: TO: Faycal Benmlih <faycal.benmlih@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
