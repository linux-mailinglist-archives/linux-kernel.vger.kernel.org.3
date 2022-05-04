Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F212451B3BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380419AbiEDXrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385186AbiEDXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:24:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B552270F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651706428; x=1683242428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1KdGYDHVnzH8cofyIFaIPHGTf567vUqKFjQ/0YIzyc4=;
  b=Yy5YEuDhprDVzeeUPfUrQkgoTTWshx+zAvB1AT7uknEWySsQyKjJqgrR
   NnTCvA2Tw3KJem2sh//OKLzXdeipQ54L3nP2ZFA5UX8Fx/A4cwPZkBXzn
   XiqxfY3mW7BOgfLVsVDe9AGx39L66/2BKKQ+Zyh2HIpc8/fLu2jLA4+CD
   cqUe2X/RPkbM+u7OA2xSptMQWlroiy28SJ3s52u7fEERN7vs6p1B1t6zf
   DxjHBdrDScSsVgfQBdGCsGfsCqjydNkhxjD1qw9b/7xPgd2V4itKrBkuu
   02t9/TQ90BLpy+TBOLxeU0q+p7S0zWPheEMoWTHli0e58h/2jOhGw07i7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="249910676"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="249910676"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="549084317"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2022 16:20:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmOI5-000Bt5-Kw;
        Wed, 04 May 2022 23:20:17 +0000
Date:   Thu, 5 May 2022 07:19:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:flexcpy/next-20220502 31/34] WARNING: modpost:
 vmlinux.o(.text+0xe79f2a): Section mismatch in reference from the function
 ieee80211_find_sta() to the variable .init.text:.L0
Message-ID: <202205050704.5LotcLcz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git flexcpy/next-20220502
head:   1dbd8181297512b190aca23477043ac635daba4e
commit: b0fdcfe7030e00d582776443aabf76d8653104dc [31/34] xtensa: Use mem_to_flex_dup() with struct property
config: riscv-randconfig-r023-20220501 (https://download.01.org/0day-ci/archive/20220505/202205050704.5LotcLcz-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=b0fdcfe7030e00d582776443aabf76d8653104dc
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees flexcpy/next-20220502
        git checkout b0fdcfe7030e00d582776443aabf76d8653104dc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xe79f2a): Section mismatch in reference from the function ieee80211_find_sta() to the variable .init.text:.L0
The function ieee80211_find_sta() references
the variable __init .L0 .
This is often because ieee80211_find_sta lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xc57482): Section mismatch in reference from the function snd_soc_jack_report() to the function .init.text:oom_init()
<< WARNING: modpost: vmlinux.o(.text+0xc574aa): Section mismatch in reference from the function snd_soc_jack_add_zones() to the variable .init.text:$x
<< WARNING: modpost: vmlinux.o(.text+0xe56854): Section mismatch in reference from the function cfg80211_report_obss_beacon_khz() to the function .init.text:mt7621_pci_phy_driver_init()
<< WARNING: modpost: vmlinux.o(__ex_table+0x11a0): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF2051

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
