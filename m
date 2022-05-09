Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979951FB4F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiEILb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiEILbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:31:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCBAFE21B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652095631; x=1683631631;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=trEBVu7RWf305USIYH9r4hSJ3GwXYp5S15MRjPlFsXM=;
  b=TxeuDfshkuE8Uxq28sY7/7+9q2bWcQ6SHSik0M5ZGluoL0S8VBAimLti
   OKz/1NkFmWPobSuPhVzs9mjCe+LJEiWHCBtLIDrrM/JE3ikSwu/cO5rlA
   8xYddqTLWsxLPIeyQCHskl3Mi6d8q0TBiHIX28ES73mVICxokBsS+uc56
   9txYxhr6kRVGpzL7av4+BodmuEx/PckMj8BZcCKkDinMuwghTv5jkFEuF
   NGwAhSRaqh6w5Zd18NrkW7fnOd2Dh9/pw9AN+No8I3WMD91ah7J0wBHty
   SVj7405asiFxAaJb4CDrCP/YKQ1o+6aYvTIdC8z/+iaR8j4cnjy5JIbJ+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="249558407"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="249558407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 04:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="519177188"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 May 2022 04:27:09 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no1Xg-000GT8-Ew;
        Mon, 09 May 2022 11:27:08 +0000
Date:   Mon, 9 May 2022 19:26:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:timers/core 1/8] WARNING: modpost: vmlinux.o(.text+0xc28c04):
 Section mismatch in reference from the function sock_from_file() to the
 variable .init.text:.LFB3599
Message-ID: <202205091925.kRfA1mR4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
head:   f4b62e1e1137507268c2c63dc4e6da279dc58e9f
commit: 3dc6ffae2da201284cb24af66af77ee0bbb2efaa [1/8] timekeeping: Introduce fast accessor to clock tai
config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205091925.kRfA1mR4-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3dc6ffae2da201284cb24af66af77ee0bbb2efaa
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip timers/core
        git checkout 3dc6ffae2da201284cb24af66af77ee0bbb2efaa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xc28c04): Section mismatch in reference from the function sock_from_file() to the variable .init.text:.LFB3599
The function sock_from_file() references
the variable __init .LFB3599.
This is often because sock_from_file lacks a __init
annotation or the annotation of .LFB3599 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xbad7d2): Section mismatch in reference from the function comedi_proc_cleanup() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.exit.text+0x8562): Section mismatch in reference from the function lirc_dev_exit() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_rnglists:.LLRL39

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
