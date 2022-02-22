Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0964BF714
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiBVLSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiBVLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:18:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836F760AB5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645528656; x=1677064656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=01FM+XDYVYu6vlbc8rhYQyETgXGF5ZRBxthYS1B2HgA=;
  b=hdF1g44No0bug2SxZ1pFLRdCnR/4LhRS64la0g9WMjE3l476V/QygFfg
   zv7k9B9o7zVDb3iLQLEKB5FzSKQABr/hLPE+Av0TA8bXSA6+7bfectxmM
   oT3IyXbp/qAu/8glgaRJfx6KbIXK6abOLZ+NGzy6X9OUMmY7dYGDm9vgn
   +NjjVo+lAjDxP0zkibkj9x9OMdiWIK/ls9NDUs/QTLJ68l07WuYp7gJQI
   EtK6D1MrURqComvWjyqS/oFpygD3sHp/FyNF1CNRbQCw3lFXAcgFWmNpn
   OTVNF8mpHVtiz6giozk9suvU+22MrRU+wv9JwVqR7kq7ieNvaodQ+o1ov
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="239080501"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="239080501"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 03:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532187635"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2022 03:17:35 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMTAk-0000Ab-G4; Tue, 22 Feb 2022 11:17:34 +0000
Date:   Tue, 22 Feb 2022 19:17:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 23/28] aarch64-linux-ld:
 arch/arm64/mm/pgd.o:(__jump_table+0x18): undefined reference to
 `kvm_protected_mode_initialized'
Message-ID: <202202221905.eZcFyuZ0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   5ca7e5f74d85e6d2ddeabaa1b85b64ae50864676
commit: 61fb51c0f895face8b0c920001be074df6825391 [23/28] arm64: kvm: track root page table state at hyp and remap r/o when active
config: arm64-randconfig-r015-20220222 (https://download.01.org/0day-ci/archive/20220222/202202221905.eZcFyuZ0-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=61fb51c0f895face8b0c920001be074df6825391
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout 61fb51c0f895face8b0c920001be074df6825391
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> aarch64-linux-ld: arch/arm64/mm/pgd.o:(__jump_table+0x18): undefined reference to `kvm_protected_mode_initialized'
   aarch64-linux-ld: arch/arm64/mm/pgd.o:(__jump_table+0x38): undefined reference to `kvm_protected_mode_initialized'
   aarch64-linux-ld: arch/arm64/mm/ro_page_tables.o:(__jump_table+0x8): undefined reference to `kvm_protected_mode_initialized'
   aarch64-linux-ld: arch/arm64/mm/ro_page_tables.o:(__jump_table+0x38): undefined reference to `kvm_protected_mode_initialized'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
