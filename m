Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB24A69EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243805AbiBBC3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:29:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:14595 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbiBBC30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643768966; x=1675304966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QIfwxsTloxTCDjYMbsizWEXC4hp3EtD3c1AWi+Q5Wo4=;
  b=ajh6OI0w/7A7FrTfT5Q8y9dwPFkDpyPfRkKGx5LKhRBS2uvZtTM5WaUX
   gbmFVKo7ZyU+5cjjz+dgqO6jjJUEIofhskwR/gbgadUNeQH680lyiIZ16
   kdb4EAhXssp7j+RU/6j6NGNnMxDWAde4y/TYMYcpfhaIC0S0BYRD1nqRd
   FGUUwKuniql4A/atUE9pXCLYARsoJAqFefOf+XbkdwxxiibhnER9E3ONy
   xNxjGW2XA3mhQcAzgyPOGWc+W+WD+kE/aYG0wmXcI5F03KDu67nljjVvj
   HpEiP33oGx8q1MtLeWy025udUp/r8Ad1IM41mgNMp4ziMsq/ER/15HbZz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="272320723"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="272320723"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 18:29:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="698632562"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2022 18:29:24 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF5Od-000Tzg-LV; Wed, 02 Feb 2022 02:29:23 +0000
Date:   Wed, 2 Feb 2022 10:28:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux.o(.text.unlikely+0x1810): Section mismatch
 in reference from the function trace_define_generic_fields.isra.0() to the
 variable .init.data:initcall_level_names
Message-ID: <202202021032.Mz078Swe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: a55f224ff5f238013de8762c4287117e47b86e22 tracing: Fix pid filtering when triggers are attached
date:   10 weeks ago
config: xtensa-randconfig-r021-20220202 (https://download.01.org/0day-ci/archive/20220202/202202021032.Mz078Swe-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a55f224ff5f238013de8762c4287117e47b86e22
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a55f224ff5f238013de8762c4287117e47b86e22
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

<< WARNING: modpost: vmlinux.o(.text.unlikely+0x1674): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x1810): Section mismatch in reference from the function trace_define_generic_fields.isra.0() to the variable .init.data:initcall_level_names
The function trace_define_generic_fields.isra.0() references
the variable __initdata initcall_level_names.
This is often because trace_define_generic_fields.isra.0 lacks a __initdata
annotation or the annotation of initcall_level_names is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
