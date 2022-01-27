Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A356A49D978
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiA0Dor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:44:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:64526 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbiA0Dop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643255085; x=1674791085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o+faBcN4/RZLTSCL4A4NTwESNAoJdibFSZU0WnNtj4A=;
  b=MOH4QMOGZ8sZo6FpTK4fS3V3UmTx5bJxK0DycJlsVZ2INvfLqvySCPzT
   ypEyHvptMnOGq2HDlyXgqe1QMC4L9yxDXCG2RXaUw0QopT5HxPX/E0J+g
   /9b6SCoOIRLW86zaSFWUnac/atQ8VPqpmzqvzMpcuWpRaJSBbiYtTIPex
   ClKSThER52tBpWbc0Lz7FMSwLjmli4q/Bw9G7aoBAQYFZfKqM3yDrUms3
   8fM7CdDn0ViZ5at7YZVhkdHnvpxCG4cO3+LSj2WqsnkTwNkDc4WYl5ExG
   QcVrABmvZRfW8glYBep5jYo3bPIHKu27oKlQPBmU/XIAUQYOXdfoJbghG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310051650"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="310051650"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 19:44:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="618194726"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2022 19:44:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCviA-000M3N-Og; Thu, 27 Jan 2022 03:44:38 +0000
Date:   Thu, 27 Jan 2022 11:44:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Maurer <mmaurer@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5854/5866] trusty-ipc.c:undefined reference to `trusty_dma_buf_get_ffa_tag'
Message-ID: <202201271139.j8fKxiFq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   52cdd137fae0b001197a51646289e3cbdda921d5
commit: 988b52b392a13c1b710e9ffdc5de9f933de77551 [5854/5866] ANDROID: trusty: Support setting FF-A Tag
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201271139.j8fKxiFq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/988b52b392a13c1b710e9ffdc5de9f933de77551
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 988b52b392a13c1b710e9ffdc5de9f933de77551
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/trusty/trusty-ipc.o: in function `dn_share_fd':
>> trusty-ipc.c:(.text+0x2b04): undefined reference to `trusty_dma_buf_get_ffa_tag'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
