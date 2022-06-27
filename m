Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B144B55E14B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiF0Jg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiF0Jgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:36:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4763E7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656322591; x=1687858591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I237VzvHZrO95w+7uVTfyjRoDhOy1MYS/DEqL30Knf4=;
  b=Oxutq2GR9rLF6RFiPnIjqwwzX3V/SDB0iILBIvJw7edmP+dS0uYGK8C8
   Eh/0h06LFYEF616sJ3kOz+1aN3Q+PcGuN8PCnJXmdonRKxfJluK9h0qaF
   V3J9TlL7OMlnfxzgSCHgqPqukoK11I/LF2ZweffNB9ybbu6zQ9obhZ/C7
   AcD3C9fl+L+pRLnFjahmr4ijvh/B2A2Wqu5HAkFOvYF/oPwsx9xRDkMes
   fugRFOCeUfN+BLcCe7Ub1eP7kC5B/teylvmEyMCw/PjqukwR/RuTHSrdv
   dUskkR+6hYeZWTaCRSn7tYeqZWRA0exD3/QCYc5qC1y+tvVmXCnLzCIqp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="264452798"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="264452798"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 02:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="646356543"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2022 02:36:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5lAS-0008PV-IO;
        Mon, 27 Jun 2022 09:36:28 +0000
Date:   Mon, 27 Jun 2022 17:35:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: drivers/pci/controller/pci-xgene.c:626:34: warning: unused variable
 'xgene_pcie_match_table'
Message-ID: <202206271743.QveZ7pGm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   03c765b0e3b4cb5063276b086c76f7a612856a9a
commit: 6e5a1fff9096ecd259dedcbbdc812aa90986a40e PCI: Avoid building empty drivers
date:   1 year, 4 months ago
config: x86_64-buildonly-randconfig-r001-20220627 (https://download.01.org/0day-ci/archive/20220627/202206271743.QveZ7pGm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 016342e319fd31e41cf5ed16a6140a8ea2de74dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5a1fff9096ecd259dedcbbdc812aa90986a40e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5a1fff9096ecd259dedcbbdc812aa90986a40e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/controller/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pci-xgene.c:626:34: warning: unused variable 'xgene_pcie_match_table' [-Wunused-const-variable]
   static const struct of_device_id xgene_pcie_match_table[] = {
                                    ^
   1 warning generated.


vim +/xgene_pcie_match_table +626 drivers/pci/controller/pci-xgene.c

5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  625  
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01 @626  static const struct of_device_id xgene_pcie_match_table[] = {
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  627  	{.compatible = "apm,xgene-pcie",},
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  628  	{},
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  629  };
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c Tanmay Inamdar 2014-10-01  630  

:::::: The code at line 626 was first introduced by commit
:::::: 5f6b6ccdbe1cdfa5aa4347ec5412509b8995db27 PCI: xgene: Add APM X-Gene PCIe driver

:::::: TO: Tanmay Inamdar <tinamdar@apm.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
