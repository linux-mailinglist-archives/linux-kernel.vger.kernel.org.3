Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC94767A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhLPCB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:01:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:62606 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhLPCB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639620089; x=1671156089;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M34YpFV3LtjTcta8x9LmISk3aU1sU3D/bujo4U1q1k8=;
  b=lK/n4UMG7xiIUUyNXmRwVbX8wig7MwkRB1UMZJb9TzkFrdAhQvn9KR7L
   vs3BAs2Neyn3UMdr4cQdFq1xQ9fE0M5aeJPQgJd4nH/pmsxjOa7zflaGp
   gLk318Fs9zpfzLQA372UersWqyC/KBjP/XDoWBzF34CdMjyiVpoJHXEAU
   0BVR2AnFq9k88H0zeRll+PsUYfBaedn1wTJTXuN1kuvhHOwPBVFuMLVX6
   gIXZD3NB/QOvm5XZzrvkl2lbuF2jEpNpcAiFV+5dpL62lL7DI1QOR1Erx
   77qdAqgyaN6x49uXqF8D25F9kmRFqJmQEo8US13BB+8tLJ5/1Vb6noAem
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="263541033"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="263541033"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 18:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="753848745"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 15 Dec 2021 18:01:27 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxg5H-0002c1-5d; Thu, 16 Dec 2021 02:01:27 +0000
Date:   Thu, 16 Dec 2021 10:01:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm-entry-literals 32/38] /tmp/cc0RnU2d.s:504: Error: invalid
 literal constant: pool needs to be closer
Message-ID: <202112160910.s4VdWOfI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm-entry-literals
head:   bed1490d5af6f3411b5b8ca816c8b6ddb9206528
commit: 9c46929e7989efacc1dd0a1dd662a839897ea2b6 [32/38] ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20211216/202112160910.s4VdWOfI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=9c46929e7989efacc1dd0a1dd662a839897ea2b6
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm-entry-literals
        git checkout 9c46929e7989efacc1dd0a1dd662a839897ea2b6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /tmp/cc0RnU2d.s: Assembler messages:
>> /tmp/cc0RnU2d.s:504: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:8233: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:11428: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:11472: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:11828: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:12151: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:16734: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:16795: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:26574: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:27829: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:27913: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:27973: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28032: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28107: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28191: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28251: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28310: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28385: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28470: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28530: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28589: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28667: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28757: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28817: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28876: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:28955: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29047: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29107: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29166: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29477: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29567: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29627: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29686: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29798: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29893: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:29955: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30014: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30172: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30261: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30321: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30380: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30474: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30563: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30625: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30684: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30828: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30923: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:30985: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31044: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31186: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31275: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31335: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31394: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31494: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31583: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31645: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31704: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31858: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:31947: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32007: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32066: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32212: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32307: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32369: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32428: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32572: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32668: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32730: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32789: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:32950: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33045: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33107: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33166: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33300: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33397: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33459: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33518: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33677: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33774: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33840: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:33899: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34056: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34155: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34222: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34281: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34452: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34548: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34610: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34669: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34875: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:34971: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35038: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35097: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35266: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35363: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35429: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35488: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35638: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35735: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35801: Error: invalid literal constant: pool needs to be closer
   /tmp/cc0RnU2d.s:35860: Error: invalid literal constant: pool needs to be closer

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
