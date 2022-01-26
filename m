Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566FD49C4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiAZHjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:39:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:6615 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237937AbiAZHjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643182779; x=1674718779;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qpwkq/tfgyuDWo8286GPA9d2hhEfNOjp5kDGgAGyq0I=;
  b=mpJ1luKPp/L/ROaEysd+ZiLpmLBQTUgnG1ORby9M1DisWpU4hFn8UPyK
   GF7f00YWEket1O/b1c7ppS0RQIhF0kZvllHVzdieyvi/Mygzzf/b1ooYJ
   OfOp15pgFjFLnH69mzmWQz1juJ8O29SXCC/jkDJMGHsYmwqPHmi3KIvcn
   5cX/uH/FMpe/Mf92s42CP/IVrOvG4icc7G3EYxTmQyt6cjRqqdDVJJU8S
   evoNyMoDdrm+BzTXIOnyNA72BkBH7JW3RwGptJBLdg9XmhyB76ggCZgUS
   H/AjEdQ2pqJXXkF4xhsXhRDhi4NAKEe6EgeEd/HBU88veeI5JbUhe/pxV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="270949581"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="270949581"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 23:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="696135344"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2022 23:39:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCcu1-000KwV-Ba; Wed, 26 Jan 2022 07:39:37 +0000
Date:   Wed, 26 Jan 2022 15:39:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 60/137] WARNING: modpost:
 vmlinux.o(.text+0x48087): Section mismatch in reference from the function
 resctrl_init() to the function .init.text:thread_throttle_mode_init()
Message-ID: <202201261528.jKedbVna-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: 5d118e3da1ad725c2ea8da30eda516096e550289 [60/137] x86/resctrl: Drop __init/__exit on assorted symbols
config: i386-randconfig-a011-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261528.jKedbVna-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=5d118e3da1ad725c2ea8da30eda516096e550289
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 5d118e3da1ad725c2ea8da30eda516096e550289
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x48087): Section mismatch in reference from the function resctrl_init() to the function .init.text:thread_throttle_mode_init()
The function resctrl_init() references
the function __init thread_throttle_mode_init().
This is often because resctrl_init lacks a __init
annotation or the annotation of thread_throttle_mode_init is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
