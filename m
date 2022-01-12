Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD948CDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiALViU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:38:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:61994 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233065AbiALViT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642023499; x=1673559499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PlRV6NgyKJHpJxY6AseVrmm7/psi2SqMiIhELbNlXdY=;
  b=ma/oDpLCil8A26/fhmLUP6hNmB2uRD59KHtNRCXavDkVnfUxwrd1wmem
   LcP8HsqWzwc4zA0sKFRS7kSm9+HY/96Pxelt6NaYpDDOYEffMUbWV11dT
   dARO6El/TSL9Mn6NP4C1UAAckEFtu7VimyOw4IMFIAETqS4PtDW/cZJFQ
   XkEUUUa9yDNna1CnO6a0dozmj+pmTHBF/kLB5r5/F+bxE2MBi0S7K+v5T
   e249T6oPWctBZHa7hdZFPoGv2kzRZ3peoag5SVX/1ju5VD+ksTK2hJJwi
   HxkmbP69tF5kImhAwuOqN7HGNShslqnLeTcHKQ4hESqC4D/CeEfzHMqCA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="304595795"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="304595795"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:38:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475068887"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2022 13:38:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7lJu-0006RA-OJ; Wed, 12 Jan 2022 21:38:14 +0000
Date:   Thu, 13 Jan 2022 05:37:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sanket Goswami <Sanket.Goswami@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: drivers/platform/x86/amd-pmc.c:229:30: sparse: sparse: symbol
 'amd_pmc_stb_debugfs_fops' was not declared. Should it be static?
Message-ID: <202201130558.YpowhSOs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e3084ed48fd6b661fe434da0cb36d7d6706cf27f
commit: 426c0ff27b833939ed434b4a468bdc010864922a platform/x86: amd-pmc: Add support for AMD Smart Trace Buffer
date:   3 weeks ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220113/202201130558.YpowhSOs-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=426c0ff27b833939ed434b4a468bdc010864922a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 426c0ff27b833939ed434b4a468bdc010864922a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/leds/ drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/amd-pmc.c:229:30: sparse: sparse: symbol 'amd_pmc_stb_debugfs_fops' was not declared. Should it be static?

vim +/amd_pmc_stb_debugfs_fops +229 drivers/platform/x86/amd-pmc.c

   228	
 > 229	const struct file_operations amd_pmc_stb_debugfs_fops = {
   230		.owner = THIS_MODULE,
   231		.open = amd_pmc_stb_debugfs_open,
   232		.read = amd_pmc_stb_debugfs_read,
   233		.release = amd_pmc_stb_debugfs_release,
   234	};
   235	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
