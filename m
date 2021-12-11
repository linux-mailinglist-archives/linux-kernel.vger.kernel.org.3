Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973834711F8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhLKFjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:39:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:2377 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhLKFjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639200934; x=1670736934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/bZKWyAFHG3HJHAMwXYUZZsrHm4ILvRq4hR+zJiXZu4=;
  b=V3yVm0MH6CaBVMY541qz1+4k9Xeu1vXf1zJjnW9unjg5QBmFp5bN8nBt
   zh37Xo+yvXQlFRDFL9NRKCGtGBkT+r+JswQfdZ3CaQgew1MzNJzJzPd3V
   lqI5KFqEAkAso0RQ5r2g6ZtTSLGaQhSO8bUOoRWXeFGcDVBlNmkZ1KoLi
   PiQ81+55SHWGZnX1Ema8O9YY5NYItIA+zlIGFL8nbkSVFeqrwtSeTH+4i
   +KtXZ/mMkQRchtT31RC4FLjTw8RPy2h9h6MsjPZUhZaa1c+wMNwHLE75o
   P4NItlVmxpGac+ZGq72K9Kn9ovPfRS+WKjHS88D8iyvDzYxRUel5+sd2Q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="225372997"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="225372997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 21:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="462790275"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2021 21:35:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvv2g-0004Av-Rv; Sat, 11 Dec 2021 05:35:30 +0000
Date:   Sat, 11 Dec 2021 13:34:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function
 'set_test_mode_src_osc_freq_target_low_bits'
Message-ID: <202112111334.EmMJpBTI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6f513529296fd4f696afb4354c46508abe646541
commit: ade896460e4a62f5e4a892a98d254937f6f5b64c drm: DRM_KMB_DISPLAY should depend on ARCH_KEEMBAY
date:   1 year, 1 month ago
config: mips-randconfig-r026-20211211 (https://download.01.org/0day-ci/archive/20211211/202112111334.EmMJpBTI-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ade896460e4a62f5e4a892a98d254937f6f5b64c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ade896460e4a62f5e4a892a98d254937f6f5b64c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/kmb/ fs/ mm/ sound/soc/samsung/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function 'set_test_mode_src_osc_freq_target_low_bits'
   set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi
   ^
>> drivers/gpu/drm/kmb/kmb_dsi.c:824:2: warning: unused function 'set_test_mode_src_osc_freq_target_hi_bits'
   set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-097a1cb1d5/bin
   clang-14: note: diagnostic msg:
   Makefile arch drivers fs include kernel mm nr_bisected scripts sound source usr


vim +/set_test_mode_src_osc_freq_target_low_bits +812 drivers/gpu/drm/kmb/kmb_dsi.c

98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  810  
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  811  static inline void
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04 @812  	set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi *kmb_dsi,
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  813  						   u32 dphy_no,
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  814  						   u32 freq)
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  815  {
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  816  	/* Typical rise/fall time=166, refer Table 1207 databook,
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  817  	 * sr_osc_freq_target[7:0]
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  818  	 */
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  819  	test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES,
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  820  		       (freq & 0x7f));
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  821  }
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  822  
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  823  static inline void
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04 @824  	set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi *kmb_dsi,
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  825  						  u32 dphy_no,
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  826  						  u32 freq)
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  827  {
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  828  	u32 data;
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  829  
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  830  	/* Flag this as high nibble */
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  831  	data = ((freq >> 6) & 0x1f) | (1 << 7);
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  832  
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  833  	/* Typical rise/fall time=166, refer Table 1207 databook,
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  834  	 * sr_osc_freq_target[11:7]
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  835  	 */
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  836  	test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES, data);
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  837  }
98521f4d4b4cb2 Anitha Chrisanthus 2020-11-04  838  

:::::: The code at line 812 was first introduced by commit
:::::: 98521f4d4b4cb265374a4b1e13b41287a1960243 drm/kmb: Mipi DSI part of the display driver

:::::: TO: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
:::::: CC: Sam Ravnborg <sam@ravnborg.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
