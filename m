Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7507B4D3D43
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiCIWoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiCIWoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:44:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA670F48
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646865793; x=1678401793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1cto/p8dRg+AnEOvrrippLbcucvestYrwf3SNsBrMYs=;
  b=HPMmYQim01WMPaMoma1JAfZXdZRKAxU8Q3YAatUr2GofpLkb0no5Smci
   cYXzVsFnQsQyo7Jqvj2YI8RX9NNhE9QZVXarV7fa0fieiKjpb9eY08fve
   JU4NWvw/efRcMq2lTYXwVdOaDrRw/56XfPQhVBHqRmhgXUiV06AoQsh2d
   FSk1MSsja+TDufv9iLVdOIkwZ6XRcz7GiluhKg6GpnSnABcs3y0X2djxX
   wSXg3ozp1iw0QyBEKISG+OV9prhJcEv+S8ck/dtKLrfkioS6IVcSeib51
   YQ0PjihAwcQWtEKmd+2R+vfwWVRm4ql4myJEkum2UUsRy+L8unJrESxWB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="254841438"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="254841438"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="513710049"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2022 14:43:11 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS51S-0003uU-TJ; Wed, 09 Mar 2022 22:43:10 +0000
Date:   Thu, 10 Mar 2022 06:28:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: {standard input}:17065: Error: Insn slot not set in unwind record.
Message-ID: <202203100620.iV7ASPnG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: a82adfd5c7cb4b8bb37ef439aed954f9972bb618 hardening: Introduce CONFIG_ZERO_CALL_USED_REGS
date:   8 months ago
config: ia64-randconfig-r013-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100620.iV7ASPnG-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a82adfd5c7cb4b8bb37ef439aed954f9972bb618
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a82adfd5c7cb4b8bb37ef439aed954f9972bb618
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from fs/dcache.c:20:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:17065: Error: Insn slot not set in unwind record.
   {standard input}:17065: Fatal error: Section switching in code is not supported.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
