Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669A255CAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiF0JFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiF0JFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:05:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E226343
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656320730; x=1687856730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y7Bnm7t7TjTtAlu/JwqIMutYoVkhtjRFLIevu8zu33M=;
  b=kjnAKax71JhOti02pmVTzP4usxtjsf4rm1QFo+q61xmsajwVBEMVYuFI
   +g/pzAjJ5X4kImxP4Bl6bMKo5pRriIZgCDJ1Qw25KzV/WMyV2jTxdLUFq
   XAm859TaQiG5v8kwaHCBTXHEdRD51vYHJ+o4q2zGxVRKpyLgnvuMIf8pA
   JxtMUSk+/qwp7CySxlKAlB1KoDzM+gLXatLroL+28iAcPiiRQv5DMR62S
   awaLyiAwMFpWdR+yk/8szaY/y4aCwJsj3/twCzvDdb3GinuFCkle4W2cj
   8yU1PyX5TiUn3XY5Z/SU4DG+Ok/iqM931ccSys7nJ8N65OA4mZowQ+dAR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="343090083"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="343090083"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 02:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="679500670"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2022 02:05:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5kgR-0008OK-Hp;
        Mon, 27 Jun 2022 09:05:27 +0000
Date:   Mon, 27 Jun 2022 17:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: arch/riscv/kernel/compat_syscall_table.o:undefined reference to
 `compat_sys_fadvise64_64'
Message-ID: <202206271631.is6IZBec-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   03c765b0e3b4cb5063276b086c76f7a612856a9a
commit: 9be8459298eadb39b9fe9974b890239e9c123107 riscv: compat: Add COMPAT Kbuild skeletal support
date:   6 weeks ago
config: riscv-randconfig-m031-20220627 (https://download.01.org/0day-ci/archive/20220627/202206271631.is6IZBec-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9be8459298eadb39b9fe9974b890239e9c123107
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9be8459298eadb39b9fe9974b890239e9c123107
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: riscv64-linux-ld: DWARF error: could not find abbrev number 56
>> arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8): undefined reference to `compat_sys_fadvise64_64'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
