Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD71C4A32C0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353529AbiA3AJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:09:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:7601 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353509AbiA3AJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643501351; x=1675037351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IDotzqPh1Xwsld/kU45ptc58h71ouhRIvIDPnNiiFMc=;
  b=PtoKqpS/QrqMIJ/PsAvCeQ2aDuLGqAfC/8HtFhbEAKwatOF7B8MYiPWt
   DD/Mn81Ec3jle5H/dTvTTncbVDHnuCPv6U4Xkec6DRg1wTFiAyu9U8JH+
   B1E7jskr+9DB2CYYJmUYakaWHHiZJMFyA5R1XeW2oWY+3nYaqTr+Qzwpf
   lS+TlAWQVR/EFeA5YjyPCTrI1WTcyZ7PPcx2MJdR636Y25ID0cmzq4Wd0
   I6e/Ne2w31OqYMzBoDXtBqsTMh1t/q9oNuLV1cgFOvfpn9EkePU90hyQb
   Sy+l+hjUkSq/M8Fj37XA8g97jjc+fPTHlr1MhYAEv/4H2nIg01U7IJcmM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247524742"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="247524742"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 16:09:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="522127645"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Jan 2022 16:09:09 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDxmG-000PnT-RH; Sun, 30 Jan 2022 00:09:08 +0000
Date:   Sun, 30 Jan 2022 08:08:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: /tmp/ccFBm0kb.s: Warning: Can not find match relax hint.  Line: 1875
Message-ID: <202201300841.3iDnRrAM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8c7e4ede46fe63ff10000669652648aab09d112
commit: 29db4bea1d10b73749d7992c1fc9ac13499e8871 bpf: Prepare relo_core.c for kernel duty.
date:   8 weeks ago
config: nds32-randconfig-m031-20220130 (https://download.01.org/0day-ci/archive/20220130/202201300841.3iDnRrAM-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29db4bea1d10b73749d7992c1fc9ac13499e8871
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 29db4bea1d10b73749d7992c1fc9ac13499e8871
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   tools/lib/bpf/relo_core.c: In function 'bpf_core_apply_relo_insn':
   tools/lib/bpf/relo_core.c:1346:1: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1346 | }
         | ^
   /tmp/ccFBm0kb.s: Assembler messages:
>> /tmp/ccFBm0kb.s: Warning: Can not find match relax hint.  Line: 1875

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
