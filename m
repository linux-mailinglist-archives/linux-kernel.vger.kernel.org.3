Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093AA471998
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 11:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhLLKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 05:17:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:60061 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhLLKRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 05:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639304226; x=1670840226;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uHtj6yjabwtBYtIkHr8L3/K0B+6a/zxU6yfhWG9AHmQ=;
  b=AfNLzaYhymQSRZkMyr3/IONxgsC95Jxfl1Nz8+lKYnKACMzEpQ3ZtuhL
   LsrXNx/vZu/sG1NgyOShsNLP51EpPIYQ1DeJ/gBJ4YrDyn8C5+8ZLHr6j
   Kd30q0WT8xrdkWoF8vajlv/hSzhge9c2CRusH5Z+ZA/lygyDGxtJNth/v
   0498ACCe+OughKEU7co4160Cc6ysMJPHrhmd2ZH9BfTWywSOcBX+L453z
   0n7Zzyf5RwDtD2LwDtdSzWc/OFzU5LVpzc0Rt7Fa7weR7yCMmKI+p1a4X
   5bbMF6xJ53zqjj9LDX66hGIV5lP2YhchhRrtOJxR7zIftYguh3XFkJA06
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="238814730"
X-IronPort-AV: E=Sophos;i="5.88,200,1635231600"; 
   d="scan'208";a="238814730"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 02:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,200,1635231600"; 
   d="scan'208";a="464279993"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2021 02:17:04 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwLuh-0005YS-K0; Sun, 12 Dec 2021 10:17:03 +0000
Date:   Sun, 12 Dec 2021 18:16:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: sound/soc/samsung/spdif.c:95:2: warning: unused function
 'component_to_info'
Message-ID: <202112121823.rMdVwjAL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a763d5a5abd65797aec3dd1bf01fe2ccbec32967
commit: 35f752be4f412a1a58f4c15fa9282c53b956e067 mips: ralink: convert to CONFIG_COMMON_CLK
date:   6 months ago
config: mips-randconfig-r026-20211211 (https://download.01.org/0day-ci/archive/20211212/202112121823.rMdVwjAL-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=35f752be4f412a1a58f4c15fa9282c53b956e067
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 35f752be4f412a1a58f4c15fa9282c53b956e067
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs// mm// sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/samsung/spdif.c:95:2: warning: unused function 'component_to_info'
   snd_soc_component
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-097a1cb1d5/bin
   clang-14: note: diagnostic msg:
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm nr_bisected scripts security sound source usr virt


vim +/component_to_info +95 sound/soc/samsung/spdif.c

fc127ccccc5de1 sound/soc/s3c24xx/spdif.c Seungwhan Youn    2010-10-12  93  
79a5cf90f8719c sound/soc/samsung/spdif.c Kuninori Morimoto 2020-01-20  94  static inline struct samsung_spdif_info
79a5cf90f8719c sound/soc/samsung/spdif.c Kuninori Morimoto 2020-01-20 @95  *component_to_info(struct snd_soc_component *component)
79a5cf90f8719c sound/soc/samsung/spdif.c Kuninori Morimoto 2020-01-20  96  {
79a5cf90f8719c sound/soc/samsung/spdif.c Kuninori Morimoto 2020-01-20  97  	return snd_soc_component_get_drvdata(component);
79a5cf90f8719c sound/soc/samsung/spdif.c Kuninori Morimoto 2020-01-20  98  }
79a5cf90f8719c sound/soc/samsung/spdif.c Kuninori Morimoto 2020-01-20  99  

:::::: The code at line 95 was first introduced by commit
:::::: 79a5cf90f8719c3f69a0dc53efebb38da654512f ASoC: samsung: spdif: move .suspend/.resume to component

:::::: TO: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
