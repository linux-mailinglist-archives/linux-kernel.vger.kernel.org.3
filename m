Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7855607F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiF2R5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiF2R5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:57:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE4A3981D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656525428; x=1688061428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8Z8d+vB+c+oayRdApzeWjdqIaMdxqCy+aayzn7wVe34=;
  b=dxnB2NYDNhbmwwP6E5UNGvPrCGRUYJkU/U0NysusoWf6bTuQOb4f5hdD
   cuOsagveOiX/mpDjTwX69DDbNZQt/SUPSgzeiBqPLMBGjn3wuQPQlB90V
   9T6yNoENsJRSMt0CGUrRX+rZOZcHX46I3dP7sx9ZQnle6E0jsckTvnOk5
   O2tyVkABAoSF1uv2fYkqz1SIUL9GvNipxcv/k+C7KTW0QeqdKwyIyaNWf
   azKX0suePAz+AaEzA10sqp2kq0J5vBtI4XHVbXiKfE9yCL17XfsaMO4RK
   TcyNmSwGpJA7syey0XN6U1saJ1dJOhUC7u/YJM0iuGdCYm9LzFGiHTgWu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="265139674"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="265139674"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 10:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="917698336"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2022 10:57:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6bw1-000BOM-QL;
        Wed, 29 Jun 2022 17:57:05 +0000
Date:   Thu, 30 Jun 2022 01:56:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function
 'set_test_mode_src_osc_freq_target_low_bits'
Message-ID: <202206300147.qdDDrtfw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d9b2ba67917c18822c6a09af41c32fa161f1606b
commit: ade896460e4a62f5e4a892a98d254937f6f5b64c drm: DRM_KMB_DISPLAY should depend on ARCH_KEEMBAY
date:   1 year, 8 months ago
config: mips-randconfig-r016-20220629 (https://download.01.org/0day-ci/archive/20220630/202206300147.qdDDrtfw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ade896460e4a62f5e4a892a98d254937f6f5b64c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ade896460e4a62f5e4a892a98d254937f6f5b64c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/kmb/ drivers/net/ethernet/mellanox/mlxsw/ drivers/scsi/ufs/ drivers/staging/ fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/kmb/kmb_dsi.c:812:2: warning: unused function 'set_test_mode_src_osc_freq_target_low_bits'
   set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi
   ^
>> drivers/gpu/drm/kmb/kmb_dsi.c:824:2: warning: unused function 'set_test_mode_src_osc_freq_target_hi_bits'
   set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-15: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-a774ba7f60/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers fs include kernel mm nr_bisected scripts source usr


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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
