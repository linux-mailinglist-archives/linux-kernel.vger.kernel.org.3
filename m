Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B347D194
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhLVMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:19:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:1689 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhLVMTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640175586; x=1671711586;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IpQcbv20rPvoU2QuAxvuOWNufLhcgT8QLvQICN5SqcI=;
  b=gs2yHw+SZCfmsGYV0NhebdFV9ZVYISCfPCZAyadhDliBaW12qaxy3Ad0
   9/F87QkyvBO6SqC5/rxq7FGdgE2sOvejAlW8IzeupkXrAwtu8/RUWD6Xf
   BmhZHOBpOVOcsac6vqudcuBLSe8EF5TTBFntJ+aZsMxqVdNzj2QBhqx5Z
   mYCh/VPwSvOM0n43MJq8BbeeipwPwVR+qR/PvfeeF1LRAeVGZaugPsW0S
   6fvV1+ShV6zLlaTZVzBZmrS1Ufidbdjr3Rx7UETzTVIzA1sdPvpg4K0zo
   mvDDGVYk7ua4EpspSUkrR0DSYkkMFdDbxLkEk+26IVo8NJa9u0Hl3UycT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240559036"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240559036"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="685004645"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Dec 2021 04:19:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n00ar-0000QD-3M; Wed, 22 Dec 2021 12:19:41 +0000
Date:   Wed, 22 Dec 2021 20:19:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: mm/kasan/sw_tags.c:211:6: warning: no previous prototype for
 function 'kasan_tag_mismatch'
Message-ID: <202112222040.WutR6KJ2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f47a9a4dfa3674fad19a49b40c5103a9a8e1589
commit: 1cbdf60bd1b74e397d48aa877367cfc621f45ffe kasan: arm64: support specialized outlined tag mismatch checks
date:   7 months ago
config: arm64-randconfig-r023-20211222 (https://download.01.org/0day-ci/archive/20211222/202112222040.WutR6KJ2-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project de4e0195ae1c39f1c3b07834b8e32c113f4f20eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1cbdf60bd1b74e397d48aa877367cfc621f45ffe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1cbdf60bd1b74e397d48aa877367cfc621f45ffe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/kasan/sw_tags.c:211:6: warning: no previous prototype for function 'kasan_tag_mismatch' [-Wmissing-prototypes]
   void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
        ^
   mm/kasan/sw_tags.c:211:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
   ^
   static 
   1 warning generated.


vim +/kasan_tag_mismatch +211 mm/kasan/sw_tags.c

   210	
 > 211	void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
