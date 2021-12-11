Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E347130D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhLKI6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:58:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:11059 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhLKI6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639213117; x=1670749117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c69z9ssnFeHJKesmh0alTNQ6ljocX/UdfZXdlwLn880=;
  b=kgMR4RTaId4xYQ0UGMLjY9iPG9H0l54nNfkkRfov3WM/1yQZbp57mrFZ
   BXo/dwEfydobdL83g4ah33p5u5X14tPI4Gyg2QXGG/ZFhTcmRn8lAsRZv
   R4rL7N8PphdyKdNf/Y4QI1Aug5v2GHUgF3E4ARCBHcP/FLCtpTU48La3C
   4QJbuJsO6ZNUaTO35MAKo4ajAiqRCrvD7CXqqmTzgyn9B+zCJLNprNXRm
   alpqlYOp/rtokDcsm4/c3IRFWXUq427q7jmvzUPa5VtTIQpHSO7IJTMYL
   96wPwT3L3ykovPgVZ5GZzbovgVQ1iYlmDbcsC39h1hFo42eI7FU2lYCK5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238328820"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="238328820"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 00:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="602476961"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Dec 2021 00:58:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvyDD-0004NV-2r; Sat, 11 Dec 2021 08:58:35 +0000
Date:   Sat, 11 Dec 2021 16:58:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-1 1/2] arch/parisc/kernel/signal.c:36:10:
 fatal error: generated/vdso32-offsets.h: No such file or directory
Message-ID: <202112111656.nshwOA0r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-1
head:   e87fad18b5acbcb8b3f345bfe6ea1099f239bd23
commit: 1e4b26c042645773fa45cc09eb7cfe59917969e3 [1/2] initial vDSO implementation
config: parisc-randconfig-r013-20211211 (https://download.01.org/0day-ci/archive/20211211/202112111656.nshwOA0r-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=1e4b26c042645773fa45cc09eb7cfe59917969e3
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc 5.16-vdso-1
        git checkout 1e4b26c042645773fa45cc09eb7cfe59917969e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash arch/parisc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/parisc/kernel/signal.c:36:10: fatal error: generated/vdso32-offsets.h: No such file or directory
      36 | #include <generated/vdso32-offsets.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +36 arch/parisc/kernel/signal.c

  > 36	#include <generated/vdso32-offsets.h>
    37	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
