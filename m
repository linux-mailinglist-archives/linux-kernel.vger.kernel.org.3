Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E499050DE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbiDYKl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbiDYKlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:41:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC60DB87C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650883100; x=1682419100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZmOvpfhratRIkwuw8D+s35C96Xsu5QDil0qdt+ZdK3U=;
  b=Z4ZF1wwrgVchu81dps/QCtLCgYhID1w1lz1DkSV7vPlURJbbRDf9rxMx
   6DQLoDmeIuyGEudKO3punLY9Zvk4ZC+QIVO70QeMfxr6O+I0szibml/Yb
   aiV0rl4kLu1J9C9/drxxrr9hWqeSfycnb1DafXHx6ny1dVIVuaNPxwOhE
   Pwj6S+0niLqq+UdgPAA0DGgt7ilCylXNXxhPMwxByKSFRrbHbpkczkk7M
   5+3jq/ZnMdKhVZxCHE41F0OlhIMe1uYeCB1UyBX42tW5J3jQ2I9xIfw13
   nB8LgtvpwGwg57NaKPn6KMqEn4oHktDAqR4JWcClXQqwEfeFgSC65Rdji
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="262809939"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="262809939"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 03:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="627996501"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2022 03:38:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niw6g-0002L8-N0;
        Mon, 25 Apr 2022 10:38:14 +0000
Date:   Mon, 25 Apr 2022 18:37:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: drivers/pci/controller/pci-xgene.c:626:34: warning: unused variable
 'xgene_pcie_match_table'
Message-ID: <202204251857.XKGp0wbV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af2d861d4cd2a4da5137f795ee3509e6f944a25b
commit: 6e5a1fff9096ecd259dedcbbdc812aa90986a40e PCI: Avoid building empty drivers
date:   1 year, 1 month ago
config: x86_64-buildonly-randconfig-r006-20220425 (https://download.01.org/0day-ci/archive/20220425/202204251857.XKGp0wbV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
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

If you fix the issue, kindly add following tag as appropriate
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
