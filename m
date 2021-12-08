Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73BB46CAB5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbhLHCGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:06:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:53842 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhLHCGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:06:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="224994877"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="224994877"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 18:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="611918198"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2021 18:03:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mumIi-000NET-Dg; Wed, 08 Dec 2021 02:03:20 +0000
Date:   Wed, 8 Dec 2021 10:03:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kees:memcpy/step2/next-20211206 19/19] ld.lld: warning: call to
 __read_overflow2_field marked "dontcall-warn": detected read beyond size of
 field (2nd parameter); maybe use struct_group()?
Message-ID: <202112080941.omOoH0rV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git memcpy/step2/next-20211206
head:   082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0
commit: 082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0 [19/19] fortify: Work around Clang inlining bugs
config: i386-randconfig-a012-20211207 (https://download.01.org/0day-ci/archive/20211208/202112080941.omOoH0rV-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees memcpy/step2/next-20211206
        git checkout 082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> ld.lld: warning: call to __read_overflow2_field marked "dontcall-warn": detected read beyond size of field (2nd parameter); maybe use struct_group()?
>> ld.lld: warning: call to __read_overflow2_field marked "dontcall-warn": detected read beyond size of field (2nd parameter); maybe use struct_group()?

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
