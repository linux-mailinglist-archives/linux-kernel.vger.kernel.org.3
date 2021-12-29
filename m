Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D10480FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 05:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbhL2Ezq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 23:55:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:54276 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhL2Ezo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 23:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640753744; x=1672289744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P+ztV3bQQ5QZEPv4FFhjTVX0wdgypaZI7qqLReakVXs=;
  b=LK8v+TmMOiIGNK9XfbWmXX9zVC/ZGRva3p2XX1Jb7xL2JY3E/cSmNtKd
   CToKBL/mESiRX8IiDNe/RCF4qt0iaWcqPxLM71m80Oi817MK6XWI1g4Da
   6Il/nC6NNB2hDrOF4dPG+V9SAIQYWPl0SnFXzgNnhVcIyPh6E/SNDl8pJ
   XTo5iXtXfJAKiQCXX3yISQe2RZ2DynnFJsxTor0GVd+6i5DEXEH6v4g33
   T5crFkMF6O955KC7huhjqKXIu5T0ikVs4fCIkiapSAbLOeX0grO4T7Gjn
   WeAjH3TVvWi/hM29MbCBnbL0QGnIrkhS1NIxjPBHCxPuY+0B8cb2lT6SK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="265697036"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="265697036"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 20:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="510384149"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Dec 2021 20:55:42 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2R02-0008VD-AF; Wed, 29 Dec 2021 04:55:42 +0000
Date:   Wed, 29 Dec 2021 12:54:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luto:sched/lazymm 12/17] nds32le-linux-ld: idle.c:undefined
 reference to `unlazy_mm_irqs_off'
Message-ID: <202112291221.C6LzfqOg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git sched/lazymm
head:   fbea7977edc16ae85f8e2255b084bc2403801327
commit: a3d2a94bc79f367c31d3962f3957dfe0ded13b58 [12/17] Rework "sched/core: Fix illegal RCU from offline CPUs"
config: nds32-randconfig-r014-20211228 (https://download.01.org/0day-ci/archive/20211229/202112291221.C6LzfqOg-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?id=a3d2a94bc79f367c31d3962f3957dfe0ded13b58
        git remote add luto https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git
        git fetch --no-tags luto sched/lazymm
        git checkout a3d2a94bc79f367c31d3962f3957dfe0ded13b58
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: kernel/sched/idle.o: in function `do_idle':
   idle.c:(.text+0x1b0): undefined reference to `unlazy_mm_irqs_off'
>> nds32le-linux-ld: idle.c:(.text+0x1b4): undefined reference to `unlazy_mm_irqs_off'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
