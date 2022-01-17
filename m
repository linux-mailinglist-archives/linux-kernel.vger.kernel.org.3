Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3BC491128
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiAQU5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:57:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:58660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235752AbiAQU5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642453071; x=1673989071;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ze1TtS9EWwk598oqZ++lM0WsAz2TsJLsrHKqp+Xs6NQ=;
  b=MMIal9oFJ++h7DuOL64pMUw03LwYpqexO4SGCs9XknunGc8vojfJW4sL
   Sgx5TIMITo95M+4Gx/jLHU9D1bUStl0bZzl5dXNYqABAxOXgMC1Dc2ck0
   VJFbISC4g9hP2FXHA3S2VqgVSKbaABtS/bBJ9F28yoa/RZe1/qh1jEoWk
   JsRRcx2WfqFb1wOzJKbkmw4dSDKa+kj2uy/okpkXTHC3EXx6U8uPp0MAT
   W4hITqN//oq0mf4QnhRDXBcvzblbO/sOFzGGSq8TQDeZ3WEvTpDxEe+pI
   vlUIfseYByuBJsP5P8Mx5MWjWt3Yq1YT4kJUnB/awlL66T/QKwYN7gTbz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244648934"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="244648934"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 12:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="476760990"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2022 12:57:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9Z4W-000Brv-HR; Mon, 17 Jan 2022 20:57:48 +0000
Date:   Tue, 18 Jan 2022 04:57:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/pending 283/294]
 drivers/net/wireless/ath/ath11k/pci_cmn.c:185:10: warning: variable 'val' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202201180419.pxOIAhwJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
head:   8415824bf3ea5c313f15b902497cd2834c01e78e
commit: f38b44f68cd13a37d90c62863250c16b951e202e [283/294] ath11k: Add register access logic for WCN6750
config: arm64-randconfig-r011-20220116 (https://download.01.org/0day-ci/archive/20220118/202201180419.pxOIAhwJ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/f38b44f68cd13a37d90c62863250c16b951e202e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/pending
        git checkout f38b44f68cd13a37d90c62863250c16b951e202e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/pci_cmn.c:185:10: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   } else if (ab->bus_params.ops.window_read32) {
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath11k/pci_cmn.c:195:9: note: uninitialized use occurs here
           return val;
                  ^~~
   drivers/net/wireless/ath/ath11k/pci_cmn.c:185:10: note: remove the 'if' if its condition is always true
                   } else if (ab->bus_params.ops.window_read32) {
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   drivers/net/wireless/ath/ath11k/pci_cmn.c:168:9: note: initialize the variable 'val' to silence this warning
           u32 val, window_start;
                  ^
                   = 0
   1 warning generated.


vim +185 drivers/net/wireless/ath/ath11k/pci_cmn.c

   165	
   166	u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
   167	{
   168		u32 val, window_start;
   169	
   170		/* for offset beyond BAR + 4K - 32, may
   171		 * need to wakeup the device to access.
   172		 */
   173		if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
   174		    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
   175		    ab->bus_params.ops.wakeup)
   176			ab->bus_params.ops.wakeup(ab);
   177	
   178		if (offset < ATH11K_PCI_WINDOW_START) {
   179			val = ioread32(ab->mem + offset);
   180		} else {
   181			if (ab->bus_params.static_window_map) {
   182				window_start = ath11k_pci_get_window_start(ab, offset);
   183				val = ioread32(ab->mem + window_start +
   184					       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
 > 185			} else if (ab->bus_params.ops.window_read32) {
   186				val = ab->bus_params.ops.window_read32(ab, offset);
   187			}
   188		}
   189	
   190		if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
   191		    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF &&
   192		    ab->bus_params.ops.release)
   193			ab->bus_params.ops.release(ab);
   194	
   195		return val;
   196	}
   197	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
