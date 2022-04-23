Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8354C50C6DF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiDWDQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiDWDQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:16:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7DC2B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650683622; x=1682219622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oQvCOAMcc/LKRAmbzIvKLfJ8w2+B553mmn6UBLzF+dc=;
  b=ENEITTMPf7absqZXww3aLuxz7/smaeO9v2PHJP86y/Gwl8HeY2BesoQy
   sC6iMNOQK3lOsoQBkLDvZU29DjsEk+WBzkwW6LhhEeQRIcfI3DU7GJgAH
   hoSm9zHbKfmz45Fk8t8Qv5XukzK/dSstHcDVBfuwuVk6+U+HBZ4dDdJYx
   EcS8tmuovRXirDKQ8lNQV5xtJ4xnRsxFO4KMgMG236j85tZgFFHQH04Co
   7ESXLT5ACfcu+XUHn47OyXRhLNQ88on6NOUGMmzcp+COOb7R4q2c3zGEn
   cNNpddoyCzwIT2FLRTOt9gGQWhn3JXJuFph7/eukC/AY/742UDqv2ky/G
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244766853"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="244766853"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 20:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="673056640"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2022 20:13:40 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni6DL-000AwT-Pc;
        Sat, 23 Apr 2022 03:13:39 +0000
Date:   Sat, 23 Apr 2022 11:13:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [vkoul-dmaengine:next 32/42] WARNING: modpost:
 vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function
 tipc_topsrv_init_net() to the variable .init.text:.L0
Message-ID: <202204231004.tnlEcRrm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
head:   99faef48e7a3f878848a2d711af710e36fadbd6e
commit: a8facc7b988599f83a680d2d61f4607cda495175 [32/42] dmaengine: add verification of DMA_INTERRUPT capability for dmatest
config: riscv-buildonly-randconfig-r002-20220421 (https://download.01.org/0day-ci/archive/20220423/202204231004.tnlEcRrm-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?id=a8facc7b988599f83a680d2d61f4607cda495175
        git remote add vkoul-dmaengine https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
        git fetch --no-tags vkoul-dmaengine next
        git checkout a8facc7b988599f83a680d2d61f4607cda495175
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x1c35db0): Section mismatch in reference from the function tipc_topsrv_init_net() to the variable .init.text:.L0
The function tipc_topsrv_init_net() references
the variable __init .L0 .
This is often because tipc_topsrv_init_net lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x1ad84d4): Section mismatch in reference from the function x25_limit_facilities() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1b8a6ac): Section mismatch in reference from the function vlan_gvrp_uninit_applicant() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1bc3c34): Section mismatch in reference from the function sctp_bind_addr_free() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x1cd8f80): Section mismatch in reference from the function rawsock_exit() to the function .init.text:sm501fb_driver_init()
<< WARNING: modpost: vmlinux.o(.text+0x1ce03bc): Section mismatch in reference from the function nfc_llcp_sock_exit() to the function .init.text:sm501fb_driver_init()
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF236

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
