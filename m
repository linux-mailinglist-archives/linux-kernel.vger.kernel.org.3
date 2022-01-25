Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7526E49BBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiAYTRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:17:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:3854 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbiAYTRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138238; x=1674674238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3r9uKp6vr/2+1NkFiyAC/cyaB7iy/IE1OWf9ykonGbo=;
  b=QxG0/v0mHzkP0lRVFPKm28wKdOnB1rPijq80ZUmkMx8pcWx82zwADDCY
   yQ/8WoiEJJW9cPEbYUaQ2UpO+nnunUYvZYASNjPjzVqa8bD2gkyvvC4yx
   jYvbE28bkETkIejIde2xT4QufGxkRQrJANa5WNN3AHdOrqur7sfJdtYrF
   j7z6881foAm5543R+WbWJezuBIwiALuesN8XqOJnyB3xjcAtksknT9qEU
   Ra1wk/vvQyRkkZ4HMqelwz4ctzNCGmbcjm3vnZ6fAkFR/Gdn5fHMMqtqG
   q4rq29/RbRU1faYARzpG43HGSjJxT7dKewcRs9IfdFN5B0jihdw+QVGdx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="270841709"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="270841709"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="597232822"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2022 11:17:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRJb-000KKr-En; Tue, 25 Jan 2022 19:17:15 +0000
Date:   Wed, 26 Jan 2022 03:17:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>
Subject: collect2: error: ld returned 1 exit status
Message-ID: <202201260016.WjRQsceW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a08b41ab9e2e468647f78eb17c28e29b93006394
commit: b18adee4ce4443399963826b5d28d9e63d40740c stacktrace: Move documentation for arch_stack_walk_reliable() to header
date:   11 months ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220126/202201260016.WjRQsceW-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b18adee4ce4443399963826b5d28d9e63d40740c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b18adee4ce4443399963826b5d28d9e63d40740c
        # save the config file to linux build tree
        make W=1 ARCH=x86_64 SHELL=/bin/bash tools/all

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: virtio_ring.o: in function `spin_lock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
   /usr/bin/ld: virtio_ring.o: in function `spin_unlock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
   /usr/bin/ld: virtio_ring.o: in function `spin_lock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
   /usr/bin/ld: virtio_ring.o: in function `spin_unlock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
   /usr/bin/ld: virtio_ring.o: in function `spin_lock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
   /usr/bin/ld: virtio_ring.o: in function `spin_unlock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
   /usr/bin/ld: virtio_ring.o: in function `spin_lock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
   /usr/bin/ld: virtio_ring.o: in function `spin_unlock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
>> collect2: error: ld returned 1 exit status
   make[3]: *** [<builtin>: virtio_test] Error 1
   make[3]: *** Waiting for unfinished jobs....
   /usr/bin/ld: virtio_ring.o: in function `spin_lock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
   /usr/bin/ld: virtio_ring.o: in function `spin_unlock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
   /usr/bin/ld: virtio_ring.o: in function `spin_lock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
   /usr/bin/ld: virtio_ring.o: in function `spin_unlock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
   /usr/bin/ld: virtio_ring.o: in function `spin_lock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
   /usr/bin/ld: virtio_ring.o: in function `spin_unlock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
   /usr/bin/ld: virtio_ring.o: in function `spin_lock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
   /usr/bin/ld: virtio_ring.o: in function `spin_unlock':
   /kbuild/worktree/build-ktools-consumer/tools/virtio/./linux/spinlock.h:22: undefined reference to `pthread_spin_unlock'
>> collect2: error: ld returned 1 exit status
   make[3]: *** [<builtin>: vringh_test] Error 1
   ***
   *** The source tree is not clean, please run 'make mrproper'
   *** in /kbuild/worktree/build-ktools-consumer
   ***
   make[5]: *** [/kbuild/worktree/build-ktools-consumer/Makefile:573: outputmakefile] Error 1
   make[4]: *** [Makefile:732: include/config/auto.conf.cmd] Error 2
   make[3]: *** [Makefile:11: mod] Error 2

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
