Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2F48E28A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiANCbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:31:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:61467 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235069AbiANCba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642127490; x=1673663490;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HnfkjBhZcb2uuNePhngqlLH0cl9KfuymZhcGpa9HMTE=;
  b=PZBBcwVQbeziuC3pzqKIezNDUDGIvP1FRRQZsx+xXBJld1c6VKSutLVe
   f4FjD+c5S7KQvBIEUHUWgJC4PaFmd9afcc494arbeOx36Y746J2aPG1ay
   ShBjwSYOjKdBSAe8TJ8ljePYpMMHu/7W/LL8OpwZgB9Dgp1HQsAW1xm5h
   qN7GjxC5yC50/z4NMlIHTJguCP4fJTmo5bDPiF3uy686nxXzIVru13KGb
   imE/HqcGvNR+D9yn2KOlSxV1GBKMldas/W911HEx2tcxSOf2TqoxEr+IM
   qTS3cJ9gde2DX74p9xiqQkZdsvAjUtxbuKQywDfocmZJOH+fz57sC4W47
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="268530960"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="268530960"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 18:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="491345643"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2022 18:29:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8CLA-0007yn-5f; Fri, 14 Jan 2022 02:29:20 +0000
Date:   Fri, 14 Jan 2022 10:28:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 102/2382] ./usr/include/asm-generic/shmbuf.h:7:10:
 fatal error: 'uapi/asm-generic/ipcbuf.h' file not found
Message-ID: <202201141048.lZL29hek-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: bfc9d5c126bd10a654139934f14575c9b4f627ae [102/2382] headers/deps: Remove <linux/sem.h> from <linux/sched.h>
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220114/202201141048.lZL29hek-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=bfc9d5c126bd10a654139934f14575c9b4f627ae
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout bfc9d5c126bd10a654139934f14575c9b4f627ae
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/shm.h:26:
   In file included from ./usr/include/asm/shmbuf.h:6:
>> ./usr/include/asm-generic/shmbuf.h:7:10: fatal error: 'uapi/asm-generic/ipcbuf.h' file not found
   #include <uapi/asm-generic/ipcbuf.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
