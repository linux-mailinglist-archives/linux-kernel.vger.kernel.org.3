Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABA489E04
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbiAJRII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:08:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:8331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237655AbiAJRIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641834487; x=1673370487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+inpjhusQ191r/uaq3Nr5tdFQJRGkxrtus5P5NLh/H8=;
  b=f1K2tfTUmGWqrNOh8fcw2ujqWXT4HoZuk09caKO/znicaSipe4UCCS1W
   d0ykGnoA0d7rgTSL9+MkAs8c5x7jzhQh4opXA5wofsHKhbIXlWdqMiwYN
   Qo/V5swOq+oUsVZJcUOaQNywKppuF5x2walNvackQRVMyPx4jpUAYc0ez
   sVLPs/KMCtCwQiZ8PMUiF1VRYniICZ91vlbBlkpVEmZEUMQZdhg4wHDqi
   oN8ToApAYSthyN9laobiJ/Ob8ZsL9svv2HCE9neoDcDqFl23pqhprLfrm
   MXYP7aHmtvjLj2PFa2mHhsftWFMmG1q97X5su+ARG5UgvVatzPUeWxi2s
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="242083836"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="242083836"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 09:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="690639374"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2022 09:08:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6y9N-0003lW-FY; Mon, 10 Jan 2022 17:08:05 +0000
Date:   Tue, 11 Jan 2022 01:07:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yogesh Lal <quic_ylal@quicinc.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 1117/2545] (.rodata+0x0): multiple definition of `__crc_si_swapinfo';
 arch/s390/appldata/appldata_base.o:(.rodata+0x0): first defined here
Message-ID: <202201110124.G2WaFCMn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   23c5cc871466520099bda5e999e14b98dd8f44da
commit: eb03ee118ab0680aebda709b5c3e32a3e3b4c99c [1117/2545] ANDROID: mm: Export si_swapinfo
config: s390-defconfig (https://download.01.org/0day-ci/archive/20220111/202201110124.G2WaFCMn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/eb03ee118ab0680aebda709b5c3e32a3e3b4c99c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout eb03ee118ab0680aebda709b5c3e32a3e3b4c99c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: mm/swapfile.o: in function `__crc_si_swapinfo':
>> (.rodata+0x0): multiple definition of `__crc_si_swapinfo'; arch/s390/appldata/appldata_base.o:(.rodata+0x0): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
