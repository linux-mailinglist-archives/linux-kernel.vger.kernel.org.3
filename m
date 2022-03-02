Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6E24CB228
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiCBWVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiCBWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:21:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD09B10B8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 14:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646259650; x=1677795650;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qo4j3X7WLFdvbff/D0l66c6NPreCefTQR1sInTIJcDM=;
  b=hudvjYcb4LdYZqQdOqsDuImCBoKZOcAXjr0JuE7alF06hsnwd+ayQhgf
   oLUmzBMgwPvX5ObsJylyl3s4qopwq6rcYYBReeagDumBwdcImENJRi/DN
   I564xffA+DCDgxTtBowWiop31Y3eUTrgymjb2m7kBwlBQ0fHhxVey+dSr
   vW9WAt/fifEMkxRgy7sFmtsELtvykhnrBWQdLxackQ8h3iqj0c7UjiNbP
   8sGuW/cmhyOX+8NFzl+WD6wadubvjwQaU/GKuSMGQDGY0uiBthBJ5Oprf
   NocDPWBS2/pkZ3OkIuHx5UlGONmxJatBttgk8PWBkg/yFPqqhFvqa7F3I
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="240935245"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="240935245"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 14:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="535562800"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2022 14:20:48 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPXKx-00020M-V5; Wed, 02 Mar 2022 22:20:47 +0000
Date:   Thu, 3 Mar 2022 06:20:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: kernel/irq/irqdomain.c:1672:13: warning: no previous declaration for
 'irq_domain_debugfs_init'
Message-ID: <202203030600.ipn15MBE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb184c4af9b9f4563e7a126219389986a71d5b5b
commit: 087cdfb662ae50e3826e7cd2e54b6519d07b60f0 genirq/debugfs: Add proper debugfs interface
date:   4 years, 8 months ago
config: i386-randconfig-r024-20211115 (https://download.01.org/0day-ci/archive/20220303/202203030600.ipn15MBE-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=087cdfb662ae50e3826e7cd2e54b6519d07b60f0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 087cdfb662ae50e3826e7cd2e54b6519d07b60f0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/mcheck/ drivers/staging/ccree/ kernel/irq/ net/ipv6/ net/sunrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/irq/irqdomain.c:1672:13: warning: no previous declaration for 'irq_domain_debugfs_init' [-Wmissing-declarations]
    void __init irq_domain_debugfs_init(struct dentry *root)
                ^~~~~~~~~~~~~~~~~~~~~~~


vim +/irq_domain_debugfs_init +1672 kernel/irq/irqdomain.c

  1671	
> 1672	void __init irq_domain_debugfs_init(struct dentry *root)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
