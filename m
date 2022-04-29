Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1851432E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346771AbiD2HYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiD2HYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:24:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A863F36322
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651216862; x=1682752862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jnx+Ro52qkbZweZcqPZpLGmaJi6VRUu8Ggk/PtUr1es=;
  b=Ra8xssRI3NCfwEHsVWsVDF/MEVSzmrcstJrfMSejLC/o7N2mcTcEeafv
   QyzSk559xYfe/ZxoDufgWe4uKX4COO5cs8gWJbj6d1DkRCxuMioyuByK6
   rYybzqwz6V838u+zVEWZTlz4uL0PEgwGYljxFQIKmrgWObaUH0UwVa3fT
   njY/WzltGawfVpfsK/GqKc32R3k+3rzcpBKW9eXpDwN0Uv2Gfv6tPf6US
   zrYPkh42fXHdOjyUIYVrbZYc3hla0TaWEDFfwmggoEHzhEHVmQXKvWwib
   gAf1D+kyTcIpAs9YVy23crLSGXAHpqXU9OIWiprxIWu5Wz5zKYPGy0aiV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266376780"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="266376780"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 00:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="706430857"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2022 00:21:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkKvz-00066W-Cb;
        Fri, 29 Apr 2022 07:20:59 +0000
Date:   Fri, 29 Apr 2022 15:20:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:pending 21/34] WARNING: modpost: vmlinux.o(.data+0x211170):
 Section mismatch in reference from the variable ocores_algorithm to the
 function .init.text:set_reset_devices()
Message-ID: <202204291528.JcxVNDff-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
head:   e6829d1bd3c4b58296ee9e412f7ed4d6cb390192
commit: 26f89535a5bb17915a2e1062c3999a2ee797c7b0 [21/34] cxl/mbox: Use type __u32 for mailbox payload sizes
config: riscv-buildonly-randconfig-r003-20220428 (https://download.01.org/0day-ci/archive/20220429/202204291528.JcxVNDff-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=26f89535a5bb17915a2e1062c3999a2ee797c7b0
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl pending
        git checkout 26f89535a5bb17915a2e1062c3999a2ee797c7b0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.data+0x211170): Section mismatch in reference from the variable ocores_algorithm to the function .init.text:set_reset_devices()
The variable ocores_algorithm references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:


Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.data+0x20a7cc): Section mismatch in reference from the variable rk805_pwrkey_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x20d8b8): Section mismatch in reference from the variable tegra_rtc_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2950a8): Section mismatch in reference from the variable wm5100_mixer_texts to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2950b8): Section mismatch in reference from the variable wm5100_mixer_texts to the variable .init.text:.LBB1_1
<< WARNING: modpost: vmlinux.o(.data+0x2950d0): Section mismatch in reference from the variable wm5100_mixer_texts to the function .exit.text:versatile_pci_driver_exit()
<< WARNING: modpost: vmlinux.o(.data+0x2950d4): Section mismatch in reference from the variable wm5100_mixer_texts to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.data+0x2950d8): Section mismatch in reference from the variable wm5100_mixer_texts to the variable .exit.text:.LBB2_1
<< WARNING: modpost: vmlinux.o(.data+0x2b6658): Section mismatch in reference from the variable t9015_dai to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.data+0x2bfb20): Section mismatch in reference from the variable sprd_mcdt_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2bfb88): Section mismatch in reference from the variable stm32_sai_sub_driver to the function .init.text:set_reset_devices()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
