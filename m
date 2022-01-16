Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBD848FA7E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 04:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiAPDiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 22:38:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:55336 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234181AbiAPDit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 22:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642304329; x=1673840329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hMBa1n8oU4uOJe2h3XmimPDhVuGiIhE/i1BdrYrEFt4=;
  b=fBTJBW1E6FO1qURolgfIcJwuKRJrw40cp6ply/P+LfYYfXIaOaP+Us6h
   m48isVtO43L6h19hhSlXTubhZ8E9UCZw5pD/n7Bc3bR4hlx5glDsmVu+H
   WUKq/T+3lB4F/weVqlmCcGV9rwHjIMXZY9aLbIg1q6lys1S9B9tn201Dy
   zWC+JqoorafEtVF68aG9ObnsXI4e3A13E8xroTGPzwR3fN2/8UumsBaK6
   Otchqk6gBbB0tO1HGdQ5a5+oceoUYrCxzmNhUIUT3X6hJHVcHAlMRI+hU
   nGjEPT6wM9MMa56EBP2wVdW084eRTv/xe/D/0nK11JEI//qfnNW+s2VlE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="225140303"
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="225140303"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 19:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="491981705"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Jan 2022 19:38:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8wNS-000AQj-TH; Sun, 16 Jan 2022 03:38:46 +0000
Date:   Sun, 16 Jan 2022 11:37:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1941/2384]
 ./usr/include/linux/if_addr.h:5:10: fatal error: 'uapi/linux/types.h' file
 not found
Message-ID: <202201160847.helVBuM9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 97d04c6183db4658f05ac14df308c4efd3871346 [1941/2384] headers/deps: net: Optimize <uapi/linux/if_addr.h> dependencies
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220116/202201160847.helVBuM9-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=97d04c6183db4658f05ac14df308c4efd3871346
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 97d04c6183db4658f05ac14df308c4efd3871346
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/if_addr.h:5:10: fatal error: 'uapi/linux/types.h' file not found
   #include <uapi/linux/types.h>
            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
