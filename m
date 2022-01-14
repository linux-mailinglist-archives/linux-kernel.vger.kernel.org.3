Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8248F0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbiANU22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 15:28:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:25118 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244193AbiANU21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 15:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642192107; x=1673728107;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6YKid5x2G3RibSq8lkqrK2/HGiyoSYh0VIRtJAhhNb8=;
  b=dbSCJ4gD+9QWo0r7TocyjhZ2qoJAiHo7+lyP0URBb8DZkbaQy1eX7/Gf
   dNzVW7uwgDtVcqDCnIbXv5qId01G4LZUlhV+iWwVTY5QrWE96WOyfAwua
   fedJ4O8geNtRvND3urEIGI5mjAvCfxVEmyw4ntVKXkgzwqya/qmcTN3Bf
   JP6GH5MzsP543pkutmxGyXAqBmCeRuAnbfqHK7+HgYuaHTahnjKpCSUU2
   WkWB6a6o4oa/r08jFtAgVJPwhIP3Tjqa0f/LHrNVkPOYfbU++WsolC0t8
   omI/5bfjm81SxlG9R2XThNzkU34kesq8nFdwsF1lyEhS8TritcDtDLjVd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="243142429"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="243142429"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 12:28:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="692339887"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2022 12:28:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8TBQ-0008xY-O7; Fri, 14 Jan 2022 20:28:24 +0000
Date:   Sat, 15 Jan 2022 04:27:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1502/2383]
 ./usr/include/asm-generic/bpf_perf_event.h:4:10: fatal error:
 'uapi/linux/ptrace.h' file not found
Message-ID: <202201150437.qy7o7fCa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   d772004cd069a1947a890ccc8346e922f866ba1e
commit: b5253c772f85973787772c6bd4ee3026cd5d9386 [1502/2383] headers/deps: bpf: Use <uapi/linux/ptrace.h> in <uapi/asm-generic/bpf_perf_event.h>
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220115/202201150437.qy7o7fCa-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b5253c772f85973787772c6bd4ee3026cd5d9386
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b5253c772f85973787772c6bd4ee3026cd5d9386
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/asm/bpf_perf_event.h:1:
>> ./usr/include/asm-generic/bpf_perf_event.h:4:10: fatal error: 'uapi/linux/ptrace.h' file not found
   #include <uapi/linux/ptrace.h>
            ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
