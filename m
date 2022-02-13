Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA9E4B3DE3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiBMWCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:02:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiBMWCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:02:18 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DEC541A5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 14:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644789732; x=1676325732;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8gHnC+e5bbqLdMUHuvpd2PqIUd+f01iwkJtCkQmwQdc=;
  b=VULexaIcikTZ1I3sYXB4Ilk6lc7YaBKB+LhqI2dDeZtkjhBIuiPZDNmF
   0ft9u3uuSvyBg7g5g6Wy52kn/sdqZCcglBUS51DIV8rXM4br/lGX/QZHB
   9kjz3JpNeIYxEzkouy9ZWnw+dscX+xqJiMMHFi/L1qn+mLOIFxibqyY7V
   GVXJ8q4+pBXwKWAghissbkYvrT7GgSty3nYhSIGeHgpBVxH6YcZrJyfiA
   iBso8ImKfMInrtZtaTms4UXjjR9+brfsOEzuZfYkkgkWPIEay9D5/fI5R
   2ZvCfKqn2dTyrLyrWqoQzdlqxHeAzb357Dn8FUTyG6hpPNMIBxX2VvJG7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="233526731"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="233526731"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 14:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="702781641"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2022 14:02:10 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJMwb-0007t8-Ql; Sun, 13 Feb 2022 22:02:09 +0000
Date:   Mon, 14 Feb 2022 06:02:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [boqun:dev/arm64 1/3] drivers/pci/controller/pci-hyperv.c:769:13:
 error: 'hv_set_msi_entry_from_desc' defined but not used
Message-ID: <202202140532.7tKzn8ca-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git dev/arm64
head:   715cdf131dd8fcb33591dc7143d193050368ecc1
commit: 39649970d5e2d161268189e1dcb9b3cb7a6ee03b [1/3] PCI: hv: Avoid the retarget interrupt hypercall in irq_unmask() on ARM64
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220214/202202140532.7tKzn8ca-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/commit/?id=39649970d5e2d161268189e1dcb9b3cb7a6ee03b
        git remote add boqun https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git
        git fetch --no-tags boqun dev/arm64
        git checkout 39649970d5e2d161268189e1dcb9b3cb7a6ee03b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/ drivers/pci/ kernel//

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/controller/pci-hyperv.c:769:13: error: 'hv_set_msi_entry_from_desc' defined but not used [-Werror=unused-function]
     769 | static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/hv_set_msi_entry_from_desc +769 drivers/pci/controller/pci-hyperv.c

d9932b46915664 Sunil Muthuswamy 2022-01-05  768  
d9932b46915664 Sunil Muthuswamy 2022-01-05 @769  static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
d9932b46915664 Sunil Muthuswamy 2022-01-05  770  				       struct msi_desc *msi_desc)
d9932b46915664 Sunil Muthuswamy 2022-01-05  771  {
d9932b46915664 Sunil Muthuswamy 2022-01-05  772  	msi_entry->address = ((u64)msi_desc->msg.address_hi << 32) |
d9932b46915664 Sunil Muthuswamy 2022-01-05  773  			      msi_desc->msg.address_lo;
d9932b46915664 Sunil Muthuswamy 2022-01-05  774  	msi_entry->data = msi_desc->msg.data;
d9932b46915664 Sunil Muthuswamy 2022-01-05  775  }
d9932b46915664 Sunil Muthuswamy 2022-01-05  776  

:::::: The code at line 769 was first introduced by commit
:::::: d9932b46915664c88709d59927fa67e797adec56 PCI: hv: Add arm64 Hyper-V vPCI support

:::::: TO: Sunil Muthuswamy <sunilmut@microsoft.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
