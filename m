Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8748E349
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 05:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbiANEa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 23:30:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:31874 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239020AbiANEa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 23:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642134626; x=1673670626;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v0cY9Tq+PJLlhw2QRlNvqIImw1Ixq3++UUfLenq28Kg=;
  b=hhzhp/TKWz/xXhe1TPihc0X2GiQD/ZKLsCb+NeZxuMalizwE95i9zWdp
   8he5aGs8YNjlTmMOwRzHFUrNpw5tuaKXCkzJg6UN3+l/5ABBKYDf07zCL
   F6USCuL9eXZXJyT3/CFhDHGGiYenpOKglWEszTJGyKsCxmMGAohlgmlYD
   Y/1O1rSpkZ92VxeldfEaTOCESTOR4g1QUsFS3Pkyb/b4d42fSk6hBp7ZE
   ASvS3yIUdy6U0D8yn8YLroPjzAPSIRcW07Q8etYV+IxjlW4fqHTkSXxYm
   /VC3dZNHKShV6Ex8CKuvjEybZYI2WZK32uWM/IWh1sXMLUJ2zOVIMPy1I
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="241742547"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="241742547"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 20:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="516216435"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2022 20:30:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8EEJ-00085b-91; Fri, 14 Jan 2022 04:30:23 +0000
Date:   Fri, 14 Jan 2022 12:30:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>, Maxim Kochetkov <fido_max@inbox.ru>
Subject: FATAL ERROR: Unable to parse input tree
Message-ID: <202201141251.QpH7HSS3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220112-013848/Maxim-Kiselev/powerpc-dts-t1040rdb-fix-ports-names-for-Seville-Ethernet-switch/20211230-184411
head:   50f019b2ff409796f96cd749ecd816ff18575d8b
commit: 50f019b2ff409796f96cd749ecd816ff18575d8b powerpc: dts: t1040rdb: fix ports names for Seville Ethernet switch
date:   2 days ago
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201141251.QpH7HSS3-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/50f019b2ff409796f96cd749ecd816ff18575d8b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220112-013848/Maxim-Kiselev/powerpc-dts-t1040rdb-fix-ports-names-for-Seville-Ethernet-switch/20211230-184411
        git checkout 50f019b2ff409796f96cd749ecd816ff18575d8b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   Error: arch/powerpc/boot/dts/fsl/t1040rdb.dts:112.1-9 syntax error
>> FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
