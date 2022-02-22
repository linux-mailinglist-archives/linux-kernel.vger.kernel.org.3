Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405424BF319
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiBVIFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiBVIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:05:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5720910BBC6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645517074; x=1677053074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VShtbmi8FOCzLPHTSGPTXWbhC6RlBZZOPJuwM5dqRVY=;
  b=de1qnS0Uk2iVVLQgzF+oVQRYe+8AO4tbJE6+K9H1cFYOsxIhI5QY3N12
   pO/vyFpVThbs3Rc/PhriNgU9WpGT+KDUV5/kA8+1hXA0iRxRGgDwwwVJI
   EKIvSDewv/Y0HMjcEoOtSQvjx4jxVGzQnkk4vE9lThUfssIEHBzGs8geK
   sFqjotxQYzUac/51HZ0X3jiliTnrLjeaYxtBgfUFulhp9f0xXoJuXt1ZZ
   9BJiuwUQpgQyw50Zf84EiNfMi9zi5Suxffj+QZK2vVUssgAE6h9O4B16h
   dId84kLr5nwS7jxGEQuPPIh88QY2tEnpJfT4rMkohkRVsON4NEL2jj3AD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276234439"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276234439"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 00:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="507891880"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2022 00:04:29 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMQ9s-00000n-GD; Tue, 22 Feb 2022 08:04:28 +0000
Date:   Tue, 22 Feb 2022 16:04:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 19/28] aarch64-linux-ld:
 arch/arm64/mm/ro_page_tables.o:(__jump_table+0x8): undefined reference to
 `kvm_protected_mode_initialized'
Message-ID: <202202221516.u3Jzf46e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   5ca7e5f74d85e6d2ddeabaa1b85b64ae50864676
commit: 490e2f46e5708259a80308e790e4ddd3d59691a2 [19/28] arm64: kvm: use HYP helpers to perform page table updates
config: arm64-randconfig-r015-20220222 (https://download.01.org/0day-ci/archive/20220222/202202221516.u3Jzf46e-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=490e2f46e5708259a80308e790e4ddd3d59691a2
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout 490e2f46e5708259a80308e790e4ddd3d59691a2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> aarch64-linux-ld: arch/arm64/mm/ro_page_tables.o:(__jump_table+0x8): undefined reference to `kvm_protected_mode_initialized'
   aarch64-linux-ld: arch/arm64/mm/ro_page_tables.o:(__jump_table+0x38): undefined reference to `kvm_protected_mode_initialized'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
