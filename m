Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96526466683
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347791AbhLBPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:36:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:52748 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347638AbhLBPgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:36:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="297525617"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="297525617"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 07:32:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="500782921"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2021 07:32:34 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mso4X-000GRb-Nb; Thu, 02 Dec 2021 15:32:33 +0000
Date:   Thu, 2 Dec 2021 23:32:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux.o(.text.unlikely+0x4a60): Section mismatch
 in reference from the function trace_define_generic_fields() to the variable
 .init.data:initcall_level_names
Message-ID: <202112022336.rYvP7NxX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
commit: a55f224ff5f238013de8762c4287117e47b86e22 tracing: Fix pid filtering when triggers are attached
date:   6 days ago
config: xtensa-buildonly-randconfig-r002-20211202 (https://download.01.org/0day-ci/archive/20211202/202112022336.rYvP7NxX-lkp@intel.com/config)
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

<< WARNING: modpost: vmlinux.o(.text.unlikely+0x48c8): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x4a60): Section mismatch in reference from the function trace_define_generic_fields() to the variable .init.data:initcall_level_names
The function trace_define_generic_fields() references
the variable __initdata initcall_level_names.
This is often because trace_define_generic_fields lacks a __initdata
annotation or the annotation of initcall_level_names is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
