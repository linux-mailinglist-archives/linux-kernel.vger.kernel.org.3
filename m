Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506FE50CF1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 06:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbiDXEYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 00:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiDXEYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 00:24:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BF71A836
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 21:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650774106; x=1682310106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GzpruI2RiR0MADPFP36Tm9nNam/1lc1RO/Il++9eS9E=;
  b=GkIfNR5/OHsZpi8aGbHD3NBaA96ZR7zzNh07Etk+1RfFn1IQBv3LJapb
   AhCNnD41iypLjzt1tQzOEqWEK7QK2xi6qh8t4TEOOdH/THwCtA2aalWcK
   6NqeHtPXu43VK56DFHWbjKX/ygKRERCTw6hvixFwqlhlgbt7oGDQBwRq3
   dBh0RffFTUBbDnItzfvUXjSj8n+E0vn+CYZ/TML8h22bmlCGRD84ASMz+
   rtUFSFl5G4IpqqYeh/+Xya3vSs52j7uuqDizjVxHe53mqcjzpM1q4JeNV
   fqp04je/1bnTqRjou+bCsXJQjb9Wi7qeFS8ihyZGwAdvfX8bXV1qL1jIj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="262587170"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="262587170"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 21:21:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="674804980"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Apr 2022 21:21:44 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niTkl-00010l-Ek;
        Sun, 24 Apr 2022 04:21:43 +0000
Date:   Sun, 24 Apr 2022 12:21:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 34/291] WARNING: modpost: vmlinux.o(.data+0x234bc8):
 Section mismatch in reference from the variable fc2580_driver to the
 function .init.text:set_reset_devices()
Message-ID: <202204241241.dnUrBBvT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   ba42854fa9997614e0ffdbc35b082df3ba6e59da
commit: 477a4d0f1f38e738d1a50d5005b79aca719c30bc [34/291] mm/hugetlb: take src_mm->write_protect_seq in copy_hugetlb_page_range()
config: riscv-randconfig-r015-20220420 (https://download.01.org/0day-ci/archive/20220424/202204241241.dnUrBBvT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/hnaz/linux-mm/commit/477a4d0f1f38e738d1a50d5005b79aca719c30bc
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout 477a4d0f1f38e738d1a50d5005b79aca719c30bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.data+0x234bc8): Section mismatch in reference from the variable fc2580_driver to the function .init.text:set_reset_devices()
The variable fc2580_driver references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:


Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x13e3592): Section mismatch in reference from the function usbhid_find_interface() to the variable .init.text:.LBB0_1
<< WARNING: modpost: vmlinux.o(.text+0x13e3596): Section mismatch in reference from the function usbhid_find_interface() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x23ad30): Section mismatch in reference from the variable empty_map to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x258174): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x258194): Section mismatch in reference from the variable w83795_in to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x23ba8c): Section mismatch in reference from the variable stm32_cec_driver to the variable .init.text:.LBB20_8
<< WARNING: modpost: vmlinux.o(.data+0x256558): Section mismatch in reference from the variable w83793_temp to the variable .init.text:.LBB46_1
<< WARNING: modpost: vmlinux.o(.data+0x25655c): Section mismatch in reference from the variable w83793_temp to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x230444): Section mismatch in reference from the variable ov5695_i2c_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x25c1dc): Section mismatch in reference from the variable sensor_dev_attr_temp1_input to the function .meminit.text:init_reserve_notifier()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
