Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736B3494317
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357523AbiASWgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:36:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:56248 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243245AbiASWgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642631804; x=1674167804;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1gWGX1h8BWrCCIKoA/6KpIWfv4FlIBjGre0d3kpmSdU=;
  b=eMJVCQNkr7dR3gWtIBo4bGcMb5s9yJG4EbTQwmkfW9urm5IvvHYHEAXD
   0uXKaQQzdk9UCF7hY1eUlkL7d9EHGBska7voBT4ZKemdnWvxeHhTF+fB3
   0f6Tx/0UEIHYDtpMaTipGhMwSVhIfcc7fWnsgiwBXRniLuz7HWVJAi61m
   UfxX52WwD0yk/Lw/nnj2oTINElaAKF5bSdeylJ3UGvIUMWpLX7GTIlLAX
   FBlML1UC7f2/GnqPSZhI1+QGs/Uxm1Pt9R/MzfAoEXRik4/8kOnWfHwyN
   f71I2E1WlgPJOUYKLhUCeDpDSlol48pPJ8GbrXqOQhq17LDlCjvNYr/ps
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269608787"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="269608787"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 14:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="477562281"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2022 14:36:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAJZJ-000Dnc-UQ; Wed, 19 Jan 2022 22:36:41 +0000
Date:   Thu, 20 Jan 2022 06:35:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 24/29]
 nios2-linux-ld: fs/cifs/file.o:undefined reference to `netfs_invalidatepage'
Message-ID: <202201200630.EgURYeDW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   893ce0d06d6627c743bf20d48234543ff9262d19
commit: 7deb1d07f1b835b302c1a747312e02d2e1089578 [24/29] netfs: Provide invalidatepage and releasepage calls
config: nios2-randconfig-r006-20220119 (https://download.01.org/0day-ci/archive/20220120/202201200630.EgURYeDW-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7deb1d07f1b835b302c1a747312e02d2e1089578
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout 7deb1d07f1b835b302c1a747312e02d2e1089578
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> nios2-linux-ld: fs/cifs/file.o:(.rodata+0x48fc): undefined reference to `netfs_invalidatepage'
>> nios2-linux-ld: fs/cifs/file.o:(.rodata+0x4900): undefined reference to `netfs_releasepage'
   nios2-linux-ld: fs/cifs/file.o:(.rodata+0x4954): undefined reference to `netfs_invalidatepage'
   nios2-linux-ld: fs/cifs/file.o:(.rodata+0x4958): undefined reference to `netfs_releasepage'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
